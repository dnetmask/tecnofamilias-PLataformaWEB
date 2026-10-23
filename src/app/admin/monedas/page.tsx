import { SubmitButton } from "@/components/SubmitButton";
import { chargeCop, CURRENCIES, formatPrice, formatRange } from "@/lib/currency";
import { formatCop, formatDateTime } from "@/lib/format";
import { getRatesInfo, getRatesSetting } from "@/lib/pricing";
import { saveRatesAction } from "../actions";
import { Notice, type NoticeParams } from "../Notice";

const SOURCE = {
  auto: "Automática (tasa del día)",
  manual: "Manual",
  default: "Por defecto (aún no configurada)",
};

export default async function AdminCurrenciesPage({ searchParams }: { searchParams: NoticeParams }) {
  const { error, ok } = await searchParams;
  const [setting, info] = await Promise.all([getRatesSetting(), getRatesInfo()]);
  const { rates } = info;
  const autoFailed = setting.mode === "auto" && info.source !== "auto";
  const examples = [
    { label: "Plan anual", from: 60, to: 60 },
    { label: "Asesoría personalizada", from: 300, to: 300 },
    { label: "Programa anual colegios", from: 3000, to: 5000 },
  ];
  return (
    <>
      <h1>Monedas</h1>
      <Notice error={error} ok={ok} />
      <p className="small muted">
        Todos los precios se definen en <strong>dólares</strong>. Se muestran convertidos a COP, MXN o PEN según la moneda del visitante, y
        al pagar se convierten a <strong>pesos colombianos</strong>, que es lo que cobra Mercado Pago. Cada orden guarda el precio en USD y la tasa usada.
      </p>

      <div className="card stack">
        <div className="row between">
          <h3 style={{ margin: 0 }}>Tasas en uso</h3>
          <span className={`badge ${info.source === "auto" ? "badge-green" : "badge-yellow"}`}>{SOURCE[info.source]}</span>
        </div>
        {autoFailed && <div className="alert alert-error">No se pudo consultar la tasa automática; se están usando las tasas manuales.</div>}
        <div className="grid grid-3" style={{ gap: 12 }}>
          {(["COP", "MXN", "PEN"] as const).map((c) => (
            <div key={c} className="card card-tint" style={{ padding: 14 }}>
              <div className="small muted">{CURRENCIES[c].flag} 1 USD =</div>
              <div className="stat" style={{ fontSize: "1.5rem" }}>{rates[c].toLocaleString("es-CO", { maximumFractionDigits: 2 })} {c}</div>
            </div>
          ))}
        </div>
        {info.asOf && <p className="small muted" style={{ margin: 0 }}>Actualizada: {formatDateTime(info.asOf)}</p>}
        {info.source === "auto" && (
          <p className="small muted" style={{ margin: 0 }}>
            Fuente: <a href="https://www.exchangerate-api.com" target="_blank" rel="noopener noreferrer">Rates By Exchange Rate API</a> · se consulta cada 6 horas.
          </p>
        )}
      </div>

      <form action={saveRatesAction} className="card form">
        <h3>Configuración</h3>
        <label className="check"><input type="radio" name="mode" value="auto" defaultChecked={setting.mode === "auto"} /> Automática: usar la tasa del día (las manuales quedan como respaldo)</label>
        <label className="check"><input type="radio" name="mode" value="manual" defaultChecked={setting.mode === "manual"} /> Manual: usar siempre estas tasas</label>
        <div className="grid grid-3" style={{ gap: 14 }}>
          {(["COP", "MXN", "PEN"] as const).map((c) => (
            <div key={c} className="field">
              <label>{CURRENCIES[c].flag} 1 USD = … {c}</label>
              <input className="input" name={c} type="number" min={0.0001} step="0.0001" defaultValue={setting.manual[c]} required />
              <span className="hint">{CURRENCIES[c].name}</span>
            </div>
          ))}
        </div>
        <div><SubmitButton className="btn btn-sm">Guardar</SubmitButton></div>
      </form>

      <div className="table-wrap card" style={{ padding: 0 }}>
        <table className="table">
          <thead><tr><th>Ejemplo</th><th>USD (base)</th><th>COP</th><th>MXN</th><th>PEN</th><th>Se cobra hoy</th></tr></thead>
          <tbody>
            {examples.map((e) => (
              <tr key={e.label}>
                <td>{e.label}</td>
                {(["USD", "COP", "MXN", "PEN"] as const).map((c) => (
                  <td key={c}>{e.from === e.to ? formatPrice(e.from, c, rates) : formatRange(e.from, e.to, c, rates)}</td>
                ))}
                <td>{e.from === e.to ? formatCop(chargeCop(e.from, rates)) : "Cotización"}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </>
  );
}
