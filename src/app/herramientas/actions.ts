"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { requireUser } from "@/lib/auth";
import { db } from "@/lib/db";

/** Agrega o quita una herramienta de los favoritos del usuario. */
export async function toggleFavoriteAction(formData: FormData) {
  const resourceId = String(formData.get("id") ?? "");
  const raw = String(formData.get("back") ?? "");
  const back = raw.startsWith("/herramientas") ? raw : "/herramientas";
  const user = await requireUser(back);
  const key = { userId_resourceId: { userId: user.id, resourceId } };
  const existing = await db.resourceFavorite.findUnique({ where: key });
  if (existing) {
    await db.resourceFavorite.delete({ where: key });
  } else if (await db.resource.findFirst({ where: { id: resourceId, published: true }, select: { id: true } })) {
    await db.resourceFavorite.create({ data: { userId: user.id, resourceId } });
  }
  revalidatePath("/herramientas");
  redirect(back);
}
