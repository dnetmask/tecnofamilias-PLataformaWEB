"use client";

import { useActionState, useState } from "react";
import { FormMessage, type FormState } from "@/components/FormMessage";
import { SubmitButton } from "@/components/SubmitButton";
import { fieldInfo, fieldsIn, fillClause, hasFields } from "@/lib/pact-fields";

type Initial = {
  id?: string;
  templateId?: string;
  appName: string;
  childName: string;
  childAge: string;
  parentName: string;
  clauses: string[];
  rewards: string;
  consequences: string;
  reviewDate: string;
};

type Props = {
  initial: Initial;
  action: (state: FormState, formData: FormData) => Promise<FormState>;
  submitLabel: string;
  /** Pacto sin cuenta: pide aceptar términos y agrega un campo trampa contra bots. */
  publicForm?: boolean;
};

export function PactForm({ initial, action, submitLabel, publicForm = false }: Props) {
  const [state, formAction] = useActionState(action, undefined);
  const [clauses, setClauses] = useState(() =>
    (initial.clauses.length ? initial.clauses : [""]).map((text, i) => ({ key: i, text, on: true })),
  );
  const [nextKey, setNextKey] = useState(initial.clauses.length + 1);
  // Valores de los campos de los acuerdos ({horas}, {lugar}, {hora}…).
  const [values, setValues] = useState<Record<string, string>>({});
  const fields = fieldsIn(clauses.filter((c) => c.on).map((c) => c.text));
  const shown = (text: string) => (hasFields(text) ? fillClause(text, values) : text);

  const update = (key: number, patch: Partial<{ text: string; on: boolean }>) =>
    setClauses((cs) => cs.map((c) => (c.key === key ? { ...c, ...patch } : c)));

  return (
    <form action={formAction} className="form">
      {initial.id && <input type="hidden" name="id" value={initial.id} />}
      {initial.templateId && <input type="hidden" name="templateId" value={initial.templateId} />}

      <div className="grid grid-2" style={{ gap: 14 }}>
        <div className="field">
          <label htmlFor="appName">Aplicación o dispositivo</label>
          <input className="input" id="appName" name="appName" defaultValue={initial.appName} required />
        </div>
        <div className="field">
          <label htmlFor="parentName">Adulto responsable</label>
          <input className="input" id="parentName" name="parentName" defaultValue={initial.parentName} required />
        </div>
        <div className="field">
          <label htmlFor="childName">Nombre del hijo o hija</label>
          <input className="input" id="childName" name="childName" defaultValue={initial.childName} required />
          <span className="hint">Basta con el primer nombre o un apodo.</span>
        </div>
        <div className="field">
          <label htmlFor="childAge">Edad</label>
          <input className="input" id="childAge" name="childAge" type="number" min={0} max={25} defaultValue={initial.childAge} />
        </div>
        {fields.map((name) => {
          const f = fieldInfo(name);
          return (
            <div className="field" key={name}>
              <label htmlFor={`f-${name}`}>{f.label}</label>
              <input
                className="input"
                id={`f-${name}`}
                type={f.type}
                min={f.type === "number" ? 0 : undefined}
                placeholder={f.placeholder}
                value={values[name] ?? ""}
                onChange={(e) => setValues((v) => ({ ...v, [name]: e.target.value }))}
                required
              />
              <span className="hint">Se completa en el acuerdo de abajo.</span>
            </div>
          );
        })}
      </div>

      <fieldset className="card card-tint" style={{ margin: 0 }}>
        <legend className="label" style={{ padding: "0 6px" }}>Acuerdos</legend>
        <p className="hint" style={{ marginTop: 0 }}>Desmarca los que no apliquen, edítalos o agrega los tuyos. Escríbanlos juntos.</p>
        <div className="stack">
          {clauses.map((c, i) => (
            <div key={c.key} className="clause-row">
              <input
                type="checkbox"
                checked={c.on}
                onChange={(e) => update(c.key, { on: e.target.checked })}
                aria-label={`Incluir acuerdo ${i + 1}`}
                style={{ marginTop: 14 }}
              />
              <textarea
                className="textarea"
                name={c.on ? "clause" : undefined}
                value={shown(c.text)}
                // Si editan a mano un acuerdo con campos, queda con el texto ya completado.
                onChange={(e) => update(c.key, { text: e.target.value })}
                placeholder="Escribe un acuerdo…"
                style={c.on ? undefined : { opacity: 0.5 }}
                rows={2}
              />
              <button
                type="button"
                className="btn-link btn-danger-link small"
                style={{ marginTop: 12 }}
                onClick={() => setClauses((cs) => cs.filter((x) => x.key !== c.key))}
                aria-label={`Quitar acuerdo ${i + 1}`}
              >
                ✕
              </button>
            </div>
          ))}
        </div>
        <button
          type="button"
          className="btn btn-ghost btn-sm"
          style={{ marginTop: 12 }}
          onClick={() => {
            setClauses((cs) => [...cs, { key: nextKey, text: "", on: true }]);
            setNextKey((k) => k + 1);
          }}
        >
          + Agregar acuerdo
        </button>
      </fieldset>

      <div className="grid grid-2" style={{ gap: 14 }}>
        <div className="field">
          <label htmlFor="rewards">Si cumplimos…</label>
          <textarea className="textarea" id="rewards" name="rewards" defaultValue={initial.rewards} placeholder="Ej: el fin de semana sumamos 30 minutos de juego." />
        </div>
        <div className="field">
          <label htmlFor="consequences">Si no cumplimos…</label>
          <textarea className="textarea" id="consequences" name="consequences" defaultValue={initial.consequences} placeholder="Ej: al día siguiente no hay pantalla." />
        </div>
      </div>
      <div className="field" style={{ maxWidth: 280 }}>
        <label htmlFor="reviewDate">Fecha para revisar el pacto</label>
        <input className="input" id="reviewDate" name="reviewDate" type="date" defaultValue={initial.reviewDate} />
      </div>

      {publicForm && (
        <>
          <input type="text" name="website" tabIndex={-1} autoComplete="off" aria-hidden="true" style={{ position: "absolute", left: "-9999px" }} />
          <label className="check">
            <input type="checkbox" name="terms" required />
            <span>
              Acepto los <a href="/terminos" target="_blank">términos y la política de tratamiento de datos</a>. Solo guardamos lo
              que escribes en el pacto y las firmas.
            </span>
          </label>
        </>
      )}
      <FormMessage state={state} />
      <div>
        <SubmitButton>{submitLabel}</SubmitButton>
      </div>
    </form>
  );
}
