import type { Metadata } from "next";
import Link from "next/link";
import { getCurrentUser } from "@/lib/auth";
import { TEAM } from "@/lib/team";
import { pageMeta, SITE_URL } from "@/lib/site";
import { JsonLd } from "@/components/JsonLd";

export const metadata: Metadata = pageMeta(
  "/quienes-somos",
  "Quiénes somos: especialistas en ciberseguridad y padres de familia",
  "El equipo Tecnofamilias: especialistas en tecnología y ciberseguridad, y papás y mamás, que ayudan a las familias a proteger a sus hijos en el mundo digital.",
);

const WHATSAPP = "https://wa.me/573138743101";

const VALUES = [
  { icon: "💬", color: "var(--blue)", title: "Lenguaje de papá y mamá", text: "Explicamos la tecnología sin tecnicismos, con ejemplos de la vida real de una familia." },
  { icon: "🛠", color: "var(--yellow)", title: "Cada riesgo con su solución", text: "No venimos a asustar: cada riesgo que mostramos viene con el paso a paso para prevenirlo." },
  { icon: "🌱", color: "var(--red)", title: "Según la edad", text: "Lo que necesita un niño de 5 años no es lo que necesita un adolescente de 15." },
  { icon: "🤝", color: "var(--navy-soft)", title: "Acompañar, no vigilar", text: "Reglas acordadas y conversación en casa: la única protección que funciona en todas partes." },
];

const OFFER = [
  { href: "/clases", title: "Plataforma web", text: "Clases pregrabadas, guías, pactos para firmar con tus hijos, juegos y una comunidad de familias." },
  { href: "/servicios/asesoria-personalizada", title: "Asesoría personalizada", text: "Un mes de acompañamiento para tu hogar: diagnóstico, configuración y seguimiento." },
  { href: "/planes#servicios", title: "Colegios, empresas y entidades", text: "Programas para padres, docentes, estudiantes y empleados, y programas sociales con alcaldías y gobernaciones." },
];

export default async function AboutPage() {
  const user = await getCurrentUser();
  return (
    <>
      <JsonLd
        data={{
          "@context": "https://schema.org",
          "@graph": [
            { "@type": "AboutPage", url: `${SITE_URL}/quienes-somos`, name: "Quiénes somos", about: { "@id": `${SITE_URL}/#organization` }, inLanguage: "es" },
            ...TEAM.map((t) => ({
              "@type": "Person",
              name: t.name,
              description: t.bio,
              image: `${SITE_URL}${t.img}`,
              worksFor: { "@id": `${SITE_URL}/#organization` },
            })),
          ],
        }}
      />
      <section className="hero">
        <span className="bubble b1" />
        <span className="bubble b2" />
        <span className="bubble b3" />
        <div className="container">
          <div className="hero-inner">
            <p className="mc-label" style={{ color: "var(--yellow)" }}>Quiénes somos</p>
            <h1>Protegemos a las familias en el mundo digital</h1>
            <p>
              Somos el equipo Tecnofamilias: especialistas en tecnología y ciberseguridad, y papás y mamás, que ayudamos a las familias a entender los riesgos
              reales de internet, configurar los dispositivos de sus hijos y saber qué hacer si algo pasa.
            </p>
          </div>
        </div>
      </section>

      <section className="mc-section">
        <div className="container about-story">
          <div>
            <p className="mc-label">Nuestra historia</p>
            <h2>Empezamos respondiendo las preguntas de otras familias</h2>
          </div>
          <div className="stack">
            <p>
              Tecnofamilias nació dando asesorías personalizadas y conferencias presenciales gratuitas en Colombia, atendiendo por
              WhatsApp a padres y madres preocupados por lo que sus hijos veían y con quién hablaban en internet.
            </p>
            <p>
              En cada charla encontramos lo mismo: las familias saben que hay riesgos, pero no saben cómo configurar los dispositivos
              ni cómo actuar cuando algo pasa. Esa brecha es la razón de ser de Tecnofamilias.
            </p>
            <p>
              Hoy llevamos esa experiencia a una plataforma web, a asesorías personalizadas y a programas para colegios, empresas y
              entidades públicas, para llegar a más hogares de Latinoamérica.
            </p>
          </div>
        </div>
      </section>

      <section className="mc-section tint">
        <div className="container">
          <div className="mc-head">
            <p className="mc-label">Cómo lo hacemos</p>
            <h2>Tecnología explicada para la vida en casa</h2>
          </div>
          <div className="grid grid-4">
            {VALUES.map((v) => (
              <div key={v.title} className="card stack">
                <span className="icon-dot" style={{ background: v.color }}>{v.icon}</span>
                <h3 style={{ margin: 0 }}>{v.title}</h3>
                <p className="muted small" style={{ margin: 0 }}>{v.text}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section className="mc-section">
        <div className="container">
          <div className="mc-head">
            <p className="mc-label">El equipo</p>
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

      <section className="mc-section tint">
        <div className="container">
          <div className="mc-head">
            <p className="mc-label">Lo que hacemos</p>
            <h2>Acompañamiento para cada familia y cada institución</h2>
          </div>
          <div className="grid grid-4">
            {OFFER.map((o) => (
              <Link key={o.href} href={o.href} className="card card-link stack">
                <h3 style={{ margin: 0 }}>{o.title}</h3>
                <p className="muted small" style={{ margin: 0 }}>{o.text}</p>
                <span className="small" style={{ fontWeight: 800, color: "var(--blue-dark)", marginTop: "auto" }}>Conocer más →</span>
              </Link>
            ))}
          </div>
        </div>
      </section>

      <section className="mc-final">
        <div className="container row between" style={{ gap: 20 }}>
          <h2 style={{ margin: 0, color: "var(--navy-dark)", flex: "1 1 420px" }}>¿Hablamos? Cuéntanos qué está pasando en tu casa o en tu institución.</h2>
          <div className="row">
            <a href={WHATSAPP} target="_blank" rel="noopener noreferrer" className="btn" style={{ background: "var(--navy)" }}>Escríbenos por WhatsApp</a>
            {user ? (
              <Link href="/clases" className="btn btn-light">Ir a las clases</Link>
            ) : (
              <Link href="/planes" className="btn btn-light">Ver planes</Link>
            )}
          </div>
        </div>
      </section>
    </>
  );
}
