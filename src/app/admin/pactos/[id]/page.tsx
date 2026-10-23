import Link from "next/link";
import { notFound } from "next/navigation";
import { SubmitButton } from "@/components/SubmitButton";
import { db } from "@/lib/db";
import { deleteTemplateAction, saveTemplateAction } from "../../actions";
import { Notice, type NoticeParams } from "../../Notice";

export default async function AdminTemplatePage({ params, searchParams }: { params: Promise<{ id: string }>; searchParams: NoticeParams }) {
  const { id } = await params;
  const { error, ok } = await searchParams;
  const t = id === "nuevo" ? null : await db.pactTemplate.findUnique({ where: { id } });
  if (id !== "nuevo" && !t) notFound();
  const clauses = Array.isArray(t?.clauses) ? (t!.clauses as string[]).join("\n") : "";

  return (
    <>
      <p className="small"><Link href="/admin/pactos">← Plantillas</Link></p>
      <h1>{t ? `Plantilla: ${t.appName}` : "Nueva plantilla"}</h1>
      <Notice error={error} ok={ok} />
      <form action={saveTemplateAction} className="card form">
        {t && <input type="hidden" name="id" value={t.id} />}
        <div className="grid grid-2" style={{ gap: 14 }}>
          <div className="field"><label>Aplicación / dispositivo</label><input className="input" name="appName" defaultValue={t?.appName} required /></div>
          <div className="field"><label>Slug (URL)</label><input className="input" name="slug" defaultValue={t?.slug} placeholder="Se genera del nombre" /></div>
          <div className="field"><label>Color</label><input className="input" name="color" defaultValue={t?.color ?? "#3DAEE4"} pattern="#[0-9a-fA-F]{6}" /></div>
          <div className="field"><label>Edad mínima sugerida</label><input className="input" name="minAge" type="number" min={0} max={18} defaultValue={t?.minAge ?? 0} /></div>
        </div>
        <div className="field"><label>Descripción</label><textarea className="textarea" name="description" defaultValue={t?.description} rows={3} /></div>
        <div className="field">
          <label>Cláusulas sugeridas (una por línea)</label>
          <textarea className="textarea" name="clauses" defaultValue={clauses} rows={12} required />
        </div>
        <div className="field" style={{ maxWidth: 160 }}><label>Orden</label><input className="input" name="order" type="number" defaultValue={t?.order ?? 0} /></div>
        <label className="check"><input type="checkbox" name="published" defaultChecked={t?.published ?? true} /> Publicada</label>
        <div><SubmitButton>Guardar plantilla</SubmitButton></div>
      </form>
      {t && (
        <form action={deleteTemplateAction}>
          <input type="hidden" name="id" value={t.id} />
          <button className="btn-link btn-danger-link small">Eliminar plantilla (los pactos ya creados se conservan)</button>
        </form>
      )}
    </>
  );
}
