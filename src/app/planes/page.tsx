import Link from "next/link";
import { PlanCards } from "@/components/PlanCards";
import { db } from "@/lib/db";

export const dynamic = "force-dynamic";
export const metadata = { title: "Planes" };

export default async function PlansPage({ searchParams }: { searchParams: Promise<{ requiere?: string }> }) {
  const { requiere } = await searchParams;
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
        {requiere && (
          <div className="alert alert-info">
            Para acceder a las clases, los pactos, los videos y la comunidad necesitas una suscripción activa. Elige tu plan para continuar.
          </div>
        )}
        <PlanCards plans={plans} />
        <div className="card card-tint">
          <h3>¿Qué son los cursos complementarios?</h3>
          <p className="muted" style={{ margin: 0 }}>
            La suscripción incluye toda la base de clases, videos, podcasts, pactos y la comunidad. Algunos cursos
            especializados son complementos: los suscriptores los compran una sola vez con un pago adicional y quedan
            en su cuenta mientras la suscripción esté activa. Míralos en el <Link href="/clases?tipo=complementos">catálogo</Link>.
          </p>
        </div>
      </div>
    </>
  );
}
