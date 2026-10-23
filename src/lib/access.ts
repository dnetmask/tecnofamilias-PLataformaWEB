import "server-only";
import type { Lesson } from "@prisma/client";
import { db } from "./db";

export async function getActiveSubscription(userId: string) {
  const sub = await db.subscription.findUnique({ where: { userId }, include: { plan: true } });
  if (!sub || sub.status !== "ACTIVE" || sub.currentPeriodEnd < new Date()) return null;
  return sub;
}

export async function isSubscriber(userId: string | undefined | null) {
  if (!userId) return false;
  return (await getActiveSubscription(userId)) !== null;
}

export async function canWatchLesson(
  user: { id: string; role: string } | null,
  lesson: Pick<Lesson, "id" | "access">,
) {
  if (!user) return false;
  if (user.role === "ADMIN") return true;
  if (lesson.access === "FREE") return true;
  if (lesson.access === "INCLUDED") return isSubscriber(user.id);
  const purchase = await db.purchase.findUnique({
    where: { userId_lessonId: { userId: user.id, lessonId: lesson.id } },
  });
  return purchase !== null;
}

/** Los usuarios sin suscripción pueden crear un pacto de prueba. */
export const FREE_PACT_LIMIT = 1;
