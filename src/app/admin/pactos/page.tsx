import Link from "next/link";
import { db } from "@/lib/db";
import { formatDateTime } from "@/lib/format";
import { Notice, type NoticeParams } from "../Notice";

export default async function AdminTemplatesPage({ searchParams }: { searchParams: NoticeParams }) {
  const { error, ok } = await searchParams;
  const since = new Date(Date.now() - 30 * 24 * 60 * 60 * 1000);
  const [templates, totals, perPact, recent, last30] = await Promise.all([
    db.pactTemplate.findMany({ orderBy: [{ order: "asc" }, { appName: "asc" }], include: { _count: { select: { pacts: true } } } }),
    db.pact.groupBy({ by: ["status"], _count: true }),
    // Descargas agrupadas por plantilla y pacto: da el total y los pactos distintos.
    db.pactDownload.groupBy({ by: ["templateId", "pactId"], _count: true }),
    db.pactDownload.findMany({ orderBy: { createdAt: "desc" }, take: 15, include: { template: { select: { appName: true } } } }),
    db.pactDownload.count({ where: { createdAt: { gte: since } } }),
  ]);
  const count = (s: string) => totals.find((t) => t.status === s)?._count ?? 0;

  const byTemplate = new Map<string | null, { downloads: number; pacts: number }>();
  for (const row of perPact) {
    const cur = byTemplate.get(row.templateId) ?? { downloads: 0, pacts: 0 };
    cur.downloads += row._count;
    if (row.pactId) cur.pacts += 1;
    byTemplate.set(row.templateId, cur);
  }
  const totalDownloads = perPact.reduce((n, r) => n + r._count, 0);
  const totalPacts = perPact.filter((r) => r.pactId).length;
  const noTemplate = byTemplate.get(null);
  const stat = (id: string | null) => byTemplate.get(id) ?? { downloads: 0, pacts: 0 };

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

      <div className="grid grid-3" style={{ marginBottom: 20 }}>
        <div className="card"><div className="small muted">Descargas en PDF</div><div className="price">{totalDownloads}</div></div>
        <div className="card"><div className="small muted">Pactos descargados (distintos)</div><div className="price">{totalPacts}</div></div>
        <div className="card"><div className="small muted">Descargas últimos 30 días</div><div className="price">{last30}</div></div>
      </div>

      <div className="table-wrap card" style={{ padding: 0 }}>
        <table className="table">
          <thead><tr><th>Orden</th><th>Aplicación</th><th>Cláusulas</th><th>Pactos creados</th><th>Pactos descargados</th><th>Descargas</th><th>Estado</th></tr></thead>
          <tbody>
            {templates.map((t) => (
              <tr key={t.id}>
                <td>{t.order}</td>
                <td><span className="icon-dot" style={{ background: t.color, width: 14, height: 14, display: "inline-block", marginRight: 8, verticalAlign: "middle" }} /><Link href={`/admin/pactos/${t.id}`}>{t.appName}</Link></td>
                <td>{Array.isArray(t.clauses) ? t.clauses.length : 0}</td>
                <td>{t._count.pacts}</td>
                <td>{stat(t.id).pacts}</td>
                <td><strong>{stat(t.id).downloads}</strong></td>
                <td>
                  {t.published ? <span className="badge badge-green">Publicada</span> : <span className="badge badge-gray">Oculta</span>}
                  {t.public && t.published && <div className="small"><Link href={`/pacto/${t.slug}`}>🔗 Enlace público</Link></div>}
                </td>
              </tr>
            ))}
            {noTemplate && (
              <tr>
                <td>—</td>
                <td className="muted">Sin plantilla o plantilla eliminada</td>
                <td>—</td>
                <td>—</td>
                <td>{noTemplate.pacts}</td>
                <td><strong>{noTemplate.downloads}</strong></td>
                <td />
              </tr>
            )}
          </tbody>
        </table>
      </div>

      <h2 style={{ marginTop: 32 }}>Últimas descargas</h2>
      {recent.length === 0 ? (
        <p className="muted">Aún no hay descargas de pactos.</p>
      ) : (
        <div className="table-wrap card" style={{ padding: 0 }}>
          <table className="table">
            <thead><tr><th>Fecha</th><th>Pacto</th><th>Descargó</th><th>Origen</th><th>Firmas</th></tr></thead>
            <tbody>
              {recent.map((d) => (
                <tr key={d.id}>
                  <td>{formatDateTime(d.createdAt)}</td>
                  <td>{d.template?.appName ?? d.appName}{!d.pactId && <div className="small muted">pacto eliminado</div>}</td>
                  <td>{d.by === "CHILD" ? "Hijo/a" : "Adulto"}</td>
                  <td>{d.withAccount ? <span className="badge badge-blue">Con cuenta</span> : <span className="badge badge-gray">Enlace público</span>}</td>
                  <td>{d.fullySigned ? "Las dos" : "Solo el adulto"}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </>
  );
}
