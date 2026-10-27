"use client";

import { track } from "@vercel/analytics";
import { usePathname } from "next/navigation";
import { useEffect } from "react";

declare global {
  interface Window { gtag?: (...args: unknown[]) => void }
}

/** Cuenta los clics a WhatsApp (contacto y asesoría) en la analítica de Vercel y en Google Analytics. */
export function ClickTracker() {
  const pathname = usePathname();
  useEffect(() => {
    const onClick = (e: MouseEvent) => {
      const a = (e.target as HTMLElement | null)?.closest?.("a");
      if (!a?.href.startsWith("https://wa.me/")) return;
      const boton = a.classList.contains("wa-float") ? "flotante" : "pagina";
      track("WhatsApp", { pagina: pathname, boton });
      window.gtag?.("event", "contacto_whatsapp", { pagina: pathname, boton, texto: a.textContent?.trim().slice(0, 80) });
    };
    document.addEventListener("click", onClick);
    return () => document.removeEventListener("click", onClick);
  }, [pathname]);
  return null;
}
