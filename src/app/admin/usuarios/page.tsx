import type { Prisma } from "@prisma/client";
import Link from "next/link";
import { SubmitButton } from "@/components/SubmitButton";
import { db } from "@/lib/db";
import { formatDate } from "@/lib/format";
import { createUserAction } from "../actions";
import { Notice } from "../Notice";

const PAGE_SIZE = 30;

export default async function UsersPage({
  searchParams,
}: {
  searchParams: Promise<{ q?: string; filtro?: string; pagina?: string; error?: string; ok?: string }>;
}) {
  const { q, filtro, pagina, error, ok } = await searchParams;
  const page = Math.max(1, Number(pagina) || 1);
  const now = new Date();
  const where: Prisma.UserWhereInput = {};
  if (q) where.OR = [{ email: { contains: q, mode: "insensitive" } }, { name: { contains: q, mode: "insensitive" } }];
  if (filtro === "suscriptores") where.subscription = { status: "ACTIVE", currentPeriodEnd: { gt: now } };
  if (filtro === "admins") where.role = "ADMIN";
  if (filtro === "inactivos") where.active = false;

  const [users, total] = await Promise.all([
    db.user.findMany({
      where,
      orderBy: { createdAt: "desc" },
      skip: (page - 1) * PAGE_SIZE,
      take: PAGE_SIZE,
      include: { subscription: true },
    }),
    db.user.count({ where }),
  ]);
  const pages = Math.max(1, Math.ceil(total / PAGE_SIZE));
  const qs = (p: number) => `?${new URLSearchParams({ ...(q ? { q } : {}), ...(filtro ? { filtro } : {}), pagina: String(p) })}`;

  return (
    <>
      <h1>Usuarios</h1>
      <Notice error={error} ok={ok} />

      <details className="card">
        <summary className="label" style={{ cursor: "pointer" }}>+ Crear usuario</summary>
        <form action={createUserAction} className="form" style={{ marginTop: 14 }}>
          <div className="grid grid-2" style={{ gap: 14 }}>
            <div className="field"><label>Nombre</label><input className="input" name="name" required /></div>
            <div className="field"><label>Correo</label><input className="input" name="email" type="email" required /></div>
            <div className="field"><label>Contraseña temporal</label><input className="input" name="password" minLength={8} required /></div>
            <div className="field">
              <label>Rol</label>
              <select className="select" name="role" defaultValue="USER">
                <option value="USER">Usuario</option>
                <option value="ADMIN">Administrador</option>
              </select>
            </div>
            <div className="field">
              <label>Meses de suscripción de cortesía</label>
              <input className="input" name="months" type="number" min={0} max={36} defaultValue={0} />
            </div>
          </div>
          <div><SubmitButton className="btn btn-sm">Crear usuario</SubmitButton></div>
        </form>
      </details>

      <form className="row" method="get">
        <input className="input" name="q" defaultValue={q} placeholder="Buscar por nombre o correo" style={{ maxWidth: 320 }} />
        <select className="select" name="filtro" defaultValue={filtro ?? ""} style={{ maxWidth: 200 }}>
          <option value="">Todos</option>
          <option value="suscriptores">Suscriptores activos</option>
          <option value="admins">Administradores</option>
          <option value="inactivos">Desactivados</option>
        </select>
        <button className="btn btn-ghost btn-sm">Filtrar</button>
        <span className="small muted">{total} resultados</span>
      </form>

      <div className="table-wrap card" style={{ padding: 0 }}>
        <table className="table">
          <thead><tr><th>Nombre</th><th>Correo</th><th>Rol</th><th>Suscripción</th><th>Registro</th></tr></thead>
          <tbody>
            {users.map((u) => {
              const active = u.subscription?.status === "ACTIVE" && u.subscription.currentPeriodEnd > now;
              return (
                <tr key={u.id}>
                  <td><Link href={`/admin/usuarios/${u.id}`}>{u.name}</Link>{!u.active && <span className="badge badge-red" style={{ marginLeft: 6 }}>Inactivo</span>}</td>
                  <td>{u.email}</td>
                  <td>{u.role === "ADMIN" ? <span className="badge badge-blue">Admin</span> : "Usuario"}</td>
                  <td>{active ? <span className="badge badge-green">Hasta {formatDate(u.subscription!.currentPeriodEnd)}</span> : <span className="muted">—</span>}</td>
                  <td>{formatDate(u.createdAt)}</td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
      {pages > 1 && (
        <div className="row">
          {page > 1 && <Link className="btn btn-ghost btn-sm" href={qs(page - 1)}>← Anterior</Link>}
          <span className="small muted">Página {page} de {pages}</span>
          {page < pages && <Link className="btn btn-ghost btn-sm" href={qs(page + 1)}>Siguiente →</Link>}
        </div>
      )}
    </>
  );
}
