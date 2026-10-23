import Link from "next/link";
import { notFound } from "next/navigation";
import { CurrencyNote } from "@/components/CurrencyNote";
import { CurrencySwitcher } from "@/components/CurrencySwitcher";
import { getCurrentUser } from "@/lib/auth";
import { getPricing } from "@/lib/pricing";
import { db } from "@/lib/db";
import { AUDIENCES } from "@/lib/services";
import { QuoteForm } from "../QuoteForm";

export const dynamic = "force-dynamic";

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }) {
  const s = await db.service.findUnique({ where: { slug: (await params).slug }, select: { name: true } });
  return { title: s?.name ?? "Servicio" };
}

export default async function ServicePage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const [service, user, pricing] = await Promise.all([db.service.findUnique({ where: { slug } }), getCurrentUser(), getPricing()]);
  if (!service || (!service.active && user?.role !== "ADMIN")) notFound();
  const meta = AUDIENCES[service.audience];
  const back = user ? "/servicios" : "/planes#servicios";

  return (
    <div className="container section">
      <p className="small"><Link href={back}>← Otros servicios</Link></p>
      <div className="layout-aside">
        <div className="stack" style={{ minWidth: 0 }}>
          <div className="row">
            <span className="icon-dot" style={{ background: meta.color }}>{meta.icon}</span>
            <span className="badge">{meta.label}</span>
          </div>
          <h1 style={{ fontSize: "2rem" }}>{service.name}</h1>
          <p style={{ fontSize: "1.1rem" }}>{service.description}</p>
          {service.details && <p className="muted" style={{ whiteSpace: "pre-wrap" }}>{service.details}</p>}

          {!service.priceCop && (
            <div className="card">
              <h3>Solicitar cotización</h3>
              <p className="muted small">Te enviaremos una propuesta ajustada a tu institución.</p>
              <QuoteForm
                serviceId={service.id}
                institutional={service.audience !== "FAMILIAS"}
                defaults={{ name: user?.name ?? "", email: user?.email ?? "" }}
              />
            </div>
          )}
        </div>

        <aside className={`card stack${service.featured ? " service-dark" : ""}`}>
          <div className="service-price" style={{ alignItems: "flex-start", textAlign: "left" }}>
            <div className="price-label">{pricing.range(service.priceFromCop, service.priceToCop)}</div>
            <div className="small">{service.unit}</div>
          </div>
          <CurrencySwitcher current={pricing.currency} dark={service.featured} />
          {service.priceCop && pricing.currency !== "COP" && <div className="small">Se cobra {pricing.cop(service.priceCop)}</div>}
          {!service.priceCop && <CurrencyNote currency={pricing.currency} />}
          {service.priceCop ? (
            user ? (
              <Link className="btn btn-red" href={`/checkout?servicio=${service.slug}`}>Comprar</Link>
            ) : (
              <>
                <p className="small" style={{ margin: 0 }}>Crea tu cuenta o ingresa para comprar.</p>
                <Link className="btn btn-red" href={`/registro?next=${encodeURIComponent(`/checkout?servicio=${service.slug}`)}`}>Crear cuenta y comprar</Link>
                <Link className="btn btn-ghost" href={`/ingresar?next=${encodeURIComponent(`/checkout?servicio=${service.slug}`)}`}>Ya tengo cuenta</Link>
              </>
            )
          ) : (
            <p className="small" style={{ margin: 0 }}>
              {service.audience === "GOBIERNO"
                ? "Acompañamos el proceso de contratación pública con la documentación técnica y de impacto."
                : "Valor de referencia; la propuesta final depende del alcance."}
            </p>
          )}
        </aside>
      </div>
    </div>
  );
}
