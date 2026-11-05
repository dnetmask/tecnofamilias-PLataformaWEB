import "server-only";
import { db } from "./db";
import { getMasterclass } from "./masterclass";
import { fulfillOrder } from "./payments";

/**
 * Checkout de PayPal (pagos en dólares) con la API de órdenes v2: el servidor
 * crea la orden con el valor de la plataforma y la captura; nunca se confía en
 * el monto que llega del navegador.
 *
 * Variables: PAYPAL_CLIENT_ID, PAYPAL_CLIENT_SECRET y PAYPAL_ENV ("live" o
 * "sandbox", por defecto sandbox). Sin las dos primeras el checkout no se muestra.
 */
function config() {
  const clientId = process.env.PAYPAL_CLIENT_ID;
  const secret = process.env.PAYPAL_CLIENT_SECRET;
  if (!clientId || !secret) return null;
  const live = process.env.PAYPAL_ENV === "live";
  const base = process.env.PAYPAL_API_BASE ?? (live ? "https://api-m.paypal.com" : "https://api-m.sandbox.paypal.com");
  return { clientId, secret, base };
}

/** Client ID público para el SDK del navegador, o null si PayPal no está configurado. */
export function paypalClientId() {
  return config()?.clientId ?? null;
}

let cachedToken: { value: string; expiresAt: number } | null = null;

async function accessToken(c: NonNullable<ReturnType<typeof config>>) {
  if (cachedToken && cachedToken.expiresAt > Date.now() + 60_000) return cachedToken.value;
  const res = await fetch(`${c.base}/v1/oauth2/token`, {
    method: "POST",
    headers: {
      Authorization: `Basic ${Buffer.from(`${c.clientId}:${c.secret}`).toString("base64")}`,
      "Content-Type": "application/x-www-form-urlencoded",
    },
    body: "grant_type=client_credentials",
    signal: AbortSignal.timeout(10_000),
  });
  if (!res.ok) throw new Error(`PayPal (token) respondió ${res.status}: ${await res.text()}`);
  const data = (await res.json()) as { access_token: string; expires_in: number };
  cachedToken = { value: data.access_token, expiresAt: Date.now() + data.expires_in * 1000 };
  return data.access_token;
}

async function paypal<T>(path: string, init: { method?: string; body?: unknown; requestId?: string } = {}): Promise<{ status: number; data: T }> {
  const c = config();
  if (!c) throw new Error("PayPal no está configurado");
  const res = await fetch(`${c.base}${path}`, {
    method: init.method ?? "GET",
    headers: {
      Authorization: `Bearer ${await accessToken(c)}`,
      "Content-Type": "application/json",
      ...(init.requestId ? { "PayPal-Request-Id": init.requestId } : {}),
    },
    body: init.body === undefined ? undefined : JSON.stringify(init.body),
    cache: "no-store",
    signal: AbortSignal.timeout(15_000),
  });
  const data = (await res.json().catch(() => ({}))) as T;
  return { status: res.status, data };
}

type PayPalOrder = {
  id: string;
  status: string;
  payer?: { name?: { given_name?: string; surname?: string }; email_address?: string };
  purchase_units?: {
    custom_id?: string;
    payments?: { captures?: { id: string; status: string; custom_id?: string; amount: { currency_code: string; value: string } }[] };
  }[];
};

/** Crea la orden local y la de PayPal para la masterclass. Devuelve el id de la orden de PayPal. */
export async function createMasterclassOrder(userId: string | null) {
  const mc = await getMasterclass();
  const service = mc.service;
  const amount = mc.paypalAmountUsd;
  if (!service?.active || mc.isPast || !amount) throw new Error("La masterclass no está disponible para compra");

  const description = `${service.name} · ${mc.dateLabel}`;
  const order = await db.order.create({
    data: { userId, kind: "SERVICE", serviceId: service.id, description, amountCop: 0, amountUsd: amount, provider: "paypal" },
  });
  const { status, data } = await paypal<PayPalOrder>("/v2/checkout/orders", {
    method: "POST",
    requestId: order.id,
    body: {
      intent: "CAPTURE",
      purchase_units: [
        {
          reference_id: order.id,
          custom_id: order.id,
          description: description.slice(0, 127),
          soft_descriptor: "TECNOFAMILIAS",
          amount: { currency_code: "USD", value: amount.toFixed(2) },
        },
      ],
      application_context: { brand_name: "Tecnofamilias", shipping_preference: "NO_SHIPPING", user_action: "PAY_NOW", locale: "es-CO" },
    },
  });
  if (status >= 300 || !data.id) {
    await db.order.update({ where: { id: order.id }, data: { status: "FAILED" } });
    throw new Error(`PayPal no creó la orden (${status}): ${JSON.stringify(data)}`);
  }
  await db.order.update({ where: { id: order.id }, data: { providerRef: data.id } });
  return data.id;
}

/** Verifica una orden ya pagada en PayPal contra la orden local y entrega el cupo. */
async function settle(pp: PayPalOrder) {
  const local = await db.order.findFirst({ where: { provider: "paypal", providerRef: pp.id } });
  if (!local) return { ok: false as const, reason: "orden desconocida" };
  const unit = pp.purchase_units?.[0];
  const capture = unit?.payments?.captures?.[0];
  if (pp.status !== "COMPLETED" || capture?.status !== "COMPLETED") return { ok: false as const, reason: `estado ${capture?.status ?? pp.status}` };
  const paid = Number(capture.amount.value);
  if (capture.amount.currency_code !== "USD" || !(paid >= (local.amountUsd ?? Infinity)) || (unit?.custom_id ?? capture.custom_id) !== local.id) {
    console.error("PayPal: monto, moneda u orden no coinciden", { order: local.id, paypal: pp.id });
    return { ok: false as const, reason: "monto no coincide" };
  }
  const email = pp.payer?.email_address ?? "";
  const name = [pp.payer?.name?.given_name, pp.payer?.name?.surname].filter(Boolean).join(" ") || "Pago con PayPal";
  await fulfillOrder(local.id, capture.id, { name, email });
  return { ok: true as const, email };
}

/** Captura el pago después de que la persona lo aprueba en PayPal. Es idempotente. */
export async function captureOrder(paypalOrderId: string) {
  const local = await db.order.findFirst({ where: { provider: "paypal", providerRef: paypalOrderId } });
  if (!local) return { ok: false as const, reason: "orden desconocida" };
  let { status, data } = await paypal<PayPalOrder & { details?: { issue?: string }[] }>(`/v2/checkout/orders/${encodeURIComponent(paypalOrderId)}/capture`, {
    method: "POST",
    requestId: `capture-${local.id}`,
  });
  // Ya capturada (p. ej. por el webhook): se consulta el estado actual.
  if (status === 422 && data.details?.some((d) => d.issue === "ORDER_ALREADY_CAPTURED")) {
    ({ status, data } = await paypal<PayPalOrder>(`/v2/checkout/orders/${encodeURIComponent(paypalOrderId)}`));
  }
  if (status >= 300) {
    if (data.details?.some((d) => d.issue === "INSTRUMENT_DECLINED")) return { ok: false as const, reason: "declinado", retry: true };
    console.error("PayPal: no se pudo capturar", { order: local.id, status, data });
    return { ok: false as const, reason: `PayPal respondió ${status}` };
  }
  return settle(data);
}

/** Para el webhook: consulta la orden en PayPal (nunca se confía en el cuerpo) y la cierra si ya se pagó. */
export async function syncOrder(paypalOrderId: string) {
  const { status, data } = await paypal<PayPalOrder>(`/v2/checkout/orders/${encodeURIComponent(paypalOrderId)}`);
  if (status >= 300) throw new Error(`PayPal respondió ${status}`);
  if (data.status === "APPROVED") return captureOrder(paypalOrderId);
  if (data.status === "COMPLETED") return settle(data);
  return { ok: false as const, reason: `estado ${data.status}` };
}

/** Marca como reembolsada la orden de una captura que PayPal reporta reembolsada. */
export async function syncRefund(captureId: string) {
  const { status, data } = await paypal<{ status: string }>(`/v2/payments/captures/${encodeURIComponent(captureId)}`);
  if (status >= 300) throw new Error(`PayPal respondió ${status}`);
  if (data.status === "REFUNDED" || data.status === "PARTIALLY_REFUNDED" || data.status === "REVERSED") {
    await db.order.updateMany({ where: { provider: "paypal", providerRef: captureId, status: "PAID" }, data: { status: "REFUNDED" } });
  }
}
