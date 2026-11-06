"use client";

import { useState } from "react";

const SCRIPT_SRC = "https://checkout.bold.co/library/boldPaymentButton.js";

type BoldCheckoutCtor = new (config: Record<string, unknown>) => { open: () => void };
declare global {
  interface Window {
    BoldCheckout?: BoldCheckoutCtor;
  }
}

let loader: Promise<BoldCheckoutCtor> | null = null;

function loadBold(): Promise<BoldCheckoutCtor> {
  if (window.BoldCheckout) return Promise.resolve(window.BoldCheckout);
  if (!loader) {
    loader = new Promise((resolve, reject) => {
      const s = document.createElement("script");
      s.src = SCRIPT_SRC;
      s.async = true;
      s.onload = () => {
        // La librería define BoldCheckout al cargar; se espera un momento por si tarda.
        let tries = 0;
        const t = setInterval(() => {
          if (window.BoldCheckout) {
            clearInterval(t);
            resolve(window.BoldCheckout);
          } else if (++tries > 50) {
            clearInterval(t);
            reject(new Error("Bold no cargó"));
          }
        }, 100);
      };
      s.onerror = () => reject(new Error("Bold no cargó"));
      document.head.appendChild(s);
    }).catch((err) => {
      loader = null;
      throw err;
    }) as Promise<BoldCheckoutCtor>;
  }
  return loader;
}

/** Botón que abre la pasarela de Bold en un modal (Embedded Checkout) con una orden firmada por el servidor. */
export function BoldCheckoutButton({ currency, label, className = "btn btn-yellow" }: { currency: "COP" | "USD"; label: string; className?: string }) {
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState("");

  async function pay() {
    setBusy(true);
    setError("");
    try {
      const [Bold, res] = await Promise.all([
        loadBold(),
        fetch("/api/bold/orders", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ currency }) }),
      ]);
      const data = await res.json();
      if (!res.ok) throw new Error(data.error ?? "No pudimos iniciar el pago");
      window.dataLayer?.push({ event: "begin_checkout", payment_provider: "Bold embebido", currency });
      new Bold({ ...data, renderMode: "embedded" }).open();
    } catch (err) {
      setError(err instanceof Error ? err.message : "No pudimos iniciar el pago");
    } finally {
      setBusy(false);
    }
  }

  return (
    <>
      <button type="button" className={className} onClick={pay} disabled={busy}>
        {busy ? "Abriendo pago…" : label}
      </button>
      {error && <span className="small" role="alert" style={{ color: "#b42318" }}>{error}. Intenta de nuevo o usa el otro botón.</span>}
    </>
  );
}
