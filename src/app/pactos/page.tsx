import Link from "next/link";
import { FREE_PACT_LIMIT, isSubscriber } from "@/lib/access";
import { getCurrentUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { formatDate } from "@/lib/format";

export const dynamic = "force-dynamic";
export const metadata = { title: "Pactos digitales" };

const STATUS = {
  DRAFT: { label: "Borrador", cls: "badge-gray" },
  PARENT_SIGNED: { label: "Falta la firma del menor", cls: "badge-yellow" },
  SIGNED: { label: "Firmado", cls: "badge-green" },
} as const;

export default async function PactsPage() {
  const user = await getCurrentUser();
  const [templates, pacts, subscribed] = await Promise.all([
    db.pactTemplate.findMany({ where: { published: true }, orderBy: [{ order: "asc" }, { appName: "asc" }] }),
    user ? db.pact.findMany({ where: { userId: user.id }, orderBy: { updatedAt: "desc" } }) : [],
    user ? (user.role === "ADMIN" ? true : isSubscriber(user.id)) : false,
  ]);
  const reachedLimit = !!user && !subscribed && pacts.length >= FREE_PACT_LIMIT;

  return (
    <>
      <div className="page-head">
        <div className="container">
          <h1>Pactos por aplicación</h1>
          <p>Acuerdos claros que tú y tus hijos firman juntos. Menos peleas, reglas que se entienden.</p>
        </div>
      </div>
      <div className="container section stack">
        {user && pacts.length > 0 && (
          <section className="stack">
            <h2>Mis pactos</h2>
            <div className="grid grid-3">
              {pacts.map((p) => (
                <Link key={p.id} href={`/pactos/${p.id}`} className="card card-link stack">
                  <span className={`badge ${STATUS[p.status].cls}`} style={{ alignSelf: "flex-start" }}>{STATUS[p.status].label}</span>
                  <h3>{p.appName} · {p.childName}</h3>
                  <div className="small muted">
                    Creado el {formatDate(p.createdAt)}
                    {p.reviewDate && <> · revisar el {formatDate(p.reviewDate)}</>}
                  </div>
                </Link>
              ))}
            </div>
          </section>
        )}

        {reachedLimit && (
          <div className="alert alert-info">
            Con la cuenta gratuita puedes tener {FREE_PACT_LIMIT} pacto. <Link href="/planes">Suscríbete</Link> para crear pactos ilimitados.
          </div>
        )}

        <section className="stack">
          <div className="row between">
            <h2 style={{ margin: 0 }}>Elige una plantilla</h2>
            {!reachedLimit && <Link href="/pactos/nuevo" className="btn btn-ghost btn-sm">Crear pacto en blanco</Link>}
          </div>
          <div className="grid grid-3">
            {templates.map((t) => (
              <Link key={t.id} href={user ? `/pactos/nuevo?plantilla=${t.slug}` : `/registro?next=${encodeURIComponent(`/pactos/nuevo?plantilla=${t.slug}`)}`} className="card card-link stack">
                <div className="row">
                  <span className="icon-dot" style={{ background: t.color }}>{t.appName.slice(0, 1)}</span>
                  <div>
                    <h3 style={{ margin: 0 }}>{t.appName}</h3>
                    {t.minAge > 0 && <span className="small muted">Desde {t.minAge} años</span>}
                  </div>
                </div>
                <p className="muted small" style={{ margin: 0 }}>{t.description}</p>
                <span className="small" style={{ color: "var(--blue-dark)", fontWeight: 700 }}>
                  {Array.isArray(t.clauses) ? t.clauses.length : 0} acuerdos sugeridos →
                </span>
              </Link>
            ))}
          </div>
        </section>
      </div>
    </>
  );
}
