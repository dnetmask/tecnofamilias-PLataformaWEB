import Link from "next/link";
import { notFound, redirect } from "next/navigation";
import { VideoPlayer } from "@/components/VideoPlayer";
import { hasMemberAccess, hasPurchased } from "@/lib/access";
import { getCurrentUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { CurrencySwitcher } from "@/components/CurrencySwitcher";
import { ACCESS_LABELS, stageLabel } from "@/lib/format";
import { formatCop } from "@/lib/format";
import { getPricing } from "@/lib/pricing";
import { NOINDEX } from "@/lib/site";

export const dynamic = "force-dynamic";

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }) {
  const lesson = await db.lesson.findUnique({ where: { slug: (await params).slug }, select: { title: true } });
  return { title: lesson?.title ?? "Clase", ...NOINDEX };
}

export default async function LessonPage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const user = await getCurrentUser();
  // Sin sesión no se muestra el contenido: se invita a ver los planes.
  if (!user) redirect("/planes");
  const lesson = await db.lesson.findUnique({ where: { slug } });
  if (!lesson || (!lesson.published && user?.role !== "ADMIN")) notFound();

  const [member, pricing] = await Promise.all([hasMemberAccess(user), getPricing()]);
  const owned = user && lesson.access === "ADDON" ? user.role === "ADMIN" || (await hasPurchased(user.id, lesson.id)) : false;
  const canWatch = member && (lesson.access === "INCLUDED" || owned);
  const isAddon = lesson.access === "ADDON";
  const next = `/clases/${lesson.slug}`;

  return (
    <div className="container section">
      <p className="small"><Link href="/clases">← Volver a clases</Link></p>
      <div className="layout-aside">
        <div className="stack" style={{ minWidth: 0 }}>
          {canWatch ? (
            // La URL del video solo se envía al navegador si el usuario tiene acceso.
            <VideoPlayer url={lesson.videoUrl} title={lesson.title} />
          ) : (
            <div className="locked">
              <div>
                <div style={{ fontSize: "2.4rem" }}>🔒</div>
                <h3>{!member ? "Contenido para suscriptores" : "Curso complementario"}</h3>
                <p style={{ color: "#cfdbec" }}>
                  {!member
                    ? isAddon
                      ? "Este curso es un complemento de la suscripción: primero suscríbete y luego súmalo con un pago adicional."
                      : "Suscríbete para ver esta clase y toda la base de contenido."
                    : "Súmalo a tu suscripción con un pago único."}
                </p>
              </div>
            </div>
          )}
          <h1 style={{ fontSize: "1.9rem" }}>{lesson.title}</h1>
          <div className="row">
            <span className="badge badge-gray">{stageLabel(lesson.ageStage)}</span>
            {lesson.durationMin > 0 && <span className="badge badge-gray">{lesson.durationMin} min</span>}
            {lesson.instructor && <span className="small muted">Con {lesson.instructor}</span>}
          </div>
          <p className="muted" style={{ fontSize: "1.05rem" }}>{lesson.summary}</p>
          {lesson.description && <div style={{ whiteSpace: "pre-wrap" }}>{lesson.description}</div>}
        </div>

        <aside className="card stack">
          <span className={`badge ${isAddon ? "badge-yellow" : "badge-blue"}`} style={{ alignSelf: "flex-start" }}>
            {ACCESS_LABELS[lesson.access]}
          </span>
          {canWatch ? (
            <p style={{ margin: 0, color: "var(--ok)", fontWeight: 700 }}>✓ Tienes acceso a esta clase</p>
          ) : !user ? (
            <>
              <p className="muted" style={{ margin: 0 }}>Crea tu cuenta y elige un plan para empezar.</p>
              <Link className="btn" href={`/registro?next=${encodeURIComponent("/planes")}`}>Crear cuenta</Link>
              <Link className="btn btn-ghost" href={`/ingresar?next=${encodeURIComponent(next)}`}>Ya tengo cuenta</Link>
            </>
          ) : !member ? (
            <>
              <p className="muted" style={{ margin: 0 }}>
                {isAddon ? `Requiere suscripción activa más un pago adicional de ${pricing.price(lesson.priceUsd)}.` : "Incluida en todos los planes."}
              </p>
              <Link className="btn" href="/planes">Ver planes</Link>
            </>
          ) : (
            <>
              <div className="price">{pricing.price(lesson.priceUsd)}</div>
              <div className="small muted">Se cobra hoy {formatCop(pricing.charge(lesson.priceUsd))}</div>
              <CurrencySwitcher current={pricing.currency} />
              <p className="muted small" style={{ margin: 0 }}>Pago único. Queda en tu cuenta mientras tu suscripción esté activa.</p>
              <Link className="btn btn-red" href={`/checkout?clase=${lesson.slug}`}>Agregar a mi suscripción</Link>
            </>
          )}
        </aside>
      </div>
    </div>
  );
}
