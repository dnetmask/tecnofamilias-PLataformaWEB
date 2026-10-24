import "server-only";
import { Prisma, type Lesson } from "@prisma/client";
import { redirect } from "next/navigation";
import { requireUser } from "./auth";
import { db } from "./db";
import type { ToolViewer } from "./tools";

export async function getActiveSubscription(userId: string) {
  const sub = await db.subscription.findUnique({ where: { userId }, include: { plan: true } });
  if (!sub || sub.status !== "ACTIVE" || sub.currentPeriodEnd < new Date()) return null;
  return sub;
}

export async function isSubscriber(userId: string | undefined | null) {
  if (!userId) return false;
  return (await getActiveSubscription(userId)) !== null;
}

/** Los administradores ven todo; el resto necesita suscripción activa. */
export async function hasMemberAccess(user: { id: string; role: string } | null) {
  if (!user) return false;
  return user.role === "ADMIN" || isSubscriber(user.id);
}

/** Para páginas solo de suscriptores: sin suscripción se envía a /planes. */
export async function requireSubscriber(next: string) {
  const user = await requireUser(next);
  if (!(await hasMemberAccess(user))) redirect("/planes?requiere=suscripcion");
  return user;
}

/**
 * Toda clase requiere suscripción activa; los complementos además requieren
 * haberlos comprado.
 */
export async function canWatchLesson(
  user: { id: string; role: string } | null,
  lesson: Pick<Lesson, "id" | "access">,
) {
  if (!user) return false;
  if (user.role === "ADMIN") return true;
  if (!(await isSubscriber(user.id))) return false;
  if (lesson.access === "INCLUDED") return true;
  return hasPurchased(user.id, lesson.id);
}

export async function hasPurchased(userId: string, lessonId: string) {
  const purchase = await db.purchase.findUnique({ where: { userId_lessonId: { userId, lessonId } } });
  return purchase !== null;
}

/** Lo que se necesita para decidir qué herramientas puede abrir el usuario. */
export async function getToolViewer(user: { id: string; role: string } | null): Promise<ToolViewer> {
  if (!user) return { loggedIn: false, member: false, admin: false, purchased: new Set() };
  const [member, purchases] = await Promise.all([
    hasMemberAccess(user),
    db.resourcePurchase.findMany({ where: { userId: user.id }, select: { resourceId: true } }),
  ]);
  return { loggedIn: true, member, admin: user.role === "ADMIN", purchased: new Set(purchases.map((p) => p.resourceId)) };
}

/** Cuenta a cada usuario una sola vez por herramienta para el ranking de las más usadas. */
export async function recordToolUse(userId: string, resourceId: string) {
  try {
    await db.$transaction([
      db.resourceUse.create({ data: { userId, resourceId } }),
      db.resource.update({ where: { id: resourceId }, data: { uses: { increment: 1 } } }),
    ]);
  } catch (err) {
    if (!(err instanceof Prisma.PrismaClientKnownRequestError && err.code === "P2002")) throw err;
  }
}
