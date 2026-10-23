import Link from "next/link";
import { notFound } from "next/navigation";
import { SubmitButton } from "@/components/SubmitButton";
import { db } from "@/lib/db";
import { AUDIENCE_ORDER, AUDIENCES } from "@/lib/services";
import { saveServiceAction } from "../../actions";
import { Notice, type NoticeParams } from "../../Notice";

export default async function AdminServicePage({ params, searchParams }: { params: Promise<{ id: string }>; searchParams: NoticeParams }) {
  const { id } = await params;
  const { error, ok } = await searchParams;
  const s = id === "nuevo" ? null : await db.service.findUnique({ where: { id } });
  if (id !== "nuevo" && !s) notFound();

  return (
    <>
      <p className="small"><Link href="/admin/servicios">← Otros servicios</Link></p>
      <div className="row between">
        <h1 style={{ margin: 0 }}>{s ? "Editar servicio" : "Nuevo servicio"}</h1>
        {s && <Link className="btn btn-ghost btn-sm" href={`/servicios/${s.slug}`} target="_blank">Ver en el sitio ↗</Link>}
      </div>
      <Notice error={error} ok={ok} />
      <form action={saveServiceAction} className="card form">
        {s && <input type="hidden" name="id" value={s.id} />}
        <div className="grid grid-2" style={{ gap: 14 }}>
          <div className="field"><label>Nombre</label><input className="input" name="name" defaultValue={s?.name} required /></div>
          <div className="field">
            <label>Público</label>
            <select className="select" name="audience" defaultValue={s?.audience ?? "COLEGIOS"}>
              {AUDIENCE_ORDER.map((a) => <option key={a} value={a}>{AUDIENCES[a].label}</option>)}
            </select>
          </div>
          <div className="field"><label>Precio de referencia desde (COP)</label><input className="input" name="priceFromCop" type="number" min={0} step={1000} defaultValue={s?.priceFromCop ?? ""} placeholder="3000000" /></div>
          <div className="field"><label>Precio de referencia hasta (COP)</label><input className="input" name="priceToCop" type="number" min={0} step={1000} defaultValue={s?.priceToCop ?? ""} placeholder="5000000" /></div>
          <div className="field"><label>Unidad</label><input className="input" name="unit" defaultValue={s?.unit} placeholder="por sesión, por año…" /></div>
          <div className="field">
            <label>Precio para compra en línea (COP)</label>
            <input className="input" name="priceCop" type="number" min={1000} step={1000} defaultValue={s?.priceCop ?? ""} />
            <span className="hint">Déjalo vacío para que sea “Solicitar cotización”. Si lo llenas, el rango toma este mismo valor. Los precios se muestran convertidos a USD, MXN y PEN con las tasas de Monedas.</span>
          </div>
          <div className="field"><label>Orden</label><input className="input" name="order" type="number" defaultValue={s?.order ?? 0} /></div>
          <div className="field"><label>Slug (URL)</label><input className="input" name="slug" defaultValue={s?.slug} placeholder="Se genera del nombre" /></div>
        </div>
        <div className="field"><label>Descripción corta</label><textarea className="textarea" name="description" defaultValue={s?.description} rows={3} /></div>
        <div className="field"><label>Detalles (página del servicio)</label><textarea className="textarea" name="details" defaultValue={s?.details} rows={4} /></div>
        <label className="check"><input type="checkbox" name="featured" defaultChecked={s?.featured ?? false} /> Destacado (tarjeta oscura)</label>
        <label className="check"><input type="checkbox" name="active" defaultChecked={s?.active ?? true} /> Visible</label>
        <div><SubmitButton>Guardar servicio</SubmitButton></div>
      </form>
    </>
  );
}
