import type { ServiceRequestStatus } from "@prisma/client";
import Link from "next/link";
import { SubmitButton } from "@/components/SubmitButton";
import { db } from "@/lib/db";
import { formatDateTime } from "@/lib/format";
import { AUDIENCES, REQUEST_STATUS } from "@/lib/services";
import { updateServiceRequestAction } from "../actions";
import { Notice } from "../Notice";

const STATUSES = Object.keys(REQUEST_STATUS) as ServiceRequestStatus[];

export default async function AdminRequestsPage({
  searchParams,
}: {
  searchParams: Promise<{ estado?: string; error?: string; ok?: string }>;
}) {
  const { estado, error, ok } = await searchParams;
  const status = STATUSES.find((s) => s === estado);
  const requests = await db.serviceRequest.findMany({
    where: status ? { status } : { status: { in: ["NEW", "PAID", "CONTACTED"] } },
    orderBy: { createdAt: "desc" },
    take: 100,
    include: { service: true },
  });
  const back = `/admin/solicitudes${status ? `?estado=${status}` : ""}`;

  return (
    <>
      <h1>Solicitudes de servicios</h1>
      <Notice error={error} ok={ok} />
      <div className="chips">
        <Link className={`chip${!status ? " active" : ""}`} href="/admin/solicitudes">Abiertas</Link>
        {STATUSES.map((s) => (
          <Link key={s} className={`chip${status === s ? " active" : ""}`} href={`/admin/solicitudes?estado=${s}`}>{REQUEST_STATUS[s][0]}</Link>
        ))}
      </div>
      {requests.length === 0 && <p className="muted">No hay solicitudes en este estado.</p>}
      {requests.map((r) => (
        <div key={r.id} className="card stack">
          <div className="row between">
            <div>
              <strong>{r.service.name}</strong> <span className="small muted">· {AUDIENCES[r.service.audience].label} · {formatDateTime(r.createdAt)}</span>
            </div>
            <span className={`badge ${REQUEST_STATUS[r.status][1]}`}>{REQUEST_STATUS[r.status][0]}</span>
          </div>
          <div className="small">
            <strong>{r.name}</strong>
            {r.organization && <> · {r.organization}</>}
            {r.city && <> · {r.city}</>}
            <br />
            <a href={`mailto:${r.email}`}>{r.email}</a>
            {r.phone && <> · <a href={`https://wa.me/${r.phone.replace(/\D/g, "").replace(/^(?=3\d{9}$)/, "57")}`} target="_blank" rel="noopener noreferrer">{r.phone}</a></>}
          </div>
          {r.message && <div className="post-body small card card-tint" style={{ padding: 12 }}>{r.message}</div>}
          <form action={updateServiceRequestAction} className="row" style={{ alignItems: "flex-end" }}>
            <input type="hidden" name="id" value={r.id} />
            <input type="hidden" name="back" value={back} />
            <div className="field" style={{ width: 200 }}>
              <label className="small">Estado</label>
              <select className="select" name="status" defaultValue={r.status}>
                {STATUSES.map((s) => <option key={s} value={s}>{REQUEST_STATUS[s][0]}</option>)}
              </select>
            </div>
            <div className="field" style={{ flex: "1 1 260px" }}>
              <label className="small">Notas internas</label>
              <input className="input" name="adminNotes" defaultValue={r.adminNotes} />
            </div>
            <SubmitButton className="btn btn-sm">Guardar</SubmitButton>
          </form>
        </div>
      ))}
    </>
  );
}
