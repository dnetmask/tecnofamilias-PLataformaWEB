import Link from "next/link";
import { PlanCards } from "@/components/PlanCards";
import { ServicesCatalog } from "@/components/ServicesCatalog";
import { CurrencyNote } from "@/components/CurrencyNote";
import { CurrencySwitcher } from "@/components/CurrencySwitcher";
import { getCurrentUser } from "@/lib/auth";
import { getPricing } from "@/lib/pricing";
import { db } from "@/lib/db";

export const dynamic = "force-dynamic";
export const metadata = { title: "Planes" };

export default async function PlansPage({ searchParams }: { searchParams: Promise<{ requiere?: string }> }) {
  const { requiere } = await searchParams;
  const [plans, user, pricing] = await Promise.all([
    db.plan.findMany({ where: { active: true }, orderBy: { order: "asc" } }),
    getCurrentUser(),
    getPricing(),
  ]);
  return (
    <>
      <div className="page-head">
        <div className="container">
          <h1>Planes</h1>
          <p>Un solo plan con acceso a todo el contenido de Tecnofamilias.</p>
          <div style={{ marginTop: 16 }}><CurrencySwitcher current={pricing.currency} dark /></div>
        </div>
      </div>
      <div className="container section stack">
        {requiere && (
          <div className="alert alert-info">
            Para acceder a las clases, los pactos, los videos y la comunidad necesitas una suscripción activa. Elige tu plan para continuar.
          </div>
        )}
        <PlanCards plans={plans} />
        <div className="center"><CurrencyNote currency={pricing.currency} /></div>
        <div className="card card-tint">
          <h3>¿Qué son los cursos complementarios?</h3>
          <p className="muted" style={{ margin: 0 }}>
            La suscripción incluye toda la base de clases, videos, podcasts, pactos y la comunidad. Algunos cursos
            especializados son complementos: los suscriptores los compran una sola vez con un pago adicional y quedan
            en su cuenta mientras la suscripción esté activa. Míralos en el <Link href="/clases?tipo=complementos">catálogo</Link>.
          </p>
        </div>
      </div>
      {!user && (
        <div className="container section" id="servicios" style={{ borderTop: "1px solid var(--line)" }}>
          <h2>Otros servicios</h2>
          <p className="muted" style={{ marginBottom: 28 }}>
            Además de la suscripción: asesoría personalizada para tu familia y programas para colegios, empresas y entidades públicas.
          </p>
          <ServicesCatalog />
        </div>
      )}
    </>
  );
}
