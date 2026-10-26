import Link from "next/link";
import { db } from "@/lib/db";
import { formatCop } from "@/lib/format";
import { SubmitButton } from "@/components/SubmitButton";
import { notifySearchEnginesAction } from "./actions";
import { Notice, type NoticeParams } from "./Notice";

export default async function AdminHome({ searchParams }: { searchParams: NoticeParams }) {
  const { error, ok } = await searchParams;
  const now = new Date();
  const monthStart = new Date(now.getFullYear(), now.getMonth(), 1);
  const [users, subs, lessons, pacts, threads, reports, revenue, monthRevenue, requests] = await Promise.all([
    db.user.count(),
    db.subscription.count({ where: { status: "ACTIVE", currentPeriodEnd: { gt: now } } }),
    db.lesson.count({ where: { published: true } }),
    db.pact.count(),
    db.forumThread.count(),
    db.forumReport.count({ where: { resolved: false } }),
    db.order.aggregate({ where: { status: "PAID" }, _sum: { amountCop: true } }),
    db.order.aggregate({ where: { status: "PAID", paidAt: { gte: monthStart } }, _sum: { amountCop: true } }),
    db.serviceRequest.count({ where: { status: { in: ["NEW", "PAID"] } } }),
  ]);

  const stats = [
    { label: "Usuarios", value: users, href: "/admin/usuarios" },
    { label: "Suscriptores activos", value: subs, href: "/admin/usuarios?filtro=suscriptores" },
    { label: "Clases publicadas", value: lessons, href: "/admin/clases" },
    { label: "Pactos creados", value: pacts, href: "/admin/pactos" },
    { label: "Conversaciones", value: threads, href: "/admin/comunidad" },
    { label: "Reportes pendientes", value: reports, href: "/admin/comunidad" },
    { label: "Solicitudes por atender", value: requests, href: "/admin/solicitudes" },
    { label: "Ingresos del mes", value: formatCop(monthRevenue._sum.amountCop ?? 0), href: "/admin/pagos" },
    { label: "Ingresos totales", value: formatCop(revenue._sum.amountCop ?? 0), href: "/admin/pagos" },
  ];

  return (
    <>
      <h1>Resumen</h1>
      <Notice error={error} ok={ok} />
      <form action={notifySearchEnginesAction} className="card row between">
        <div>
          <strong>Avisar a los buscadores</strong>
          <p className="small muted" style={{ margin: 0 }}>Envía todas las páginas públicas a Bing con IndexNow. Las herramientas nuevas se avisan solas al guardarlas.</p>
        </div>
        <SubmitButton className="btn btn-sm">Avisar a Bing</SubmitButton>
      </form>
      <div className="grid grid-4">
        {stats.map((s) => (
          <Link key={s.label} href={s.href} className="card card-link">
            <div className="small muted">{s.label}</div>
            <div className="stat">{s.value}</div>
          </Link>
        ))}
      </div>
    </>
  );
}
