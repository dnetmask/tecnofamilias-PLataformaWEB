import Link from "next/link";
import { notFound } from "next/navigation";
import { CurrencyNote } from "@/components/CurrencyNote";
import { CurrencySwitcher } from "@/components/CurrencySwitcher";
import { ServiceDetails } from "@/components/ServiceDetails";
import { getCurrentUser } from "@/lib/auth";
import { formatCop } from "@/lib/format";
import { getPricing } from "@/lib/pricing";
import { db } from "@/lib/db";
import { AUDIENCES } from "@/lib/services";
import { WHATSAPP_SERVICES, whatsappUrl } from "@/lib/whatsapp";
import { WhatsAppIcon } from "@/components/WhatsAppButton";
import { QuoteForm } from "../QuoteForm";
import { NOINDEX, pageMeta } from "@/lib/site";

export const dynamic = "force-dynamic";

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }) {
  const s = await db.service.findUnique({ where: { slug: (await params).slug }, select: { slug: true, name: true, description: true } });
  if (!s) return { title: "Servicio" };
  if (s.slug.startsWith("masterclass-crianza")) return { title: s.name, ...NOINDEX };
  return pageMeta(`/servicios/${s.slug}`, s.name, s.description.slice(0, 160));
}

export default async function ServicePage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const [service, user, pricing] = await Promise.all([db.service.findUnique({ where: { slug } }), getCurrentUser(), getPricing()]);
  if (!service || (!service.active && user?.role !== "ADMIN")) notFound();
  const meta = AUDIENCES[service.audience];
  // Algunos servicios (p. ej. la asesoría) se atienden por ahora por WhatsApp en lugar de comprarse en línea.
  const viaWhatsapp = WHATSAPP_SERVICES.has(service.slug);

  return (
    <div className="container section">
      <p className="small"><Link href="/planes#servicios">← Planes</Link></p>
      <div className="layout-aside">
        <div className="stack" style={{ minWidth: 0 }}>
          <div className="row">
            <span className="icon-dot" style={{ background: meta.color }}>{meta.icon}</span>
            <span className="badge">{meta.label}</span>
          </div>
          <h1 style={{ fontSize: "2rem" }}>{service.name}</h1>
          <p style={{ fontSize: "1.1rem" }}>{service.description}</p>
          {service.details && <ServiceDetails text={service.details} />}

          {!service.priceUsd && (
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
            <div className="price-label">{pricing.range(service.priceFromUsd, service.priceToUsd, service.priceCop)}</div>
            <div className="small">{service.unit}</div>
          </div>
          <CurrencySwitcher current={pricing.currency} dark={service.featured} />
          {service.priceUsd && !viaWhatsapp ? <div className="small">Se cobra hoy {formatCop(pricing.charge(service.priceUsd, service.priceCop))}</div> : null}
          {!viaWhatsapp && <CurrencyNote currency={pricing.currency} />}
          {viaWhatsapp ? (
            <>
              <p className="small" style={{ margin: 0 }}>Escríbenos y agendamos tu asesoría por WhatsApp.</p>
              <a className="btn btn-wa" href={whatsappUrl(`Hola Tecnofamilias, quiero información sobre la ${service.name.toLowerCase()}.`)} target="_blank" rel="noopener noreferrer">
                <WhatsAppIcon size={20} /> Escribir por WhatsApp
              </a>
            </>
          ) : service.priceUsd ? (
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
