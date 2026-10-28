import type { Resource } from "@prisma/client";
import Link from "next/link";
import { stageShort } from "@/lib/format";
import { canUseTool, formatUntil, TOOL_ACCESS, TOOL_KINDS, type ToolViewer, usesLabel } from "@/lib/tools";
import { FavoriteButton } from "./FavoriteButton";

export function ToolCard({
  tool,
  viewer,
  favorite,
  back,
  price,
  rank,
}: {
  tool: Resource;
  viewer: ToolViewer;
  favorite: boolean;
  back: string;
  /** Precio ya formateado en la moneda del visitante (herramientas pagas o externas). */
  price: string | null;
  /** Posición en el ranking de las más usadas. */
  rank?: number;
}) {
  const kind = TOOL_KINDS[tool.kind];
  const access = TOOL_ACCESS[tool.access];
  const usable = canUseTool(viewer, tool);
  const href = `/herramientas/${tool.slug}`;
  const cta = usable
    ? tool.access === "EXTERNAL" ? "Ver dónde comprar →" : `${kind.open} →`
    : tool.access === "PAID" ? "Ver y comprar →" : "🔒 Disponible con la suscripción";

  return (
    <article className="card stack tool-card">
      <div className="row between" style={{ alignItems: "flex-start", flexWrap: "nowrap" }}>
        <Link href={href} className="row" style={{ color: "inherit", flexWrap: "nowrap", minWidth: 0 }}>
          {tool.imageUrl ? (
            // eslint-disable-next-line @next/next/no-img-element
            <img src={tool.imageUrl} alt="" className="tool-thumb" loading="lazy" />
          ) : (
            <span className="icon-dot" style={{ background: kind.color }}>{kind.icon}</span>
          )}
          <div style={{ minWidth: 0 }}>
            {rank && <span className="small" style={{ color: "var(--red)", fontWeight: 800 }}>#{rank} más usada</span>}
            <h3 style={{ margin: 0 }}>{tool.title}</h3>
            {tool.author && <div className="small muted">{tool.author}</div>}
          </div>
        </Link>
        <FavoriteButton id={tool.id} favorite={favorite} loggedIn={viewer.loggedIn} back={back} />
      </div>
      <div className="row" style={{ gap: 6 }}>
        <span className="badge">{kind.label}</span>
        <span className={`badge ${access.badge}`}>{access.label}</span>
        {tool.ageStage !== "ALL" && <span className="badge badge-gray">{stageShort(tool.ageStage)} años</span>}
        {tool.fileUrl && <span className="badge badge-gray">📄 PDF</span>}
        {tool.availableUntil && <span className="badge badge-yellow">⏳ Hasta el {formatUntil(tool.availableUntil)}</span>}
      </div>
      {tool.description && <p className="muted small tool-desc" style={{ margin: 0 }}>{tool.description}</p>}
      <div className="row between" style={{ marginTop: "auto" }}>
        <Link href={href} className="small" style={{ fontWeight: 700 }}>{cta}</Link>
        <span className="small muted">
          {price && <strong style={{ color: "var(--navy)" }}>{price}</strong>}
          {price && tool.uses > 0 && " · "}
          {tool.uses > 0 && `👥 ${usesLabel(tool.uses)}`}
        </span>
      </div>
    </article>
  );
}
