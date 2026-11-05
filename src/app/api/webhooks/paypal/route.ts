import { NextResponse } from "next/server";
import { paypalEnabled, syncOrder, syncRefund } from "@/lib/paypal";

export const dynamic = "force-dynamic";

type Event = {
  event_type?: string;
  resource?: { id?: string; links?: { rel?: string; href?: string }[]; supplementary_data?: { related_ids?: { order_id?: string } } };
};

/**
 * Avisos de PayPal: confirman el pago aunque la persona cierre la ventana antes
 * de volver. No se confía en el cuerpo: cada aviso se vuelve a consultar en la API.
 */
export async function POST(request: Request) {
  if (!paypalEnabled()) return NextResponse.json({ ok: true });
  const event = (await request.json().catch(() => ({}))) as Event;
  try {
    switch (event.event_type) {
      case "CHECKOUT.ORDER.APPROVED":
        if (event.resource?.id) await syncOrder(event.resource.id);
        break;
      case "PAYMENT.CAPTURE.COMPLETED": {
        const orderId = event.resource?.supplementary_data?.related_ids?.order_id;
        if (orderId) await syncOrder(orderId);
        break;
      }
      case "PAYMENT.CAPTURE.REFUNDED": {
        // El recurso es el reembolso; la captura es su enlace "up".
        const up = event.resource?.links?.find((l) => l.rel === "up")?.href ?? "";
        const captureId = up.match(/\/captures\/([A-Z0-9]+)/)?.[1];
        if (captureId) await syncRefund(captureId);
        break;
      }
      case "PAYMENT.CAPTURE.REVERSED":
        if (event.resource?.id) await syncRefund(event.resource.id);
        break;
    }
    return NextResponse.json({ ok: true });
  } catch (err) {
    console.error(err);
    // 500 para que PayPal reintente.
    return NextResponse.json({ error: "error procesando" }, { status: 500 });
  }
}
