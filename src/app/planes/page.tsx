import Link from "next/link";
import { PlanCards } from "@/components/PlanCards";
import { db } from "@/lib/db";

export const dynamic = "force-dynamic";
export const metadata = { title: "Planes" };

export default async function PlansPage() {
  const plans = await db.plan.findMany({ where: { active: true }, orderBy: { order: "asc" } });
  return (
    <>
      <div className="page-head">
        <div className="container">
          <h1>Planes</h1>
          <p>Elige cómo quieres acompañar a tu familia.</p>
        </div>
      </div>
      <div className="container section stack">
        <PlanCards plans={plans} />
        <div className="card card-tint">
          <h3>¿Cómo funcionan las clases de pago puntual?</h3>
          <p className="muted" style={{ margin: 0 }}>
            Algunas masterclass especializadas se compran una sola vez y quedan disponibles en tu cuenta para siempre,
            tengas o no suscripción. Puedes verlas en el <Link href="/clases">catálogo de clases</Link>.
          </p>
        </div>
      </div>
    </>
  );
}
