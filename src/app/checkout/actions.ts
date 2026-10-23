"use server";

import { redirect } from "next/navigation";
import { canWatchLesson, hasMemberAccess } from "@/lib/access";
import { requireUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { chargeCop } from "@/lib/currency";
import { fulfillOrder, paymentsMode, startCheckout } from "@/lib/payments";
import { getRatesInfo } from "@/lib/pricing";

export async function createOrderAction(formData: FormData) {
  const planSlug = formData.get("plan");
  const lessonSlug = formData.get("clase");
  const serviceSlug = formData.get("servicio");
  const user = await requireUser("/planes");
  // El precio base está en dólares: se convierte a COP con la tasa del día y se guarda la tasa usada.
  const { rates } = await getRatesInfo();
  const amounts = (usd: number) => ({ amountUsd: usd, amountCop: chargeCop(usd, rates), fxRate: rates.COP });

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
        ...amounts(plan.priceUsd),
        provider: paymentsMode(),
      },
    });
  } else if (typeof lessonSlug === "string" && lessonSlug) {
    const lesson = await db.lesson.findUnique({ where: { slug: lessonSlug } });
    if (!lesson || !lesson.published || lesson.access !== "ADDON") redirect("/clases");
    // Los complementos se suman a una suscripción activa.
    if (!(await hasMemberAccess(user))) redirect("/planes?requiere=suscripcion");
    if (await canWatchLesson(user, lesson)) redirect(`/clases/${lesson.slug}`);
    order = await db.order.create({
      data: {
        userId: user.id,
        kind: "LESSON",
        lessonId: lesson.id,
        description: `Complemento: ${lesson.title}`,
        ...amounts(lesson.priceUsd),
        provider: paymentsMode(),
      },
    });
  } else if (typeof serviceSlug === "string" && serviceSlug) {
    // Servicios con precio fijo (p. ej. asesoría): no requieren suscripción.
    const service = await db.service.findUnique({ where: { slug: serviceSlug } });
    if (!service || !service.active || !service.priceUsd) redirect("/servicios");
    order = await db.order.create({
      data: {
        userId: user.id,
        kind: "SERVICE",
        serviceId: service.id,
        description: `Servicio: ${service.name}`,
        ...amounts(service.priceUsd),
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
