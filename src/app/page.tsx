import Link from "next/link";
import { PlanCards } from "@/components/PlanCards";
import { getCurrentUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { AGE_STAGES } from "@/lib/format";

export const dynamic = "force-dynamic";

const PILLARS = [
  {
    href: "/clases",
    icon: "▶",
    color: "var(--blue)",
    title: "Clases pregrabadas",
    text: "Masterclass por edad para configurar dispositivos y actuar ante grooming, sexting o ciberacoso. Toda la base incluida en tu suscripción.",
  },
  {
    href: "/recursos",
    icon: "🎧",
    color: "var(--yellow)",
    title: "Videos y podcasts",
    text: "Una selección curada de contenidos para ver y escuchar en familia, organizada por etapa.",
  },
  {
    href: "/pactos",
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
    icon: "💬",
    color: "var(--navy-soft)",
    title: "Comunidad de apoyo",
    text: "Un foro moderado para preguntar, compartir experiencias y apoyarse entre familias.",
  },
];

export default async function Home() {
  const user = await getCurrentUser();
  // Con sesión iniciada la sección de planes ya no se muestra.
  const plans = user ? [] : await db.plan.findMany({ where: { active: true }, orderBy: { order: "asc" } });
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
              Aprende a poner reglas sin pelear, configura los dispositivos de tus hijos y sabe qué hacer si alguien
              los contacta. Todo en una sola plataforma.
            </p>
            <div className="row" style={{ marginTop: 24 }}>
              {user ? (
                <>
                  <Link href="/clases" className="btn btn-yellow">Ir a mis clases</Link>
                  <Link href="/juegos" className="btn btn-light">Jugar en familia</Link>
                </>
              ) : (
                <>
                  <Link href="/planes" className="btn btn-yellow">Ver planes</Link>
                  <Link href="/clases" className="btn btn-light">Explorar clases</Link>
                </>
              )}
            </div>
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
              <Link key={p.href} href={p.href} className="card card-link stack">
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
              <Link key={s.value} href={`/clases?etapa=${s.value}`} className="card card-tint card-link">
                <span className="icon-dot" style={{ background: ["var(--blue)", "var(--yellow)", "var(--red)", "var(--navy)"][i], marginBottom: 12 }}>
                  {i + 1}
                </span>
                <h3>{s.label.split(" · ")[0]}</h3>
                <div className="badge" style={{ marginBottom: 8 }}>{s.label.split(" · ")[1]}</div>
                <p className="muted small" style={{ margin: 0 }}>{s.hint}</p>
              </Link>
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
