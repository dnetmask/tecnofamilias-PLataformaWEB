import Link from "next/link";
import { PlanCards } from "@/components/PlanCards";
import { getCurrentUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { MemberHome } from "./MemberHome";
import { AGE_STAGES } from "@/lib/format";
import { MasterclassPromo } from "@/components/MasterclassPromo";
import { isPlatformOpen } from "@/lib/launch";
import { SITE_URL } from "@/lib/site";
import { JsonLd } from "@/components/JsonLd";

export const dynamic = "force-dynamic";
export const metadata = { alternates: { canonical: SITE_URL } };

// `auth`: para visitantes sin sesión el enlace lleva a Planes.
const PILLARS = [
  {
    href: "/clases",
    auth: true,
    icon: "▶",
    color: "var(--blue)",
    title: "Clases pregrabadas",
    text: "Masterclass por edad para configurar dispositivos y actuar ante grooming, sexting o ciberacoso. Toda la base incluida en tu suscripción.",
  },
  {
    href: "/herramientas",
    icon: "🧰",
    color: "var(--yellow)",
    title: "Caja de herramientas",
    text: "Videos, podcasts, libros, guías, documentos, apps y equipos que revisamos y recomendamos, organizados por etapa.",
  },
  {
    href: "/pactos",
    auth: true,
    icon: "✍",
    color: "var(--red)",
    title: "Pactos por aplicación",
    text: "Acuerdos claros para Roblox, TikTok, WhatsApp y más. Los firman tú y tus hijos desde el celular.",
  },
  {
    href: "/juegos",
    icon: "🃏",
    color: "var(--blue-dark)",
    title: "Juegos en familia",
    text: "Juegos como Modo Familia para conversar de pantallas, redes y emociones entre risas y retos.",
  },
  {
    href: "/comunidad",
    auth: true,
    icon: "💬",
    color: "var(--navy-soft)",
    title: "Comunidad de apoyo",
    text: "Un foro moderado para preguntar, compartir experiencias y apoyarse entre familias.",
  },
];

// Preguntas frecuentes del inicio: visibles para las familias y marcadas como FAQPage para buscadores e IA.
function homeFaq(platformOpen: boolean): [string, string][] {
  return [
    ["¿Qué es Tecnofamilias?", "Tecnofamilias es una iniciativa colombiana de especialistas en ciberseguridad y padres de familia que ayuda a las familias de habla hispana a proteger a sus hijos en internet: control parental, prevención de riesgos como el grooming y el ciberacoso, y acuerdos familiares sobre el uso de la tecnología."],
    ["¿Qué puedo usar gratis?", "Sin crear cuenta puedes jugar Farmea aura, un juego para conversar en familia sobre la vida digital, y usar las herramientas de libre acceso de la Caja de herramientas: videos, podcasts y apps de control parental que el equipo revisó y recomienda."],
    ["¿Cómo funciona la asesoría personalizada?", "Es un mes de acompañamiento uno a uno para tu hogar: dos sesiones virtuales con un experto, un informe con el diagnóstico de los dispositivos y hábitos de tu familia y soporte por WhatsApp. Escríbenos por WhatsApp y agendamos la primera sesión."],
    ["¿Trabajan con colegios, empresas y entidades públicas?", "Sí. Tenemos charlas y programas anuales de seguridad digital para padres, docentes y estudiantes, programas de bienestar digital para empresas y programas sociales para alcaldías y gobernaciones."],
    ["¿Atienden familias fuera de Colombia?", "Sí. Las asesorías y charlas son virtuales, así que acompañamos familias en cualquier país de habla hispana, incluido Estados Unidos. Los precios se muestran en dólares, pesos colombianos, pesos mexicanos y soles."],
    ...(platformOpen ? [] : [["¿Cuándo abre la plataforma de suscripción?", "Muy pronto. Estamos preparando las clases por edad, los pactos digitales y la comunidad. Mientras tanto, el juego y las herramientas gratuitas ya están disponibles."] as [string, string]]),
  ];
}

export default async function Home() {
  const user = await getCurrentUser();
  // Con sesión iniciada se muestra un inicio orientado a usar el contenido.
  if (user) return <MemberHome user={user} />;
  const [plans, freeGame, freeTools, open] = await Promise.all([
    db.plan.findMany({ where: { active: true }, orderBy: { order: "asc" } }),
    db.game.findFirst({ where: { free: true, published: true }, orderBy: { order: "asc" }, select: { slug: true, title: true, emoji: true, color: true, description: true } }),
    db.resource.count({ where: { published: true, access: { in: ["FREE", "EXTERNAL"] } } }),
    isPlatformOpen(),
  ]);
  return (
    <>
      <section className="hero">
        <span className="bubble b1" />
        <span className="bubble b2" />
        <span className="bubble b3" />
        <div className="container">
          <div className="hero-inner">
            <h1>Protege a tu familia en el mundo digital</h1>
            <p>
              Aprende a poner reglas sin pelear, configura los dispositivos de tus hijos y ten claro qué hacer si alguien
              los contacta. Todo en una sola plataforma.
            </p>
            <div className="row" style={{ marginTop: 24 }}>
              <Link href="/planes" className="btn btn-yellow">Ver planes</Link>
              {freeGame && <Link href={`/juegos/${freeGame.slug}`} className="btn btn-light">🎮 Juega gratis</Link>}
            </div>
          </div>
        </div>
      </section>

      <MasterclassPromo />

      <section className="section free-start">
        <div className="container">
          <h2 className="center">Empieza gratis, sin crear cuenta</h2>
          <p className="muted center" style={{ maxWidth: 620, margin: "0 auto 28px" }}>
            Prueba con tu familia un juego y las herramientas que recomendamos. Cuando quieras más, la suscripción desbloquea todo.
          </p>
          <div className="grid grid-2 free-grid">
            {freeGame && (
              <Link href={`/juegos/${freeGame.slug}`} className="card card-link free-card">
                <span className="icon-dot" style={{ background: freeGame.color, width: 64, height: 64, fontSize: "2rem" }}>{freeGame.emoji}</span>
                <div className="stack" style={{ gap: 6, minWidth: 0 }}>
                  <span className="badge badge-green" style={{ alignSelf: "flex-start" }}>Juego gratis</span>
                  <h3 style={{ margin: 0 }}>{freeGame.title}</h3>
                  <p className="muted small free-desc" style={{ margin: 0 }}>{freeGame.description}</p>
                  <span className="btn btn-yellow btn-sm" style={{ alignSelf: "flex-start", marginTop: 6 }}>Jugar ahora</span>
                </div>
              </Link>
            )}
            <Link href="/herramientas" className="card card-link free-card">
              <span className="icon-dot" style={{ background: "var(--yellow)", width: 64, height: 64, fontSize: "2rem" }}>🧰</span>
              <div className="stack" style={{ gap: 6, minWidth: 0 }}>
                <span className="badge badge-green" style={{ alignSelf: "flex-start" }}>Contenido gratuito</span>
                <h3 style={{ margin: 0 }}>Caja de herramientas</h3>
                <p className="muted small" style={{ margin: 0 }}>
                  Videos, podcasts, guías, apps y equipos que revisamos y recomendamos por etapa.
                  {freeTools > 0 ? ` ${freeTools === 1 ? "Una herramienta es" : `${freeTools} herramientas son`} de libre acceso.` : " Las de libre acceso las usas sin cuenta."}
                </p>
                <span className="btn btn-sm" style={{ alignSelf: "flex-start", marginTop: 6 }}>Explorar herramientas</span>
              </div>
            </Link>
          </div>
        </div>
      </section>

      <section className="section">
        <div className="container">
          <h2 className="center">Todo lo que tu familia necesita</h2>
          <p className="muted center" style={{ maxWidth: 620, margin: "0 auto 32px" }}>
            Contenido creado por especialistas en ciberseguridad y familias que viven los mismos retos que tú.
          </p>
          <div className="grid grid-4">
            {PILLARS.map((p) => (
              <Link key={p.href} href={p.auth ? "/planes" : p.href} className="card card-link stack">
                <span className="icon-dot" style={{ background: p.color }}>{p.icon}</span>
                <h3>{p.title}</h3>
                <p className="muted small" style={{ margin: 0 }}>{p.text}</p>
              </Link>
            ))}
          </div>
        </div>
      </section>

      <section className="section" style={{ background: "#fff" }}>
        <div className="container">
          <h2>Contenido para cada etapa</h2>
          <p className="muted">Cada vez que tu hijo cambia de etapa, aparece una plataforma o un riesgo nuevo.</p>
          <div className="grid grid-4" style={{ marginTop: 24 }}>
            {AGE_STAGES.filter((s) => s.value !== "ALL").map((s, i) => (
              <div key={s.value} className="card card-tint">
                <span className="icon-dot" style={{ background: ["var(--blue)", "var(--yellow)", "var(--red)", "var(--navy)"][i], marginBottom: 12 }}>
                  {i + 1}
                </span>
                <h3>{s.label.split(" · ")[0]}</h3>
                <div className="badge" style={{ marginBottom: 8 }}>{s.label.split(" · ")[1]}</div>
                <p className="muted small" style={{ margin: 0 }}>{s.hint}</p>
              </div>
            ))}
          </div>
          <div className="row center-row" style={{ marginTop: 28 }}>
            {open ? (
              <>
                <p style={{ margin: 0, fontWeight: 700, color: "var(--navy)" }}>Las clases de cada etapa están incluidas en la suscripción.</p>
                <Link href="/planes" className="btn btn-yellow">Suscribirme para verlas</Link>
              </>
            ) : (
              <>
                <span className="badge badge-yellow">Próximamente</span>
                <p style={{ margin: 0, fontWeight: 700, color: "var(--navy)" }}>Las clases de cada etapa llegan muy pronto con la suscripción.</p>
              </>
            )}
          </div>
        </div>
      </section>

      <section className="section faq-home">
        <div className="container" style={{ maxWidth: 820 }}>
          <JsonLd
            data={{
              "@context": "https://schema.org",
              "@type": "FAQPage",
              mainEntity: homeFaq(open).map(([q, a]) => ({ "@type": "Question", name: q, acceptedAnswer: { "@type": "Answer", text: a } })),
            }}
          />
          <h2 className="center">Preguntas frecuentes</h2>
          <div className="faq">
            {homeFaq(open).map(([q, a]) => (
              <details key={q}>
                <summary>{q}</summary>
                <p>{a}</p>
              </details>
            ))}
          </div>
        </div>
      </section>

      {plans.length > 0 && (
        <section className="section">
          <div className="container">
            <h2 className="center">Planes de suscripción</h2>
            <p className="muted center" style={{ marginBottom: 32 }}>Todo el contenido base está incluido. Algunos cursos especializados se suman como complemento.</p>
            <PlanCards plans={plans} />
          </div>
        </section>
      )}
    </>
  );
}
