"use client";

import { useEffect, useRef, useState } from "react";

/**
 * Herramienta interactiva propia (HTML en /interactivas/) dentro de su ficha.
 * El marco crece con el contenido: la herramienta avisa su alto con
 * postMessage({ tipo: "tecnofamilias:altura", altura }).
 */
export function InteractiveToolFrame({ src, title }: { src: string; title: string }) {
  const ref = useRef<HTMLIFrameElement>(null);
  const [height, setHeight] = useState(900);

  useEffect(() => {
    function onMessage(e: MessageEvent) {
      if (e.source !== ref.current?.contentWindow) return;
      const d = e.data as { tipo?: string; altura?: number } | null;
      if (d?.tipo === "tecnofamilias:altura" && typeof d.altura === "number" && d.altura > 200) {
        const next = Math.min(Math.ceil(d.altura) + 8, 20000);
        setHeight((prev) => {
          // Si el contenido se achica (cambio de pantalla) y la persona quedó más abajo, vuelve al inicio de la herramienta.
          const top = ref.current?.getBoundingClientRect().top ?? 0;
          if (next < prev - 80 && top < 0) {
            window.scrollTo({ top: window.scrollY + top - 90, behavior: "smooth" });
          }
          return next;
        });
      }
    }
    window.addEventListener("message", onMessage);
    return () => window.removeEventListener("message", onMessage);
  }, []);

  return (
    <iframe
      ref={ref}
      src={src}
      title={title}
      style={{ width: "100%", height, border: 0, borderRadius: 16, background: "#fff", display: "block" }}
      sandbox="allow-scripts allow-forms allow-popups allow-popups-to-escape-sandbox allow-modals allow-top-navigation-by-user-activation allow-downloads"
      loading="lazy"
    />
  );
}
