import Link from "next/link";
import { db } from "@/lib/db";
import { ACCESS_LABELS, formatCop, stageShort } from "@/lib/format";
import { Notice, type NoticeParams } from "../Notice";

export default async function AdminLessonsPage({ searchParams }: { searchParams: NoticeParams }) {
  const { error, ok } = await searchParams;
  const lessons = await db.lesson.findMany({
    orderBy: [{ order: "asc" }, { createdAt: "desc" }],
    include: { _count: { select: { purchases: true } } },
  });
  return (
    <>
      <div className="row between">
        <h1 style={{ margin: 0 }}>Clases</h1>
        <Link className="btn btn-sm" href="/admin/clases/nuevo">+ Nueva clase</Link>
      </div>
      <Notice error={error} ok={ok} />
      <div className="table-wrap card" style={{ padding: 0 }}>
        <table className="table">
          <thead><tr><th>Orden</th><th>Título</th><th>Etapa</th><th>Acceso</th><th>Ventas</th><th>Estado</th></tr></thead>
          <tbody>
            {lessons.map((l) => (
              <tr key={l.id}>
                <td>{l.order}</td>
                <td><Link href={`/admin/clases/${l.id}`}>{l.title}</Link></td>
                <td>{stageShort(l.ageStage)}</td>
                <td>{l.access === "ADDON" ? `Complemento · ${formatCop(l.priceCop)}` : ACCESS_LABELS[l.access]}</td>
                <td>{l._count.purchases}</td>
                <td>{l.published ? <span className="badge badge-green">Publicada</span> : <span className="badge badge-gray">Borrador</span>}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </>
  );
}
