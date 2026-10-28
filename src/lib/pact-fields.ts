/**
 * Campos dentro de los acuerdos de las plantillas de pactos, p. ej.
 * "lo uso máximo {horas} horas". El formulario muestra un campo por cada uno
 * y reemplaza el valor en el acuerdo mientras la familia escribe.
 */
export type PactField = { label: string; type: "number" | "text" | "time"; placeholder?: string; suffix?: string };

export const PACT_FIELDS: Record<string, PactField> = {
  horas: { label: "Horas máximas al día (lunes a viernes)", type: "number", placeholder: "2" },
  minutos: { label: "Minutos máximos al día", type: "number", placeholder: "60" },
  partidas: { label: "Partidas máximas al día", type: "number", placeholder: "3" },
  lugar: { label: "¿Dónde se carga el celular en la noche?", type: "text", placeholder: "la cocina" },
  hora: { label: "¿Desde qué hora?", type: "time" },
};

const TOKEN = /\{([a-z_]+)\}/gi;

/** Nombres de campos que aparecen en los acuerdos, en orden y sin repetir. */
export function fieldsIn(clauses: string[]) {
  const names: string[] = [];
  for (const c of clauses) for (const m of c.matchAll(TOKEN)) if (!names.includes(m[1].toLowerCase())) names.push(m[1].toLowerCase());
  return names;
}

export function fieldInfo(name: string): PactField {
  return PACT_FIELDS[name] ?? { label: name.charAt(0).toUpperCase() + name.slice(1).replace(/_/g, " "), type: "text" };
}

/** "21:30" → "9:30 p. m." */
function formatTime(value: string) {
  const m = /^(\d{1,2}):(\d{2})$/.exec(value);
  if (!m) return value;
  const h = Number(m[1]);
  return `${h % 12 || 12}:${m[2]} ${h < 12 ? "a. m." : "p. m."}`;
}

/** Reemplaza los campos por sus valores; los vacíos quedan como ___. */
export function fillClause(text: string, values: Record<string, string>) {
  return text.replace(TOKEN, (_, raw: string) => {
    const name = raw.toLowerCase();
    const v = (values[name] ?? "").trim();
    if (!v) return "___";
    return fieldInfo(name).type === "time" ? formatTime(v) : v;
  }).replace(/m\.\./g, "m."); // "9:00 p. m." al final de la frase no lleva doble punto
}

export function hasFields(text: string) {
  return new RegExp(TOKEN.source, "i").test(text);
}
