import type { OrderStatus } from "@prisma/client";
import Link from "next/link";
import { db } from "@/lib/db";
import { formatCop, formatDateTime } from "@/lib/format";
import { paymentsMode } from "@/lib/payments";
import { markOrderPaidAction } from "../actions";
import { Notice } from "../Notice";

const STATUSES: OrderStatus[] = ["PENDING", "PAID", "FAILED", "REFUNDED"];
const LABELS: Record<OrderStatus, [string, string]> = {
  PENDING: ["Pendiente", "badge-yellow"],
  PAID: ["Pagado", "badge-green"],
  FAILED: ["Fallido", "badge-red"],
  REFUNDED: ["Reembolsado", "badge-gray"],
};

export default async function AdminPaymentsPage({ searchParams }: { searchParams: Promise<{ estado?: string; error?: string; ok?: string }> }) {
  const { estado, error, ok } = await searchParams;
  const status = STATUSES.find((s) => s === estado);
  const orders = await db.order.findMany({
    where: status ? { status } : {},
    orderBy: { createdAt: "desc" },
    take: 100,
    include: { user: { select: { id: true, name: true, email: true } } },
  });
  return (
    <>
      <h1>Pagos</h1>
      <Notice error={error} ok={ok} />
      <p className="small muted">
        Pasarela: <strong>{paymentsMode() === "demo" ? "modo demo (sin cobros reales)" : "Mercado Pago"}</strong>. Se muestran las últimas 100 órdenes.
      </p>
      <div className="chips">
        <Link className={`chip${!status ? " active" : ""}`} href="/admin/pagos">Todas</Link>
        {STATUSES.map((s) => (
          <Link key={s} className={`chip${status === s ? " active" : ""}`} href={`/admin/pagos?estado=${s}`}>{LABELS[s][0]}</Link>
        ))}
      </div>
      <div className="table-wrap card" style={{ padding: 0 }}>
        <table className="table">
          <thead><tr><th>Fecha</th><th>Usuario</th><th>Concepto</th><th>Valor</th><th>Estado</th><th>Referencia</th><th></th></tr></thead>
          <tbody>
            {orders.map((o) => (
              <tr key={o.id}>
                <td>{formatDateTime(o.createdAt)}</td>
                <td><Link href={`/admin/usuarios/${o.user.id}`}>{o.user.name}</Link><div className="small muted">{o.user.email}</div></td>
                <td>{o.description}</td>
                <td>{formatCop(o.amountCop)}</td>
                <td><span className={`badge ${LABELS[o.status][1]}`}>{LABELS[o.status][0]}</span></td>
                <td className="small muted">{o.provider}{o.providerRef ? ` · ${o.providerRef}` : ""}</td>
                <td>
                  {o.status === "PENDING" && (
                    <form action={markOrderPaidAction}>
                      <input type="hidden" name="id" value={o.id} />
                      <button className="btn btn-ghost btn-sm" title="Para pagos recibidos por transferencia u otro medio">Marcar pagada</button>
                    </form>
                  )}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </>
  );
}
