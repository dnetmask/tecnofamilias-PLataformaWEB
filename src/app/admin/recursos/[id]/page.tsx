import Link from "next/link";
import { notFound } from "next/navigation";
import { SubmitButton } from "@/components/SubmitButton";
import { db } from "@/lib/db";
import { TOOL_ACCESS, TOOL_KIND_ORDER, TOOL_KINDS } from "@/lib/tools";
import { deleteResourceAction, saveResourceAction } from "../../actions";
import { Notice, type NoticeParams } from "../../Notice";
import { StageSelect } from "../../StageSelect";

export default async function AdminResourcePage({ params, searchParams }: { params: Promise<{ id: string }>; searchParams: NoticeParams }) {
  const { id } = await params;
  const { error, ok } = await searchParams;
  const r = id === "nuevo" ? null : await db.resource.findUnique({ where: { id } });
  if (id !== "nuevo" && !r) notFound();

  return (
    <>
      <p className="small"><Link href="/admin/recursos">← Caja de herramientas</Link></p>
      <h1>{r ? "Editar herramienta" : "Nueva herramienta"}</h1>
      {r && (
        <p className="small muted">
          Página: <Link href={`/herramientas/${r.slug}`}>/herramientas/{r.slug}</Link>
          {r.access === "PAID" && <> · Pago: <Link href={`/checkout?herramienta=${r.slug}`}>/checkout?herramienta={r.slug}</Link></>}
          {" · "}👥 {r.uses} usos
        </p>
      )}
      <Notice error={error} ok={ok} />
      <form action={saveResourceAction} className="card form">
        {r && <input type="hidden" name="id" value={r.id} />}
        <div className="grid grid-2" style={{ gap: 14 }}>
          <div className="field">
            <label>Tipo</label>
            <select className="select" name="kind" defaultValue={r?.kind ?? "VIDEO"}>
              {TOOL_KIND_ORDER.map((k) => <option key={k} value={k}>{TOOL_KINDS[k].icon} {TOOL_KINDS[k].label}</option>)}
            </select>
          </div>
          <div className="field">
            <label>Acceso</label>
            <select className="select" name="access" defaultValue={r?.access ?? "SUBSCRIPTION"}>
              {(["FREE", "SUBSCRIPTION", "PAID", "EXTERNAL"] as const).map((a) => <option key={a} value={a}>{TOOL_ACCESS[a].label}</option>)}
            </select>
          </div>
          <div className="field"><label>Título</label><input className="input" name="title" defaultValue={r?.title} required /></div>
          <div className="field"><label>Autor / canal / marca</label><input className="input" name="author" defaultValue={r?.author} /></div>
          <div className="field"><label>Etapa</label><StageSelect defaultValue={r?.ageStage ?? "ALL"} /></div>
          <div className="field">
            <label>Dirección (slug)</label>
            <input className="input" name="slug" defaultValue={r?.slug} placeholder="Se genera con el título" />
          </div>
        </div>
        <div className="hint">
          <strong>Libre acceso:</strong> cualquiera, sin cuenta. <strong>Incluida en la suscripción:</strong> solo suscriptores.{" "}
          <strong>Pago adicional:</strong> suscriptores que la compren aquí; se crea su página de pago automáticamente.{" "}
          <strong>Se compra por fuera:</strong> el enlace lleva a la tienda del vendedor.
        </div>
        <div className="field">
          <label>URL</label>
          <input className="input" name="url" defaultValue={r?.url} required placeholder="https://… (video, episodio, archivo, tienda o sitio del producto)" />
          <span className="hint">YouTube, Vimeo y Spotify se muestran embebidos. En las pagas, es el enlace que recibe quien compra (p. ej. el archivo del ebook). En las externas, la tienda.</span>
        </div>
        <div className="field">
          <label>Imagen (opcional)</label>
          <input className="input" name="imageUrl" defaultValue={r?.imageUrl} placeholder="https://… portada del libro o foto del producto" />
        </div>
        <div className="grid grid-2" style={{ gap: 14 }}>
          <div className="field">
            <label>Precio en dólares</label>
            <input className="input" name="priceUsd" type="number" min={0} defaultValue={r?.priceUsd ?? 0} />
            <span className="hint">Obligatorio si es de pago adicional. En las externas es el precio de referencia (0 = no se muestra).</span>
          </div>
          <div className="field">
            <label>Precio fijo en COP (opcional)</label>
            <input className="input" name="priceCop" type="number" min={0} defaultValue={r?.priceCop ?? ""} />
            <span className="hint">Si lo llenas, en pesos se usa este valor en vez de convertir el dólar.</span>
          </div>
        </div>
        <div className="field"><label>¿Por qué la recomendamos?</label><textarea className="textarea" name="description" defaultValue={r?.description} rows={4} /></div>
        <div className="field" style={{ maxWidth: 160 }}><label>Orden</label><input className="input" name="order" type="number" defaultValue={r?.order ?? 0} /></div>
        <label className="check"><input type="checkbox" name="published" defaultChecked={r?.published ?? true} /> Publicada</label>
        <div><SubmitButton>Guardar</SubmitButton></div>
      </form>
      {r && (
        <form action={deleteResourceAction}>
          <input type="hidden" name="id" value={r.id} />
          <button className="btn-link btn-danger-link small">Eliminar herramienta</button>
        </form>
      )}
    </>
  );
}
