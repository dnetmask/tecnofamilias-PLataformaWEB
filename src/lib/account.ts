import "server-only";
import { createHash, randomBytes } from "node:crypto";
import { db } from "./db";

const RESET_TTL_MS = 60 * 60 * 1000; // 1 hora

/** Cookie donde viaja el token del enlace de recuperación (ver /restablecer/[token]). */
export const RESET_COOKIE = "tf_reset";

function hashToken(token: string) {
  return createHash("sha256").update(token).digest("hex");
}

/** Crea un enlace de recuperación de un solo uso y anula los anteriores del usuario. */
export async function createResetToken(userId: string) {
  const token = randomBytes(32).toString("base64url");
  await db.$transaction([
    db.passwordResetToken.deleteMany({ where: { userId } }),
    db.passwordResetToken.create({ data: { userId, tokenHash: hashToken(token), expiresAt: new Date(Date.now() + RESET_TTL_MS) } }),
  ]);
  return token;
}

/** ¿Se pidió un enlace hace muy poco? Evita reenvíos en ráfaga al mismo correo. */
export async function recentlyRequested(userId: string) {
  const last = await db.passwordResetToken.findFirst({ where: { userId }, orderBy: { createdAt: "desc" } });
  return !!last && Date.now() - last.createdAt.getTime() < 60 * 1000;
}

/** Devuelve el token vigente (sin usar ni vencido) o null. */
export async function findValidResetToken(token: string) {
  if (!token || token.length > 100) return null;
  const row = await db.passwordResetToken.findUnique({ where: { tokenHash: hashToken(token) }, include: { user: true } });
  if (!row || row.usedAt || row.expiresAt < new Date() || !row.user.active) return null;
  return row;
}

/**
 * Elimina la cuenta y sus datos personales. Los pagos se conservan sin usuario
 * (obligaciones contables y tributarias) y las solicitudes de servicios quedan
 * anonimizadas. Pactos, compras, favoritos, suscripción y publicaciones del
 * foro se borran con la cuenta.
 */
export async function deleteUserAccount(userId: string) {
  await db.$transaction([
    db.serviceRequest.updateMany({
      where: { userId },
      data: { name: "Cuenta eliminada", email: "", phone: "", organization: "", city: "", message: "", userId: null },
    }),
    db.user.delete({ where: { id: userId } }),
  ]);
}
