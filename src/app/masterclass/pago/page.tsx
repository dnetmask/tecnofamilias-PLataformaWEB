import Link from "next/link";
import { captureOrder, paypalEnabled } from "@/lib/paypal";
import { NOINDEX } from "@/lib/site";
import { whatsappUrl } from "@/lib/whatsapp";

export const dynamic = "force-dynamic";
export const metadata = { title: "Pago de la masterclass", ...NOINDEX };

/** Regreso desde PayPal (?token=<orden>): se captura el pago y se confirma el cupo. */
export default async function PayPalReturnPage({ searchParams }: { searchParams: Promise<{ token?: string }> }) {
  const { token } = await searchParams;
  const valid = !!token && /^[A-Z0-9]{5,40}$/.test(token) && paypalEnabled();
  const result = valid ? await captureOrder(token).catch((err) => (console.error(err), { ok: false as const, reason: "error" })) : null;

  return (
    <div className="container section" style={{ maxWidth: 640 }}>
      {result?.ok ? (
        <div className="card stack">
          <h1 style={{ margin: 0 }}>¡Pago recibido! Tu cupo está reservado</h1>
          <p style={{ margin: 0 }}>
            Gracias por inscribirte a la masterclass. Te enviaremos el enlace de conexión y los materiales
            {result.email ? <> a <strong>{result.email}</strong></> : <> por correo</>}.
          </p>
          <div className="row">
            <Link href="/masterclass" className="btn">Volver a la masterclass</Link>
            <a href={whatsappUrl("Hola Tecnofamilias, acabo de pagar la masterclass con PayPal.")} target="_blank" rel="noopener noreferrer" className="btn btn-ghost">Escríbenos por WhatsApp</a>
          </div>
        </div>
      ) : (
        <div className="card stack">
          <h1 style={{ margin: 0 }}>No pudimos confirmar el pago</h1>
          <p style={{ margin: 0 }}>
            {result && "reason" in result && result.reason === "declinado"
              ? "PayPal rechazó el medio de pago. Puedes intentarlo de nuevo con otra tarjeta o cuenta."
              : "No se completó el cobro. Si PayPal te descontó el dinero, escríbenos y lo revisamos de inmediato."}
          </p>
          <div className="row">
            <Link href="/masterclass#precio" className="btn">Intentar de nuevo</Link>
            <a href={whatsappUrl("Hola Tecnofamilias, tuve un problema pagando la masterclass con PayPal.")} target="_blank" rel="noopener noreferrer" className="btn btn-ghost">Escríbenos por WhatsApp</a>
          </div>
        </div>
      )}
    </div>
  );
}
