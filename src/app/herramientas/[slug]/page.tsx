import Link from "next/link";
import { notFound } from "next/navigation";
import { getToolViewer, recordToolUse } from "@/lib/access";
import { getCurrentUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { formatCop, stageLabel } from "@/lib/format";
import { getPricing } from "@/lib/pricing";
import { canUseTool, TOOL_ACCESS, TOOL_KINDS, usesLabel } from "@/lib/tools";
import { resolvePodcastEmbed, resolveVideo } from "@/lib/video";
import { FavoriteButton } from "../FavoriteButton";
import { isPlatformOpen } from "@/lib/launch";
import { pageMeta, SITE_URL } from "@/lib/site";
import { breadcrumbs, JsonLd } from "@/components/JsonLd";

export const dynamic = "force-dynamic";

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }) {
  const t = await db.resource.findUnique({ where: { slug: (await params).slug }, select: { slug: true, title: true, description: true, kind: true, author: true, imageUrl: true } });
  if (!t) return { title: "Herramienta" };
  const description = `${TOOL_KINDS[t.kind].label}${t.author ? ` de ${t.author}` : ""} recomendado por Tecnofamilias. ${t.description}`.slice(0, 160);
  const meta = pageMeta(`/herramientas/${t.slug}`, t.title, description);
  return { ...meta, openGraph: { ...meta.openGraph, ...(t.imageUrl ? { images: [t.imageUrl] } : {}) } };
}

export default async function ToolPage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const [tool, user, pricing, platformOpen] = await Promise.all([db.resource.findUnique({ where: { slug } }), getCurrentUser(), getPricing(), isPlatformOpen()]);
  if (!tool || (!tool.published && user?.role !== "ADMIN")) notFound();

  const [viewer, favorite] = await Promise.all([
    getToolViewer(user),
    user ? db.resourceFavorite.findUnique({ where: { userId_resourceId: { userId: user.id, resourceId: tool.id } } }) : null,
  ]);
  const kind = TOOL_KINDS[tool.kind];
  const access = TOOL_ACCESS[tool.access];
  const usable = canUseTool(viewer, tool);
  const back = `/herramientas/${tool.slug}`;
  const open = `/herramientas/${tool.slug}/abrir`;

  const video = usable && tool.kind === "VIDEO" ? resolveVideo(tool.url) : null;
  const podcast = usable && tool.kind === "PODCAST" ? resolvePodcastEmbed(tool.url) : null;
  const embedded = video?.type === "iframe" || !!podcast;
  // Ver el video o el podcast en la página también cuenta como uso.
  if (embedded && user) await recordToolUse(user.id, tool.id);

  const hasPrice = tool.priceUsd > 0 || !!tool.priceCop;
  const checkout = `/checkout?herramienta=${tool.slug}`;

  const SCHEMA_TYPE = { VIDEO: "VideoObject", PODCAST: "PodcastEpisode", BOOK: "Book", EBOOK: "Book", DOCUMENT: "DigitalDocument", SOFTWARE: "SoftwareApplication", HARDWARE: "Product" } as const;
  const jsonLd = {
    "@context": "https://schema.org",
    "@type": SCHEMA_TYPE[tool.kind],
    name: tool.title,
    description: tool.description,
    url: `${SITE_URL}/herramientas/${tool.slug}`,
    sameAs: tool.url,
    inLanguage: "es",
    ...(tool.author ? { author: { "@type": "Organization", name: tool.author } } : {}),
    ...(tool.imageUrl ? { image: tool.imageUrl } : {}),
    ...(tool.kind === "VIDEO" ? { uploadDate: tool.createdAt.toISOString(), thumbnailUrl: tool.imageUrl || `${SITE_URL}/opengraph-image` } : {}),
    isAccessibleForFree: tool.access === "FREE" || tool.access === "EXTERNAL",
  };

  return (
    <div className="container section">
      <JsonLd data={{ "@context": "https://schema.org", "@graph": [{ ...jsonLd, "@context": undefined }, breadcrumbs([["Inicio", SITE_URL], ["Caja de herramientas", `${SITE_URL}/herramientas`], [tool.title, `${SITE_URL}/herramientas/${tool.slug}`]])] }} />
      <p className="small"><Link href="/herramientas">← Caja de herramientas</Link></p>
      <div className="layout-aside">
        <div className="stack" style={{ minWidth: 0 }}>
          <div className="row" style={{ gap: 6 }}>
            <span className="icon-dot" style={{ background: kind.color }}>{kind.icon}</span>
            <span className="badge">{kind.label}</span>
            <span className={`badge ${access.badge}`}>{access.label}</span>
            <span className="badge badge-gray">{stageLabel(tool.ageStage)}</span>
          </div>
          <div className="row between" style={{ alignItems: "flex-start", flexWrap: "nowrap" }}>
            <div>
              <h1 style={{ fontSize: "2rem", margin: 0 }}>{tool.title}</h1>
              {tool.author && <div className="muted">{tool.author}</div>}
            </div>
            <FavoriteButton id={tool.id} favorite={!!favorite} loggedIn={viewer.loggedIn} back={back} />
          </div>
          {video?.type === "iframe" && (
            <iframe className="player" src={video.src} title={tool.title} allowFullScreen allow="encrypted-media; picture-in-picture; fullscreen" />
          )}
          {podcast && (
            <iframe src={podcast} title={tool.title} height={152} style={{ width: "100%", border: 0, borderRadius: 12 }} allow="encrypted-media" />
          )}
          {tool.description && (
            <div>
              <h3>¿Por qué la recomendamos?</h3>
              <p className="muted" style={{ whiteSpace: "pre-wrap" }}>{tool.description}</p>
            </div>
          )}
          {tool.uses > 0 && <p className="small muted" style={{ margin: 0 }}>👥 {usesLabel(tool.uses)}</p>}
        </div>

        <aside className="card stack">
          {tool.imageUrl && (
            // eslint-disable-next-line @next/next/no-img-element
            <img src={tool.imageUrl} alt={tool.title} style={{ width: "100%", borderRadius: 12, objectFit: "cover" }} />
          )}
          {tool.access === "EXTERNAL" ? (
            <>
              {hasPrice && <div className="price">{pricing.price(tool.priceUsd, tool.priceCop)}</div>}
              {hasPrice && <div className="small muted">Precio de referencia; puede variar en la tienda.</div>}
              <a className="btn" href={open} target="_blank" rel="noopener noreferrer">Ver dónde comprar ↗</a>
              <p className="small muted" style={{ margin: 0 }}>Tecnofamilias no vende este producto: la compra se hace directamente con el vendedor.</p>
            </>
          ) : usable ? (
            <>
              {tool.access === "PAID" && !viewer.admin && <div className="badge badge-green" style={{ alignSelf: "flex-start" }}>✓ Ya es tuya</div>}
              {!embedded && <a className="btn" href={open} target="_blank" rel="noopener noreferrer">{kind.open} ↗</a>}
              {embedded && <p className="small muted" style={{ margin: 0 }}>Disfrútala aquí mismo o <a href={open} target="_blank" rel="noopener noreferrer">ábrela en una pestaña nueva ↗</a>.</p>}
            </>
          ) : tool.access === "PAID" ? (
            <>
              <div className="price">{pricing.price(tool.priceUsd, tool.priceCop)}</div>
              <div className="small muted">Se cobra hoy {formatCop(pricing.charge(tool.priceUsd, tool.priceCop))} · pago único, adicional a la suscripción.</div>
              {viewer.member ? (
                <Link className="btn btn-red" href={checkout}>Comprar</Link>
              ) : user ? (
                <>
                  <p className="small" style={{ margin: 0 }}>Esta herramienta es un complemento para suscriptores.</p>
                  <Link className="btn" href="/planes">Ver planes</Link>
                </>
              ) : !platformOpen ? (
                <p className="small" style={{ margin: 0 }}>Esta herramienta es un complemento para suscriptores. La suscripción llega muy pronto.</p>
              ) : (
                <>
                  <p className="small" style={{ margin: 0 }}>Esta herramienta es un complemento para suscriptores.</p>
                  <Link className="btn" href={`/registro?next=${encodeURIComponent(back)}`}>Crear cuenta</Link>
                  <Link className="btn btn-ghost" href={`/ingresar?next=${encodeURIComponent(back)}`}>Ya tengo cuenta</Link>
                </>
              )}
            </>
          ) : (
            <>
              <p style={{ margin: 0 }}>🔒 {platformOpen ? "Disponible con la suscripción." : "Disponible muy pronto con la suscripción."}</p>
              {platformOpen && <Link className="btn" href={user ? "/planes" : `/registro?next=${encodeURIComponent(back)}`}>{user ? "Ver planes" : "Crear cuenta"}</Link>}
              {platformOpen && !user && <Link className="btn btn-ghost" href={`/ingresar?next=${encodeURIComponent(back)}`}>Ya tengo cuenta</Link>}
            </>
          )}
        </aside>
      </div>
    </div>
  );
}
