import Link from "next/link";
import { notFound } from "next/navigation";
import { SubmitButton } from "@/components/SubmitButton";
import { db } from "@/lib/db";
import { deleteLessonAction, saveLessonAction } from "../../actions";
import { Notice, type NoticeParams } from "../../Notice";
import { StageSelect } from "../../StageSelect";

export default async function AdminLessonPage({ params, searchParams }: { params: Promise<{ id: string }>; searchParams: NoticeParams }) {
  const { id } = await params;
  const { error, ok } = await searchParams;
  const lesson = id === "nuevo" ? null : await db.lesson.findUnique({ where: { id } });
  if (id !== "nuevo" && !lesson) notFound();

  return (
    <>
      <p className="small"><Link href="/admin/clases">← Clases</Link></p>
      <div className="row between">
        <h1 style={{ margin: 0 }}>{lesson ? "Editar clase" : "Nueva clase"}</h1>
        {lesson && <Link className="btn btn-ghost btn-sm" href={`/clases/${lesson.slug}`} target="_blank">Ver en el sitio ↗</Link>}
      </div>
      <Notice error={error} ok={ok} />
      <form action={saveLessonAction} className="card form">
        {lesson && <input type="hidden" name="id" value={lesson.id} />}
        <div className="grid grid-2" style={{ gap: 14 }}>
          <div className="field"><label>Título</label><input className="input" name="title" defaultValue={lesson?.title} required /></div>
          <div className="field"><label>Slug (URL)</label><input className="input" name="slug" defaultValue={lesson?.slug} placeholder="Se genera del título" /></div>
        </div>
        <div className="field"><label>Resumen</label><input className="input" name="summary" defaultValue={lesson?.summary} maxLength={300} required /></div>
        <div className="field"><label>Descripción</label><textarea className="textarea" name="description" defaultValue={lesson?.description} rows={6} /></div>
        <div className="grid grid-2" style={{ gap: 14 }}>
          <div className="field"><label>Etapa</label><StageSelect defaultValue={lesson?.ageStage ?? "ALL"} /></div>
          <div className="field">
            <label>Acceso</label>
            <select className="select" name="access" defaultValue={lesson?.access ?? "INCLUDED"}>
              <option value="INCLUDED">Incluida en la suscripción</option>
              <option value="ADDON">Complemento (pago adicional para suscriptores)</option>
            </select>
          </div>
          <div className="field">
            <label>Precio del complemento (USD)</label>
            <input className="input" name="priceUsd" type="number" min={0} step={1} defaultValue={lesson?.priceUsd ?? 0} />
          </div>
          <div className="field"><label>Duración (min)</label><input className="input" name="durationMin" type="number" min={0} defaultValue={lesson?.durationMin ?? 0} /></div>
          <div className="field"><label>Instructor/a</label><input className="input" name="instructor" defaultValue={lesson?.instructor} /></div>
          <div className="field"><label>Orden</label><input className="input" name="order" type="number" defaultValue={lesson?.order ?? 0} /></div>
        </div>
        <div className="field">
          <label>URL del video</label>
          <input className="input" name="videoUrl" defaultValue={lesson?.videoUrl} placeholder="https://vimeo.com/… o https://youtu.be/…" />
          <span className="hint">
            Vimeo (con privacidad “ocultar de Vimeo” y dominio restringido a tecnofamilias.com) o YouTube no listado. También se acepta un .mp4/.m3u8 por https.
          </span>
        </div>
        <div className="field"><label>URL de la miniatura (opcional)</label><input className="input" name="thumbnailUrl" defaultValue={lesson?.thumbnailUrl} /></div>
        <label className="check"><input type="checkbox" name="published" defaultChecked={lesson?.published ?? false} /> Publicada</label>
        <div><SubmitButton>Guardar clase</SubmitButton></div>
      </form>
      {lesson && (
        <form action={deleteLessonAction}>
          <input type="hidden" name="id" value={lesson.id} />
          <button className="btn-link btn-danger-link small">Eliminar clase (también retira el acceso de quienes la compraron)</button>
        </form>
      )}
    </>
  );
}
