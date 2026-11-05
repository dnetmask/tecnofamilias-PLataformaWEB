"use client";

import Script from "next/script";
import { useEffect, useRef, useState } from "react";

type Buttons = { render: (el: HTMLElement) => Promise<void>; isEligible: () => boolean };
type PayPalSdk = {
  FUNDING: { CARD: string; PAYPAL: string };
  Buttons: (o: {
    fundingSource: string;
    style?: Record<string, unknown>;
    createOrder: () => Promise<string>;
    onApprove: (d: { orderID: string }, actions: { restart: () => Promise<void> }) => Promise<void>;
    onError: (err: unknown) => void;
  }) => Buttons;
};

declare global {
  interface Window { paypal?: PayPalSdk; dataLayer?: Record<string, unknown>[] }
}

/**
 * Pago en dólares con la integración de PayPal: primero la tarjeta de crédito o débito (el formulario se abre
 * aquí mismo) y, como alternativa, la cuenta PayPal. La orden la crea y la cobra el servidor.
 */
export function DollarCheckout({ clientId, amountUsd }: { clientId: string; amountUsd: number }) {
  const cardRef = useRef<HTMLDivElement>(null);
  const paypalRef = useRef<HTMLDivElement>(null);
  const [sdkReady, setSdkReady] = useState(false);
  const [state, setState] = useState<{ kind: "idle" | "paid" | "error"; text?: string }>({ kind: "idle" });

  useEffect(() => {
    if (window.paypal) setSdkReady(true);
  }, []);

  useEffect(() => {
    const sdk = window.paypal;
    if (!sdkReady || !sdk) return;
    const handlers = {
      async createOrder() {
        setState({ kind: "idle" });
        const res = await fetch("/api/paypal/orders", { method: "POST" });
        const data = (await res.json().catch(() => ({}))) as { id?: string; error?: string };
        if (!res.ok || !data.id) throw new Error(data.error ?? "No pudimos iniciar el pago");
        return data.id;
      },
      async onApprove({ orderID }: { orderID: string }, actions: { restart: () => Promise<void> }) {
        const res = await fetch(`/api/paypal/orders/${encodeURIComponent(orderID)}/capture`, { method: "POST" });
        const data = (await res.json().catch(() => ({}))) as { ok?: boolean; email?: string; retry?: boolean };
        // Tarjeta rechazada: PayPal deja intentar con otra sin perder la orden.
        if (data.retry) return actions.restart();
        if (!data.ok) {
          setState({ kind: "error", text: "El pago no se confirmó. Si se descontó el dinero, escríbenos y lo revisamos." });
          return;
        }
        window.dataLayer?.push({ event: "purchase", metodo: "paypal", currency: "USD", value: amountUsd, transaction_id: orderID });
        setState({ kind: "paid", text: data.email ?? "" });
      },
      onError() {
        setState({ kind: "error", text: "No pudimos completar el pago. Revisa los datos e intenta de nuevo, o escríbenos por WhatsApp." });
      },
    };
    const mount = (el: HTMLDivElement | null, fundingSource: string, style: Record<string, unknown>) => {
      if (!el || el.childElementCount) return;
      const b = sdk.Buttons({ fundingSource, style, ...handlers });
      if (b.isEligible()) b.render(el).catch(() => undefined);
    };
    mount(cardRef.current, sdk.FUNDING.CARD, { shape: "pill", height: 50 });
    mount(paypalRef.current, sdk.FUNDING.PAYPAL, { shape: "pill", color: "gold", label: "pay", height: 50 });
  }, [sdkReady, amountUsd]);

  if (state.kind === "paid") {
    return (
      <div className="alert alert-ok" role="status">
        <strong>¡Pago recibido! Tu cupo está reservado.</strong>{" "}
        {state.text ? <>Te enviaremos el enlace de conexión y los materiales a <strong>{state.text}</strong>.</> : <>Te enviaremos el enlace de conexión y los materiales por correo.</>}
      </div>
    );
  }

  return (
    <div className="stack" style={{ gap: 14 }}>
      <Script
        src={`https://www.paypal.com/sdk/js?client-id=${encodeURIComponent(clientId)}&currency=USD&intent=capture&components=buttons&enable-funding=card&disable-funding=venmo,paylater&locale=es_CO`}
        strategy="afterInteractive"
        onReady={() => setSdkReady(true)}
        onError={() => setState({ kind: "error", text: "No pudimos cargar el formulario de pago. Recarga la página." })}
      />
      <div>
        <p className="mc-pay-label" style={{ margin: "0 0 8px" }}>Paga con tarjeta de crédito o débito</p>
        <div ref={cardRef} style={{ minHeight: 50 }} />
      </div>
      <div>
        <p className="small muted" style={{ margin: "0 0 8px" }}>¿Tienes cuenta PayPal?</p>
        <div ref={paypalRef} style={{ minHeight: 50 }} />
      </div>
      {state.kind === "error" && <p className="small" role="alert" style={{ margin: 0, color: "var(--red)" }}>{state.text}</p>}
    </div>
  );
}
