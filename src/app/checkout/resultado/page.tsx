import Link from "next/link";
import { notFound } from "next/navigation";
import { requireUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { formatCop } from "@/lib/format";
import { MASTERCLASS_DEFAULTS } from "@/lib/masterclass";
import { failOrder, fetchMpPayment, fulfillOrder, paymentsMode } from "@/lib/payments";

export const dynamic = "force-dynamic";
export const metadata = { title: "Resultado del pago" };

export default async function ResultPage({
  searchParams,
}: {
  searchParams: Promise<{ orden?: string; payment_id?: string }>;
}) {
  const { orden, payment_id } = await searchParams;
  const user = await requireUser();
  let order = orden ? await db.order.findUnique({ where: { id: orden }, include: { lesson: true, service: true, resource: true } }) : null;
  if (!order || order.userId !== user.id) notFound();

  // Si el usuario vuelve antes que el webhook, se consulta el pago directamente.
  if (order.status === "PENDING" && payment_id && paymentsMode() === "mercadopago") {
    try {
      const payment = await fetchMpPayment(payment_id);
      if (payment.external_reference === order.id) {
        if (payment.status === "approved" && payment.transaction_amount >= order.amountCop) {
          await fulfillOrder(order.id, String(payment.id));
        } else if (payment.status === "rejected" || payment.status === "cancelled") {
          await failOrder(order.id);
        }
        order = await db.order.findUniqueOrThrow({ where: { id: order.id }, include: { lesson: true, service: true, resource: true } });
      }
    } catch (err) {
      console.error(err);
    }
  }

  return (
    <div className="container">
      <div className="card auth-card stack center">
        {order.status === "PAID" ? (
          <>
            <div style={{ fontSize: "3rem" }}>🎉</div>
            <h1 style={{ fontSize: "1.6rem" }}>¡Pago aprobado!</h1>
            <p className="muted">{order.description} · {formatCop(order.amountCop)}</p>
            {order.kind === "SERVICE" && order.service?.slug === MASTERCLASS_DEFAULTS.serviceSlug ? (
              <>
                <p>Tu cupo en la masterclass está reservado. Te enviaremos el enlace de Zoom y el kit por correo antes del evento.</p>
                <Link className="btn" href="/masterclass">Ver la masterclass</Link>
              </>
            ) : order.kind === "SERVICE" ? (
              <>
                <p>Te contactaremos por correo o WhatsApp en las próximas 24 horas hábiles para agendar.</p>
                <Link className="btn" href="/cuenta">Ir a mi cuenta</Link>
              </>
            ) : order.kind === "RESOURCE" && order.resource ? (
              <Link className="btn" href={`/herramientas/${order.resource.slug}`}>Abrir la herramienta</Link>
            ) : order.kind === "LESSON" && order.lesson ? (
              <Link className="btn" href={`/clases/${order.lesson.slug}`}>Ver la clase</Link>
            ) : (
              <Link className="btn" href="/clases">Empezar a ver clases</Link>
            )}
          </>
        ) : order.status === "PENDING" ? (
          <>
            <div style={{ fontSize: "3rem" }}>⏳</div>
            <h1 style={{ fontSize: "1.6rem" }}>Pago en proceso</h1>
            <p className="muted">
              Cuando Mercado Pago confirme el pago activaremos tu acceso automáticamente. Puede tardar unos minutos
              (PSE o efectivo pueden tardar más).
            </p>
            <Link className="btn btn-ghost" href="/cuenta">Ir a mi cuenta</Link>
          </>
        ) : (
          <>
            <div style={{ fontSize: "3rem" }}>⚠️</div>
            <h1 style={{ fontSize: "1.6rem" }}>El pago no se completó</h1>
            <p className="muted">No se realizó ningún cobro. Puedes intentarlo de nuevo.</p>
            <Link className="btn" href={order.kind === "SERVICE" ? "/planes#servicios" : order.kind === "LESSON" && order.lesson ? `/clases/${order.lesson.slug}` : order.kind === "RESOURCE" && order.resource ? `/herramientas/${order.resource.slug}` : "/planes"}>Volver a intentar</Link>
          </>
        )}
      </div>
    </div>
  );
}
