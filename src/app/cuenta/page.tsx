import Link from "next/link";
import { getActiveSubscription } from "@/lib/access";
import { requireUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { formatCop, formatDate, formatDateTime } from "@/lib/format";
import { PasswordForm, ProfileForm } from "./Forms";

export const dynamic = "force-dynamic";
export const metadata = { title: "Mi cuenta" };

const ORDER_STATUS = {
  PENDING: ["Pendiente", "badge-yellow"],
  PAID: ["Pagado", "badge-green"],
  FAILED: ["Fallido", "badge-red"],
  REFUNDED: ["Reembolsado", "badge-gray"],
} as const;

export default async function AccountPage() {
  const user = await requireUser("/cuenta");
  const [sub, purchases, orders] = await Promise.all([
    getActiveSubscription(user.id),
    db.purchase.findMany({ where: { userId: user.id }, include: { lesson: true }, orderBy: { createdAt: "desc" } }),
    db.order.findMany({ where: { userId: user.id }, orderBy: { createdAt: "desc" }, take: 20 }),
  ]);

  return (
    <>
      <div className="page-head">
        <div className="container">
          <h1>Hola, {user.name.split(" ")[0]}</h1>
          <p>Administra tu suscripción, tus clases y tus datos.</p>
        </div>
      </div>
      <div className="container section grid grid-2" style={{ alignItems: "start" }}>
        <div className="card stack">
          <h3>Suscripción</h3>
          {sub ? (
            <>
              <span className="badge badge-green" style={{ alignSelf: "flex-start" }}>Activa</span>
              <p style={{ margin: 0 }}>
                {sub.plan?.name ?? "Acceso otorgado por Tecnofamilias"} · vigente hasta el{" "}
                <strong>{formatDate(sub.currentPeriodEnd)}</strong>
              </p>
              <Link className="btn btn-ghost btn-sm" href="/planes" style={{ alignSelf: "flex-start" }}>Renovar o extender</Link>
            </>
          ) : (
            <>
              <p className="muted" style={{ margin: 0 }}>No tienes una suscripción activa.</p>
              <Link className="btn btn-sm" href="/planes" style={{ alignSelf: "flex-start" }}>Ver planes</Link>
            </>
          )}
        </div>

        <div className="card stack">
          <h3>Clases compradas</h3>
          {purchases.length === 0 ? (
            <p className="muted" style={{ margin: 0 }}>Aún no has comprado clases de pago puntual.</p>
          ) : (
            <ul style={{ margin: 0, paddingLeft: 18 }}>
              {purchases.map((p) => (
                <li key={p.id}><Link href={`/clases/${p.lesson.slug}`}>{p.lesson.title}</Link></li>
              ))}
            </ul>
          )}
        </div>

        <div className="card"><h3>Mis datos</h3><ProfileForm name={user.name} email={user.email} /></div>
        <div className="card"><h3>Contraseña</h3><PasswordForm /></div>

        <div className="card" style={{ gridColumn: "1 / -1" }}>
          <h3>Historial de pagos</h3>
          {orders.length === 0 ? (
            <p className="muted" style={{ margin: 0 }}>Sin pagos todavía.</p>
          ) : (
            <div className="table-wrap">
              <table className="table">
                <thead><tr><th>Fecha</th><th>Concepto</th><th>Valor</th><th>Estado</th></tr></thead>
                <tbody>
                  {orders.map((o) => (
                    <tr key={o.id}>
                      <td>{formatDateTime(o.createdAt)}</td>
                      <td>{o.description}</td>
                      <td>{formatCop(o.amountCop)}</td>
                      <td><span className={`badge ${ORDER_STATUS[o.status][1]}`}>{ORDER_STATUS[o.status][0]}</span></td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </div>
      </div>
    </>
  );
}
