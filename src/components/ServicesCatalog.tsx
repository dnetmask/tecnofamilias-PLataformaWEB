import Link from "next/link";
import { db } from "@/lib/db";
import { MASTERCLASS_DEFAULTS } from "@/lib/masterclass";
import { getPricing } from "@/lib/pricing";
import { AUDIENCE_ORDER, AUDIENCES } from "@/lib/services";
import { serviceWhatsappUrl, WHATSAPP_SERVICES } from "@/lib/whatsapp";
import { WhatsAppIcon } from "./WhatsAppButton";

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
              {items.map((s) => {
                // Las cotizaciones y la asesoría se atienden por WhatsApp; los servicios con compra en línea van a su ficha.
                const viaWhatsapp = WHATSAPP_SERVICES.has(s.slug) || !s.priceUsd;
                return (
                  <div key={s.id} className={`card service-card${s.featured ? " service-dark" : ""}`}>
                    <div style={{ minWidth: 0 }}>
                      <h3><Link href={`/servicios/${s.slug}`} className="service-title">{s.name}</Link></h3>
                      <p className="small" style={{ margin: 0 }}>{s.description}</p>
                      <Link href={`/servicios/${s.slug}`} className="small service-more">Ver detalles →</Link>
                    </div>
                    <div className="service-price">
                      <div className="price-label">{pricing.range(s.priceFromUsd, s.priceToUsd, s.priceCop)}</div>
                      <div className="small">{s.unit}</div>
                      {viaWhatsapp ? (
                        <a
                          href={serviceWhatsappUrl(s)}
                          target="_blank"
                          rel="noopener noreferrer"
                          className={`btn btn-sm ${WHATSAPP_SERVICES.has(s.slug) ? "btn-wa" : s.featured ? "btn-yellow" : ""}`}
                          style={{ marginTop: 10, gap: 6 }}
                        >
                          <WhatsAppIcon size={16} /> {WHATSAPP_SERVICES.has(s.slug) ? "Hablar por WhatsApp" : "Solicitar cotización"}
                        </a>
                      ) : (
                        <Link href={`/servicios/${s.slug}`} className="btn btn-sm btn-red" style={{ marginTop: 10 }}>Comprar</Link>
                      )}
                    </div>
                  </div>
                );
              })}
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
