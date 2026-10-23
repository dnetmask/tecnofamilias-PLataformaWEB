import { SubmitButton } from "@/components/SubmitButton";
import { CURRENCIES, formatPrice, formatRange } from "@/lib/currency";
import { formatDateTime } from "@/lib/format";
import { db } from "@/lib/db";
import { getRates, RATES_KEY } from "@/lib/pricing";
import { saveRatesAction } from "../actions";
import { Notice, type NoticeParams } from "../Notice";

export default async function AdminCurrenciesPage({ searchParams }: { searchParams: NoticeParams }) {
  const { error, ok } = await searchParams;
  const [rates, row] = await Promise.all([getRates(), db.setting.findUnique({ where: { key: RATES_KEY } })]);
  const examples = [
    { label: "Plan anual", from: 200000, to: 200000 },
    { label: "Asesoría personalizada", from: 1000000, to: 1000000 },
    { label: "Programa anual colegios", from: 12000000, to: 20000000 },
  ];
  return (
    <>
      <h1>Monedas</h1>
      <Notice error={error} ok={ok} />
      <p className="small muted">
        Los precios se guardan en pesos colombianos y se muestran convertidos según la moneda que elija el visitante (por defecto, la de su país).
        El cobro siempre se hace en COP. {row ? `Última actualización: ${formatDateTime(row.updatedAt)}.` : "Se están usando las tasas por defecto: actualízalas con las del día."}
      </p>
      <form action={saveRatesAction} className="card form">
        <h3>Pesos colombianos por unidad</h3>
        <div className="grid grid-3" style={{ gap: 14 }}>
          {(["USD", "MXN", "PEN"] as const).map((c) => (
            <div key={c} className="field">
              <label>{CURRENCIES[c].flag} 1 {c} = … COP</label>
              <input className="input" name={c} type="number" min={0.01} step="0.01" defaultValue={rates[c]} required />
              <span className="hint">{CURRENCIES[c].name}</span>
            </div>
          ))}
        </div>
        <div><SubmitButton className="btn btn-sm">Guardar tasas</SubmitButton></div>
      </form>
      <div className="table-wrap card" style={{ padding: 0 }}>
        <table className="table">
          <thead><tr><th>Ejemplo</th><th>COP</th><th>USD</th><th>MXN</th><th>PEN</th></tr></thead>
          <tbody>
            {examples.map((e) => (
              <tr key={e.label}>
                <td>{e.label}</td>
                {(["COP", "USD", "MXN", "PEN"] as const).map((c) => (
                  <td key={c}>{e.from === e.to ? formatPrice(e.from, c, rates) : formatRange(e.from, e.to, c, rates)}</td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </>
  );
}
