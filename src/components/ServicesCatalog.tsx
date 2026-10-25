import Link from "next/link";
import { db } from "@/lib/db";
import { MASTERCLASS_DEFAULTS } from "@/lib/masterclass";
import { getPricing } from "@/lib/pricing";
import { AUDIENCE_ORDER, AUDIENCES } from "@/lib/services";

/** Servicios adicionales agrupados por público (diapositivas 7 a 9 de la presentación). */
export async function ServicesCatalog() {
  const [services, pricing] = await Promise.all([
    // La masterclass se vende solo desde su landing (/masterclass), no en el catálogo.
    db.service.findMany({ where: { active: true, slug: { not: MASTERCLASS_DEFAULTS.serviceSlug } }, orderBy: { order: "asc" } }),
    getPricing(),
  ]);
  return (
    <div className="stack" style={{ gap: 36 }}>
      {AUDIENCE_ORDER.map((aud) => {
        const items = services.filter((s) => s.audience === aud);
        if (items.length === 0) return null;
        const meta = AUDIENCES[aud];
        return (
          <section key={aud} className="stack">
            <div className="row" style={{ gap: 14 }}>
              <span className="icon-dot" style={{ background: meta.color, width: 56, height: 56, fontSize: "1.6rem" }}>{meta.icon}</span>
              <div>
                <h2 style={{ margin: 0 }}>{meta.label}</h2>
                <p className="muted" style={{ margin: 0 }}>{meta.intro}</p>
              </div>
            </div>
            <div className="grid services-grid">
              {items.map((s) => (
                <Link key={s.id} href={`/servicios/${s.slug}`} className={`card card-link service-card${s.featured ? " service-dark" : ""}`}>
                  <div style={{ minWidth: 0 }}>
                    <h3>{s.name}</h3>
                    <p className="small" style={{ margin: 0 }}>{s.description}</p>
                  </div>
                  <div className="service-price">
                    <div className="price-label">{pricing.range(s.priceFromUsd, s.priceToUsd, s.priceCop)}</div>
                    <div className="small">{s.unit}</div>
                    <span className={`btn btn-sm ${s.priceUsd ? "btn-red" : s.featured ? "btn-yellow" : ""}`} style={{ marginTop: 10 }}>
                      {s.priceUsd ? "Comprar" : "Solicitar cotización"}
                    </span>
                  </div>
                </Link>
              ))}
            </div>
          </section>
        );
      })}
      <p className="small muted" style={{ margin: 0 }}>
        Valores de referencia. Para instituciones el precio final depende del número de sesiones, asistentes y sedes.
      </p>
    </div>
  );
}
