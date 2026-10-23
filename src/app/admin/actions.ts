"use server";

import { Prisma } from "@prisma/client";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { z } from "zod";
import { hashPassword, requireAdmin } from "@/lib/auth";
import { db } from "@/lib/db";
import { slugify } from "@/lib/format";
import { extendSubscription, fulfillOrder } from "@/lib/payments";

function fail(path: string, message: string): never {
  redirect(`${path}${path.includes("?") ? "&" : "?"}error=${encodeURIComponent(message)}`);
}

function done(path: string, message: string): never {
  redirect(`${path}${path.includes("?") ? "&" : "?"}ok=${encodeURIComponent(message)}`);
}

function parse<T extends z.ZodTypeAny>(schema: T, formData: FormData, path: string): z.infer<T> {
  const result = schema.safeParse(Object.fromEntries(formData));
  if (!result.success) {
    const issue = result.error.issues[0];
    fail(path, `${issue.path.join(".")}: ${issue.message}`);
  }
  return result.data;
}

function isUniqueError(err: unknown) {
  return err instanceof Prisma.PrismaClientKnownRequestError && err.code === "P2002";
}

const checkbox = z.preprocess((v) => v === "on" || v === "true", z.boolean());
const ageStage = z.enum(["ALL", "AGE_0_5", "AGE_6_10", "AGE_11_13", "AGE_14_17"]);
const optionalUrl = z.union([z.literal(""), z.string().trim().url("URL no válida").startsWith("https://", "Debe usar https")]);

/* ---------- Usuarios ---------- */

const newUserSchema = z.object({
  name: z.string().trim().min(2).max(80),
  email: z.string().trim().toLowerCase().email(),
  password: z.string().min(8, "mínimo 8 caracteres"),
  role: z.enum(["USER", "ADMIN"]),
  months: z.coerce.number().int().min(0).max(36).default(0),
});

export async function createUserAction(formData: FormData) {
  await requireAdmin();
  const data = parse(newUserSchema, formData, "/admin/usuarios");
  let id: string;
  try {
    const user = await db.user.create({
      data: { name: data.name, email: data.email, role: data.role, passwordHash: await hashPassword(data.password) },
    });
    id = user.id;
  } catch (err) {
    if (isUniqueError(err)) fail("/admin/usuarios", "Ya existe un usuario con ese correo");
    throw err;
  }
  if (data.months > 0) await grantMonths(id, data.months);
  done(`/admin/usuarios/${id}`, "Usuario creado");
}

const editUserSchema = z.object({
  id: z.string(),
  name: z.string().trim().min(2).max(80),
  email: z.string().trim().toLowerCase().email(),
  role: z.enum(["USER", "ADMIN"]),
  active: checkbox,
});

export async function updateUserAction(formData: FormData) {
  const admin = await requireAdmin();
  const path = `/admin/usuarios/${formData.get("id")}`;
  const data = parse(editUserSchema, formData, path);
  if (data.id === admin.id && (data.role !== "ADMIN" || !data.active)) {
    fail(path, "No puedes quitarte el rol de administrador ni desactivar tu propia cuenta");
  }
  try {
    await db.user.update({ where: { id: data.id }, data });
  } catch (err) {
    if (isUniqueError(err)) fail(path, "Ya existe un usuario con ese correo");
    throw err;
  }
  done(path, "Cambios guardados");
}

export async function resetPasswordAction(formData: FormData) {
  await requireAdmin();
  const id = String(formData.get("id"));
  const password = String(formData.get("password") ?? "");
  const path = `/admin/usuarios/${id}`;
  if (password.length < 8) fail(path, "La contraseña debe tener al menos 8 caracteres");
  await db.user.update({ where: { id }, data: { passwordHash: await hashPassword(password) } });
  done(path, "Contraseña restablecida. Compártela con el usuario por un canal seguro.");
}

async function grantMonths(userId: string, months: number) {
  // Se usa el plan mensual como referencia; si no existe, se extiende sin plan.
  const monthly = await db.plan.findFirst({ where: { interval: "MONTH" }, orderBy: { order: "asc" } });
  for (let i = 0; i < months; i++) {
    if (monthly) {
      await extendSubscription(userId, monthly.id, "MONTH", true);
    } else {
      const sub = await db.subscription.findUnique({ where: { userId } });
      const base = sub && sub.currentPeriodEnd > new Date() ? sub.currentPeriodEnd : new Date();
      const end = new Date(base);
      end.setMonth(end.getMonth() + 1);
      await db.subscription.upsert({
        where: { userId },
        create: { userId, currentPeriodEnd: end, grantedByAdmin: true },
        update: { currentPeriodEnd: end, status: "ACTIVE", grantedByAdmin: true },
      });
    }
  }
}

export async function grantSubscriptionAction(formData: FormData) {
  await requireAdmin();
  const id = String(formData.get("id"));
  const months = Number(formData.get("months"));
  const path = `/admin/usuarios/${id}`;
  if (!Number.isInteger(months) || months < 1 || months > 36) fail(path, "Indica entre 1 y 36 meses");
  await grantMonths(id, months);
  done(path, `Se otorgaron ${months} mes(es) de suscripción`);
}

export async function cancelSubscriptionAction(formData: FormData) {
  await requireAdmin();
  const id = String(formData.get("id"));
  await db.subscription.updateMany({ where: { userId: id }, data: { status: "CANCELED", currentPeriodEnd: new Date() } });
  done(`/admin/usuarios/${id}`, "Suscripción cancelada");
}

export async function grantLessonAction(formData: FormData) {
  await requireAdmin();
  const userId = String(formData.get("id"));
  const lessonId = String(formData.get("lessonId"));
  await db.purchase.upsert({
    where: { userId_lessonId: { userId, lessonId } },
    create: { userId, lessonId },
    update: {},
  });
  done(`/admin/usuarios/${userId}`, "Clase otorgada");
}

export async function revokeLessonAction(formData: FormData) {
  await requireAdmin();
  const userId = String(formData.get("id"));
  await db.purchase.deleteMany({ where: { userId, lessonId: String(formData.get("lessonId")) } });
  done(`/admin/usuarios/${userId}`, "Acceso a la clase retirado");
}

export async function deleteUserAction(formData: FormData) {
  const admin = await requireAdmin();
  const id = String(formData.get("id"));
  if (id === admin.id) fail(`/admin/usuarios/${id}`, "No puedes eliminar tu propia cuenta");
  if (formData.get("confirm") !== "ELIMINAR") fail(`/admin/usuarios/${id}`, "Escribe ELIMINAR para confirmar");
  await db.user.delete({ where: { id } });
  done("/admin/usuarios", "Usuario eliminado");
}

/* ---------- Clases ---------- */

const lessonSchema = z
  .object({
    id: z.string().optional(),
    title: z.string().trim().min(3).max(140),
    slug: z.string().trim().max(80).optional(),
    summary: z.string().trim().min(3).max(300),
    description: z.string().trim().max(10000).default(""),
    ageStage,
    access: z.enum(["INCLUDED", "ADDON"]),
    priceCop: z.coerce.number().int().min(0).max(100_000_000).default(0),
    videoUrl: optionalUrl,
    thumbnailUrl: optionalUrl,
    durationMin: z.coerce.number().int().min(0).max(1000).default(0),
    instructor: z.string().trim().max(120).default(""),
    order: z.coerce.number().int().default(0),
    published: checkbox,
  })
  .refine((d) => d.access !== "ADDON" || d.priceCop >= 1000, { message: "Los complementos necesitan un precio", path: ["priceCop"] });

export async function saveLessonAction(formData: FormData) {
  await requireAdmin();
  const path = `/admin/clases/${formData.get("id") || "nuevo"}`;
  const { id, slug, ...data } = parse(lessonSchema, formData, path);
  const finalSlug = slugify(slug || data.title);
  if (!finalSlug) fail(path, "slug: no válido");
  try {
    const lesson = id
      ? await db.lesson.update({ where: { id }, data: { ...data, slug: finalSlug } })
      : await db.lesson.create({ data: { ...data, slug: finalSlug } });
    revalidatePath("/clases");
    done(`/admin/clases/${lesson.id}`, "Clase guardada");
  } catch (err) {
    if (isUniqueError(err)) fail(path, "Ya existe una clase con ese slug");
    throw err;
  }
}

export async function deleteLessonAction(formData: FormData) {
  await requireAdmin();
  await db.lesson.delete({ where: { id: String(formData.get("id")) } });
  done("/admin/clases", "Clase eliminada");
}

/* ---------- Videos y podcasts ---------- */

const resourceSchema = z.object({
  id: z.string().optional(),
  kind: z.enum(["VIDEO", "PODCAST"]),
  title: z.string().trim().min(2).max(160),
  author: z.string().trim().max(120).default(""),
  description: z.string().trim().max(2000).default(""),
  url: z.string().trim().url("URL no válida").startsWith("https://", "Debe usar https"),
  ageStage,
  order: z.coerce.number().int().default(0),
  published: checkbox,
});

export async function saveResourceAction(formData: FormData) {
  await requireAdmin();
  const path = `/admin/recursos/${formData.get("id") || "nuevo"}`;
  const { id, ...data } = parse(resourceSchema, formData, path);
  const resource = id
    ? await db.resource.update({ where: { id }, data })
    : await db.resource.create({ data });
  revalidatePath("/recursos");
  done(`/admin/recursos/${resource.id}`, "Recurso guardado");
}

export async function deleteResourceAction(formData: FormData) {
  await requireAdmin();
  await db.resource.delete({ where: { id: String(formData.get("id")) } });
  done("/admin/recursos", "Recurso eliminado");
}

/* ---------- Plantillas de pactos ---------- */

const templateSchema = z.object({
  id: z.string().optional(),
  appName: z.string().trim().min(2).max(60),
  slug: z.string().trim().max(80).optional(),
  description: z.string().trim().max(500).default(""),
  color: z.string().regex(/^#[0-9a-fA-F]{6}$/, "Color hexadecimal, ej. #3DAEE4"),
  minAge: z.coerce.number().int().min(0).max(18).default(0),
  clauses: z.string().min(1, "Agrega al menos una cláusula"),
  order: z.coerce.number().int().default(0),
  published: checkbox,
});

export async function saveTemplateAction(formData: FormData) {
  await requireAdmin();
  const path = `/admin/pactos/${formData.get("id") || "nuevo"}`;
  const { id, slug, clauses, ...data } = parse(templateSchema, formData, path);
  const list = clauses.split("\n").map((c) => c.trim()).filter(Boolean);
  if (list.length === 0) fail(path, "Agrega al menos una cláusula");
  const finalSlug = slugify(slug || data.appName);
  try {
    const tpl = id
      ? await db.pactTemplate.update({ where: { id }, data: { ...data, slug: finalSlug, clauses: list } })
      : await db.pactTemplate.create({ data: { ...data, slug: finalSlug, clauses: list } });
    revalidatePath("/pactos");
    done(`/admin/pactos/${tpl.id}`, "Plantilla guardada");
  } catch (err) {
    if (isUniqueError(err)) fail(path, "Ya existe una plantilla con ese slug");
    throw err;
  }
}

export async function deleteTemplateAction(formData: FormData) {
  await requireAdmin();
  await db.pactTemplate.delete({ where: { id: String(formData.get("id")) } });
  done("/admin/pactos", "Plantilla eliminada");
}

/* ---------- Comunidad ---------- */

const categorySchema = z.object({
  id: z.string().optional(),
  name: z.string().trim().min(2).max(80),
  description: z.string().trim().max(300).default(""),
  order: z.coerce.number().int().default(0),
});

export async function saveCategoryAction(formData: FormData) {
  await requireAdmin();
  const { id, ...data } = parse(categorySchema, formData, "/admin/comunidad");
  try {
    if (id) await db.forumCategory.update({ where: { id }, data });
    else await db.forumCategory.create({ data: { ...data, slug: slugify(data.name) } });
  } catch (err) {
    if (isUniqueError(err)) fail("/admin/comunidad", "Ya existe una categoría con ese nombre");
    throw err;
  }
  done("/admin/comunidad", "Categoría guardada");
}

export async function deleteCategoryAction(formData: FormData) {
  await requireAdmin();
  const id = String(formData.get("id"));
  const threads = await db.forumThread.count({ where: { categoryId: id } });
  if (threads > 0) fail("/admin/comunidad", "La categoría tiene conversaciones; muévelas o elimínalas primero");
  await db.forumCategory.delete({ where: { id } });
  done("/admin/comunidad", "Categoría eliminada");
}

export async function resolveReportAction(formData: FormData) {
  await requireAdmin();
  const id = String(formData.get("id"));
  const hide = formData.get("hide") === "1";
  const report = await db.forumReport.findUnique({ where: { id } });
  if (!report) return;
  if (hide) {
    if (report.postId) await db.forumPost.update({ where: { id: report.postId }, data: { hidden: true } });
    else if (report.threadId) await db.forumThread.update({ where: { id: report.threadId }, data: { hidden: true } });
  }
  // Se resuelven todos los reportes abiertos sobre el mismo contenido.
  await db.forumReport.updateMany({
    where: { resolved: false, postId: report.postId, threadId: report.threadId },
    data: { resolved: true },
  });
  done("/admin/comunidad", hide ? "Contenido ocultado" : "Reporte descartado");
}

/* ---------- Planes ---------- */

const planSchema = z.object({
  id: z.string().optional(),
  name: z.string().trim().min(2).max(80),
  description: z.string().trim().max(300).default(""),
  priceCop: z.coerce.number().int().min(1000),
  interval: z.enum(["MONTH", "YEAR"]),
  order: z.coerce.number().int().default(0),
  active: checkbox,
});

export async function savePlanAction(formData: FormData) {
  await requireAdmin();
  const { id, ...data } = parse(planSchema, formData, "/admin/planes");
  try {
    if (id) await db.plan.update({ where: { id }, data });
    else await db.plan.create({ data: { ...data, slug: slugify(data.name) } });
  } catch (err) {
    if (isUniqueError(err)) fail("/admin/planes", "Ya existe un plan con ese nombre");
    throw err;
  }
  revalidatePath("/planes");
  done("/admin/planes", "Plan guardado");
}

/* ---------- Pagos ---------- */

export async function markOrderPaidAction(formData: FormData) {
  await requireAdmin();
  const id = String(formData.get("id"));
  const ok = await fulfillOrder(id, `manual-${Date.now()}`);
  if (!ok) fail("/admin/pagos", "La orden ya no estaba pendiente");
  done("/admin/pagos", "Orden marcada como pagada y acceso entregado");
}

/* ---------- Juegos ---------- */

const gameSchema = z.object({
  id: z.string().optional(),
  title: z.string().trim().min(2).max(140),
  slug: z.string().trim().max(80).optional(),
  description: z.string().trim().max(600).default(""),
  ageLabel: z.string().trim().max(40).default(""),
  emoji: z.string().trim().max(8).default("🎲"),
  color: z.string().regex(/^#[0-9a-fA-F]{6}$/, "Color hexadecimal, ej. #3DAEE4"),
  order: z.coerce.number().int().default(0),
  published: checkbox,
});

const MAX_GAME_BYTES = 1_500_000;

export async function saveGameAction(formData: FormData) {
  await requireAdmin();
  const id = formData.get("id") || "";
  const path = `/admin/juegos/${id || "nuevo"}`;
  const file = formData.get("file");
  formData.delete("file");
  const { id: _id, slug, ...data } = parse(gameSchema, formData, path);

  let html: string | undefined;
  if (file instanceof File && file.size > 0) {
    if (file.size > MAX_GAME_BYTES) fail(path, "El archivo supera 1,5 MB");
    html = await file.text();
    if (!/<html[\s>]/i.test(html)) fail(path, "El archivo debe ser una página HTML completa");
  }
  if (!id && !html) fail(path, "Sube el archivo HTML del juego");

  const finalSlug = slugify(slug || data.title);
  try {
    const game = id
      ? await db.game.update({ where: { id: String(id) }, data: { ...data, slug: finalSlug, ...(html ? { html } : {}) } })
      : await db.game.create({ data: { ...data, slug: finalSlug, html: html! } });
    revalidatePath("/juegos");
    done(`/admin/juegos/${game.id}`, html && id ? "Juego actualizado con el nuevo archivo" : "Juego guardado");
  } catch (err) {
    if (isUniqueError(err)) fail(path, "Ya existe un juego con ese slug");
    throw err;
  }
}

export async function deleteGameAction(formData: FormData) {
  await requireAdmin();
  await db.game.delete({ where: { id: String(formData.get("id")) } });
  revalidatePath("/juegos");
  done("/admin/juegos", "Juego eliminado");
}
