import "server-only";
import { createHash, createHmac, timingSafeEqual } from "node:crypto";
import { db } from "./db";
import { getMasterclass } from "./masterclass";
import { appUrl, fulfillOrder } from "./payments";

/**
 * Botón de pagos de Bold (integración manual, Embedded Checkout): el servidor
 * crea la orden local con el valor de la plataforma y firma los datos de la
 * venta (hash de integridad SHA-256 de {orden}{monto}{moneda}{llave secreta});
 * el navegador abre la pasarela de Bold en un modal sin salir del sitio.
 * El cupo se entrega solo con el webhook firmado de Bold, nunca con lo que
 * llega en la URL de retorno.
 *
 * Variables: BOLD_API_KEY (llave de identidad, pública) y BOLD_SECRET_KEY
 * (llave secreta, sensible). Sin las dos los botones no se muestran.
 */
function config() {
  const apiKey = process.env.BOLD_API_KEY;
  const secret = process.env.BOLD_SECRET_KEY;
  return apiKey && secret ? { apiKey, secret } : null;
}

export function boldEnabled() {
  return !!config();
}

export type BoldCurrency = "COP" | "USD";

export type BoldCheckoutData = {
  orderId: string;
  currency: BoldCurrency;
  amount: string;
  apiKey: string;
  integritySignature: string;
  description: string;
  redirectionUrl: string;
};

/** Crea la orden local de la masterclass y devuelve los datos firmados para abrir el checkout de Bold. */
export async function createBoldMasterclassOrder(currency: BoldCurrency, userId: string | null): Promise<BoldCheckoutData> {
  const c = config();
  if (!c) throw new Error("Bold no está configurado");
  const mc = await getMasterclass();
  const service = mc.service;
  const amount = currency === "COP" ? mc.paymentAmountCop : mc.paypalAmountUsd;
  if (!service?.active || mc.isPast || !amount) throw new Error("La masterclass no está disponible para compra");

  const description = `${service.name} · ${mc.dateLabel}`.slice(0, 100);
  const order = await db.order.create({
    data: {
      userId,
      kind: "SERVICE",
      serviceId: service.id,
      description,
      amountCop: currency === "COP" ? amount : 0,
      amountUsd: currency === "USD" ? amount : null,
      provider: currency === "COP" ? "bold" : "bold-usd",
    },
  });
  const amountStr = String(amount);
  const integritySignature = createHash("sha256").update(`${order.id}${amountStr}${currency}${c.secret}`).digest("hex");
  return {
    orderId: order.id,
    currency,
    amount: amountStr,
    apiKey: c.apiKey,
    integritySignature,
    description,
    redirectionUrl: `${appUrl()}/masterclass/pago-bold`,
  };
}

/** Verifica la cabecera x-bold-signature: HMAC-SHA256 (llave secreta) del cuerpo codificado en base64. */
export function verifyBoldSignature(rawBody: string, signature: string | null) {
  const c = config();
  if (!c || !signature) return false;
  const expected = createHmac("sha256", c.secret).update(Buffer.from(rawBody).toString("base64")).digest("hex");
  const a = Buffer.from(expected);
  const b = Buffer.from(signature.trim().toLowerCase());
  return a.length === b.length && timingSafeEqual(a, b);
}

export type BoldEvent = {
  id?: string;
  type?: string;
  subject_id?: string;
  data?: {
    payment_id?: string;
    payer_email?: string;
    amount?: { total?: number; currency?: string };
    metadata?: { reference?: string | null };
  };
};

/** Procesa un evento de Bold ya verificado. Es idempotente. */
export async function handleBoldEvent(event: BoldEvent) {
  const reference = event.data?.metadata?.reference;
  if (!reference) return { ok: false as const, reason: "sin referencia" };
  const local = await db.order.findFirst({ where: { id: reference, provider: { in: ["bold", "bold-usd"] } } });
  if (!local) return { ok: false as const, reason: "orden desconocida" };

  if (event.type === "SALE_APPROVED") {
    const currency = event.data?.amount?.currency ?? "";
    const total = Number(event.data?.amount?.total ?? 0);
    const expectedCurrency = local.provider === "bold" ? "COP" : "USD";
    const expectedAmount = local.provider === "bold" ? local.amountCop : local.amountUsd ?? Infinity;
    if (currency.toUpperCase() !== expectedCurrency || !(total >= expectedAmount)) {
      console.error("Bold: monto o moneda no coinciden", { order: local.id, currency, total });
      return { ok: false as const, reason: "monto no coincide" };
    }
    const email = event.data?.payer_email ?? "";
    await fulfillOrder(local.id, event.data?.payment_id ?? event.subject_id, { name: "Pago con Bold", email });
    return { ok: true as const };
  }
  if (event.type === "SALE_REJECTED" && local.status === "PENDING") {
    await db.order.update({ where: { id: local.id }, data: { status: "FAILED", providerRef: event.data?.payment_id ?? event.subject_id } });
  }
  if (event.type === "VOID_APPROVED" && local.status === "PAID") {
    await db.order.update({ where: { id: local.id }, data: { status: "REFUNDED" } });
  }
  return { ok: true as const };
}
