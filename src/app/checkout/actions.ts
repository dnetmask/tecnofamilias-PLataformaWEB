"use server";

import { redirect } from "next/navigation";
import { canWatchLesson, getToolViewer, hasMemberAccess } from "@/lib/access";
import { requireUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { chargeCop } from "@/lib/currency";
import { fulfillOrder, paymentsMode, startCheckout } from "@/lib/payments";
import { getRatesInfo } from "@/lib/pricing";
import { canUseTool } from "@/lib/tools";

export async function createOrderAction(formData: FormData) {
  const planSlug = formData.get("plan");
  const lessonSlug = formData.get("clase");
  const serviceSlug = formData.get("servicio");
  const toolSlug = formData.get("herramienta");
  const user = await requireUser("/planes");
  // El precio base está en dólares: se convierte a COP con la tasa del día (o se usa el precio fijo en COP)
  // y se guarda la tasa efectiva.
  const { rates } = await getRatesInfo();
  const amounts = (usd: number, cop?: number | null) => {
    const amountCop = chargeCop(usd, rates, cop);
    return { amountUsd: usd, amountCop, fxRate: cop ? amountCop / usd : rates.COP };
  };

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
        ...amounts(plan.priceUsd, plan.priceCop),
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
    if (!service || !service.active || !service.priceUsd) redirect("/planes#servicios");
    order = await db.order.create({
      data: {
        userId: user.id,
        kind: "SERVICE",
        serviceId: service.id,
        description: `Servicio: ${service.name}`,
        ...amounts(service.priceUsd, service.priceCop),
        provider: paymentsMode(),
      },
    });
  } else if (typeof toolSlug === "string" && toolSlug) {
    // Herramientas pagas: pago adicional a una suscripción activa.
    const tool = await db.resource.findUnique({ where: { slug: toolSlug } });
    if (!tool || !tool.published || tool.access !== "PAID") redirect("/herramientas");
    if (!(await hasMemberAccess(user))) redirect("/planes?requiere=suscripcion");
    if (canUseTool(await getToolViewer(user), tool)) redirect(`/herramientas/${tool.slug}`);
    order = await db.order.create({
      data: {
        userId: user.id,
        kind: "RESOURCE",
        resourceId: tool.id,
        description: `Herramienta: ${tool.title}`,
        ...amounts(tool.priceUsd, tool.priceCop),
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
