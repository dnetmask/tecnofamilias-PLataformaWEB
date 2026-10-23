"use client";

import { useEffect, useRef, useState } from "react";
import { GAME_HEIGHT_MESSAGE, GAME_SANDBOX } from "@/lib/games";

export function GameFrame({ src, title }: { src: string; title: string }) {
  const ref = useRef<HTMLIFrameElement>(null);
  const [height, setHeight] = useState<number | null>(null);

  useEffect(() => {
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
  }, []);

  return (
    <div className="stack">
      <div className="row between no-print">
        <span className="small muted">Ideal en tablet o computador, con toda la familia alrededor.</span>
        <button type="button" className="btn btn-ghost btn-sm" onClick={() => ref.current?.requestFullscreen?.()}>
          Pantalla completa
        </button>
      </div>
      <iframe
        ref={ref}
        src={src}
        title={title}
        sandbox={GAME_SANDBOX}
        allow="fullscreen"
        allowFullScreen
        className="game-frame"
        style={height ? { height } : undefined}
      />
    </div>
  );
}
