import type { Metadata } from "next";
import Link from "next/link";
import { SeatsBar } from "@/components/SeatsBar";
import { formatCop } from "@/lib/format";
import { getMasterclass, payLinkProvider } from "@/lib/masterclass";
import { getPricing } from "@/lib/pricing";
import { paypalClientId } from "@/lib/paypal";
import { boldEnabled } from "@/lib/bold";
import { BoldCheckoutButton } from "@/components/BoldCheckoutButton";
import { TEAM } from "@/lib/team";

export const dynamic = "force-dynamic";

export const metadata: Metadata = {
  title: "Masterclass Crianza digital segura",
  // Aún no se lanza: fuera de los buscadores hasta definir la fecha.
  robots: { index: false, follow: false },
  description:
    "Masterclass en vivo para familias con hijos de 3 a 17 años: riesgos reales por edad y configuración paso a paso de Roblox, Instagram, YouTube, WhatsApp y los celulares de tus hijos.",
};

const SITUATIONS = [
  { color: "var(--blue)", text: "Tu hijo de 8 años juega Roblox todas las tardes y habla con “amigos” que tú no conoces." },
  { color: "var(--yellow)", text: "Tu hija de 13 quiere Instagram y no sabes qué puede ver, quién le escribe ni cómo poner reglas sin pelear." },
  { color: "var(--red)", text: "El YouTube “para niños” de tu hijo de 5 años termina mostrando videos que nadie eligió." },
];

const RISKS = [
  "Ciberacoso",
  "Grooming",
  "Sextorsión",
  "Sexting",
  "Pornografía y contenido violento",
  "Material de abuso sexual infantil",
  "Retos virales, autolesiones y trastornos alimentarios",
  "Estafas, malware y robo de cuentas",
  "Apuestas, cajas de premio y casinos en línea",
  "IA: falsos desnudos, voces clonadas y “amigos” virtuales",
  "Huella digital y “sharenting”",
  "Uso problemático y diseño adictivo",
];

const AGENDA = [
  ["Apertura: la historia que nadie quiere vivir", "Un caso real compuesto y lo que revela un perfil “inocente”."],
  ["Los 12 riesgos que vamos a revisar", "Explicados con su solución, las 4C y el semáforo digital."],
  ["Pantallas, cuerpo y cerebro", "Sueño, visión, postura, desarrollo y salud mental."],
  ["El mapa del mundo digital de tus hijos", "Qué usan por edad, el diccionario para papás y el test de las 5 preguntas para evaluar cualquier app."],
  ["Crianza digital con disciplina positiva", "Acuerdos por edad, el primer celular y el contrato familiar."],
  ["Taller de controles parentales en vivo", "Android, iPhone, WhatsApp, Instagram, YouTube y Roblox, con tu celular en la mano."],
  ["Cuando el riesgo se materializa", "Señales de alarma, el protocolo P.A.R.A.R. y las rutas de ayuda."],
  ["Cierre: medición de madurez familiar", "Medimos en vivo qué tan protegida está tu familia y qué hacer primero."],
];

const KIT = [
  { icon: "📊", title: "Medición de madurez familiar en ciberseguridad", text: "En vivo: sabes dónde está tu familia y qué hacer primero.", highlight: true },
  { icon: "🎥", title: "Sesión en vivo", text: "Con especialistas en ciberseguridad y crianza." },
  { icon: "📘", title: "Guía maestra en PDF", text: "Paso a paso para proteger las diferentes plataformas de tu hijo." },
  { icon: "📝", title: "Contrato digital familiar", text: "Imprimible, para acordar reglas sin pelear." },
  { icon: "✅", title: "Checklist del primer celular", text: "Todo lo que debes revisar antes de entregarlo." },
  { icon: "🆘", title: "Tarjeta P.A.R.A.R.", text: "De bolsillo, con las rutas de ayuda." },
  { icon: "💬", title: "Preguntas para conversar", text: "Con tus hijos, según su edad." },
];

const PARAR = [
  ["P", "Pausa", "Respira antes de reaccionar: tu primera reacción decide si tu hijo vuelve a contarte."],
  ["A", "Acoger", "“Gracias por contarme. No es tu culpa. Lo vamos a resolver juntos.”"],
  ["R", "Registrar", "Capturas de mensajes, perfiles, usuarios y fechas."],
  ["A", "Asegurar", "Bloquear y reportar en la plataforma y cambiar contraseñas."],
  ["R", "Recurrir", "Autoridades, colegio y apoyo psicológico. No tienes que resolverlo solo."],
];


export default async function MasterclassPage() {
  const [mc, pricing] = await Promise.all([getMasterclass(), getPricing()]);
  const usd = mc.service?.priceUsd ?? 0;
  const cop = mc.service?.priceCop;
  // Con enlace de Mercado Pago se cobra un valor fijo en pesos: ese es el precio que se muestra.
  const price = mc.paymentLink && mc.paymentAmountCop ? formatCop(mc.paymentAmountCop) : pricing.price(usd, cop);
  const canBuy = !!mc.service?.active && !!usd && !mc.isPast;
  // Pago en dólares: la página de pago propia con tarjeta (integración de PayPal); sin credenciales de
  // PayPal, el enlace de pago de un botón de PayPal, si está configurado.
  const checkout = canBuy && !!mc.paypalAmountUsd && !!paypalClientId();
  const payLink = canBuy && !checkout && !!mc.paypalButtonId;
  const paypal = payLink || checkout || (canBuy && !!mc.usdLink);
  // Botones adicionales con la pasarela de Bold embebida (modal en el sitio), además de los enlaces de pago.
  const boldEmbedded = canBuy && boldEnabled();
  const copProvider = mc.paymentLink ? payLinkProvider(mc.paymentLink) : "Mercado Pago";
  const paypalHref = `https://www.paypal.com/ncp/payment/${mc.paypalButtonId}`;
  const paypalTestHref = canBuy && mc.paypalTestButtonId ? `https://www.paypal.com/ncp/payment/${mc.paypalTestButtonId}` : null;
  const PayPalLink = ({ className = "btn btn-yellow" }: { className?: string }) =>
    paypal ? (
      <a href={paypalHref} target="_blank" rel="noopener noreferrer" className={className}>Pagar en dólares</a>
    ) : null;
  const buyHref = mc.service ? `/checkout?servicio=${mc.service.slug}` : "/planes";
  // Con enlace de Mercado Pago el pago se hace allá, en otra pestaña.
  const BuyLink = ({ className, style, children }: { className: string; style?: React.CSSProperties; children: React.ReactNode }) =>
    mc.paymentLink ? (
      <a href={mc.paymentLink} target="_blank" rel="noopener noreferrer" className={className} style={style}>{children}</a>
    ) : (
      <Link href={buyHref} className={className} style={style}>{children}</Link>
    );
  const Reserve = ({ className = "btn btn-yellow", label = `Reservar mi cupo · ${price}` }: { className?: string; label?: string }) =>
    canBuy ? (
      <BuyLink className={className} style={{ fontSize: "1.05rem", padding: "14px 26px" }}>{label}</BuyLink>
    ) : (
      <span className="btn btn-ghost" aria-disabled>Inscripciones cerradas</span>
    );

  // Las dos formas de pago juntas (Colombia y exterior). Arriba y al final, en recuadros con el precio y el
  // botón de cada opción; en la tarjeta de precio, además el detalle de cada medio y los pagos de prueba.
  const PayOptions = ({ variant }: { variant: "hero" | "final" | "detail" }) => {
    if (!canBuy) return <Reserve />;
    const detail = variant === "detail";
    const hasTests = boldEmbedded && (!!mc.boldTestAmountCop || !!mc.boldTestAmountUsd);
    return (
      <div className={`mc-pay-wrap mc-pay-wrap-${variant}`}>
        <div className={`mc-pay mc-pay-${variant}${detail ? "" : " mc-pay-boxed"}`}>
          <div className="mc-pay-opt">
            <div className="mc-pay-head"><span aria-hidden>🇨🇴</span><span className="mc-pay-label">En Colombia</span></div>
            <div className="mc-pay-price">{price}<small>por persona</small></div>
            {boldEmbedded && !!mc.paymentAmountCop ? (
              <>
                {mc.paymentLink && <BuyLink className="btn btn-yellow">Pagar {price} · Link</BuyLink>}
                <BoldCheckoutButton currency="COP" label={`Pagar ${price} · API`} className="btn" />
              </>
            ) : (
              <Reserve className="btn btn-yellow" label="Reservar mi cupo" />
            )}
            <span className="mc-pay-help">💳 {copProvider === "Bold" ? "Tarjeta, PSE, Nequi y más" : "Tarjeta, PSE, Nequi o efectivo"}</span>
          </div>
          {paypal && (
            <div className="mc-pay-opt">
              <div className="mc-pay-head"><span aria-hidden>🌎</span><span className="mc-pay-label">Fuera de Colombia</span></div>
              <div className="mc-pay-price">USD {mc.paypalAmountUsd}<small>por persona</small></div>
              {mc.usdLink ? (
                <a href={mc.usdLink} target="_blank" rel="noopener noreferrer" className="btn btn-yellow">Pagar USD {mc.paypalAmountUsd} · Link</a>
              ) : checkout ? (
                <a href="/masterclass/pagar-dolares" target="_blank" rel="noopener" className="btn btn-yellow">Pagar en dólares</a>
              ) : (
                <PayPalLink />
              )}
              {boldEmbedded && !!mc.paypalAmountUsd && <BoldCheckoutButton currency="USD" label={`Pagar USD ${mc.paypalAmountUsd} · API`} className="btn" />}
              <span className="mc-pay-help">💳 {mc.usdLink ? "Tarjeta de crédito o débito internacional" : checkout ? "Tarjeta de crédito o débito, o PayPal" : "PayPal, Apple Pay o tarjeta internacional"}</span>
            </div>
          )}
        </div>
        <ul className="mc-trust">
          <li>🔒 Pago seguro con {copProvider}</li>
          <li>✉️ Acceso por correo</li>
          {mc.recordingDays > 0 && <li>🎥 Grabación por {mc.recordingDays} días</li>}
        </ul>
        {hasTests && (
          <div className="mc-pay-tests">
            <span className="mc-pay-tests-label">Zona de pruebas · no reserva cupo</span>
            <div className="mc-pay-tests-row">
              {!!mc.boldTestAmountCop && <BoldCheckoutButton currency="COP" test label={`Prueba ${formatCop(mc.boldTestAmountCop)} · API`} className="btn btn-red" />}
              {!!mc.boldTestAmountUsd && <BoldCheckoutButton currency="USD" test label={`Prueba USD ${mc.boldTestAmountUsd} · API`} className="btn btn-red" />}
            </div>
          </div>
        )}
      </div>
    );
  };

  const faqs = [
    ["¿Necesito saber de tecnología?", "No. Todo se explica en lenguaje sencillo y vamos configurando juntos, pantalla por pantalla."],
    ["¿Sirve si mis hijos tienen Android, iPhone o consola?", "Sí. Cubrimos Android, iPhone y computador, y te mostramos dónde están los controles en consolas y televisores."],
    ["Mi hijo tiene 4 años, ¿me sirve?", "Sí. La masterclass es para familias con hijos de 3 a 17 años; cada riesgo y cada ajuste se explica según la edad."],
    ["¿Queda grabada?", `Sí. La grabación queda disponible durante ${mc.recordingDays} días para quienes compraron su cupo.`],
    ["¿Cómo recibo el enlace?", "Después del pago te llega el enlace de conexión y el kit de materiales al correo con el que te registraste."],
    ["¿Pueden asistir los dos padres con un solo cupo?", "Sí, si se conectan juntos desde el mismo dispositivo. Si van a conectarse desde lugares distintos, cada uno necesita su cupo."],
    [
      "¿Puedo pagar desde otro país?",
      paypal
        ? `Sí. Desde fuera de Colombia pagas USD ${mc.paypalAmountUsd} con tarjeta internacional${mc.usdLink ? "" : " o PayPal"}. En Colombia pagas en pesos con ${copProvider}.`
        : "Sí. El precio base es en dólares; Mercado Pago cobra el equivalente en pesos colombianos y tu banco hace la conversión final.",
    ],
  ];

  return (
    <>
      {/* HERO */}
      <section className="mc-hero">
        <div className="container mc-hero-grid">
          <div className="stack" style={{ gap: 20 }}>
            <p className="mc-eyebrow">Masterclass en vivo · Familias con hijos de 3 a 17 años</p>
            <h1>Tus hijos ya están en Roblox, Instagram y YouTube. <span className="mc-accent">¿Sabes cómo protegerlos?</span></h1>
            <p className="mc-lead">
              En {mc.duration} entiendes los riesgos reales según la edad de tus hijos y sales con sus cuentas y dispositivos configurados,
              paso a paso y sin tecnicismos.
            </p>
            <div className="mc-facts">
              <span>📅 {mc.dateLabel}</span>
              <span>🕕 {mc.time} ({mc.timezone})</span>
              <span>💻 {mc.modality}</span>
            </div>
            <div className="mc-hero-ctas">
              <a href="#contenido" className="mc-link-light">Ver qué vas a aprender</a>
            </div>
          </div>
          <div className="mc-art" aria-hidden>
            <span className="b" style={{ right: 10, top: 0, width: 280, height: 280, background: "var(--blue)" }} />
            <span className="b" style={{ left: 30, top: 230, width: 110, height: 110, background: "var(--yellow)" }} />
            <span className="b" style={{ right: 0, bottom: 10, width: 84, height: 84, background: "var(--red)" }} />
            <div className="mc-bubbles">
              <div><strong>Roblox</strong>Un “amigo” del juego le pide pasar a otra app</div>
              <div style={{ marginLeft: 36 }}><strong>Instagram</strong>Mensajes directos de cuentas desconocidas</div>
              <div style={{ marginLeft: 72 }}><strong>YouTube</strong>Un video infantil que termina en contenido inapropiado</div>
            </div>
          </div>
        </div>
      </section>

      {/* KIT (fondo claro) */}
      <section className="mc-kit-section">
        <div className="container mc-kit">
          <div className="mc-kit-head">
            <p className="mc-label" style={{ color: "#8fd3f4" }}>Lo que te llevas</p>
            <h2>Tu kit incluye</h2>
          </div>
          <div className="mc-kit-grid">
            {KIT.map((k) => k.title === "Sesión en vivo" ? (
              <details key={k.title} className="mc-kit-item mc-kit-details" id="contenido">
                <summary>
                  <span className="mc-kit-icon" aria-hidden>{k.icon}</span>
                  <div>
                    <strong>{k.title}</strong>
                    <p>{k.text}</p>
                    <span className="mc-kit-more">Ver la agenda y el taller</span>
                  </div>
                </summary>
                <div className="mc-kit-panel">
                  <p className="mc-kit-panel-lead">Taller en vivo: configuramos juntos, con tu celular en la mano · {mc.duration} · {mc.dateLabel} · {mc.time}</p>
                  <div className="mc-chips">
                    {["Android", "iPhone", "WhatsApp", "Instagram", "YouTube", "Roblox", "TikTok"].map((c) => <span key={c}>{c}</span>)}
                  </div>
                  <ol className="mc-agenda">
                    {AGENDA.map(([t, d], i) => (
                      <li key={t}><span className="n">{i + 1}</span><span><strong>{t}.</strong> {d}</span></li>
                    ))}
                  </ol>
                </div>
              </details>
            ) : (
              <div key={k.title} className={`mc-kit-item${k.highlight ? " hl" : ""}`}>
                <span className="mc-kit-icon" aria-hidden>{k.icon}</span>
                <div>
                  <strong>{k.title}</strong>
                  {k.highlight && <span className="mc-kit-new">Nuevo</span>}
                  <p>{k.text}</p>
                </div>
              </div>
            ))}
            {mc.recordingDays > 0 && (
              <div className="mc-kit-item">
                <span className="mc-kit-icon" aria-hidden>⏺️</span>
                <div><strong>Grabación por {mc.recordingDays} días</strong><p>Por si no puedes asistir o quieres repasar.</p></div>
              </div>
            )}
          </div>
        </div>
      </section>

      {/* PRECIOS (franja oscura corta) */}
      <section className="mc-hero mc-pay-band">
        <div className="container mc-hero-pay" id="precio">
          <div className="mc-hero-pay-head">
            <div>
              <h2>Reserva tu cupo</h2>
              <p className="mc-hero-pay-sub">{mc.duration} hoy para dormir más tranquilo mañana.</p>
            </div>
            <span className="mc-urgency">🔥 {mc.seatsPct} % de cupos ocupados</span>
          </div>
          <PayOptions variant="hero" />
        </div>
      </section>

      {/* CUPOS */}
      <div className="container" style={{ marginTop: -28, position: "relative", zIndex: 2 }}>
        <SeatsBar pct={mc.seatsPct} />
      </div>

      {/* 12 RIESGOS */}
      <section className="mc-section tint" id="riesgos">
        <div className="container stack" style={{ gap: 24 }}>
          <div className="mc-head" style={{ marginBottom: 0 }}>
            <p className="mc-label">Los riesgos reales</p>
            <h2>Los 12 riesgos que vamos a revisar</h2>
            <p>Cada uno con su solución concreta: no venimos a asustarte, venimos a que salgas sabiendo qué hacer.</p>
          </div>
          <ol className="mc-risks" style={{ padding: 0, margin: 0 }}>
            {RISKS.map((r) => <li key={r}>{r}</li>)}
          </ol>
        </div>
      </section>

      {/* ¿TE SUENA? */}
      <section className="mc-section">
        <div className="container">
          <div className="mc-head"><h2>¿Te suena alguna de estas situaciones?</h2></div>
          <div className="grid grid-3">
            {SITUATIONS.map((s) => (
              <div key={s.text} className="mc-card stack" style={{ background: "var(--tint)", border: 0 }}>
                <span style={{ width: 14, height: 14, borderRadius: "50%", background: s.color, display: "block" }} />
                <p style={{ margin: 0, fontSize: "1.1rem" }}>{s.text}</p>
              </div>
            ))}
          </div>
          <p style={{ marginTop: 24, fontSize: "1.15rem", fontWeight: 800, color: "var(--navy)" }}>
            No necesitas ser experto en tecnología. Necesitas saber qué mirar y qué configurar.
          </p>
        </div>
      </section>

      {/* P.A.R.A.R. */}
      <section className="mc-section dark">
        <div className="container">
          <div className="mc-head">
            <p className="mc-label">Si algo pasa</p>
            <h2>El protocolo P.A.R.A.R.</h2>
            <p>Cinco pasos fáciles de recordar para los primeros minutos y horas. Te lo llevas impreso en la tarjeta de bolsillo.</p>
          </div>
          <div className="mc-parar">
            {PARAR.map(([l, t, d], i) => (
              <div key={i}><b>{l}</b><strong>{t}</strong><p>{d}</p></div>
            ))}
          </div>
        </div>
      </section>

      {/* EQUIPO */}
      <section className="mc-section">
        <div className="container">
          <div className="mc-head">
            <p className="mc-label">Quiénes dictan la masterclass</p>
            <h2>Somos el equipo Tecnofamilias</h2>
            <p>Tecnología y familia en la misma mesa: dictamos las charlas y creamos juntos cada contenido de Tecnofamilias.</p>
          </div>
          <div className="mc-team">
            {TEAM.map((t) => (
              <div key={t.name}>
                <img src={t.img} alt={t.name} width={150} height={150} />
                <h3>{t.name}</h3>
                <p className="small" style={{ margin: 0 }}>{t.bio}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* FAQ */}
      <section className="mc-section" id="preguntas">
        <div className="container mc-faq" style={{ maxWidth: 860 }}>
          <div className="mc-head"><h2>Preguntas frecuentes</h2></div>
          {faqs.map(([q, a]) => (
            <details key={q}><summary>{q}</summary><p>{a}</p></details>
          ))}
        </div>
      </section>

      {/* CTA FINAL */}
      <section className="mc-final">
        <div className="container" style={{ maxWidth: 980 }}>
          <div className="center" style={{ marginBottom: 22 }}>
            <h2 style={{ margin: 0, color: "var(--navy-dark)", fontSize: "clamp(1.6rem, 3.2vw, 2.3rem)", fontWeight: 900 }}>
              {mc.duration} hoy para dormir más tranquilo mañana.
            </h2>
            <p style={{ margin: "8px 0 0", color: "var(--navy-dark)", fontWeight: 700 }}>
              🔥 {mc.seatsPct} % de cupos ocupados · {mc.dateLabel}
            </p>
          </div>
          <PayOptions variant="final" />
          <p className="small center" style={{ margin: "18px 0 0", color: "var(--navy-dark)" }}>
            ¿Colegio, empresa o entidad pública? <Link href="/planes#servicios" style={{ fontWeight: 800, color: "var(--navy-dark)" }}>Pide una propuesta institucional</Link>
          </p>
        </div>
      </section>

      {canBuy && (
        <div className="mc-sticky">
          <div className="container row between" style={{ flexWrap: "nowrap" }}>
            <span className="small"><strong>{mc.shortDate}</strong> · {mc.seatsPct} % ocupado</span>
            <a href="#precio" className="btn btn-yellow btn-sm" style={{ color: "var(--navy-dark)" }}>Reservar mi cupo</a>
          </div>
        </div>
      )}
    </>
  );
}
