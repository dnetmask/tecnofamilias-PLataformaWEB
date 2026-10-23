import type { AgeStage, Prisma, ResourceKind } from "@prisma/client";
import Link from "next/link";
import { isSubscriber } from "@/lib/access";
import { getCurrentUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { AGE_STAGES, RESOURCE_LABELS, stageShort } from "@/lib/format";
import { resolvePodcastEmbed, resolveVideo } from "@/lib/video";

export const dynamic = "force-dynamic";
export const metadata = { title: "Videos y podcasts recomendados" };

/** Cuántos recursos ven completos quienes no tienen suscripción. */
const PREVIEW = 3;

export default async function ResourcesPage({ searchParams }: { searchParams: Promise<{ tipo?: string; etapa?: string }> }) {
  const { tipo, etapa } = await searchParams;
  const kind = (tipo === "VIDEO" || tipo === "PODCAST" ? tipo : undefined) as ResourceKind | undefined;
  const stage = AGE_STAGES.find((s) => s.value === etapa)?.value as AgeStage | undefined;

  const where: Prisma.ResourceWhereInput = { published: true };
  if (kind) where.kind = kind;
  if (stage) where.ageStage = { in: [stage, "ALL"] };

  const user = await getCurrentUser();
  const [resources, subscribed] = await Promise.all([
    db.resource.findMany({ where, orderBy: [{ order: "asc" }, { createdAt: "desc" }] }),
    user ? (user.role === "ADMIN" ? true : isSubscriber(user.id)) : false,
  ]);

  const href = (p: { tipo?: string; etapa?: string }) => {
    const q = new URLSearchParams(Object.entries(p).filter(([, v]) => v) as [string, string][]);
    return q.size ? `/recursos?${q}` : "/recursos";
  };

  return (
    <>
      <div className="page-head">
        <div className="container">
          <h1>Videos y podcasts recomendados</h1>
          <p>Contenido seleccionado por el equipo para ver y escuchar en familia.</p>
        </div>
      </div>
      <div className="container section stack">
        <div className="chips">
          <Link href={href({ etapa })} className={`chip${!kind ? " active" : ""}`}>Todo</Link>
          <Link href={href({ etapa, tipo: "VIDEO" })} className={`chip${kind === "VIDEO" ? " active" : ""}`}>🎬 Videos</Link>
          <Link href={href({ etapa, tipo: "PODCAST" })} className={`chip${kind === "PODCAST" ? " active" : ""}`}>🎧 Podcasts</Link>
        </div>
        <div className="chips">
          <Link href={href({ tipo })} className={`chip${!stage ? " active" : ""}`}>Todas las etapas</Link>
          {AGE_STAGES.filter((s) => s.value !== "ALL").map((s) => (
            <Link key={s.value} href={href({ tipo, etapa: s.value })} className={`chip${stage === s.value ? " active" : ""}`}>
              {s.short} años
            </Link>
          ))}
        </div>

        {!subscribed && resources.length > PREVIEW && (
          <div className="alert alert-info">
            Estás viendo {PREVIEW} de {resources.length} recomendaciones. <Link href="/planes">Suscríbete</Link> para ver la lista completa.
          </div>
        )}

        <div className="grid grid-2">
          {resources.map((r, i) => {
            const locked = !subscribed && i >= PREVIEW;
            const video = r.kind === "VIDEO" && !locked ? resolveVideo(r.url) : null;
            const podcast = r.kind === "PODCAST" && !locked ? resolvePodcastEmbed(r.url) : null;
            return (
              <article key={r.id} className="card stack" style={locked ? { opacity: 0.6 } : undefined}>
                {video?.type === "iframe" && (
                  <iframe className="player" src={video.src} title={r.title} loading="lazy" allowFullScreen
                    allow="encrypted-media; picture-in-picture; fullscreen" />
                )}
                {podcast && (
                  <iframe src={podcast} title={r.title} loading="lazy" height={152} style={{ width: "100%", border: 0, borderRadius: 12 }}
                    allow="encrypted-media" />
                )}
                <div className="row">
                  <span className={`badge ${r.kind === "VIDEO" ? "badge-blue" : "badge-red"}`}>{RESOURCE_LABELS[r.kind]}</span>
                  <span className="badge badge-gray">{stageShort(r.ageStage)}{r.ageStage !== "ALL" ? " años" : ""}</span>
                </div>
                <div>
                  <h3>{r.title}</h3>
                  {r.author && <div className="small muted">{r.author}</div>}
                </div>
                {r.description && <p className="muted small" style={{ margin: 0 }}>{r.description}</p>}
                {locked ? (
                  <span className="small muted">🔒 Disponible con la suscripción</span>
                ) : (
                  !(video?.type === "iframe") && !podcast && (
                    <a className="btn btn-ghost btn-sm" href={r.url} target="_blank" rel="noopener noreferrer" style={{ alignSelf: "flex-start" }}>
                      Abrir {r.kind === "VIDEO" ? "video" : "podcast"} ↗
                    </a>
                  )
                )}
              </article>
            );
          })}
        </div>
        {resources.length === 0 && <p className="muted">Aún no hay recomendaciones para este filtro.</p>}
      </div>
    </>
  );
}
