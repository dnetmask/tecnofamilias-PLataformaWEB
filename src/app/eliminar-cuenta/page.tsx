import Link from "next/link";
import { DeleteAccountForm } from "@/app/cuenta/Forms";
import { getActiveSubscription } from "@/lib/access";
import { getCurrentUser } from "@/lib/auth";
import { formatDate } from "@/lib/format";
import { pageMeta } from "@/lib/site";
import { whatsappUrl } from "@/lib/whatsapp";

export const dynamic = "force-dynamic";
export const metadata = pageMeta(
  "/eliminar-cuenta",
  "Eliminar mi cuenta",
  "Cómo eliminar tu cuenta de Tecnofamilias y qué datos se borran.",
);

export default async function DeleteAccountPage({ searchParams }: { searchParams: Promise<{ hecho?: string }> }) {
  const { hecho } = await searchParams;
  const user = hecho ? null : await getCurrentUser();
  const sub = user ? await getActiveSubscription(user.id) : null;

  if (hecho) {
    return (
      <div className="container">
        <div className="card auth-card stack center">
          <div style={{ fontSize: "3rem" }}>👋</div>
          <h1 style={{ fontSize: "1.6rem" }}>Tu cuenta fue eliminada</h1>
          <p className="muted">Borramos tus datos personales de Tecnofamilias. Gracias por habernos acompañado; aquí estaremos si quieres volver.</p>
          <Link className="btn" href="/">Ir al inicio</Link>
        </div>
      </div>
    );
  }

  return (
    <div className="container section" style={{ maxWidth: 720 }}>
      <h1>Eliminar mi cuenta</h1>
      <p className="muted">Puedes eliminar tu cuenta de Tecnofamilias cuando quieras. La eliminación es definitiva y no se puede deshacer.</p>

      <div className="card stack">
        <h3>Qué se borra</h3>
        <ul style={{ margin: 0, paddingLeft: 18 }}>
          <li>Tu nombre, correo y contraseña.</li>
          <li>Tu suscripción y las compras dentro de la plataforma (cursos complementarios y herramientas pagas).</li>
          <li>Tus pactos digitales, favoritos y el progreso en la plataforma.</li>
          <li>Tus temas y respuestas en la comunidad.</li>
        </ul>
        <h3>Qué se conserva</h3>
        <p className="muted" style={{ margin: 0 }}>
          El registro de los pagos (fecha, concepto y valor), sin tu nombre ni tu correo, porque la ley nos obliga a guardar los soportes
          contables. Las solicitudes de servicios quedan sin tus datos de contacto.
        </p>
      </div>

      {user ? (
        <div className="card stack" style={{ marginTop: 20 }}>
          <h3>Eliminar la cuenta de {user.email}</h3>
          {sub && (
            <div className="alert alert-error">
              Tienes una suscripción activa hasta el {formatDate(sub.currentPeriodEnd)}. Si eliminas la cuenta, pierdes el tiempo restante.
            </div>
          )}
          <DeleteAccountForm />
          <p className="small muted" style={{ margin: 0 }}><Link href="/cuenta">← Volver a Mi cuenta</Link></p>
        </div>
      ) : (
        <div className="card stack" style={{ marginTop: 20 }}>
          <h3>Cómo eliminarla</h3>
          <p className="muted" style={{ margin: 0 }}>Ingresa a tu cuenta y confirma con tu contraseña. Si no recuerdas la contraseña, primero recupérala.</p>
          <div className="row">
            <Link className="btn" href="/ingresar?next=%2Feliminar-cuenta">Ingresar para eliminarla</Link>
            <Link className="btn btn-ghost" href="/recuperar">Recuperar contraseña</Link>
          </div>
          <p className="small muted" style={{ margin: 0 }}>
            ¿No puedes ingresar? Escríbenos por <a href={whatsappUrl("Hola Tecnofamilias, quiero eliminar mi cuenta.")} target="_blank" rel="noopener noreferrer">WhatsApp</a> desde
            el número o con el correo de tu cuenta y la eliminamos por ti.
          </p>
        </div>
      )}
    </div>
  );
}
