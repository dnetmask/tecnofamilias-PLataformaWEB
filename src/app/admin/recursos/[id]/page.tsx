import Link from "next/link";
import { notFound } from "next/navigation";
import { SubmitButton } from "@/components/SubmitButton";
import { db } from "@/lib/db";
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
      <p className="small"><Link href="/admin/recursos">← Videos y podcasts</Link></p>
      <h1>{r ? "Editar recurso" : "Nuevo recurso"}</h1>
      <Notice error={error} ok={ok} />
      <form action={saveResourceAction} className="card form">
        {r && <input type="hidden" name="id" value={r.id} />}
        <div className="grid grid-2" style={{ gap: 14 }}>
          <div className="field">
            <label>Tipo</label>
            <select className="select" name="kind" defaultValue={r?.kind ?? "VIDEO"}>
              <option value="VIDEO">Video</option>
              <option value="PODCAST">Podcast</option>
            </select>
          </div>
          <div className="field"><label>Etapa</label><StageSelect defaultValue={r?.ageStage ?? "ALL"} /></div>
          <div className="field"><label>Título</label><input className="input" name="title" defaultValue={r?.title} required /></div>
          <div className="field"><label>Autor / canal</label><input className="input" name="author" defaultValue={r?.author} /></div>
        </div>
        <div className="field">
          <label>URL</label>
          <input className="input" name="url" defaultValue={r?.url} required placeholder="https://www.youtube.com/watch?v=… o https://open.spotify.com/episode/…" />
          <span className="hint">YouTube, Vimeo y Spotify se muestran embebidos; otros enlaces se abren en una pestaña nueva.</span>
        </div>
        <div className="field"><label>¿Por qué lo recomendamos?</label><textarea className="textarea" name="description" defaultValue={r?.description} rows={4} /></div>
        <div className="field" style={{ maxWidth: 160 }}><label>Orden</label><input className="input" name="order" type="number" defaultValue={r?.order ?? 0} /></div>
        <label className="check"><input type="checkbox" name="published" defaultChecked={r?.published ?? true} /> Publicado</label>
        <div><SubmitButton>Guardar</SubmitButton></div>
      </form>
      {r && (
        <form action={deleteResourceAction}>
          <input type="hidden" name="id" value={r.id} />
          <button className="btn-link btn-danger-link small">Eliminar recurso</button>
        </form>
      )}
    </>
  );
}
