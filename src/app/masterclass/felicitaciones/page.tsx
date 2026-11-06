import Link from "next/link";
import { BOLD_PROVIDERS } from "@/lib/bold";
import { db } from "@/lib/db";
import { getMasterclass } from "@/lib/masterclass";
import { LEGAL, NOINDEX } from "@/lib/site";
import { WHATSAPP_NUMBER } from "@/lib/whatsapp";

export const dynamic = "force-dynamic";
export const metadata = { title: "¡Felicitaciones! · Masterclass", ...NOINDEX };

/** "6:00 p. m. a 9:00 p. m." (hora de Colombia, UTC-5) → inicio y fin en UTC para Google Calendar; null si no se entiende. */
function calendarRange(date: string, time: string) {
  const parts = [...time.matchAll(/(\d{1,2}):(\d{2})\s*([ap])\.?\s*m/gi)];
  if (parts.length < 2) return null;
  const toUtc = (m: RegExpMatchArray) => {
    let h = Number(m[1]) % 12;
    if (m[3].toLowerCase() === "p") h += 12;
    const d = new Date(`${date}T00:00:00Z`);
    d.setUTCHours(h + 5, Number(m[2]));
    return d.toISOString().replace(/[-:]/g, "").replace(/\.\d{3}/, "");
  };
  return `${toUtc(parts[0])}/${toUtc(parts[1])}`;
}

/**
 * Página a la que vuelve la persona después de pagar con el checkout embebido de Bold (API).
 * El estado de la URL solo decide el mensaje: el cupo se confirma con el webhook firmado de Bold.
 */
export default async function MasterclassWelcomePage({ searchParams }: { searchParams: Promise<Record<string, string | undefined>> }) {
  const params = await searchParams;
  const orderId = params["bold-order-id"];
  const txStatus = (params["bold-tx-status"] ?? "").toLowerCase();
  const [mc, order] = await Promise.all([
    getMasterclass(),
    orderId ? db.order.findFirst({ where: { id: orderId, provider: { in: BOLD_PROVIDERS } }, select: { status: true, provider: true } }) : null,
  ]);

  const test = !!order?.provider.endsWith("-test");
  const paid = order?.status === "PAID" || txStatus === "approved";
  const pending = !paid && (txStatus === "pending" || txStatus === "processing");

  if (!paid || test) {
    return (
      <div className="container section" style={{ maxWidth: 560 }}>
        <div className="card stack" style={{ gap: 14, textAlign: "center" }}>
          <div style={{ fontSize: "2.4rem" }}>{paid ? "✅" : pending ? "⏳" : "⚠️"}</div>
          <h1 style={{ margin: 0, fontSize: "1.6rem" }}>
            {paid ? "Pago de prueba aprobado" : pending ? "Tu pago está en proceso" : "El pago no se completó"}
          </h1>
          <p className="muted" style={{ margin: 0 }}>
            {paid
              ? "El pago de prueba se aprobó. Este pago no reserva cupo."
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

  const range = calendarRange(mc.date, mc.time);
  const allDay = `${mc.date.replace(/-/g, "")}/${new Date(new Date(`${mc.date}T00:00:00Z`).getTime() + 86_400_000).toISOString().slice(0, 10).replace(/-/g, "")}`;
  const calendarUrl =
    "https://calendar.google.com/calendar/render?action=TEMPLATE" +
    `&text=${encodeURIComponent("Masterclass Tecnofamilias: Crianza digital segura")}` +
    `&dates=${range ?? allDay}` +
    `&details=${encodeURIComponent(`${mc.modality} · ${mc.time} (${mc.timezone}). El enlace de acceso llega a tu correo.`)}` +
    `&location=${encodeURIComponent(mc.modality)}`;
  const waText = `Hola Tecnofamilias, acabo de pagar la masterclass del ${mc.shortDate}.${orderId ? ` Referencia: ${orderId}.` : ""}`;
  const waUrl = `https://wa.me/${WHATSAPP_NUMBER}?text=${encodeURIComponent(waText)}`;

  const steps = [
    { icon: "📧", title: "Revisa tu correo", text: `Te enviaremos el enlace de acceso al correo con el que pagaste. Si no lo ves, revisa spam o promociones.` },
    { icon: "📅", title: "Aparta la fecha", text: `${mc.dateLabel} · ${mc.time} (${mc.timezone}). Agrégala a tu calendario para no olvidarla.` },
    { icon: "🎥", title: `${mc.modality}`, text: `Conéctate unos minutos antes. ${mc.recordingDays ? `Si no puedes asistir, tendrás la grabación durante ${mc.recordingDays} días.` : ""}` },
  ];

  return (
    <>
      <section className="mc-hero">
        <div className="container" style={{ padding: "64px 16px 72px", textAlign: "center", maxWidth: 760 }}>
          <div style={{ fontSize: "3rem", lineHeight: 1 }} aria-hidden="true">🎉</div>
          <p className="mc-label" style={{ color: "#8fd3f4", marginTop: 16 }}>Pago confirmado</p>
          <h1 style={{ marginTop: 8 }}>¡Felicitaciones! Ya eres parte de nuestra masterclass</h1>
          <p style={{ color: "#dce6f2", fontSize: "1.15rem", margin: "16px auto 0", maxWidth: 560 }}>
            Crianza digital segura · {mc.dateLabel} · {mc.time} ({mc.timezone})
          </p>
          <div className="row" style={{ justifyContent: "center", gap: 12, marginTop: 28, flexWrap: "wrap" }}>
            <a href={calendarUrl} target="_blank" rel="noopener noreferrer" className="btn btn-yellow" style={{ padding: "14px 26px", fontSize: "1.05rem" }}>
              Agregar a mi calendario
            </a>
            <a href={waUrl} target="_blank" rel="noopener noreferrer" className="btn btn-wa" style={{ padding: "14px 26px", fontSize: "1.05rem" }}>
              Escríbenos por WhatsApp
            </a>
          </div>
        </div>
      </section>

      <section className="mc-section">
        <div className="container" style={{ maxWidth: 960 }}>
          <p className="mc-label" style={{ textAlign: "center" }}>Próximos pasos</p>
          <h2 style={{ textAlign: "center", margin: "8px 0 32px" }}>Así te preparas para el {mc.shortDate}</h2>
          <div className="grid-3" style={{ display: "grid", gap: 18, gridTemplateColumns: "repeat(auto-fit, minmax(min(240px, 100%), 1fr))" }}>
            {steps.map((s) => (
              <div key={s.title} className="card stack" style={{ gap: 8 }}>
                <div style={{ fontSize: "2rem" }} aria-hidden="true">{s.icon}</div>
                <h3 style={{ margin: 0 }}>{s.title}</h3>
                <p className="muted" style={{ margin: 0 }}>{s.text}</p>
              </div>
            ))}
          </div>
          <div className="card" style={{ marginTop: 28, textAlign: "center", background: "var(--tint)" }}>
            <p style={{ margin: 0 }}>
              <strong>Mientras tanto:</strong> explora la <Link href="/herramientas">caja de herramientas</Link> y los{" "}
              <Link href="/juegos">juegos</Link> para la familia.
            </p>
          </div>
          <p className="small muted" style={{ textAlign: "center", marginTop: 24 }}>
            {orderId && <>Referencia de tu pago: {orderId} · </>}¿Dudas? Escríbenos a <a href={`mailto:${LEGAL.email}`}>{LEGAL.email}</a>.
          </p>
        </div>
      </section>
    </>
  );
}
