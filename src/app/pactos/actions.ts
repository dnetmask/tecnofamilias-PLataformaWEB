"use server";

import { randomBytes } from "node:crypto";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { z } from "zod";
import type { FormState } from "@/components/FormMessage";
import { hasMemberAccess } from "@/lib/access";
import { requireUser } from "@/lib/auth";
import { db } from "@/lib/db";

const newShareToken = () => randomBytes(24).toString("base64url");

// Crear pactos requiere suscripción; los ya creados se pueden seguir viendo,
// firmando, imprimiendo o eliminando aunque la suscripción venza.
const canCreatePact = hasMemberAccess;

const LIMIT_MESSAGE = "Necesitas una suscripción activa para crear pactos.";

const pactSchema = z.object({
  templateId: z.string().optional(),
  appName: z.string().trim().min(2, "Indica la aplicación o el dispositivo").max(60),
  childName: z.string().trim().min(1, "Escribe el nombre de tu hijo o hija").max(60),
  childAge: z.preprocess((v) => (v === "" ? undefined : v), z.coerce.number().int().min(0).max(25).optional()),
  parentName: z.string().trim().min(2, "Escribe tu nombre").max(80),
  rewards: z.string().trim().max(1000).default(""),
  consequences: z.string().trim().max(1000).default(""),
  reviewDate: z.string().optional(),
});

function readClauses(formData: FormData) {
  return formData
    .getAll("clause")
    .map((c) => String(c).trim())
    .filter(Boolean)
    .slice(0, 30)
    .map((c) => c.slice(0, 400));
}

function parseReviewDate(value?: string) {
  if (!value) return null;
  const d = new Date(`${value}T12:00:00-05:00`);
  return Number.isNaN(d.getTime()) ? null : d;
}

export async function createPactAction(_: FormState, formData: FormData): Promise<FormState> {
  const user = await requireUser("/pactos");
  if (!(await canCreatePact(user))) return { error: LIMIT_MESSAGE };
  const parsed = pactSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) return { error: parsed.error.issues[0].message };
  const clauses = readClauses(formData);
  if (clauses.length === 0) return { error: "Agrega al menos una cláusula" };

  const { templateId, reviewDate, childAge, ...data } = parsed.data;
  const template = templateId ? await db.pactTemplate.findUnique({ where: { id: templateId } }) : null;
  const pact = await db.pact.create({
    data: {
      ...data,
      childAge: childAge ?? null,
      clauses,
      reviewDate: parseReviewDate(reviewDate),
      templateId: template?.id ?? null,
      userId: user.id,
      shareToken: newShareToken(),
    },
  });
  redirect(`/pactos/${pact.id}`);
}

async function ownPact(id: string) {
  const user = await requireUser("/pactos");
  const pact = await db.pact.findUnique({ where: { id } });
  if (!pact || pact.userId !== user.id) redirect("/pactos");
  return pact;
}

export async function updatePactAction(_: FormState, formData: FormData): Promise<FormState> {
  const pact = await ownPact(String(formData.get("id")));
  if (pact.status !== "DRAFT") return { error: "El pacto ya fue firmado y no se puede editar." };
  const parsed = pactSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) return { error: parsed.error.issues[0].message };
  const clauses = readClauses(formData);
  if (clauses.length === 0) return { error: "Agrega al menos una cláusula" };
  const { templateId: _t, reviewDate, childAge, ...data } = parsed.data;
  await db.pact.update({
    where: { id: pact.id },
    data: { ...data, childAge: childAge ?? null, clauses, reviewDate: parseReviewDate(reviewDate) },
  });
  redirect(`/pactos/${pact.id}`);
}

const signatureSchema = z
  .string()
  .startsWith("data:image/png;base64,", "Firma no válida")
  .max(400_000, "La firma es demasiado grande");

export async function signPactAction(_: FormState, formData: FormData): Promise<FormState> {
  const pact = await ownPact(String(formData.get("id")));
  const who = formData.get("who");
  const sig = signatureSchema.safeParse(formData.get("signature"));
  if (!sig.success) return { error: "Dibuja la firma antes de confirmar" };

  if (who === "parent") {
    if (pact.parentSignature) return { error: "Ya firmaste este pacto" };
    await db.pact.update({
      where: { id: pact.id },
      data: { parentSignature: sig.data, parentSignedAt: new Date(), status: "PARENT_SIGNED" },
    });
  } else if (who === "child") {
    if (!pact.parentSignature) return { error: "Primero debe firmar el adulto responsable" };
    if (pact.childSignature) return { error: "Este pacto ya tiene la firma del menor" };
    await db.pact.update({
      where: { id: pact.id },
      data: { childSignature: sig.data, childSignedAt: new Date(), status: "SIGNED" },
    });
  }
  revalidatePath(`/pactos/${pact.id}`);
  return { ok: "¡Firma guardada!" };
}

/** Firma del menor desde su propio dispositivo con el enlace compartido. */
export async function signByTokenAction(_: FormState, formData: FormData): Promise<FormState> {
  const token = String(formData.get("token") ?? "");
  const pact = token ? await db.pact.findUnique({ where: { shareToken: token } }) : null;
  if (!pact) return { error: "Enlace no válido" };
  if (!pact.parentSignature) return { error: "Primero debe firmar el adulto responsable" };
  if (pact.childSignature) return { error: "Este pacto ya fue firmado" };
  const sig = signatureSchema.safeParse(formData.get("signature"));
  if (!sig.success) return { error: "Dibuja tu firma antes de confirmar" };
  await db.pact.update({
    where: { id: pact.id },
    data: { childSignature: sig.data, childSignedAt: new Date(), status: "SIGNED" },
  });
  revalidatePath(`/pactos/firmar/${token}`);
  return { ok: "¡Gracias! El pacto quedó firmado." };
}

export async function regenerateTokenAction(formData: FormData) {
  const pact = await ownPact(String(formData.get("id")));
  await db.pact.update({ where: { id: pact.id }, data: { shareToken: newShareToken() } });
  revalidatePath(`/pactos/${pact.id}`);
}

/** Crea una copia editable (por ejemplo, para renovarlo en la fecha de revisión). */
export async function duplicatePactAction(formData: FormData) {
  const pact = await ownPact(String(formData.get("id")));
  const user = await requireUser("/pactos");
  if (!(await canCreatePact(user))) redirect("/planes");
  const copy = await db.pact.create({
    data: {
      userId: pact.userId,
      templateId: pact.templateId,
      appName: pact.appName,
      childName: pact.childName,
      childAge: pact.childAge,
      parentName: pact.parentName,
      clauses: pact.clauses ?? [],
      rewards: pact.rewards,
      consequences: pact.consequences,
      shareToken: newShareToken(),
    },
  });
  redirect(`/pactos/${copy.id}/editar`);
}

export async function deletePactAction(formData: FormData) {
  const pact = await ownPact(String(formData.get("id")));
  await db.pact.delete({ where: { id: pact.id } });
  redirect("/pactos");
}
