import Link from "next/link";
import { db } from "@/lib/db";
import { stageShort } from "@/lib/format";
import { TOOL_ACCESS, TOOL_KINDS } from "@/lib/tools";
import { Notice, type NoticeParams } from "../Notice";

export default async function AdminResourcesPage({ searchParams }: { searchParams: NoticeParams }) {
  const { error, ok } = await searchParams;
  const resources = await db.resource.findMany({
    orderBy: [{ order: "asc" }, { createdAt: "desc" }],
    include: { _count: { select: { favorites: true, purchases: true } } },
  });
  return (
    <>
      <div className="row between">
        <h1 style={{ margin: 0 }}>Caja de herramientas</h1>
        <Link className="btn btn-sm" href="/admin/recursos/nuevo">+ Nueva herramienta</Link>
      </div>
      <p className="small muted">Usos: familias distintas que abrieron, vieron o descargaron la herramienta. Las 4 con más usos aparecen arriba como “Las herramientas más usadas”.</p>
      <Notice error={error} ok={ok} />
      <div className="table-wrap card" style={{ padding: 0 }}>
        <table className="table">
          <thead><tr><th>Orden</th><th>Título</th><th>Tipo</th><th>Acceso</th><th>Etapa</th><th>Usos</th><th>Favoritos</th><th>Ventas</th><th>Estado</th></tr></thead>
          <tbody>
            {resources.map((r) => (
              <tr key={r.id}>
                <td>{r.order}</td>
                <td><Link href={`/admin/recursos/${r.id}`}>{r.title}</Link><div className="small muted">{r.author}</div></td>
                <td>{TOOL_KINDS[r.kind].icon} {TOOL_KINDS[r.kind].label}</td>
                <td><span className={`badge ${TOOL_ACCESS[r.access].badge}`}>{TOOL_ACCESS[r.access].label}</span></td>
                <td>{stageShort(r.ageStage)}</td>
                <td>{r.uses}</td>
                <td>{r._count.favorites}</td>
                <td>{r.access === "PAID" ? r._count.purchases : "—"}</td>
                <td>{r.published ? <span className="badge badge-green">Publicado</span> : <span className="badge badge-gray">Oculto</span>}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </>
  );
}
