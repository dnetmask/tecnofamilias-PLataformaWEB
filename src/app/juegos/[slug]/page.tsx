import Link from "next/link";
import { notFound } from "next/navigation";
import { requireSubscriber } from "@/lib/access";
import { db } from "@/lib/db";
import { GameFrame } from "../GameFrame";

export const dynamic = "force-dynamic";

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }) {
  const game = await db.game.findUnique({ where: { slug: (await params).slug }, select: { title: true } });
  return { title: game?.title ?? "Juego" };
}

export default async function GamePage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const user = await requireSubscriber(`/juegos/${slug}`);
  const game = await db.game.findUnique({ where: { slug }, select: { slug: true, title: true, published: true } });
  if (!game || (!game.published && user.role !== "ADMIN")) notFound();

  return (
    <div className="container section stack">
      <p className="small"><Link href="/juegos">← Juegos</Link></p>
      <GameFrame src={`/juegos/${game.slug}/jugar`} title={game.title} />
    </div>
  );
}
