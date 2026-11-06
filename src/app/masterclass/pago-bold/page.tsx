import Link from "next/link";
import { db } from "@/lib/db";
import { LEGAL, NOINDEX } from "@/lib/site";

export const dynamic = "force-dynamic";
export const metadata = { title: "Resultado del pago · Masterclass", ...NOINDEX };

/**
 * Retorno del checkout de Bold. El estado que llega en la URL solo sirve para el
 * mensaje: el cupo se confirma con el webhook firmado de Bold (estado de la orden local).
 */
export default async function BoldResultPage({ searchParams }: { searchParams: Promise<Record<string, string | undefined>> }) {
  const params = await searchParams;
  const orderId = params["bold-order-id"];
  const txStatus = (params["bold-tx-status"] ?? "").toLowerCase();
  const order = orderId ? await db.order.findFirst({ where: { id: orderId, provider: { in: ["bold", "bold-usd"] } }, select: { status: true } }) : null;

  const paid = order?.status === "PAID" || txStatus === "approved";
  const pending = !paid && (txStatus === "pending" || txStatus === "processing");

  return (
    <div className="container section" style={{ maxWidth: 560 }}>
      <div className="card stack" style={{ gap: 14, textAlign: "center" }}>
        <div style={{ fontSize: "2.4rem" }}>{paid ? "🎉" : pending ? "⏳" : "⚠️"}</div>
        <h1 style={{ margin: 0, fontSize: "1.6rem" }}>
          {paid ? "¡Tu cupo está reservado!" : pending ? "Tu pago está en proceso" : "El pago no se completó"}
        </h1>
        <p className="muted" style={{ margin: 0 }}>
          {paid
            ? `Te enviaremos al correo del pago el enlace de acceso a la masterclass. Si no lo ves, revisa spam o escríbenos a ${LEGAL.email}.`
            : pending
              ? "Bold está confirmando la transacción. Te avisaremos por correo cuando se apruebe."
              : "No se hizo ningún cobro. Puedes intentarlo de nuevo con otro medio de pago."}
        </p>
        {orderId && <p className="small muted" style={{ margin: 0 }}>Referencia: {orderId}</p>}
        <Link href="/masterclass#precio" className="btn btn-yellow">{paid ? "Volver a la masterclass" : "Volver a intentar"}</Link>
      </div>
    </div>
  );
}
