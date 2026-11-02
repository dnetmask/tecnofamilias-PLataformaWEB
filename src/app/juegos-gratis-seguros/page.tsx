import Link from "next/link";
import { db } from "@/lib/db";
import { NOINDEX } from "@/lib/site";

export const dynamic = "force-dynamic";
// Sección solo con enlace: fuera del menú, del sitemap y de los buscadores.
export const metadata = { title: "Juegos gratis y seguros", ...NOINDEX };

const SAFE = [
  { icon: "🔓", text: "Gratis y sin crear cuenta" },
  { icon: "🚫", text: "Sin anuncios, sin compras y sin chat con desconocidos" },
  { icon: "🙈", text: "No piden nombre real ni datos personales" },
  { icon: "💾", text: "El progreso queda guardado solo en este dispositivo" },
];

export default async function SafeGamesPage() {
  const games = await db.game.findMany({
    where: { published: true, free: true, unlisted: true },
    orderBy: [{ order: "asc" }, { createdAt: "desc" }],
    select: { id: true, slug: true, title: true, description: true, ageLabel: true, emoji: true, color: true },
  });

  return (
    <>
      <div className="page-head">
        <div className="container">
          <h1>Juegos gratis y seguros</h1>
          <p>Juegos para pasar un buen rato en familia, pensados para que los niños jueguen tranquilos.</p>
        </div>
      </div>
      <div className="container section stack">
        <div className="grid grid-4">
          {SAFE.map((s) => (
            <div key={s.text} className="card stack" style={{ gap: 8 }}>
              <span aria-hidden="true" style={{ fontSize: "1.4rem" }}>{s.icon}</span>
              <span className="small" style={{ fontWeight: 700 }}>{s.text}</span>
            </div>
          ))}
        </div>
        {games.length === 0 && <p className="muted">Muy pronto habrá juegos disponibles.</p>}
        <div className="grid grid-2">
          {games.map((g) => (
            <Link key={g.id} href={`/juegos/${g.slug}`} className="card card-link stack">
              <div className="row">
                <span className="icon-dot" style={{ background: g.color, width: 56, height: 56, fontSize: "1.7rem" }}>{g.emoji}</span>
                <div>
                  <h3 style={{ margin: 0 }}>{g.title}</h3>
                  <div className="row" style={{ gap: 6, marginTop: 4 }}>
                    <span className="badge badge-green">Gratis para todos</span>
                    {g.ageLabel && <span className="badge">{g.ageLabel}</span>}
                  </div>
                </div>
              </div>
              <p className="muted small" style={{ margin: 0 }}>{g.description}</p>
              <span className="small" style={{ color: "var(--blue-dark)", fontWeight: 700 }}>Jugar →</span>
            </Link>
          ))}
        </div>
        <p className="small muted">¿Quieres más juegos para conversar en familia sobre pantallas y seguridad digital? <Link href="/juegos">Mira todos los juegos de Tecnofamilias</Link>.</p>
      </div>
    </>
  );
}
