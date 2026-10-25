import Link from "next/link";
import type { Plan } from "@prisma/client";
import { formatCop } from "@/lib/format";
import { isPlatformOpen } from "@/lib/launch";
import { getPricing } from "@/lib/pricing";

const INCLUDES = [
  "Base completa de clases pregrabadas",
  "Caja de herramientas: videos, podcasts, guías y más, por etapa",
  "Pactos digitales ilimitados para firmar con tus hijos",
  "Juegos para jugar y conversar en familia",
  "Comunidad de apoyo entre familias",
  "Opción de sumar cursos complementarios con pago adicional",
];

export async function PlanCards({ plans }: { plans: Plan[] }) {
  const [pricing, open] = await Promise.all([getPricing(), isPlatformOpen()]);
  const single = plans.length === 1;
  return (
    <div className="grid grid-3" style={single ? { maxWidth: 460, margin: "0 auto" } : undefined}>
      {plans.map((plan) => {
        const featured = single || plan.interval === "YEAR";
        return (
          <div key={plan.id} className={`card plan${featured ? " featured" : ""}`}>
            <div className="row between">
              <h3 style={{ margin: 0 }}>{plan.name}</h3>
              {!open ? <span className="badge badge-yellow">Próximamente</span> : !single && featured && <span className="badge badge-blue">Mejor precio</span>}
            </div>
            {!open ? (
              <p style={{ margin: 0, fontWeight: 700, color: "var(--navy)" }}>Estamos preparando la plataforma. Muy pronto podrás suscribirte.</p>
            ) : (
            <div>
              <span className="price">{pricing.price(plan.priceUsd, plan.priceCop)}</span>
              <span className="muted"> / {plan.interval === "YEAR" ? "año" : "mes"}</span>
              {pricing.currency !== "USD" && !(pricing.currency === "COP" && plan.priceCop) && <div className="small muted">Precio base USD {plan.priceUsd}</div>}
              <div className="small muted">Se cobra hoy {formatCop(pricing.charge(plan.priceUsd, plan.priceCop))}</div>
            </div>
            )}
            {plan.description && <p className="muted small" style={{ margin: 0 }}>{plan.description}</p>}
            <ul className="small">
              {INCLUDES.map((i) => (
                <li key={i}>{i}</li>
              ))}
            </ul>
            {open ? (
              <Link href={`/checkout?plan=${plan.slug}`} className={`btn${featured ? "" : " btn-ghost"}`} style={{ marginTop: "auto" }}>
                Suscribirme
              </Link>
            ) : (
              <span className="btn btn-ghost" aria-disabled style={{ marginTop: "auto", cursor: "default" }}>Próximamente</span>
            )}
          </div>
        );
      })}
    </div>
  );
}
