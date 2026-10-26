"use client";

import { useEffect, useRef, useState } from "react";
import { GAME_HEIGHT_MESSAGE, GAME_SANDBOX, GAME_STORAGE_HASH, GAME_STORAGE_MESSAGE } from "@/lib/games";

export function GameFrame({ src, title, fullHeight = false }: { src: string; title: string; fullHeight?: boolean }) {
  const ref = useRef<HTMLIFrameElement>(null);
  const [height, setHeight] = useState<number | null>(null);
  // Progreso del juego guardado en este navegador (el iframe aislado no puede guardarlo).
  const storageKey = `tf-game:${src}`;
  const [frameSrc, setFrameSrc] = useState<string | null>(null);

  useEffect(() => {
    let saved = "";
    try {
      saved = localStorage.getItem(storageKey) ?? "";
    } catch {}
    setFrameSrc(saved ? `${src}#${GAME_STORAGE_HASH}${encodeURIComponent(saved)}` : src);

    const onMessage = (e: MessageEvent) => {
      if (e.source !== ref.current?.contentWindow) return;
      const data = e.data as { type?: string; data?: unknown };
      if (data?.type !== GAME_STORAGE_MESSAGE || !data.data || typeof data.data !== "object") return;
      const json = JSON.stringify(data.data);
      if (json.length > 1_000_000) return;
      try {
        localStorage.setItem(storageKey, json);
      } catch {}
    };
    window.addEventListener("message", onMessage);
    return () => window.removeEventListener("message", onMessage);
  }, [src, storageKey]);

  useEffect(() => {
    // Los juegos de pantalla completa tienen su propio scroll: alto fijo.
    if (fullHeight) return;
    const onMessage = (e: MessageEvent) => {
      // Solo se acepta el mensaje de altura del propio iframe del juego.
      if (e.source !== ref.current?.contentWindow) return;
      const data = e.data as { type?: string; height?: unknown };
      if (data?.type === GAME_HEIGHT_MESSAGE && typeof data.height === "number") {
        setHeight(Math.min(Math.max(data.height, 400), 20000));
      }
    };
    window.addEventListener("message", onMessage);
    return () => window.removeEventListener("message", onMessage);
  }, [fullHeight]);

  return (
    <div className="stack">
      <div className="row between no-print">
        <span className="small muted">Ideal en tablet o computador, con toda la familia alrededor.</span>
        <button type="button" className="btn btn-ghost btn-sm" onClick={() => ref.current?.requestFullscreen?.()}>
          Pantalla completa
        </button>
      </div>
      {frameSrc && (
      <iframe
        ref={ref}
        src={frameSrc}
        title={title}
        sandbox={GAME_SANDBOX}
        allow="fullscreen"
        allowFullScreen
        className={`game-frame${fullHeight ? " game-frame-screen" : ""}`}
        style={!fullHeight && height ? { height } : undefined}
      />
      )}
    </div>
  );
}
