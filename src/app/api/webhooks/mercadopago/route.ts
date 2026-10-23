import { NextResponse } from "next/server";
import { db } from "@/lib/db";
import { failOrder, fetchMpPayment, fulfillOrder, paymentsMode, verifyMpSignature } from "@/lib/payments";

export const dynamic = "force-dynamic";

export async function POST(request: Request) {
  if (paymentsMode() !== "mercadopago") return NextResponse.json({ ok: true });

  const url = new URL(request.url);
  const body = (await request.json().catch(() => ({}))) as { type?: string; data?: { id?: string | number } };
  const type = body.type ?? url.searchParams.get("type") ?? url.searchParams.get("topic");
  const dataId = String(body.data?.id ?? url.searchParams.get("data.id") ?? url.searchParams.get("id") ?? "");

  if (type !== "payment" || !dataId) return NextResponse.json({ ignored: true });
  if (!verifyMpSignature(request.headers, dataId)) {
    return NextResponse.json({ error: "firma inválida" }, { status: 401 });
  }

  try {
    // Nunca se confía en el cuerpo del webhook: se consulta el pago en la API.
    const payment = await fetchMpPayment(dataId);
    const orderId = payment.external_reference;
    if (!orderId) return NextResponse.json({ ignored: true });
    const order = await db.order.findUnique({ where: { id: orderId } });
    if (!order) return NextResponse.json({ ignored: true });

    if (payment.status === "approved") {
      if (payment.currency_id !== "COP" || payment.transaction_amount < order.amountCop) {
        console.error("Monto o moneda no coinciden", { orderId, payment: payment.id });
        return NextResponse.json({ error: "monto no coincide" }, { status: 400 });
      }
      await fulfillOrder(order.id, String(payment.id));
    } else if (payment.status === "rejected" || payment.status === "cancelled") {
      await failOrder(order.id);
    } else if (payment.status === "refunded" || payment.status === "charged_back") {
      await db.order.update({ where: { id: order.id }, data: { status: "REFUNDED" } });
    }
    return NextResponse.json({ ok: true });
  } catch (err) {
    console.error(err);
    // 500 para que Mercado Pago reintente.
    return NextResponse.json({ error: "error procesando" }, { status: 500 });
  }
}
