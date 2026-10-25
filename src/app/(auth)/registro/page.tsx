import { redirect } from "next/navigation";
import Link from "next/link";
import { CurrencySwitcher } from "@/components/CurrencySwitcher";
import { getCurrentUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { formatCop } from "@/lib/format";
import { getPricing } from "@/lib/pricing";
import { safeNext } from "@/lib/url";
import { RegisterForm } from "../AuthForms";

export const metadata = { title: "Crear cuenta" };

export default async function RegisterPage({ searchParams }: { searchParams: Promise<{ next?: string }> }) {
  const { next } = await searchParams;
  if (await getCurrentUser()) redirect(safeNext(next, "/"));
  const [plans, pricing] = await Promise.all([
    db.plan.findMany({ where: { active: true }, orderBy: { order: "asc" } }),
    getPricing(),
  ]);
  return (
    <div className="container">
      <div className="card auth-card">
        <h1 style={{ fontSize: "1.8rem" }}>Crea tu cuenta</h1>
        <p className="muted">Crea tu cuenta y elige tu plan para acceder a todo el contenido.</p>
        {plans.length > 0 && (
          <div className="auth-plans stack" style={{ gap: 10 }}>
            {plans.map((plan) => (
              <div key={plan.id} className="auth-plan">
                <div>
                  <strong style={{ color: "var(--navy)" }}>Plan {plan.name.toLowerCase()}</strong>
                  <div className="small muted">Clases, juegos, pactos, caja de herramientas y comunidad</div>
                </div>
                <div>
                  <span className="price">{pricing.price(plan.priceUsd, plan.priceCop)}</span>
                  <span className="muted small"> / {plan.interval === "YEAR" ? "año" : "mes"}</span>
                  {pricing.currency !== "COP" && <div className="small muted">Se cobra {formatCop(pricing.charge(plan.priceUsd, plan.priceCop))}</div>}
                </div>
              </div>
            ))}
            <div><CurrencySwitcher current={pricing.currency} /></div>
            <div className="small"><Link href="/planes">Ver qué incluye cada plan</Link></div>
          </div>
        )}
        <RegisterForm next={next ? safeNext(next) : undefined} />
      </div>
    </div>
  );
}
