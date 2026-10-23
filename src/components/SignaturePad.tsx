"use client";

import { useActionState, useEffect, useRef, useState } from "react";
import { FormMessage, type FormState } from "./FormMessage";
import { SubmitButton } from "./SubmitButton";

type Props = {
  action: (state: FormState, formData: FormData) => Promise<FormState>;
  fields: Record<string, string>;
  label: string;
  signerHint: string;
};

/** Lienzo para firmar con el dedo o el mouse; envía la firma como PNG en base64. */
export function SignaturePad({ action, fields, label, signerHint }: Props) {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const drawing = useRef(false);
  const [hasInk, setHasInk] = useState(false);
  const [dataUrl, setDataUrl] = useState("");
  const [state, formAction] = useActionState(action, undefined);

  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ratio = window.devicePixelRatio || 1;
    canvas.width = canvas.offsetWidth * ratio;
    canvas.height = canvas.offsetHeight * ratio;
    const ctx = canvas.getContext("2d")!;
    ctx.scale(ratio, ratio);
    ctx.lineWidth = 2.5;
    ctx.lineCap = "round";
    ctx.lineJoin = "round";
    ctx.strokeStyle = "#1e2b47";
  }, []);

  const point = (e: React.PointerEvent<HTMLCanvasElement>) => {
    const rect = e.currentTarget.getBoundingClientRect();
    return { x: e.clientX - rect.left, y: e.clientY - rect.top };
  };

  const onDown = (e: React.PointerEvent<HTMLCanvasElement>) => {
    e.currentTarget.setPointerCapture(e.pointerId);
    drawing.current = true;
    const ctx = e.currentTarget.getContext("2d")!;
    const { x, y } = point(e);
    ctx.beginPath();
    ctx.moveTo(x, y);
    ctx.lineTo(x + 0.1, y + 0.1);
    ctx.stroke();
  };
  const onMove = (e: React.PointerEvent<HTMLCanvasElement>) => {
    if (!drawing.current) return;
    const ctx = e.currentTarget.getContext("2d")!;
    const { x, y } = point(e);
    ctx.lineTo(x, y);
    ctx.stroke();
  };
  const onUp = () => {
    if (!drawing.current) return;
    drawing.current = false;
    setHasInk(true);
    setDataUrl(canvasRef.current!.toDataURL("image/png"));
  };
  const clear = () => {
    const canvas = canvasRef.current!;
    canvas.getContext("2d")!.clearRect(0, 0, canvas.width, canvas.height);
    setHasInk(false);
    setDataUrl("");
  };

  return (
    <form action={formAction} className="sig-box stack">
      <div className="label">{label}</div>
      <canvas
        ref={canvasRef}
        className="sig-canvas"
        onPointerDown={onDown}
        onPointerMove={onMove}
        onPointerUp={onUp}
        onPointerLeave={onUp}
        aria-label={`Espacio para la firma: ${label}`}
      />
      <span className="hint">{signerHint}</span>
      {Object.entries(fields).map(([k, v]) => (
        <input key={k} type="hidden" name={k} value={v} />
      ))}
      <input type="hidden" name="signature" value={dataUrl} />
      <FormMessage state={state} />
      <div className="row">
        <button type="button" className="btn btn-ghost btn-sm" onClick={clear}>Borrar</button>
        <SubmitButton className="btn btn-sm" disabled={!hasInk} pendingText="Firmando…">Firmar</SubmitButton>
      </div>
    </form>
  );
}
