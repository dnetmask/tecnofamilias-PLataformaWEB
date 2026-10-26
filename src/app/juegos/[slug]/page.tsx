import Link from "next/link";
import { notFound } from "next/navigation";
import { requireSubscriber } from "@/lib/access";
import { getCurrentUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { GameFrame } from "../GameFrame";
import { NOINDEX, pageMeta } from "@/lib/site";

export const dynamic = "force-dynamic";

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }) {
  const game = await db.game.findUnique({ where: { slug: (await params).slug }, select: { slug: true, title: true, description: true, free: true } });
  if (!game) return { title: "Juego" };
  // Solo los juegos gratis son públicos; los demás requieren suscripción.
  return game.free ? pageMeta(`/juegos/${game.slug}`, `${game.title} · juego gratis en familia`, game.description.slice(0, 160)) : { title: game.title, ...NOINDEX };
}

export default async function GamePage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const game = await db.game.findUnique({ where: { slug }, select: { slug: true, title: true, published: true, fullHeight: true, free: true } });
  // Los juegos gratis se abren sin cuenta; los demás requieren suscripción.
  const user = game?.free ? await getCurrentUser() : await requireSubscriber(`/juegos/${slug}`);
  if (!game || (!game.published && user?.role !== "ADMIN")) notFound();

  return (
    <div className="container section stack">
      <p className="small"><Link href="/juegos">← Juegos</Link></p>
      <GameFrame src={`/juegos/${game.slug}/jugar`} title={game.title} fullHeight={game.fullHeight} />
    </div>
  );
}
