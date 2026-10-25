import type { AgeStage, Prisma } from "@prisma/client";
import Link from "next/link";
import { redirect } from "next/navigation";
import { getActiveSubscription } from "@/lib/access";
import { getCurrentUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { ACCESS_LABELS, AGE_STAGES, stageShort } from "@/lib/format";
import { getPricing } from "@/lib/pricing";

export const dynamic = "force-dynamic";
export const metadata = { title: "Clases" };

export default async function LessonsPage({ searchParams }: { searchParams: Promise<{ etapa?: string; tipo?: string }> }) {
  const { etapa, tipo } = await searchParams;
  const stage = AGE_STAGES.find((s) => s.value === etapa)?.value as AgeStage | undefined;
  const where: Prisma.LessonWhereInput = { published: true };
  if (stage) where.ageStage = { in: [stage, "ALL"] };
  if (tipo === "incluidas") where.access = "INCLUDED";
  if (tipo === "complementos") where.access = "ADDON";

  const user = await getCurrentUser();
  // Sin sesión no se muestra el contenido: se invita a ver los planes.
  if (!user) redirect("/planes");
  const pricing = await getPricing();
  const [lessons, sub, purchases] = await Promise.all([
    db.lesson.findMany({ where, orderBy: [{ order: "asc" }, { createdAt: "desc" }] }),
    user ? getActiveSubscription(user.id) : null,
    user ? db.purchase.findMany({ where: { userId: user.id }, select: { lessonId: true } }) : [],
  ]);
  const owned = new Set(purchases.map((p) => p.lessonId));

  const href = (params: { etapa?: string; tipo?: string }) => {
    const q = new URLSearchParams();
    if (params.etapa) q.set("etapa", params.etapa);
    if (params.tipo) q.set("tipo", params.tipo);
    const s = q.toString();
    return s ? `/clases?${s}` : "/clases";
  };

  return (
    <>
      <div className="page-head">
        <div className="container">
          <h1>Clases pregrabadas</h1>
          <p>Toda la base viene con tu suscripción. Los cursos complementarios se suman con un pago adicional.</p>
        </div>
      </div>
      <div className="container section stack">
        <div className="chips">
          <Link href={href({ tipo })} className={`chip${!stage ? " active" : ""}`}>Todas las etapas</Link>
          {AGE_STAGES.filter((s) => s.value !== "ALL").map((s) => (
            <Link key={s.value} href={href({ etapa: s.value, tipo })} className={`chip${stage === s.value ? " active" : ""}`}>
              {s.short} años
            </Link>
          ))}
        </div>
        <div className="chips">
          <Link href={href({ etapa: stage })} className={`chip${!tipo ? " active" : ""}`}>Todas</Link>
          <Link href={href({ etapa: stage, tipo: "incluidas" })} className={`chip${tipo === "incluidas" ? " active" : ""}`}>Incluidas</Link>
          <Link href={href({ etapa: stage, tipo: "complementos" })} className={`chip${tipo === "complementos" ? " active" : ""}`}>Complementos</Link>
        </div>

        {lessons.length === 0 ? (
          <p className="muted">No hay clases para este filtro todavía.</p>
        ) : (
          <div className="grid grid-3">
            {lessons.map((l) => {
              const unlocked =
                user?.role === "ADMIN" || (!!sub && (l.access === "INCLUDED" || owned.has(l.id)));
              return (
                <Link key={l.id} href={`/clases/${l.slug}`} className="card card-link">
                  <div className="lesson-thumb">
                    {l.thumbnailUrl ? <img src={l.thumbnailUrl} alt="" /> : <span>▶</span>}
                  </div>
                  <div className="row" style={{ marginBottom: 8 }}>
                    <span className={`badge ${l.access === "ADDON" ? "badge-yellow" : "badge-blue"}`}>
                      {l.access === "ADDON" ? `Complemento · ${pricing.price(l.priceUsd)}` : ACCESS_LABELS[l.access]}
                    </span>
                    <span className="badge badge-gray">{stageShort(l.ageStage)}{l.ageStage !== "ALL" ? " años" : ""}</span>
                    {l.durationMin > 0 && <span className="small muted">{l.durationMin} min</span>}
                    {unlocked && user && <span className="small" style={{ color: "var(--ok)", fontWeight: 700 }}>✓ Disponible</span>}
                  </div>
                  <h3>{l.title}</h3>
                  <p className="muted small" style={{ margin: 0 }}>{l.summary}</p>
                </Link>
              );
            })}
          </div>
        )}
      </div>
    </>
  );
}
