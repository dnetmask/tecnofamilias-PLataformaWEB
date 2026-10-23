import Link from "next/link";
import { SubmitButton } from "@/components/SubmitButton";
import { db } from "@/lib/db";
import { formatDateTime } from "@/lib/format";
import { deleteCategoryAction, resolveReportAction, saveCategoryAction } from "../actions";
import { Notice, type NoticeParams } from "../Notice";

export default async function AdminCommunityPage({ searchParams }: { searchParams: NoticeParams }) {
  const { error, ok } = await searchParams;
  const [categories, reports, hiddenThreads] = await Promise.all([
    db.forumCategory.findMany({ orderBy: { order: "asc" }, include: { _count: { select: { threads: true } } } }),
    db.forumReport.findMany({
      where: { resolved: false },
      orderBy: { createdAt: "desc" },
      include: {
        reporter: { select: { name: true } },
        thread: { select: { id: true, title: true, body: true } },
        post: { select: { id: true, body: true, threadId: true, author: { select: { name: true } } } },
      },
    }),
    db.forumThread.count({ where: { hidden: true } }),
  ]);

  return (
    <>
      <h1>Comunidad</h1>
      <Notice error={error} ok={ok} />

      <section className="card stack">
        <h3>Reportes pendientes ({reports.length})</h3>
        {reports.length === 0 && <p className="muted small" style={{ margin: 0 }}>No hay reportes pendientes. 🎉</p>}
        {reports.map((r) => {
          const threadId = r.thread?.id ?? r.post?.threadId;
          const text = r.post?.body ?? r.thread?.body ?? "";
          return (
            <div key={r.id} className="card card-tint stack" style={{ padding: 14 }}>
              <div className="small muted">
                Reportado por {r.reporter.name} · {formatDateTime(r.createdAt)} · {r.post ? `respuesta de ${r.post.author.name}` : `conversación “${r.thread?.title}”`}
              </div>
              <div className="post-body small">{text.length > 400 ? `${text.slice(0, 400)}…` : text}</div>
              <div className="row">
                {threadId && <Link className="btn btn-ghost btn-sm" href={`/comunidad/hilo/${threadId}`}>Ver conversación</Link>}
                <form action={resolveReportAction}>
                  <input type="hidden" name="id" value={r.id} />
                  <input type="hidden" name="hide" value="1" />
                  <button className="btn btn-red btn-sm">Ocultar contenido</button>
                </form>
                <form action={resolveReportAction}>
                  <input type="hidden" name="id" value={r.id} />
                  <button className="btn btn-ghost btn-sm">Descartar</button>
                </form>
              </div>
            </div>
          );
        })}
        {hiddenThreads > 0 && <p className="small muted" style={{ margin: 0 }}>{hiddenThreads} conversaciones ocultas (visibles solo para administradores).</p>}
      </section>

      <section className="card stack">
        <h3>Categorías</h3>
        {categories.map((c) => (
          <div key={c.id} className="row" style={{ alignItems: "flex-end" }}>
            <form action={saveCategoryAction} className="row" style={{ flex: 1, alignItems: "flex-end" }}>
              <input type="hidden" name="id" value={c.id} />
              <div className="field" style={{ width: 70 }}><label className="small">Orden</label><input className="input" name="order" type="number" defaultValue={c.order} /></div>
              <div className="field" style={{ flex: "1 1 180px" }}><label className="small">Nombre</label><input className="input" name="name" defaultValue={c.name} required /></div>
              <div className="field" style={{ flex: "2 1 260px" }}><label className="small">Descripción</label><input className="input" name="description" defaultValue={c.description} /></div>
              <SubmitButton className="btn btn-sm btn-ghost">Guardar</SubmitButton>
            </form>
            <form action={deleteCategoryAction}>
              <input type="hidden" name="id" value={c.id} />
              <button className="btn-link btn-danger-link small" title={`${c._count.threads} conversaciones`}>Eliminar</button>
            </form>
          </div>
        ))}
        <form action={saveCategoryAction} className="row" style={{ alignItems: "flex-end", borderTop: "1px solid var(--line)", paddingTop: 14 }}>
          <div className="field" style={{ width: 70 }}><label className="small">Orden</label><input className="input" name="order" type="number" defaultValue={categories.length + 1} /></div>
          <div className="field" style={{ flex: "1 1 180px" }}><label className="small">Nueva categoría</label><input className="input" name="name" required /></div>
          <div className="field" style={{ flex: "2 1 260px" }}><label className="small">Descripción</label><input className="input" name="description" /></div>
          <SubmitButton className="btn btn-sm">Crear</SubmitButton>
        </form>
      </section>
    </>
  );
}
