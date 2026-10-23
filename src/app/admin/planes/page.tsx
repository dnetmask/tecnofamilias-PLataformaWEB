import { SubmitButton } from "@/components/SubmitButton";
import { db } from "@/lib/db";
import { savePlanAction } from "../actions";
import { Notice, type NoticeParams } from "../Notice";

function PlanForm({ plan }: { plan?: { id: string; name: string; description: string; priceCop: number; interval: string; order: number; active: boolean } }) {
  return (
    <form action={savePlanAction} className="card form">
      {plan && <input type="hidden" name="id" value={plan.id} />}
      <h3>{plan ? plan.name : "Nuevo plan"}</h3>
      <div className="grid grid-2" style={{ gap: 14 }}>
        <div className="field"><label>Nombre</label><input className="input" name="name" defaultValue={plan?.name} required /></div>
        <div className="field"><label>Precio (COP)</label><input className="input" name="priceCop" type="number" min={1000} step={100} defaultValue={plan?.priceCop} required /></div>
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
  const plans = await db.plan.findMany({ orderBy: { order: "asc" } });
  return (
    <>
      <h1>Planes de suscripción</h1>
      <Notice error={error} ok={ok} />
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
