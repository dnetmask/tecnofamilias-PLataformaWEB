import Link from "next/link";
import type { Plan } from "@prisma/client";
import { getPricing } from "@/lib/pricing";

const INCLUDES = [
  "Base completa de clases pregrabadas",
  "Videos y podcasts recomendados por etapa",
  "Pactos digitales ilimitados para firmar con tus hijos",
  "Juegos para jugar y conversar en familia",
  "Comunidad de apoyo entre familias",
  "Opción de sumar cursos complementarios con pago adicional",
];

export async function PlanCards({ plans }: { plans: Plan[] }) {
  const pricing = await getPricing();
  const single = plans.length === 1;
  return (
    <div className="grid grid-3" style={single ? { maxWidth: 460, margin: "0 auto" } : undefined}>
      {plans.map((plan) => {
        const featured = single || plan.interval === "YEAR";
        return (
          <div key={plan.id} className={`card plan${featured ? " featured" : ""}`}>
            <div className="row between">
              <h3 style={{ margin: 0 }}>{plan.name}</h3>
              {!single && featured && <span className="badge badge-blue">Mejor precio</span>}
            </div>
            <div>
              <span className="price">{pricing.price(plan.priceCop)}</span>
              <span className="muted"> / {plan.interval === "YEAR" ? "año" : "mes"}</span>
              {pricing.currency !== "COP" && <div className="small muted">Se cobra {pricing.cop(plan.priceCop)}</div>}
            </div>
            {plan.description && <p className="muted small" style={{ margin: 0 }}>{plan.description}</p>}
            <ul className="small">
              {INCLUDES.map((i) => (
                <li key={i}>{i}</li>
              ))}
            </ul>
            <Link href={`/checkout?plan=${plan.slug}`} className={`btn${featured ? "" : " btn-ghost"}`} style={{ marginTop: "auto" }}>
              Suscribirme
            </Link>
          </div>
        );
      })}
    </div>
  );
}
