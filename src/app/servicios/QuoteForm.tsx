"use client";

import Link from "next/link";
import { useActionState } from "react";
import { FormMessage } from "@/components/FormMessage";
import { SubmitButton } from "@/components/SubmitButton";
import { requestQuoteAction } from "./actions";

type Props = {
  serviceId: string;
  institutional: boolean;
  defaults: { name: string; email: string };
};

export function QuoteForm({ serviceId, institutional, defaults }: Props) {
  const [state, action] = useActionState(requestQuoteAction, undefined);
  if (state?.ok) return <FormMessage state={state} />;
  return (
    <form action={action} className="form">
      <input type="hidden" name="serviceId" value={serviceId} />
      <input type="text" name="website" tabIndex={-1} autoComplete="off" aria-hidden style={{ position: "absolute", left: "-9999px" }} />
      <div className="grid grid-2" style={{ gap: 14 }}>
        <div className="field">
          <label htmlFor="q-name">Nombre de contacto</label>
          <input className="input" id="q-name" name="name" defaultValue={defaults.name} autoComplete="name" required />
        </div>
        <div className="field">
          <label htmlFor="q-email">Correo</label>
          <input className="input" id="q-email" name="email" type="email" defaultValue={defaults.email} autoComplete="email" required />
        </div>
        <div className="field">
          <label htmlFor="q-phone">Teléfono / WhatsApp</label>
          <input className="input" id="q-phone" name="phone" type="tel" autoComplete="tel" required />
        </div>
        <div className="field">
          <label htmlFor="q-city">Ciudad</label>
          <input className="input" id="q-city" name="city" autoComplete="address-level2" />
        </div>
      </div>
      {institutional && (
        <div className="field">
          <label htmlFor="q-org">Institución, empresa o entidad</label>
          <input className="input" id="q-org" name="organization" required />
        </div>
      )}
      <div className="field">
        <label htmlFor="q-msg">{institutional ? "Cuéntanos qué necesitas" : "Comentarios"}</label>
        <textarea
          className="textarea"
          id="q-msg"
          name="message"
          rows={4}
          placeholder={institutional ? "Número de estudiantes o empleados, sedes, fechas tentativas, presupuesto…" : ""}
        />
      </div>
      <label className="check">
        <input type="checkbox" name="consent" required />
        <span>
          Autorizo a Tecnofamilias a contactarme y tratar estos datos según la{" "}
          <Link href="/terminos" target="_blank">política de tratamiento de datos</Link>.
        </span>
      </label>
      <FormMessage state={state} />
      <div><SubmitButton pendingText="Enviando…">Solicitar cotización</SubmitButton></div>
    </form>
  );
}
