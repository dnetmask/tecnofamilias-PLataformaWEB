"use server";

import { redirect } from "next/navigation";
import { z } from "zod";
import type { FormState } from "@/components/FormMessage";
import { endSession, hashPassword, startSession, verifyPassword } from "@/lib/auth";
import { db } from "@/lib/db";
import { safeNext } from "@/lib/url";
import { isSubscriber } from "@/lib/access";
import { isPlatformOpen, isServiceCheckout } from "@/lib/launch";
import { createResetToken, findValidResetToken, recentlyRequested, RESET_COOKIE } from "@/lib/account";
import { cookies } from "next/headers";
import { sendEmail } from "@/lib/email";
import { appUrl } from "@/lib/payments";


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

/* ---------- Recuperar contraseña ---------- */

export async function requestResetAction(_: FormState, formData: FormData): Promise<FormState> {
  const email = z.string().trim().toLowerCase().email().safeParse(formData.get("email"));
  if (!email.success) return { error: "Correo no válido" };
  // La respuesta es la misma exista o no la cuenta, para no revelar qué correos están registrados.
  const sent = { ok: "Si hay una cuenta con ese correo, te enviamos un enlace para crear una nueva contraseña. Revisa también la carpeta de spam. El enlace vence en 1 hora." };
  const user = await db.user.findUnique({ where: { email: email.data } });
  if (!user || !user.active || (await recentlyRequested(user.id))) return sent;

  const token = await createResetToken(user.id);
  const link = `${appUrl()}/restablecer/${token}`;
  const first = user.name.split(" ")[0];
  await sendEmail({
    to: user.email,
    subject: "Crea una nueva contraseña · Tecnofamilias",
    text: `Hola, ${first}:\n\nRecibimos una solicitud para cambiar la contraseña de tu cuenta de Tecnofamilias. Abre este enlace para crear una nueva (vence en 1 hora):\n\n${link}\n\nSi no fuiste tú, ignora este correo: tu contraseña no cambia.\n\nEquipo Tecnofamilias`,
    html: `<div style="font-family:Arial,sans-serif;color:#28395f;max-width:520px">
<p>Hola, ${escapeHtml(first)}:</p>
<p>Recibimos una solicitud para cambiar la contraseña de tu cuenta de Tecnofamilias.</p>
<p><a href="${link}" style="display:inline-block;background:#283a60;color:#fff;padding:12px 22px;border-radius:999px;text-decoration:none;font-weight:bold">Crear nueva contraseña</a></p>
<p style="font-size:13px;color:#5b6884">El enlace vence en 1 hora y sirve una sola vez. Si no fuiste tú, ignora este correo: tu contraseña no cambia.</p>
<p>Equipo Tecnofamilias</p></div>`,
  });
  return sent;
}

const resetSchema = z
  .object({
    password: z.string().min(8, "La contraseña debe tener al menos 8 caracteres").max(100),
    confirm: z.string(),
  })
  .refine((d) => d.password === d.confirm, { message: "Las contraseñas no coinciden" });

export async function resetPasswordAction(_: FormState, formData: FormData): Promise<FormState> {
  const parsed = resetSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) return { error: parsed.error.issues[0].message };
  const jar = await cookies();
  const row = await findValidResetToken(jar.get(RESET_COOKIE)?.value ?? "");
  if (!row) return { error: "El enlace venció o ya se usó. Pide uno nuevo." };
  const now = new Date();
  await db.$transaction([
    db.user.update({ where: { id: row.userId }, data: { passwordHash: await hashPassword(parsed.data.password), passwordChangedAt: now } }),
    db.passwordResetToken.deleteMany({ where: { userId: row.userId } }),
  ]);
  jar.delete(RESET_COOKIE);
  // Las sesiones de otros dispositivos se cierran; aquí se inicia una nueva.
  await startSession(row.user);
  redirect("/cuenta?clave=nueva");
}

function escapeHtml(s: string) {
  return s.replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" })[c]!);
}
