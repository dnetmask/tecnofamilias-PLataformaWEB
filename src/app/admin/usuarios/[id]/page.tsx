import Link from "next/link";
import { notFound } from "next/navigation";
import { SubmitButton } from "@/components/SubmitButton";
import { db } from "@/lib/db";
import { formatCop, formatDate, formatDateTime } from "@/lib/format";
import {
  cancelSubscriptionAction,
  deleteUserAction,
  grantLessonAction,
  grantSubscriptionAction,
  resetPasswordAction,
  revokeLessonAction,
  updateUserAction,
} from "../../actions";
import { Notice, type NoticeParams } from "../../Notice";

const ORDER_LABELS = { PENDING: "Pendiente", PAID: "Pagado", FAILED: "Fallido", REFUNDED: "Reembolsado" } as const;

export default async function UserDetailPage({ params, searchParams }: { params: Promise<{ id: string }>; searchParams: NoticeParams }) {
  const { id } = await params;
  const { error, ok } = await searchParams;
  const user = await db.user.findUnique({
    where: { id },
    include: {
      subscription: { include: { plan: true } },
      purchases: { include: { lesson: true } },
      orders: { orderBy: { createdAt: "desc" }, take: 10 },
      _count: { select: { pacts: true, threads: true, posts: true } },
    },
  });
  if (!user) notFound();
  const paidLessons = await db.lesson.findMany({ where: { access: "PAID" }, orderBy: { title: "asc" } });
  const owned = new Set(user.purchases.map((p) => p.lessonId));
  const sub = user.subscription;
  const subActive = sub?.status === "ACTIVE" && sub.currentPeriodEnd > new Date();

  return (
    <>
      <p className="small"><Link href="/admin/usuarios">← Usuarios</Link></p>
      <h1>{user.name}</h1>
      <Notice error={error} ok={ok} />
      <p className="small muted">
        Registrado el {formatDate(user.createdAt)} · {user._count.pacts} pactos · {user._count.threads + user._count.posts} publicaciones en la comunidad
      </p>

      <div className="grid grid-2" style={{ alignItems: "start" }}>
        <form action={updateUserAction} className="card form">
          <h3>Datos y rol</h3>
          <input type="hidden" name="id" value={user.id} />
          <div className="field"><label>Nombre</label><input className="input" name="name" defaultValue={user.name} required /></div>
          <div className="field"><label>Correo</label><input className="input" name="email" type="email" defaultValue={user.email} required /></div>
          <div className="field">
            <label>Rol</label>
            <select className="select" name="role" defaultValue={user.role}>
              <option value="USER">Usuario</option>
              <option value="ADMIN">Administrador</option>
            </select>
          </div>
          <label className="check"><input type="checkbox" name="active" defaultChecked={user.active} /> Cuenta activa (puede ingresar)</label>
          <div><SubmitButton className="btn btn-sm">Guardar</SubmitButton></div>
        </form>

        <div className="card stack">
          <h3>Suscripción</h3>
          {subActive ? (
            <p style={{ margin: 0 }}>
              <span className="badge badge-green">Activa</span> hasta el <strong>{formatDate(sub!.currentPeriodEnd)}</strong>
              {sub!.plan && <> · {sub!.plan.name}</>}
              {sub!.grantedByAdmin && <> · <span className="small muted">otorgada por admin</span></>}
            </p>
          ) : (
            <p className="muted" style={{ margin: 0 }}>Sin suscripción activa.</p>
          )}
          <form action={grantSubscriptionAction} className="row">
            <input type="hidden" name="id" value={user.id} />
            <input className="input" name="months" type="number" min={1} max={36} defaultValue={1} style={{ width: 90 }} />
            <SubmitButton className="btn btn-sm">Otorgar meses</SubmitButton>
          </form>
          {subActive && (
            <form action={cancelSubscriptionAction}>
              <input type="hidden" name="id" value={user.id} />
              <button className="btn-link btn-danger-link small">Cancelar suscripción ahora</button>
            </form>
          )}
        </div>

        <div className="card stack">
          <h3>Clases de pago</h3>
          {paidLessons.length === 0 && <p className="muted small">No hay clases de pago creadas.</p>}
          {paidLessons.map((l) => (
            <div key={l.id} className="row between">
              <span className="small">{l.title}</span>
              <form action={owned.has(l.id) ? revokeLessonAction : grantLessonAction}>
                <input type="hidden" name="id" value={user.id} />
                <input type="hidden" name="lessonId" value={l.id} />
                <button className={`btn btn-sm ${owned.has(l.id) ? "btn-ghost" : ""}`}>{owned.has(l.id) ? "Retirar" : "Otorgar"}</button>
              </form>
            </div>
          ))}
        </div>

        <form action={resetPasswordAction} className="card form">
          <h3>Restablecer contraseña</h3>
          <input type="hidden" name="id" value={user.id} />
          <div className="field"><label>Nueva contraseña</label><input className="input" name="password" minLength={8} required /></div>
          <div><SubmitButton className="btn btn-sm btn-ghost">Restablecer</SubmitButton></div>
        </form>
      </div>

      <div className="card">
        <h3>Últimos pagos</h3>
        {user.orders.length === 0 ? <p className="muted small" style={{ margin: 0 }}>Sin pagos.</p> : (
          <div className="table-wrap">
            <table className="table">
              <thead><tr><th>Fecha</th><th>Concepto</th><th>Valor</th><th>Estado</th></tr></thead>
              <tbody>
                {user.orders.map((o) => (
                  <tr key={o.id}><td>{formatDateTime(o.createdAt)}</td><td>{o.description}</td><td>{formatCop(o.amountCop)}</td><td>{ORDER_LABELS[o.status]}</td></tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

      <form action={deleteUserAction} className="card form" style={{ borderColor: "#f5b5ad" }}>
        <h3 style={{ color: "var(--red)" }}>Eliminar usuario</h3>
        <p className="small muted" style={{ margin: 0 }}>Borra la cuenta, sus pactos, publicaciones y pagos registrados. No se puede deshacer.</p>
        <input type="hidden" name="id" value={user.id} />
        <div className="row">
          <input className="input" name="confirm" placeholder="Escribe ELIMINAR" style={{ maxWidth: 220 }} />
          <SubmitButton className="btn btn-red btn-sm">Eliminar</SubmitButton>
        </div>
      </form>
    </>
  );
}
