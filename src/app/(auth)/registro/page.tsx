import { redirect } from "next/navigation";
import Link from "next/link";
import { CurrencySwitcher } from "@/components/CurrencySwitcher";
import { getCurrentUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { formatCop } from "@/lib/format";
import { isPlatformOpen, isServiceCheckout } from "@/lib/launch";
import { getPricing } from "@/lib/pricing";
import { safeNext } from "@/lib/url";
import { RegisterForm } from "../AuthForms";

export const metadata = { title: "Crear cuenta" };

export default async function RegisterPage({ searchParams }: { searchParams: Promise<{ next?: string }> }) {
  const { next } = await searchParams;
  if (await getCurrentUser()) redirect(safeNext(next, "/"));
  const [plans, pricing, open] = await Promise.all([
    db.plan.findMany({ where: { active: true }, orderBy: { order: "asc" } }),
    getPricing(),
    isPlatformOpen(),
  ]);
  const forService = isServiceCheckout(next);
  // Plataforma en "Próximamente": solo se crean cuentas para comprar un servicio.
  if (!open && !forService) {
    return (
      <div className="container">
        <div className="card auth-card stack center">
          <span className="badge badge-yellow" style={{ alignSelf: "center" }}>Próximamente</span>
          <h1 style={{ fontSize: "1.8rem", margin: 0 }}>La plataforma llega muy pronto</h1>
          <p className="muted" style={{ margin: 0 }}>
            Estamos preparando las clases, los pactos y la comunidad. Mientras tanto, prueba lo que ya está abierto para todos.
          </p>
          <div className="stack" style={{ gap: 10, width: "100%" }}>
            <Link href="/juegos" className="btn btn-yellow">🎮 Juegos gratis</Link>
            <Link href="/herramientas" className="btn">🧰 Caja de herramientas</Link>
            <Link href="/planes#servicios" className="btn btn-ghost">Asesoría y programas para instituciones</Link>
          </div>
          <p className="small muted" style={{ margin: 0 }}>¿Ya tienes cuenta? <Link href="/ingresar">Ingresar</Link></p>
        </div>
      </div>
    );
  }
  return (
    <div className="container">
      <div className="card auth-card">
        <h1 style={{ fontSize: "1.8rem" }}>Crea tu cuenta</h1>
        <p className="muted">{forService && !open ? "Crea tu cuenta para comprar el servicio." : "Crea tu cuenta y elige tu plan para acceder a todo el contenido."}</p>
        {open && plans.length > 0 && (
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
