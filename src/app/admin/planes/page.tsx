import { SubmitButton } from "@/components/SubmitButton";
import { db } from "@/lib/db";
import { savePlanAction, savePlatformAction } from "../actions";
import { Notice, type NoticeParams } from "../Notice";
import { isPlatformOpen } from "@/lib/launch";

function PlanForm({ plan }: { plan?: { id: string; name: string; description: string; priceUsd: number; priceCop: number | null; interval: string; order: number; active: boolean } }) {
  return (
    <form action={savePlanAction} className="card form">
      {plan && <input type="hidden" name="id" value={plan.id} />}
      <h3>{plan ? plan.name : "Nuevo plan"}</h3>
      <div className="grid grid-2" style={{ gap: 14 }}>
        <div className="field"><label>Nombre</label><input className="input" name="name" defaultValue={plan?.name} required /></div>
        <div className="field"><label>Precio (USD)</label><input className="input" name="priceUsd" type="number" min={1} step={1} defaultValue={plan?.priceUsd} required /></div>
        <div className="field">
          <label>Precio fijo en COP (opcional)</label>
          <input className="input" name="priceCop" type="number" min={100} step={100} defaultValue={plan?.priceCop ?? ""} placeholder="Convertir con la tasa del día" />
          <span className="hint">Si lo llenas, en pesos colombianos se muestra y se cobra este valor en lugar de convertir el dólar.</span>
        </div>
        <div className="field">
          <label>Período</label>
          <select className="select" name="interval" defaultValue={plan?.interval ?? "MONTH"}>
            <option value="MONTH">Mensual</option>
            <option value="YEAR">Anual</option>
          </select>
        </div>
        <div className="field"><label>Orden</label><input className="input" name="order" type="number" defaultValue={plan?.order ?? 0} /></div>
      </div>
      <div className="field"><label>Descripción</label><input className="input" name="description" defaultValue={plan?.description} /></div>
      <label className="check"><input type="checkbox" name="active" defaultChecked={plan?.active ?? true} /> Activo (visible en la página de planes)</label>
      <div><SubmitButton className="btn btn-sm">Guardar</SubmitButton></div>
    </form>
  );
}

export default async function AdminPlansPage({ searchParams }: { searchParams: NoticeParams }) {
  const { error, ok } = await searchParams;
  const [plans, open] = await Promise.all([db.plan.findMany({ orderBy: { order: "asc" } }), isPlatformOpen()]);
  return (
    <>
      <h1>Planes de suscripción</h1>
      <Notice error={error} ok={ok} />
      <form action={savePlatformAction} className="card form">
        <div className="row between">
          <h3 style={{ margin: 0 }}>Lanzamiento de la plataforma</h3>
          <span className={`badge ${open ? "badge-green" : "badge-yellow"}`}>{open ? "Abierta" : "Próximamente"}</span>
        </div>
        <p className="small muted" style={{ margin: 0 }}>
          Mientras está en “Próximamente”, el plan se muestra sin precio ni botón de compra y no se pueden crear cuentas,
          salvo para comprar un servicio (por ejemplo, la asesoría). Los servicios, los juegos gratis y la Caja de herramientas siguen disponibles.
        </p>
        <label className="check"><input type="checkbox" name="open" defaultChecked={open} /> Plataforma abierta: permitir crear cuentas y comprar la suscripción</label>
        <div><SubmitButton className="btn btn-sm">Guardar</SubmitButton></div>
      </form>
      <p className="small muted">
        Los cambios de precio aplican a los pagos nuevos; las suscripciones vigentes conservan su fecha de vencimiento.
      </p>
      <div className="grid grid-2" style={{ alignItems: "start" }}>
        {plans.map((p) => <PlanForm key={p.id} plan={p} />)}
        <PlanForm />
      </div>
    </>
  );
}
