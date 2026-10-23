import "server-only";
import { createHmac, timingSafeEqual } from "node:crypto";
import type { Order, PlanInterval } from "@prisma/client";
import { db } from "./db";

export type PaymentsMode = "mercadopago" | "demo";

export function paymentsMode(): PaymentsMode {
  return process.env.PAYMENTS_MODE === "mercadopago" ? "mercadopago" : "demo";
}

export function appUrl() {
  return (process.env.APP_URL ?? "http://localhost:3000").replace(/\/$/, "");
}

const MP_API = "https://api.mercadopago.com";

function mpToken() {
  const token = process.env.MP_ACCESS_TOKEN;
  if (!token) throw new Error("Falta MP_ACCESS_TOKEN");
  return token;
}

/** Devuelve la URL a la que se envía al usuario para pagar la orden. */
export async function startCheckout(order: Order, payerEmail: string): Promise<string> {
  if (paymentsMode() === "demo") return `/checkout/demo/${order.id}`;

  const res = await fetch(`${MP_API}/checkout/preferences`, {
    method: "POST",
    headers: {
      Authorization: `Bearer ${mpToken()}`,
      "Content-Type": "application/json",
      "X-Idempotency-Key": order.id,
    },
    body: JSON.stringify({
      items: [
        { id: order.id, title: order.description, quantity: 1, unit_price: order.amountCop, currency_id: "COP" },
      ],
      payer: { email: payerEmail },
      external_reference: order.id,
      back_urls: {
        success: `${appUrl()}/checkout/resultado?orden=${order.id}`,
        pending: `${appUrl()}/checkout/resultado?orden=${order.id}`,
        failure: `${appUrl()}/checkout/resultado?orden=${order.id}`,
      },
      auto_return: "approved",
      notification_url: `${appUrl()}/api/webhooks/mercadopago`,
      statement_descriptor: "TECNOFAMILIAS",
    }),
  });
  if (!res.ok) {
    throw new Error(`Mercado Pago respondió ${res.status}: ${await res.text()}`);
  }
  const pref = (await res.json()) as { id: string; init_point: string };
  await db.order.update({ where: { id: order.id }, data: { providerRef: pref.id } });
  return pref.init_point;
}

type MpPayment = {
  id: number;
  status: string;
  external_reference: string | null;
  transaction_amount: number;
  currency_id: string;
};

export async function fetchMpPayment(paymentId: string): Promise<MpPayment> {
  const res = await fetch(`${MP_API}/v1/payments/${encodeURIComponent(paymentId)}`, {
    headers: { Authorization: `Bearer ${mpToken()}` },
    cache: "no-store",
  });
  if (!res.ok) throw new Error(`No se pudo consultar el pago ${paymentId}: ${res.status}`);
  return res.json();
}

/**
 * Verifica la cabecera x-signature de Mercado Pago. Si no hay secreto
 * configurado se acepta la notificación, porque igual se vuelve a consultar
 * el pago contra la API antes de entregar cualquier acceso.
 */
export function verifyMpSignature(headers: Headers, dataId: string) {
  const secret = process.env.MP_WEBHOOK_SECRET;
  if (!secret) return true;
  const signature = headers.get("x-signature") ?? "";
  const requestId = headers.get("x-request-id") ?? "";
  const parts = Object.fromEntries(
    signature.split(",").map((p) => p.trim().split("=", 2) as [string, string]),
  );
  if (!parts.ts || !parts.v1) return false;
  const manifest = `id:${dataId.toLowerCase()};request-id:${requestId};ts:${parts.ts};`;
  const expected = createHmac("sha256", secret).update(manifest).digest("hex");
  const a = Buffer.from(expected);
  const b = Buffer.from(parts.v1);
  return a.length === b.length && timingSafeEqual(a, b);
}

function addInterval(from: Date, interval: PlanInterval) {
  const d = new Date(from);
  if (interval === "YEAR") d.setFullYear(d.getFullYear() + 1);
  else d.setMonth(d.getMonth() + 1);
  return d;
}

/** Extiende (o crea) la suscripción del usuario un período del plan. */
export async function extendSubscription(
  userId: string,
  planId: string,
  interval: PlanInterval,
  grantedByAdmin = false,
  tx: Pick<typeof db, "subscription"> = db,
) {
  const now = new Date();
  const current = await tx.subscription.findUnique({ where: { userId } });
  const base =
    current && current.status === "ACTIVE" && current.currentPeriodEnd > now ? current.currentPeriodEnd : now;
  const currentPeriodEnd = addInterval(base, interval);
  return tx.subscription.upsert({
    where: { userId },
    create: { userId, planId, currentPeriodEnd, status: "ACTIVE", grantedByAdmin },
    update: { planId, currentPeriodEnd, status: "ACTIVE", grantedByAdmin },
  });
}

/**
 * Marca la orden como pagada y entrega el acceso. Es idempotente: si la orden
 * ya no está pendiente no hace nada (los webhooks pueden llegar repetidos).
 */
export async function fulfillOrder(orderId: string, providerRef?: string) {
  return db.$transaction(async (tx) => {
    const updated = await tx.order.updateMany({
      where: { id: orderId, status: "PENDING" },
      data: { status: "PAID", paidAt: new Date(), ...(providerRef ? { providerRef } : {}) },
    });
    if (updated.count === 0) return false;
    const order = await tx.order.findUniqueOrThrow({ where: { id: orderId }, include: { plan: true } });

    if (order.kind === "SUBSCRIPTION" && order.plan) {
      await extendSubscription(order.userId, order.plan.id, order.plan.interval, false, tx);
    }
    if (order.kind === "LESSON" && order.lessonId) {
      await tx.purchase.upsert({
        where: { userId_lessonId: { userId: order.userId, lessonId: order.lessonId } },
        create: { userId: order.userId, lessonId: order.lessonId, orderId: order.id },
        update: {},
      });
    }
    return true;
  });
}

export async function failOrder(orderId: string) {
  await db.order.updateMany({ where: { id: orderId, status: "PENDING" }, data: { status: "FAILED" } });
}
