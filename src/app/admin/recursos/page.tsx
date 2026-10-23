import Link from "next/link";
import { db } from "@/lib/db";
import { RESOURCE_LABELS, stageShort } from "@/lib/format";
import { Notice, type NoticeParams } from "../Notice";

export default async function AdminResourcesPage({ searchParams }: { searchParams: NoticeParams }) {
  const { error, ok } = await searchParams;
  const resources = await db.resource.findMany({ orderBy: [{ order: "asc" }, { createdAt: "desc" }] });
  return (
    <>
      <div className="row between">
        <h1 style={{ margin: 0 }}>Videos y podcasts</h1>
        <Link className="btn btn-sm" href="/admin/recursos/nuevo">+ Nuevo recurso</Link>
      </div>
      <Notice error={error} ok={ok} />
      <div className="table-wrap card" style={{ padding: 0 }}>
        <table className="table">
          <thead><tr><th>Orden</th><th>Título</th><th>Tipo</th><th>Etapa</th><th>Estado</th></tr></thead>
          <tbody>
            {resources.map((r) => (
              <tr key={r.id}>
                <td>{r.order}</td>
                <td><Link href={`/admin/recursos/${r.id}`}>{r.title}</Link><div className="small muted">{r.author}</div></td>
                <td>{RESOURCE_LABELS[r.kind]}</td>
                <td>{stageShort(r.ageStage)}</td>
                <td>{r.published ? <span className="badge badge-green">Publicado</span> : <span className="badge badge-gray">Oculto</span>}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </>
  );
}
