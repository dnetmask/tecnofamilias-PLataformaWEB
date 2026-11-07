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
        setHeight(Math.min(Math.ceil(d.altura) + 8, 20000));
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
