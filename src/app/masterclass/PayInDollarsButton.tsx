"use client";

import { useState } from "react";

/** Botón "Pagar en dólares": el servidor crea la orden y lleva a la página de pago de PayPal (cuenta o tarjeta). */
export function PayInDollarsButton({ amountUsd }: { amountUsd: number }) {
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState("");

  const pay = async () => {
    setBusy(true);
    setError("");
    try {
      const res = await fetch("/api/paypal/orders", { method: "POST" });
      const data = (await res.json().catch(() => ({}))) as { url?: string };
      if (!res.ok || !data.url) throw new Error();
      window.dataLayer?.push({ event: "begin_checkout", metodo: "paypal", currency: "USD", value: amountUsd });
      window.location.href = data.url;
    } catch {
      setBusy(false);
      setError("No pudimos abrir PayPal. Intenta de nuevo o escríbenos por WhatsApp.");
    }
  };

  return (
    <>
      <button type="button" className="btn btn-yellow" onClick={pay} disabled={busy} aria-busy={busy}>
        {busy ? "Abriendo PayPal…" : "Pagar en dólares"}
      </button>
      {error && <span className="small" role="alert" style={{ color: "var(--red)" }}>{error}</span>}
    </>
  );
}
