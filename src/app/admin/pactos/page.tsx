import Link from "next/link";
import { db } from "@/lib/db";
import { Notice, type NoticeParams } from "../Notice";

export default async function AdminTemplatesPage({ searchParams }: { searchParams: NoticeParams }) {
  const { error, ok } = await searchParams;
  const [templates, totals] = await Promise.all([
    db.pactTemplate.findMany({ orderBy: [{ order: "asc" }, { appName: "asc" }], include: { _count: { select: { pacts: true } } } }),
    db.pact.groupBy({ by: ["status"], _count: true }),
  ]);
  const count = (s: string) => totals.find((t) => t.status === s)?._count ?? 0;
  return (
    <>
      <div className="row between">
        <h1 style={{ margin: 0 }}>Plantillas de pactos</h1>
        <Link className="btn btn-sm" href="/admin/pactos/nuevo">+ Nueva plantilla</Link>
      </div>
      <Notice error={error} ok={ok} />
      <p className="small muted">
        Pactos de las familias: {count("DRAFT")} borradores · {count("PARENT_SIGNED")} con firma del adulto · {count("SIGNED")} firmados.
        Por privacidad, el contenido de los pactos solo lo ve cada familia.
      </p>
      <div className="table-wrap card" style={{ padding: 0 }}>
        <table className="table">
          <thead><tr><th>Orden</th><th>Aplicación</th><th>Cláusulas</th><th>Pactos creados</th><th>Estado</th></tr></thead>
          <tbody>
            {templates.map((t) => (
              <tr key={t.id}>
                <td>{t.order}</td>
                <td><span className="icon-dot" style={{ background: t.color, width: 14, height: 14, display: "inline-block", marginRight: 8, verticalAlign: "middle" }} /><Link href={`/admin/pactos/${t.id}`}>{t.appName}</Link></td>
                <td>{Array.isArray(t.clauses) ? t.clauses.length : 0}</td>
                <td>{t._count.pacts}</td>
                <td>{t.published ? <span className="badge badge-green">Publicada</span> : <span className="badge badge-gray">Oculta</span>}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </>
  );
}
