import Link from "next/link";
import { db } from "@/lib/db";
import { DEFAULT_RATES, formatRange } from "@/lib/currency";
import { formatCop } from "@/lib/format";
import { AUDIENCES } from "@/lib/services";
import { Notice, type NoticeParams } from "../Notice";

export default async function AdminServicesPage({ searchParams }: { searchParams: NoticeParams }) {
  const { error, ok } = await searchParams;
  const services = await db.service.findMany({
    orderBy: { order: "asc" },
    include: { _count: { select: { requests: true } } },
  });
  return (
    <>
      <div className="row between">
        <h1 style={{ margin: 0 }}>Otros servicios</h1>
        <Link className="btn btn-sm" href="/admin/servicios/nuevo">+ Nuevo servicio</Link>
      </div>
      <Notice error={error} ok={ok} />
      <p className="small muted">
        Con <strong>precio en línea</strong> el servicio se compra con Mercado Pago; sin él, se muestra “Solicitar cotización”.
        Las solicitudes llegan a <Link href="/admin/solicitudes">Solicitudes</Link>.
      </p>
      <div className="table-wrap card" style={{ padding: 0 }}>
        <table className="table">
          <thead><tr><th>Orden</th><th>Servicio</th><th>Público</th><th>Precio mostrado</th><th>Compra</th><th>Solicitudes</th><th>Estado</th></tr></thead>
          <tbody>
            {services.map((s) => (
              <tr key={s.id}>
                <td>{s.order}</td>
                <td><Link href={`/admin/servicios/${s.id}`}>{s.name}</Link></td>
                <td>{AUDIENCES[s.audience].label}</td>
                <td>{formatRange(s.priceFromCop, s.priceToCop, "COP", DEFAULT_RATES)} <span className="small muted">{s.unit}</span></td>
                <td>{s.priceCop ? `En línea · ${formatCop(s.priceCop)}` : "Cotización"}</td>
                <td>{s._count.requests}</td>
                <td>{s.active ? <span className="badge badge-green">Visible</span> : <span className="badge badge-gray">Oculto</span>}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </>
  );
}
