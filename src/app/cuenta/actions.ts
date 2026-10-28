"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { z } from "zod";
import type { FormState } from "@/components/FormMessage";
import { endSession, hashPassword, requireUser, startSession, verifyPassword } from "@/lib/auth";
import { deleteUserAccount } from "@/lib/account";
import { db } from "@/lib/db";

export async function updateProfileAction(_: FormState, formData: FormData): Promise<FormState> {
  const user = await requireUser("/cuenta");
  const name = z.string().trim().min(2).max(80).safeParse(formData.get("name"));
  if (!name.success) return { error: "Escribe un nombre válido" };
  await db.user.update({ where: { id: user.id }, data: { name: name.data } });
  revalidatePath("/", "layout");
  return { ok: "Datos actualizados" };
}

export async function changePasswordAction(_: FormState, formData: FormData): Promise<FormState> {
  const user = await requireUser("/cuenta");
  const current = String(formData.get("current") ?? "");
  const next = String(formData.get("next") ?? "");
  if (next.length < 8) return { error: "La nueva contraseña debe tener al menos 8 caracteres" };
  const record = await db.user.findUniqueOrThrow({ where: { id: user.id } });
  if (!(await verifyPassword(current, record.passwordHash))) return { error: "La contraseña actual no es correcta" };
  await db.user.update({ where: { id: user.id }, data: { passwordHash: await hashPassword(next), passwordChangedAt: new Date() } });
  // Se cierran las sesiones de otros dispositivos y esta sigue abierta con una nueva.
  await startSession(user);
  return { ok: "Contraseña actualizada. Cerramos la sesión en tus otros dispositivos." };
}

/** El usuario elimina su propia cuenta (lo exigen las tiendas de apps y la Ley 1581). */
export async function deleteAccountAction(_: FormState, formData: FormData): Promise<FormState> {
  const user = await requireUser("/eliminar-cuenta");
  if (user.role === "ADMIN") return { error: "Las cuentas de administrador no se eliminan desde aquí. Pide a otro administrador que lo haga." };
  if (String(formData.get("confirm") ?? "").trim().toUpperCase() !== "ELIMINAR") return { error: "Escribe ELIMINAR para confirmar" };
  const record = await db.user.findUniqueOrThrow({ where: { id: user.id } });
  if (!(await verifyPassword(String(formData.get("password") ?? ""), record.passwordHash))) {
    return { error: "La contraseña no es correcta" };
  }
  await deleteUserAccount(user.id);
  await endSession();
  redirect("/eliminar-cuenta?hecho=1");
}
