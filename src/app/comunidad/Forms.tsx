"use client";

import { useActionState, useEffect, useRef } from "react";
import { FormMessage } from "@/components/FormMessage";
import { SubmitButton } from "@/components/SubmitButton";
import { createThreadAction, replyAction } from "./actions";

export function NewThreadForm({ categoryId }: { categoryId: string }) {
  const [state, action] = useActionState(createThreadAction, undefined);
  return (
    <form action={action} className="form">
      <input type="hidden" name="categoryId" value={categoryId} />
      <div className="field">
        <label htmlFor="title">Título</label>
        <input className="input" id="title" name="title" maxLength={140} required placeholder="Ej: ¿Cómo configuro el control parental en Roblox?" />
      </div>
      <div className="field">
        <label htmlFor="body">Tu mensaje</label>
        <textarea className="textarea" id="body" name="body" rows={8} required />
        <span className="hint">No publiques nombres completos, fotos, colegios ni datos que identifiquen a menores.</span>
      </div>
      <FormMessage state={state} />
      <div><SubmitButton pendingText="Publicando…">Publicar</SubmitButton></div>
    </form>
  );
}

export function ReplyForm({ threadId }: { threadId: string }) {
  const [state, action] = useActionState(replyAction, undefined);
  const ref = useRef<HTMLFormElement>(null);
  useEffect(() => {
    if (state?.ok) ref.current?.reset();
  }, [state]);
  return (
    <form ref={ref} action={action} className="form">
      <input type="hidden" name="threadId" value={threadId} />
      <div className="field">
        <label htmlFor="reply">Responder</label>
        <textarea className="textarea" id="reply" name="body" rows={4} required placeholder="Comparte tu experiencia o un consejo…" />
      </div>
      <FormMessage state={state} />
      <div><SubmitButton pendingText="Publicando…">Publicar respuesta</SubmitButton></div>
    </form>
  );
}
