"use server";

import { redirect } from "next/navigation";
import { z } from "zod";
import type { FormState } from "@/components/FormMessage";
import { endSession, hashPassword, startSession, verifyPassword } from "@/lib/auth";
import { db } from "@/lib/db";
import { safeNext } from "@/lib/url";
import { isSubscriber } from "@/lib/access";
import { isPlatformOpen, isServiceCheckout } from "@/lib/launch";


const registerSchema = z.object({
  name: z.string().trim().min(2, "Escribe tu nombre").max(80),
  email: z.string().trim().toLowerCase().email("Correo no válido"),
  password: z.string().min(8, "La contraseña debe tener al menos 8 caracteres").max(100),
  terms: z.literal("on", { errorMap: () => ({ message: "Debes aceptar los términos y el tratamiento de datos" }) }),
});

export async function registerAction(_: FormState, formData: FormData): Promise<FormState> {
  const parsed = registerSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) return { error: parsed.error.issues[0].message };
  const { name, email, password } = parsed.data;
  if (!(await isPlatformOpen()) && !isServiceCheckout(formData.get("next"))) {
    return { error: "La creación de cuentas abre muy pronto." };
  }

  const exists = await db.user.findUnique({ where: { email } });
  if (exists) return { error: "Ya existe una cuenta con ese correo" };

  const user = await db.user.create({
    data: { name, email, passwordHash: await hashPassword(password), acceptedTermsAt: new Date() },
  });
  await startSession(user);
  redirect(safeNext(formData.get("next"), "/planes"));
}

const loginSchema = z.object({
  email: z.string().trim().toLowerCase().email("Correo no válido"),
  password: z.string().min(1, "Escribe tu contraseña"),
});

export async function loginAction(_: FormState, formData: FormData): Promise<FormState> {
  const parsed = loginSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) return { error: parsed.error.issues[0].message };
  const user = await db.user.findUnique({ where: { email: parsed.data.email } });
  // Mismo mensaje para correo inexistente o clave errada.
  if (!user || !(await verifyPassword(parsed.data.password, user.passwordHash))) {
    return { error: "Correo o contraseña incorrectos" };
  }
  if (!user.active) return { error: "Tu cuenta está desactivada. Escríbenos para reactivarla." };
  await startSession(user);
  // Al ingresar se va al inicio; quien aún no tiene plan va a elegirlo.
  const fallback = user.role === "ADMIN" || (await isSubscriber(user.id)) ? "/" : "/planes";
  redirect(safeNext(formData.get("next"), fallback));
}

export async function logoutAction() {
  await endSession();
  redirect("/");
}
