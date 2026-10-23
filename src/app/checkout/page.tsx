import Link from "next/link";
import { redirect } from "next/navigation";
import { SubmitButton } from "@/components/SubmitButton";
import { canWatchLesson, getActiveSubscription, hasMemberAccess } from "@/lib/access";
import { requireUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { CurrencySwitcher } from "@/components/CurrencySwitcher";
import { formatCop, formatDate } from "@/lib/format";
import { getPricing } from "@/lib/pricing";
import { paymentsMode } from "@/lib/payments";
import { createOrderAction } from "./actions";

export const dynamic = "force-dynamic";
export const metadata = { title: "Pago" };

export default async function CheckoutPage({ searchParams }: { searchParams: Promise<{ plan?: string; clase?: string; servicio?: string }> }) {
  const { plan: planSlug, clase, servicio } = await searchParams;
  const next = planSlug
    ? `/checkout?plan=${planSlug}`
    : clase
      ? `/checkout?clase=${clase}`
      : servicio
        ? `/checkout?servicio=${servicio}`
        : "/planes";
  const user = await requireUser(next);
  const pricing = await getPricing();

  let title = "";
  let detail = "";
  let amount = 0;
  if (planSlug) {
    const plan = await db.plan.findUnique({ where: { slug: planSlug } });
    if (!plan || !plan.active) redirect("/planes");
    const sub = await getActiveSubscription(user.id);
    title = plan.name;
    amount = plan.priceUsd;
    detail = sub
      ? `Ya tienes una suscripción activa hasta el ${formatDate(sub.currentPeriodEnd)}. Este pago la extiende un ${plan.interval === "YEAR" ? "año" : "mes"} más.`
      : `Acceso a todo el contenido incluido durante un ${plan.interval === "YEAR" ? "año" : "mes"}.`;
  } else if (clase) {
    const lesson = await db.lesson.findUnique({ where: { slug: clase } });
    if (!lesson || !lesson.published || lesson.access !== "ADDON") redirect("/clases");
    if (!(await hasMemberAccess(user))) redirect("/planes?requiere=suscripcion");
    if (await canWatchLesson(user, lesson)) redirect(`/clases/${lesson.slug}`);
    title = lesson.title;
    amount = lesson.priceUsd;
    detail = "Curso complementario: pago único, disponible mientras tu suscripción esté activa.";
  } else if (servicio) {
    const service = await db.service.findUnique({ where: { slug: servicio } });
    if (!service || !service.active || !service.priceUsd) redirect("/servicios");
    title = service.name;
    amount = service.priceUsd;
    detail = `${service.unit}. Después del pago te contactamos para agendar.`;
  } else {
    redirect("/planes");
  }

  return (
    <div className="container">
      <div className="card auth-card stack">
        <h1 style={{ fontSize: "1.6rem" }}>Confirmar compra</h1>
        <div className="card card-tint">
          <h3>{title}</h3>
          <p className="muted small">{detail}</p>
          <div className="price">USD {amount}</div>
          {pricing.currency !== "USD" && <div className="small muted">≈ {pricing.price(amount)}</div>}
          <div style={{ marginTop: 10, fontWeight: 700 }}>Total a pagar hoy: {formatCop(pricing.charge(amount))}</div>
          <div className="small muted">
            Tasa del día: 1 USD = {formatCop(pricing.rates.COP)}. Mercado Pago cobra en pesos colombianos; si tu tarjeta es de otro país, tu banco hace la conversión final.
          </div>
        </div>
        <CurrencySwitcher current={pricing.currency} />
        {paymentsMode() === "demo" && (
          <div className="alert alert-info">Modo de pruebas: no se realizará ningún cobro real.</div>
        )}
        <form action={createOrderAction} className="form">
          {planSlug && <input type="hidden" name="plan" value={planSlug} />}
          {clase && <input type="hidden" name="clase" value={clase} />}
          {servicio && <input type="hidden" name="servicio" value={servicio} />}
          <SubmitButton pendingText="Redirigiendo al pago…">Ir a pagar</SubmitButton>
        </form>
        <p className="small muted center">
          Pago seguro con Mercado Pago (tarjeta, PSE, Nequi y efectivo). <Link href={servicio ? `/servicios/${servicio}` : clase ? `/clases/${clase}` : "/planes"}>Volver</Link>
        </p>
      </div>
    </div>
  );
}
