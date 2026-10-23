import { notFound } from "next/navigation";
import { SubmitButton } from "@/components/SubmitButton";
import { requireUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { formatCop } from "@/lib/format";
import { paymentsMode } from "@/lib/payments";
import { approveDemoOrderAction } from "../../actions";

export const dynamic = "force-dynamic";

export default async function DemoCheckoutPage({ params }: { params: Promise<{ id: string }> }) {
  if (paymentsMode() !== "demo") notFound();
  const user = await requireUser();
  const order = await db.order.findUnique({ where: { id: (await params).id } });
  if (!order || order.userId !== user.id) notFound();

  return (
    <div className="container">
      <div className="card auth-card stack">
        <span className="badge badge-yellow">Pasarela de pruebas</span>
        <h1 style={{ fontSize: "1.6rem" }}>{order.description}</h1>
        <div className="price">{formatCop(order.amountCop)}</div>
        <p className="muted small">
          Esta pantalla reemplaza a Mercado Pago mientras PAYMENTS_MODE=&quot;demo&quot;. En producción se usa la pasarela real.
        </p>
        {order.status === "PENDING" ? (
          <form action={approveDemoOrderAction}>
            <input type="hidden" name="orderId" value={order.id} />
            <SubmitButton pendingText="Procesando…">Simular pago aprobado</SubmitButton>
          </form>
        ) : (
          <div className="alert alert-info">Esta orden ya fue procesada.</div>
        )}
      </div>
    </div>
  );
}
