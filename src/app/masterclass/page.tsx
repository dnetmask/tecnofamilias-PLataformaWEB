import type { Metadata } from "next";
import Link from "next/link";
import { CurrencySwitcher } from "@/components/CurrencySwitcher";
import { SeatsBar } from "@/components/SeatsBar";
import { formatCop } from "@/lib/format";
import { getMasterclass } from "@/lib/masterclass";
import { getPricing } from "@/lib/pricing";
import { TEAM } from "@/lib/team";

export const dynamic = "force-dynamic";

export const metadata: Metadata = {
  title: "Masterclass Crianza digital segura",
  description:
    "Masterclass en vivo para familias con hijos de 3 a 17 años: riesgos reales por edad y configuración paso a paso de Roblox, Instagram, YouTube, WhatsApp y los celulares de tus hijos.",
};

const SITUATIONS = [
  { color: "var(--blue)", text: "Tu hijo de 8 años juega Roblox todas las tardes y habla con “amigos” que tú no conoces." },
  { color: "var(--yellow)", text: "Tu hija de 13 quiere Instagram y no sabes qué puede ver, quién le escribe ni cómo poner reglas sin pelear." },
  { color: "var(--red)", text: "El YouTube “para niños” de tu hijo de 5 años termina mostrando videos que nadie eligió." },
];

const C4 = [
  { letter: "C", color: "var(--blue)", title: "Contenido", text: "Lo que ven: violencia, pornografía, retos peligrosos que llegan por recomendación, no porque lo buscaron." },
  { letter: "C", color: "var(--red)", title: "Contacto", text: "Quién les habla: adultos que se hacen pasar por niños para ganarse su confianza." },
  { letter: "C", color: "var(--yellow)", title: "Conducta", text: "Lo que hacen ellos o sus pares: ciberacoso, sexting, exponer a otros." },
  { letter: "C", color: "var(--navy-soft)", title: "Contrato y comercio", text: "Dinero y datos: estafas, robo de cuentas, cajas de premio y apuestas." },
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

const AGES = [
  { range: "0 a 5 años", tag: "Inicio digital", color: "var(--yellow)", uses: "Videos, dibujos animados y juegos simples en la tablet de los papás.", key: "El riesgo principal es para el desarrollo: lenguaje, sueño y atención." },
  { range: "6 a 9 años", tag: "El auge del juego", color: "var(--blue)", uses: "Roblox, Minecraft, Brawl Stars, YouTube, tablet o consola propia.", key: "Primer contacto con chats, compras dentro del juego y desconocidos." },
  { range: "10 a 12 años", tag: "El móvil propio", color: "var(--red)", uses: "WhatsApp (grupos del colegio), TikTok, Free Fire, Fortnite, Discord.", key: "La edad de mayor riesgo de grooming y de mentir sobre la edad." },
  { range: "13 a 17 años", tag: "Socialización intensa", color: "#fff", uses: "Instagram, Snapchat, TikTok, WhatsApp, Twitch, chatbots de IA.", key: "Sexting, sextorsión, comparación social, apuestas y autonomía." },
];

const PLATFORMS = [
  {
    name: "Proteger Roblox",
    who: "Ideal de 6 a 12 años",
    bg: "#EEF6FC",
    color: "var(--blue)",
    items: [
      "Cuenta de padre vinculada y controles parentales con PIN",
      "Chat limitado o desactivado según la edad",
      "Límites de gasto y alertas de compras de Robux",
      "Filtro de madurez de las experiencias",
      "Señal de alerta: cuando un “amigo” pide pasar a otra app",
    ],
  },
  {
    name: "Proteger Instagram",
    who: "Ideal de 13 a 17 años",
    bg: "#FFF6DE",
    color: "var(--yellow)",
    items: [
      "Cuenta privada y cuenta de adolescente",
      "Supervisión familiar desde tu propio Instagram",
      "Quién puede escribirle, etiquetarlo y mencionarlo",
      "Límites de tiempo y modo descanso en la noche",
      "Cómo reportar y bloquear sin empeorar el problema",
    ],
  },
  {
    name: "Proteger YouTube",
    who: "De 3 a 17 años",
    bg: "#FDECEA",
    color: "var(--red)",
    items: [
      "YouTube Kids con el nivel de contenido según la edad",
      "Cuenta supervisada para preadolescentes",
      "Modo restringido en celular, TV y computador",
      "Historial, búsquedas y canales bloqueados",
      "Reproducción automática apagada",
    ],
  },
];

const LAYERS = [
  ["1", "La red de la casa", "Filtro DNS en el router: protege todos los equipos del wifi, incluidos televisores y consolas."],
  ["2", "El dispositivo", "Family Link en Android y Tiempo de uso en iPhone: tiempo, apps, compras y contenido web."],
  ["3", "Cada app", "Chat, contacto y contenido dentro de WhatsApp, Instagram, TikTok, YouTube y Roblox."],
  ["4", "Las cuentas", "Edad real, contraseñas fuertes, verificación en dos pasos y correo de recuperación del adulto."],
  ["5", "La conversación", "La única capa que funciona en todas las apps, en todos los dispositivos y fuera de casa."],
];

const AGENDA = [
  ["Apertura: la historia que nadie quiere vivir", "Un caso real compuesto y lo que revela un perfil “inocente”."],
  ["El mapa del mundo digital de tus hijos", "Qué usan por edad, el diccionario para papás y el test de las 5 preguntas para evaluar cualquier app."],
  ["Los riesgos reales", "Las 4C, doce riesgos explicados con su solución y el semáforo digital."],
  ["Pantallas, cuerpo y cerebro", "Sueño, visión, postura, desarrollo y salud mental."],
  ["Crianza digital con disciplina positiva", "Acuerdos por edad, el primer celular y el contrato familiar."],
  ["Taller de controles parentales en vivo", "Android, iPhone, WhatsApp, Instagram, YouTube y Roblox, con tu celular en la mano."],
  ["Cuando el riesgo se materializa", "Señales de alarma, el protocolo P.A.R.A.R. y las rutas de ayuda."],
  ["Cierre y plan de 7 días", "Cómo convertir lo aprendido en acciones esta misma semana."],
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
  const price = pricing.price(usd, cop);
  const canBuy = !!mc.service?.active && !!usd && !mc.isPast;
  const buyHref = mc.service ? `/checkout?servicio=${mc.service.slug}` : "/planes";
  const Reserve = ({ className = "btn btn-yellow", label = `Reservar mi cupo · ${price}` }: { className?: string; label?: string }) =>
    canBuy ? (
      <Link href={buyHref} className={className} style={{ fontSize: "1.05rem", padding: "14px 26px" }}>{label}</Link>
    ) : (
      <span className="btn btn-ghost" aria-disabled>Inscripciones cerradas</span>
    );

  const faqs = [
    ["¿Necesito saber de tecnología?", "No. Todo se explica en lenguaje sencillo y vamos configurando juntos, pantalla por pantalla."],
    ["¿Sirve si mis hijos tienen Android, iPhone o consola?", "Sí. Cubrimos Android, iPhone y computador, y te mostramos dónde están los controles en consolas y televisores."],
    ["Mi hijo tiene 4 años, ¿me sirve?", "Sí. La masterclass es para familias con hijos de 3 a 17 años; cada riesgo y cada ajuste se explica según la edad."],
    ["¿Queda grabada?", `Sí. La grabación queda disponible durante ${mc.recordingDays} días para quienes compraron su cupo.`],
    ["¿Cómo recibo el enlace?", "Después del pago te llega el enlace de conexión y el kit de materiales al correo con el que te registraste."],
    ["¿Pueden asistir los dos padres con un solo cupo?", "Sí, si se conectan juntos desde el mismo dispositivo. Si van a conectarse desde lugares distintos, cada uno necesita su cupo."],
    ["¿Puedo pagar desde otro país?", "Sí. El precio base es en dólares; Mercado Pago cobra el equivalente en pesos colombianos y tu banco hace la conversión final."],
  ];

  return (
    <>
      {/* HERO */}
      <section className="mc-hero">
        <div className="container mc-hero-grid">
          <div className="stack" style={{ gap: 20 }}>
            <p className="mc-eyebrow">Masterclass en vivo · Familias con hijos de 3 a 17 años</p>
            <h1>Tus hijos ya están en Roblox, Instagram y YouTube. ¿Sabes cómo protegerlos?</h1>
            <p className="mc-lead">
              En {mc.duration} entiendes los riesgos reales según la edad de tus hijos y sales con sus cuentas y dispositivos configurados,
              paso a paso y sin tecnicismos.
            </p>
            <div className="mc-facts">
              <span>📅 {mc.dateLabel}</span>
              <span>🕕 {mc.time} ({mc.timezone})</span>
              <span>💻 {mc.modality}</span>
            </div>
            <div className="row" style={{ gap: 16 }}>
              <Reserve />
              <a href="#contenido" style={{ color: "#fff", fontWeight: 700 }}>Ver qué vas a aprender</a>
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

      {/* CUPOS */}
      <div className="container" style={{ marginTop: -28, position: "relative", zIndex: 2 }}>
        <SeatsBar pct={mc.seatsPct} />
      </div>

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

      {/* RIESGOS: 4C + 12 */}
      <section className="mc-section tint" id="riesgos">
        <div className="container stack" style={{ gap: 28 }}>
          <div className="mc-head" style={{ marginBottom: 0 }}>
            <p className="mc-label">Los riesgos reales</p>
            <h2>Las 4C: explicadas en lenguaje de papá y mamá</h2>
            <p>Cada riesgo se cierra con su solución concreta: no venimos a asustarte, venimos a que salgas sabiendo qué hacer.</p>
          </div>
          <div className="mc-c4">
            {C4.map((c) => (
              <div key={c.title} className="mc-card">
                <h3><span className="letter" style={{ background: c.color, color: c.color === "var(--yellow)" ? "var(--navy-dark)" : "#fff" }}>{c.letter}</span>{c.title}</h3>
                <p className="muted" style={{ margin: 0 }}>{c.text}</p>
              </div>
            ))}
          </div>
          <div>
            <h3>Los 12 riesgos que vamos a revisar, cada uno con su solución</h3>
            <ol className="mc-risks" style={{ padding: 0, margin: 0 }}>
              {RISKS.map((r) => <li key={r}>{r}</li>)}
            </ol>
          </div>
        </div>
      </section>

      {/* POR EDAD */}
      <section className="mc-section dark">
        <div className="container">
          <div className="mc-head">
            <p className="mc-label">La línea de vida digital</p>
            <h2>Cada edad tiene sus propios riesgos</h2>
          </div>
          <div className="grid grid-4">
            {AGES.map((a) => (
              <div key={a.range} className="mc-age">
                <span style={{ width: 40, height: 40, borderRadius: "50%", background: a.color, display: "block" }} />
                <h3>{a.range}</h3>
                <span className="tag" style={{ color: a.color === "#fff" ? "#fff" : a.color }}>{a.tag}</span>
                <p><strong style={{ color: "#fff" }}>Usan:</strong> {a.uses}</p>
                <p>{a.key}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* PLATAFORMAS + CAPAS */}
      <section className="mc-section" id="contenido">
        <div className="container stack" style={{ gap: 28 }}>
          <div className="mc-head" style={{ marginBottom: 0 }}>
            <p className="mc-label">Taller en vivo</p>
            <h2>Configuramos juntos, con tu celular en la mano</h2>
            <p>Además de Android, iPhone y WhatsApp, estas son las plataformas que más usan tus hijos:</p>
          </div>
          <div className="grid grid-3">
            {PLATFORMS.map((p) => (
              <article key={p.name} className="mc-platform" style={{ background: p.bg }}>
                <div className="row">
                  <span className="icon-dot" style={{ background: p.color, width: 52, height: 52 }}>{p.name.includes("Roblox") ? "🎮" : p.name.includes("Instagram") ? "📷" : "▶"}</span>
                  <div>
                    <h3 style={{ margin: 0, fontSize: "1.35rem" }}>{p.name}</h3>
                    <span className="small muted">{p.who}</span>
                  </div>
                </div>
                <ul>{p.items.map((i) => <li key={i}>{i}</li>)}</ul>
              </article>
            ))}
          </div>
          <div className="mc-card" style={{ background: "var(--tint)", border: 0 }}>
            <h3>La protección funciona en capas</h3>
            <p className="muted" style={{ marginTop: 0 }}>Ningún control es perfecto. Lo que funciona es combinar capas, de modo que si una falla, otra protege.</p>
            <div className="grid grid-3" style={{ gap: 12 }}>
              {LAYERS.map(([n, t, d]) => (
                <div key={n} className="row" style={{ alignItems: "flex-start", flexWrap: "nowrap" }}>
                  <span className="icon-dot" style={{ background: "var(--navy)", width: 34, height: 34, fontSize: ".95rem", flex: "none" }}>{n}</span>
                  <div><strong style={{ color: "var(--navy)" }}>{t}</strong><div className="small muted">{d}</div></div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </section>

      {/* AGENDA + INCLUYE */}
      <section className="mc-section tint">
        <div className="container layout-aside">
          <div>
            <div className="mc-head"><h2>Así es la masterclass</h2><p>{mc.duration} en vivo · {mc.dateLabel} · {mc.time}</p></div>
            <ol className="mc-agenda">
              {AGENDA.map(([t, d], i) => (
                <li key={t}><span className="n">{i + 1}</span><span><strong>{t}.</strong> {d}</span></li>
              ))}
            </ol>
          </div>
          <aside className="mc-card stack">
            <h3 style={{ margin: 0 }}>Tu kit incluye</h3>
            <ul style={{ margin: 0, paddingLeft: 20, display: "grid", gap: 8 }}>
              <li>Sesión en vivo con especialistas en ciberseguridad y crianza</li>
              <li>Guía maestra “Crianza digital segura” en PDF</li>
              <li>Contrato digital familiar imprimible</li>
              <li>Checklist “antes del primer celular”</li>
              <li>Tarjeta de bolsillo P.A.R.A.R. con rutas de ayuda</li>
              <li>Preguntas para conversar con tus hijos según su edad</li>
              <li>Plan de 7 días para aplicar lo aprendido</li>
              <li>Grabación disponible durante {mc.recordingDays} días</li>
            </ul>
            <Reserve className="btn btn-red" label={`Reservar · ${price}`} />
          </aside>
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

      {/* PRECIO */}
      <section className="mc-section dark" id="precio">
        <div className="container stack" style={{ gap: 24 }}>
          <h2 className="center" style={{ margin: 0 }}>Reserva tu cupo</h2>
          <div style={{ maxWidth: 760, margin: "0 auto", width: "100%" }}><SeatsBar pct={mc.seatsPct} /></div>
          <div className="mc-price">
            <span className="mc-label">Familias con hijos de 3 a 17 años</span>
            <h3 style={{ margin: 0, fontSize: "1.7rem" }}>Masterclass: Crianza digital segura</h3>
            <div>
              <span className="price" style={{ fontSize: "2.6rem" }}>{price}</span> <span className="muted">por persona</span>
              {usd > 0 && <div className="small muted">Se cobra hoy {formatCop(pricing.charge(usd, cop))} · precio base USD {usd}</div>}
            </div>
            <CurrencySwitcher current={pricing.currency} />
            <ul style={{ margin: 0, paddingLeft: 20, display: "grid", gap: 6 }}>
              <li>{mc.dateLabel} · {mc.time} ({mc.timezone})</li>
              <li>{mc.modality} · {mc.duration}</li>
              <li>Taller en vivo de controles parentales</li>
              <li>Kit completo de materiales y grabación por {mc.recordingDays} días</li>
            </ul>
            <Reserve className="btn btn-yellow" label="Reservar mi cupo" />
            <p className="small muted center" style={{ margin: 0 }}>Pago seguro con Mercado Pago (tarjeta, PSE, Nequi y efectivo).</p>
          </div>
          <p className="center small" style={{ color: "#dce6f2", margin: 0 }}>
            ¿Colegio, empresa o entidad pública? <Link href="/servicios" style={{ color: "#fff", fontWeight: 800 }}>Pide una propuesta institucional</Link>
          </p>
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
        <div className="container row between" style={{ gap: 20 }}>
          <h2 style={{ margin: 0, color: "var(--navy-dark)", flex: "1 1 420px" }}>{mc.duration} hoy para dormir más tranquilo mañana.</h2>
          <Reserve className="btn" label={`Reservar mi cupo · ${price}`} />
        </div>
      </section>

      {canBuy && (
        <div className="mc-sticky">
          <div className="container row between" style={{ flexWrap: "nowrap" }}>
            <span className="small"><strong>{mc.shortDate}</strong> · {mc.seatsPct} % ocupado</span>
            <Link href={buyHref} className="btn btn-yellow btn-sm" style={{ color: "var(--navy-dark)" }}>Reservar · {price}</Link>
          </div>
        </div>
      )}
    </>
  );
}
