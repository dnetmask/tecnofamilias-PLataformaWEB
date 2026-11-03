"use client";

import { useEffect, useRef, useState, type ReactNode } from "react";
import { GAME_FULLSCREEN_MESSAGE, GAME_HEIGHT_MESSAGE, GAME_SANDBOX, GAME_STORAGE_HASH, GAME_STORAGE_MESSAGE } from "@/lib/games";

type FullscreenFrame = HTMLIFrameElement & { webkitRequestFullscreen?: () => void };
type FullscreenDoc = Document & { webkitFullscreenEnabled?: boolean; webkitFullscreenElement?: Element | null };

export function GameFrame({ src, title, fullHeight = false, children }: { src: string; title: string; fullHeight?: boolean; children?: ReactNode }) {
  const ref = useRef<HTMLIFrameElement>(null);
  // Pantalla completa propia: Safari del iPhone no permite la del navegador en un iframe.
  const [ownFullscreen, setOwnFullscreen] = useState(false);
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

  useEffect(() => {
    // Botón de pantalla completa del propio juego cuando el navegador no la permite (iPhone).
    const onMessage = (e: MessageEvent) => {
      if (e.source !== ref.current?.contentWindow) return;
      const data = e.data as { type?: string; on?: unknown };
      if (data?.type === GAME_FULLSCREEN_MESSAGE) setOwnFullscreen(data.on === true);
    };
    window.addEventListener("message", onMessage);
    return () => window.removeEventListener("message", onMessage);
  }, []);

  useEffect(() => {
    // El juego se entera de que salió (o entró) para actualizar su propio botón.
    ref.current?.contentWindow?.postMessage({ type: GAME_FULLSCREEN_MESSAGE, on: ownFullscreen }, "*");
    if (!ownFullscreen) return;
    const root = document.documentElement;
    const prev = root.style.overflow;
    root.style.overflow = "hidden";
    const onKey = (e: KeyboardEvent) => e.key === "Escape" && setOwnFullscreen(false);
    window.addEventListener("keydown", onKey);
    return () => {
      root.style.overflow = prev;
      window.removeEventListener("keydown", onKey);
    };
  }, [ownFullscreen]);

  const enterFullscreen = () => {
    const frame = ref.current as FullscreenFrame | null;
    if (!frame) return;
    const doc = document as FullscreenDoc;
    const own = () => setOwnFullscreen(true);
    try {
      if (document.fullscreenEnabled && frame.requestFullscreen) frame.requestFullscreen().catch(own);
      else if (doc.webkitFullscreenEnabled && frame.webkitRequestFullscreen) frame.webkitRequestFullscreen();
      else return own();
    } catch {
      return own();
    }
    // Si el navegador no entró a pantalla completa (pasa en el iPhone), se usa la propia.
    setTimeout(() => {
      if (!document.fullscreenElement && !doc.webkitFullscreenElement) own();
    }, 400);
  };

  return (
    <div className="stack">
      <div className="game-bar no-print">
        <div className="game-bar-title">{children}</div>
        <button type="button" className="btn btn-ghost btn-sm" onClick={enterFullscreen}>
          ⛶ Pantalla completa
        </button>
      </div>
      <div className={ownFullscreen ? "game-fs" : undefined}>
      {ownFullscreen && (
        <div className="game-fs-bar">
          <button type="button" className="game-fs-exit" onClick={() => setOwnFullscreen(false)}>
            ✕ Salir de pantalla completa
          </button>
        </div>
      )}
      {frameSrc && (
      <iframe
        ref={ref}
        src={frameSrc}
        title={title}
        sandbox={GAME_SANDBOX}
        allow="fullscreen"
        allowFullScreen
        className={`game-frame${fullHeight ? " game-frame-screen" : ""}`}
        style={!fullHeight && height && !ownFullscreen ? { height } : undefined}
      />
      )}
      </div>
    </div>
  );
}
