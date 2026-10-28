import type { AgeStage, Prisma, ResourceKind } from "@prisma/client";
import Link from "next/link";
import { getToolViewer } from "@/lib/access";
import { getCurrentUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { AGE_STAGES } from "@/lib/format";
import { getPricing } from "@/lib/pricing";
import { TOOL_KIND_ORDER, TOOL_KINDS, availableToolWhere } from "@/lib/tools";
import { ToolCard } from "./ToolCard";
import { isPlatformOpen } from "@/lib/launch";
import { pageMeta } from "@/lib/site";

export const dynamic = "force-dynamic";
export const metadata = pageMeta("/herramientas", "Caja de herramientas: control parental, videos y guías de seguridad digital", "Apps de control parental, videos, podcasts, libros y guías que el equipo Tecnofamilias revisó y recomienda para proteger a tus hijos en internet, organizados por edad.");

export default async function ToolsPage({ searchParams }: { searchParams: Promise<{ tipo?: string; etapa?: string; favoritos?: string }> }) {
  const { tipo, etapa, favoritos } = await searchParams;
  const kind = TOOL_KIND_ORDER.find((k) => k === tipo) as ResourceKind | undefined;
  const stage = AGE_STAGES.find((s) => s.value === etapa)?.value as AgeStage | undefined;

  const user = await getCurrentUser();
  const open = await isPlatformOpen();
  const onlyFavorites = favoritos === "1" && !!user;

  const where: Prisma.ResourceWhereInput = availableToolWhere();
  if (kind) where.kind = kind;
  if (stage) where.ageStage = { in: [stage, "ALL"] };
  if (onlyFavorites) where.favorites = { some: { userId: user.id } };
  const filtered = !!(kind || stage || onlyFavorites);

  const [tools, top, viewer, favorites, pricing] = await Promise.all([
    db.resource.findMany({ where, orderBy: [{ order: "asc" }, { createdAt: "desc" }] }),
    filtered ? [] : db.resource.findMany({ where: { ...availableToolWhere(), uses: { gt: 0 } }, orderBy: [{ uses: "desc" }, { order: "asc" }], take: 4 }),
    getToolViewer(user),
    user ? db.resourceFavorite.findMany({ where: { userId: user.id }, select: { resourceId: true } }) : [],
    getPricing(),
  ]);
  const favIds = new Set(favorites.map((f) => f.resourceId));

  const params = { tipo: kind, etapa: stage, favoritos: onlyFavorites ? "1" : undefined };
  const href = (p: Partial<typeof params>) => {
    const q = new URLSearchParams(Object.entries({ ...params, ...p }).filter(([, v]) => v) as [string, string][]);
    return q.size ? `/herramientas?${q}` : "/herramientas";
  };
  const back = href({});
  const priceOf = (t: (typeof tools)[number]) =>
    (t.access === "PAID" || t.access === "EXTERNAL") && (t.priceUsd > 0 || t.priceCop) ? pricing.price(t.priceUsd, t.priceCop) : null;
  const card = (t: (typeof tools)[number], rank?: number) => (
    <ToolCard key={t.id} tool={t} viewer={viewer} favorite={favIds.has(t.id)} back={back} price={priceOf(t)} rank={rank} />
  );

  return (
    <>
      <div className="page-head">
        <div className="container">
          <h1>Caja de herramientas</h1>
          <p>Videos, podcasts, libros, guías, documentos, apps y equipos que el equipo Tecnofamilias revisó y recomienda para cuidar a tu familia en el mundo digital.</p>
        </div>
      </div>
      <div className="container section stack">
        <div className="chips">
          <Link href={href({ tipo: undefined })} className={`chip${!kind ? " active" : ""}`}>Todo</Link>
          {TOOL_KIND_ORDER.map((k) => (
            <Link key={k} href={href({ tipo: k })} className={`chip${kind === k ? " active" : ""}`}>
              {TOOL_KINDS[k].icon} {TOOL_KINDS[k].plural}
            </Link>
          ))}
        </div>
        <div className="chips">
          <Link href={href({ etapa: undefined })} className={`chip${!stage ? " active" : ""}`}>Todas las etapas</Link>
          {AGE_STAGES.filter((s) => s.value !== "ALL").map((s) => (
            <Link key={s.value} href={href({ etapa: s.value })} className={`chip${stage === s.value ? " active" : ""}`}>
              {s.short} años
            </Link>
          ))}
          <Link
            href={user ? href({ favoritos: onlyFavorites ? undefined : "1" }) : `/ingresar?next=${encodeURIComponent("/herramientas?favoritos=1")}`}
            className={`chip${onlyFavorites ? " active" : ""}`}
          >
            ★ Mis favoritos
          </Link>
        </div>

        {top.length > 0 && (
          <section className="stack">
            <h2 style={{ margin: 0 }}>🔥 Las herramientas más usadas</h2>
            <div className="grid grid-2">{top.map((t, i) => card(t, i + 1))}</div>
          </section>
        )}

        {!viewer.member && (
          <div className="alert alert-info">
            {open ? (
              <>
                Muchas herramientas están incluidas en la suscripción; las de libre acceso puedes usarlas sin cuenta.{" "}
                <Link href={user ? "/planes" : "/registro"}>{user ? "Ver planes" : "Crear cuenta"}</Link>
              </>
            ) : (
              <>Las herramientas de libre acceso puedes usarlas sin cuenta. Las demás llegan muy pronto con la suscripción.</>
            )}
          </div>
        )}

        <div className="grid grid-2">{tools.map((t) => card(t))}</div>
        {tools.length === 0 && (
          <p className="muted">
            {onlyFavorites ? "Aún no tienes favoritos. Toca la estrella ☆ de una herramienta para guardarla aquí." : "Aún no hay herramientas para este filtro."}
          </p>
        )}
      </div>
    </>
  );
}
