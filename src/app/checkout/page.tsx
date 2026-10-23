import Link from "next/link";
import { redirect } from "next/navigation";
import { SubmitButton } from "@/components/SubmitButton";
import { getActiveSubscription } from "@/lib/access";
import { requireUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { formatCop, formatDate } from "@/lib/format";
import { paymentsMode } from "@/lib/payments";
import { createOrderAction } from "./actions";

export const dynamic = "force-dynamic";
export const metadata = { title: "Pago" };

export default async function CheckoutPage({ searchParams }: { searchParams: Promise<{ plan?: string; clase?: string }> }) {
  const { plan: planSlug, clase } = await searchParams;
  const next = planSlug ? `/checkout?plan=${planSlug}` : clase ? `/checkout?clase=${clase}` : "/planes";
  const user = await requireUser(next);

  let title = "";
  let detail = "";
  let amount = 0;
  if (planSlug) {
    const plan = await db.plan.findUnique({ where: { slug: planSlug } });
    if (!plan || !plan.active) redirect("/planes");
    const sub = await getActiveSubscription(user.id);
    title = plan.name;
    amount = plan.priceCop;
    detail = sub
      ? `Ya tienes una suscripción activa hasta el ${formatDate(sub.currentPeriodEnd)}. Este pago la extiende un ${plan.interval === "YEAR" ? "año" : "mes"} más.`
      : `Acceso a todo el contenido incluido durante un ${plan.interval === "YEAR" ? "año" : "mes"}.`;
  } else if (clase) {
    const lesson = await db.lesson.findUnique({ where: { slug: clase } });
    if (!lesson || !lesson.published || lesson.access !== "PAID") redirect("/clases");
    title = lesson.title;
    amount = lesson.priceCop;
    detail = "Clase de pago puntual con acceso permanente.";
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
          <div className="price">{formatCop(amount)}</div>
        </div>
        {paymentsMode() === "demo" && (
          <div className="alert alert-info">Modo de pruebas: no se realizará ningún cobro real.</div>
        )}
        <form action={createOrderAction} className="form">
          {planSlug && <input type="hidden" name="plan" value={planSlug} />}
          {clase && <input type="hidden" name="clase" value={clase} />}
          <SubmitButton pendingText="Redirigiendo al pago…">Ir a pagar</SubmitButton>
        </form>
        <p className="small muted center">
          Pago seguro con Mercado Pago (tarjeta, PSE, Nequi y efectivo). <Link href="/planes">Volver</Link>
        </p>
      </div>
    </div>
  );
}
