import Link from "next/link";
import { notFound } from "next/navigation";
import { requireSubscriber } from "@/lib/access";
import { getCurrentUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { GameFrame } from "../GameFrame";
import { NOINDEX, pageMeta, SITE_URL } from "@/lib/site";
import { breadcrumbs, JsonLd } from "@/components/JsonLd";

export const dynamic = "force-dynamic";

/** "3 a 8 años" → "3-8"; "Desde 8 años" → "8-" (formato de schema.org). */
function ageRange(label: string) {
  const n = label.match(/\d+/g);
  if (!n) return null;
  return n.length >= 2 ? `${n[0]}-${n[1]}` : `${n[0]}-`;
}

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }) {
  const game = await db.game.findUnique({ where: { slug: (await params).slug }, select: { slug: true, title: true, description: true, free: true } });
  if (!game) return { title: "Juego" };
  // Solo los juegos gratis son públicos; los demás requieren suscripción.
  return game.free ? pageMeta(`/juegos/${game.slug}`, `${game.title} · juego gratis en familia`, game.description.slice(0, 160)) : { title: game.title, ...NOINDEX };
}

export default async function GamePage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const game = await db.game.findUnique({ where: { slug }, select: { slug: true, title: true, description: true, ageLabel: true, published: true, fullHeight: true, free: true } });
  // Los juegos gratis se abren sin cuenta; los demás requieren suscripción.
  const user = game?.free ? await getCurrentUser() : await requireSubscriber(`/juegos/${slug}`);
  if (!game || (!game.published && user?.role !== "ADMIN")) notFound();

  return (
    <div className="container section stack">
      {game.free && (
        <JsonLd
          data={{
            "@context": "https://schema.org",
            "@graph": [
              {
                "@type": "VideoGame",
                name: game.title,
                description: game.description,
                url: `${SITE_URL}/juegos/${game.slug}`,
                inLanguage: "es",
                genre: ["Juego familiar", "Educativo"],
                gamePlatform: "Navegador web",
                applicationCategory: "Game",
                isAccessibleForFree: true,
                offers: { "@type": "Offer", price: 0, priceCurrency: "USD" },
                ...(ageRange(game.ageLabel) ? { typicalAgeRange: ageRange(game.ageLabel) } : {}),
                publisher: { "@id": `${SITE_URL}/#organization` },
              },
              breadcrumbs([["Inicio", SITE_URL], ["Juegos", `${SITE_URL}/juegos`], [game.title, `${SITE_URL}/juegos/${game.slug}`]]),
            ],
          }}
        />
      )}
      <p className="small"><Link href="/juegos">← Juegos</Link></p>
      <header className="stack" style={{ gap: 6 }}>
        <div className="row" style={{ gap: 8 }}>
          <h1 style={{ margin: 0, fontSize: "1.6rem" }}>{game.title}</h1>
          {game.free && <span className="badge badge-green">Gratis para todos</span>}
          {game.ageLabel && <span className="badge">{game.ageLabel}</span>}
        </div>
        <p className="muted" style={{ margin: 0, maxWidth: 820 }}>{game.description}</p>
      </header>
      <GameFrame src={`/juegos/${game.slug}/jugar`} title={game.title} fullHeight={game.fullHeight} />
    </div>
  );
}
