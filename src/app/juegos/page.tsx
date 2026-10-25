import Link from "next/link";
import { hasMemberAccess } from "@/lib/access";
import { getCurrentUser } from "@/lib/auth";
import { db } from "@/lib/db";

export const dynamic = "force-dynamic";
export const metadata = { title: "Juegos en familia" };

export default async function GamesPage() {
  const user = await getCurrentUser();
  const [games, member] = await Promise.all([
    db.game.findMany({
      where: { published: true },
      orderBy: [{ order: "asc" }, { createdAt: "desc" }],
      select: { id: true, slug: true, title: true, description: true, ageLabel: true, emoji: true, color: true, free: true },
    }),
    hasMemberAccess(user),
  ]);

  return (
    <>
      <div className="page-head">
        <div className="container">
          <h1>Juegos en familia</h1>
          <p>Para jugar juntos, conversar sin sermones y aprender a cuidarse en el mundo digital.</p>
        </div>
      </div>
      <div className="container section stack">
        {!member && (
          <div className="alert alert-info">
            Los juegos están incluidos en la suscripción; los marcados como gratis los puede jugar cualquiera. <Link href={user ? "/planes" : "/registro"}>{user ? "Suscribirme" : "Crear cuenta"}</Link>
          </div>
        )}
        {games.length === 0 && <p className="muted">Muy pronto habrá juegos disponibles.</p>}
        <div className="grid grid-2">
          {games.map((g) => {
            const canPlay = member || g.free;
            return (
            <Link key={g.id} href={canPlay ? `/juegos/${g.slug}` : user ? "/planes" : "/registro"} className="card card-link stack">
              <div className="row">
                <span className="icon-dot" style={{ background: g.color, width: 56, height: 56, fontSize: "1.7rem" }}>{g.emoji}</span>
                <div>
                  <h3 style={{ margin: 0 }}>{g.title}</h3>
                  <div className="row" style={{ gap: 6, marginTop: 4 }}>
                    {g.free && <span className="badge badge-green">Gratis para todos</span>}
                    {g.ageLabel && <span className="badge">{g.ageLabel}</span>}
                  </div>
                </div>
              </div>
              <p className="muted small" style={{ margin: 0 }}>{g.description}</p>
              <span className="small" style={{ color: "var(--blue-dark)", fontWeight: 700 }}>{canPlay ? "Jugar →" : "🔒 Disponible con la suscripción"}</span>
            </Link>
            );
          })}
        </div>
      </div>
    </>
  );
}
