import Link from "next/link";
import { redirect } from "next/navigation";
import { getMasterclass } from "@/lib/masterclass";
import { paypalClientId } from "@/lib/paypal";
import { LEGAL, NOINDEX } from "@/lib/site";
import { DollarCheckout } from "./DollarCheckout";

export const dynamic = "force-dynamic";
export const metadata = { title: "Pago en dólares · Masterclass", ...NOINDEX };

/** Página de pago en dólares de la masterclass: tarjeta (o cuenta PayPal) con la integración de PayPal. */
export default async function DollarPaymentPage() {
  const mc = await getMasterclass();
  const clientId = paypalClientId();
  const amount = mc.paypalAmountUsd;
  if (!clientId || !mc.service?.active || mc.isPast || !amount) redirect("/masterclass#precio");

  return (
    <div className="container section" style={{ maxWidth: 560 }}>
      <div className="card stack" style={{ gap: 18 }}>
        <div>
          <p className="mc-label" style={{ margin: 0 }}>Reserva tu cupo · Pago en dólares</p>
          <h1 style={{ margin: "6px 0 4px", fontSize: "1.6rem" }}>Masterclass: Crianza digital segura</h1>
          <p className="muted" style={{ margin: 0 }}>{mc.dateLabel} · {mc.time} ({mc.timezone}) · {mc.modality}</p>
        </div>
        <div className="row between" style={{ borderTop: "1px solid var(--line)", borderBottom: "1px solid var(--line)", padding: "12px 0" }}>
          <strong>Total</strong>
          <strong style={{ fontSize: "1.4rem" }}>USD {amount}</strong>
        </div>
        <DollarCheckout clientId={clientId} amountUsd={amount} />
        <p className="small muted" style={{ margin: 0 }}>
          🔒 Pago procesado por PayPal. {LEGAL.name} no ve ni guarda los datos de tu tarjeta. ¿Pagas desde Colombia?{" "}
          <Link href="/masterclass#precio">Paga en pesos con Mercado Pago</Link>.
        </p>
      </div>
    </div>
  );
}
