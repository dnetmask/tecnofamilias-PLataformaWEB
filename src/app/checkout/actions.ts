"use server";

import { redirect } from "next/navigation";
import { canWatchLesson } from "@/lib/access";
import { requireUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { fulfillOrder, paymentsMode, startCheckout } from "@/lib/payments";

export async function createOrderAction(formData: FormData) {
  const planSlug = formData.get("plan");
  const lessonSlug = formData.get("clase");
  const user = await requireUser("/planes");

  let order;
  if (typeof planSlug === "string" && planSlug) {
    const plan = await db.plan.findUnique({ where: { slug: planSlug } });
    if (!plan || !plan.active) redirect("/planes");
    order = await db.order.create({
      data: {
        userId: user.id,
        kind: "SUBSCRIPTION",
        planId: plan.id,
        description: `Tecnofamilias · ${plan.name}`,
        amountCop: plan.priceCop,
        provider: paymentsMode(),
      },
    });
  } else if (typeof lessonSlug === "string" && lessonSlug) {
    const lesson = await db.lesson.findUnique({ where: { slug: lessonSlug } });
    if (!lesson || !lesson.published || lesson.access !== "PAID") redirect("/clases");
    if (await canWatchLesson(user, lesson)) redirect(`/clases/${lesson.slug}`);
    order = await db.order.create({
      data: {
        userId: user.id,
        kind: "LESSON",
        lessonId: lesson.id,
        description: `Clase: ${lesson.title}`,
        amountCop: lesson.priceCop,
        provider: paymentsMode(),
      },
    });
  } else {
    redirect("/planes");
  }

  const url = await startCheckout(order, user.email);
  redirect(url);
}

/** Solo en modo demo: aprueba la orden sin cobro real. */
export async function approveDemoOrderAction(formData: FormData) {
  if (paymentsMode() !== "demo") throw new Error("El modo demo de pagos está desactivado");
  const user = await requireUser();
  const orderId = String(formData.get("orderId") ?? "");
  const order = await db.order.findUnique({ where: { id: orderId } });
  if (!order || order.userId !== user.id) redirect("/cuenta");
  await fulfillOrder(order.id, `demo-${Date.now()}`);
  redirect(`/checkout/resultado?orden=${order.id}`);
}
