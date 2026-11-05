"use client";

import Script from "next/script";
import { useEffect, useState } from "react";

type PayPalSdk = { HostedButtons: (o: { hostedButtonId: string }) => { render: (selector: string) => Promise<void> } };

/** Botón alojado de PayPal (pago en dólares). El monto y la cuenta se definen en PayPal. */
export function PayPalButton({ clientId, buttonId }: { clientId: string; buttonId: string }) {
  const [ready, setReady] = useState(false);
  const [failed, setFailed] = useState(false);
  const containerId = `paypal-container-${buttonId}`;

  useEffect(() => {
    if ((window as unknown as { paypal?: PayPalSdk }).paypal) setReady(true);
  }, []);

  useEffect(() => {
    const paypal = (window as unknown as { paypal?: PayPalSdk }).paypal;
    const el = document.getElementById(containerId);
    if (!ready || !paypal || !el || el.childElementCount) return;
    paypal.HostedButtons({ hostedButtonId: buttonId }).render(`#${containerId}`).catch(() => setFailed(true));
  }, [ready, buttonId, containerId]);

  return (
    <>
      <Script
        src={`https://www.paypal.com/sdk/js?client-id=${encodeURIComponent(clientId)}&components=hosted-buttons&disable-funding=venmo&currency=USD`}
        strategy="afterInteractive"
        onReady={() => setReady(true)}
        onError={() => setFailed(true)}
      />
      <div id={containerId} style={{ minHeight: 45 }} />
      {failed && <p className="small muted" style={{ margin: 0 }}>No pudimos cargar PayPal. Recarga la página o escríbenos por WhatsApp.</p>}
    </>
  );
}
