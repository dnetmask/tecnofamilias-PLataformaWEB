"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { z } from "zod";
import type { FormState } from "@/components/FormMessage";
import { hasMemberAccess } from "@/lib/access";
import { requireAdmin, requireUser } from "@/lib/auth";
import { db } from "@/lib/db";

async function requirePoster() {
  const user = await requireUser("/comunidad");
  if (!(await hasMemberAccess(user))) {
    return { user, error: "Para publicar en la comunidad necesitas una suscripción activa." };
  }
  // Freno básico contra spam: una publicación cada 15 segundos.
  const since = new Date(Date.now() - 15_000);
  const [t, p] = await Promise.all([
    db.forumThread.count({ where: { authorId: user.id, createdAt: { gt: since } } }),
    db.forumPost.count({ where: { authorId: user.id, createdAt: { gt: since } } }),
  ]);
  if (t + p > 0) return { user, error: "Espera unos segundos antes de volver a publicar." };
  return { user, error: null };
}

const threadSchema = z.object({
  categoryId: z.string().min(1),
  title: z.string().trim().min(5, "El título es muy corto").max(140),
  body: z.string().trim().min(10, "Cuéntanos un poco más").max(8000),
});

export async function createThreadAction(_: FormState, formData: FormData): Promise<FormState> {
  const { user, error } = await requirePoster();
  if (error) return { error };
  const parsed = threadSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) return { error: parsed.error.issues[0].message };
  const category = await db.forumCategory.findUnique({ where: { id: parsed.data.categoryId } });
  if (!category) return { error: "Categoría no válida" };
  const thread = await db.forumThread.create({
    data: { ...parsed.data, authorId: user.id },
  });
  redirect(`/comunidad/hilo/${thread.id}`);
}

const replySchema = z.object({
  threadId: z.string().min(1),
  body: z.string().trim().min(2, "Escribe tu respuesta").max(8000),
});

export async function replyAction(_: FormState, formData: FormData): Promise<FormState> {
  const { user, error } = await requirePoster();
  if (error) return { error };
  const parsed = replySchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) return { error: parsed.error.issues[0].message };
  const thread = await db.forumThread.findUnique({ where: { id: parsed.data.threadId } });
  if (!thread || thread.hidden) return { error: "La conversación no existe" };
  if (thread.locked && user.role !== "ADMIN") return { error: "Esta conversación está cerrada" };
  await db.$transaction([
    db.forumPost.create({ data: { threadId: thread.id, authorId: user.id, body: parsed.data.body } }),
    db.forumThread.update({ where: { id: thread.id }, data: { lastPostAt: new Date() } }),
  ]);
  revalidatePath(`/comunidad/hilo/${thread.id}`);
  return { ok: "Respuesta publicada" };
}

export async function reportAction(formData: FormData) {
  const user = await requireUser("/comunidad");
  const threadId = String(formData.get("threadId") ?? "") || null;
  const postId = String(formData.get("postId") ?? "") || null;
  const reason = String(formData.get("reason") ?? "Contenido inapropiado").slice(0, 300);
  if (!threadId && !postId) return;
  const existing = await db.forumReport.findFirst({
    where: { reporterId: user.id, threadId, postId, resolved: false },
  });
  if (!existing) await db.forumReport.create({ data: { reporterId: user.id, threadId, postId, reason } });
  const tid = threadId ?? (await db.forumPost.findUnique({ where: { id: postId! } }))?.threadId;
  redirect(`/comunidad/hilo/${tid}?reportado=1`);
}

export async function deleteOwnPostAction(formData: FormData) {
  const user = await requireUser("/comunidad");
  const post = await db.forumPost.findUnique({ where: { id: String(formData.get("postId")) } });
  if (!post || (post.authorId !== user.id && user.role !== "ADMIN")) return;
  await db.forumPost.delete({ where: { id: post.id } });
  revalidatePath(`/comunidad/hilo/${post.threadId}`);
}

/* Moderación (solo administradores) */

export async function moderateThreadAction(formData: FormData) {
  await requireAdmin();
  const id = String(formData.get("threadId"));
  const op = String(formData.get("op"));
  const thread = await db.forumThread.findUnique({ where: { id } });
  if (!thread) return;
  if (op === "delete") {
    const category = await db.forumCategory.findUnique({ where: { id: thread.categoryId } });
    await db.forumThread.delete({ where: { id } });
    redirect(`/comunidad/${category?.slug ?? ""}`);
  }
  const data =
    op === "pin" ? { pinned: !thread.pinned } :
    op === "lock" ? { locked: !thread.locked } :
    op === "hide" ? { hidden: !thread.hidden } : {};
  await db.forumThread.update({ where: { id }, data });
  revalidatePath(`/comunidad/hilo/${id}`);
}

export async function moderatePostAction(formData: FormData) {
  await requireAdmin();
  const post = await db.forumPost.findUnique({ where: { id: String(formData.get("postId")) } });
  if (!post) return;
  await db.forumPost.update({ where: { id: post.id }, data: { hidden: !post.hidden } });
  revalidatePath(`/comunidad/hilo/${post.threadId}`);
}
