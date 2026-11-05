"use client";

import Script from "next/script";
import { useEffect, useRef, useState } from "react";

type Buttons = { render: (el: HTMLElement) => Promise<void>; isEligible: () => boolean };
type PayPalSdk = {
  Buttons: (o: {
    style?: Record<string, unknown>;
    createOrder: () => Promise<string>;
    onApprove: (d: { orderID: string }, actions: { restart: () => Promise<void> }) => Promise<void>;
    onError: (err: unknown) => void;
    onCancel?: () => void;
  }) => Buttons;
};

declare global {
  interface Window { paypal?: PayPalSdk; dataLayer?: Record<string, unknown>[] }
}

/** Checkout de PayPal: la orden la crea y la cobra el servidor (USD, valor de la plataforma). */
export function PayPalCheckout({ clientId, amountUsd }: { clientId: string; amountUsd: number }) {
  const ref = useRef<HTMLDivElement>(null);
  const [sdkReady, setSdkReady] = useState(false);
  const [state, setState] = useState<{ kind: "idle" | "paid" | "error"; text?: string }>({ kind: "idle" });

  useEffect(() => {
    if (window.paypal) setSdkReady(true);
  }, []);

  useEffect(() => {
    const el = ref.current;
    if (!sdkReady || !window.paypal || !el || el.childElementCount) return;
    const buttons = window.paypal.Buttons({
      style: { layout: "vertical", color: "gold", shape: "pill", label: "pay", height: 48 },
      async createOrder() {
        setState({ kind: "idle" });
        const res = await fetch("/api/paypal/orders", { method: "POST" });
        const data = (await res.json().catch(() => ({}))) as { id?: string; error?: string };
        if (!res.ok || !data.id) throw new Error(data.error ?? "No pudimos iniciar el pago");
        return data.id;
      },
      async onApprove({ orderID }, actions) {
        const res = await fetch(`/api/paypal/orders/${encodeURIComponent(orderID)}/capture`, { method: "POST" });
        const data = (await res.json().catch(() => ({}))) as { ok?: boolean; email?: string; retry?: boolean };
        // Tarjeta o fondos rechazados: PayPal deja elegir otro medio sin perder la orden.
        if (data.retry) return actions.restart();
        if (!data.ok) {
          setState({ kind: "error", text: "PayPal no confirmó el pago. Si se descontó el dinero, escríbenos y lo revisamos." });
          return;
        }
        window.dataLayer?.push({ event: "purchase", metodo: "paypal", currency: "USD", value: amountUsd, transaction_id: orderID });
        setState({ kind: "paid", text: data.email ?? "" });
      },
      onError() {
        setState({ kind: "error", text: "No pudimos completar el pago con PayPal. Intenta de nuevo o escríbenos por WhatsApp." });
      },
    });
    if (buttons.isEligible()) buttons.render(el).catch(() => setState({ kind: "error", text: "No pudimos cargar PayPal. Recarga la página." }));
  }, [sdkReady, amountUsd]);

  if (state.kind === "paid") {
    return (
      <div className="alert alert-ok" role="status">
        <strong>¡Pago recibido! Tu cupo está reservado.</strong>{" "}
        {state.text ? <>Te enviaremos el acceso y los materiales a <strong>{state.text}</strong>.</> : <>Te enviaremos el acceso y los materiales por correo.</>}
      </div>
    );
  }

  return (
    <>
      <Script
        src={`https://www.paypal.com/sdk/js?client-id=${encodeURIComponent(clientId)}&currency=USD&intent=capture&components=buttons&disable-funding=venmo,paylater&locale=es_CO`}
        strategy="afterInteractive"
        onReady={() => setSdkReady(true)}
        onError={() => setState({ kind: "error", text: "No pudimos cargar PayPal. Recarga la página." })}
      />
      <div ref={ref} style={{ minHeight: 48 }} />
      {state.kind === "error" && <p className="small" role="alert" style={{ margin: 0, color: "var(--red)" }}>{state.text}</p>}
    </>
  );
}
