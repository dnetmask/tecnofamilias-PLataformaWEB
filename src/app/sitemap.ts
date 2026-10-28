import type { MetadataRoute } from "next";
import { availableToolWhere } from "@/lib/tools";
import { db } from "@/lib/db";
import { SITE_URL } from "@/lib/site";

export const dynamic = "force-dynamic";

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const [tools, games, services, pacts] = await Promise.all([
    db.resource.findMany({ where: availableToolWhere(), select: { slug: true, createdAt: true } }),
    db.game.findMany({ where: { published: true, free: true }, select: { slug: true, updatedAt: true } }),
    db.service.findMany({ where: { active: true }, select: { slug: true, createdAt: true } }),
    db.pactTemplate.findMany({ where: { published: true, public: true }, select: { slug: true, createdAt: true } }),
  ]);
  const page = (path: string, priority: number, lastModified = new Date()) => ({ url: `${SITE_URL}${path}`, lastModified, priority });
  return [
    page("/", 1),
    page("/herramientas", 0.9),
    page("/juegos", 0.8),
    page("/quienes-somos", 0.7),
    page("/planes", 0.7),
    page("/terminos", 0.2),
    ...tools.map((t) => page(`/herramientas/${t.slug}`, 0.8, t.createdAt)),
    ...games.map((g) => page(`/juegos/${g.slug}`, 0.7, g.updatedAt)),
    ...pacts.map((p) => page(`/pacto/${p.slug}`, 0.7, p.createdAt)),
    // La masterclass se vende solo desde su landing, que aún no está lanzada.
    ...services.filter((s) => !s.slug.startsWith("masterclass-crianza")).map((s) => page(`/servicios/${s.slug}`, 0.6, s.createdAt)),
  ];
}
