"use client";

import { track } from "@vercel/analytics";
import { usePathname } from "next/navigation";
import { useEffect } from "react";

/** Cuenta los clics a WhatsApp (contacto y asesoría) en la analítica de Vercel. */
export function ClickTracker() {
  const pathname = usePathname();
  useEffect(() => {
    const onClick = (e: MouseEvent) => {
      const a = (e.target as HTMLElement | null)?.closest?.("a");
      if (a?.href.startsWith("https://wa.me/")) track("WhatsApp", { pagina: pathname, boton: a.classList.contains("wa-float") ? "flotante" : "pagina" });
    };
    document.addEventListener("click", onClick);
    return () => document.removeEventListener("click", onClick);
  }, [pathname]);
  return null;
}
