import { db } from "@/lib/db";
import { SITE_DESCRIPTION, SITE_NAME, SITE_URL } from "@/lib/site";
import { TOOL_KINDS, availableToolWhere } from "@/lib/tools";

export const dynamic = "force-dynamic";

/** Resumen del sitio para asistentes de IA (https://llmstxt.org). */
export async function GET() {
  const [tools, games] = await Promise.all([
    db.resource.findMany({ where: availableToolWhere(), orderBy: [{ order: "asc" }, { createdAt: "desc" }], select: { slug: true, title: true, kind: true, author: true } }),
    db.game.findMany({ where: { published: true, free: true }, select: { slug: true, title: true, description: true } }),
  ]);
  const lines = [
    `# ${SITE_NAME}`,
    "",
    `> ${SITE_DESCRIPTION}`,
    "",
    "Tecnofamilias es una iniciativa colombiana creada por especialistas en ciberseguridad y padres de familia. Explica en lenguaje sencillo los riesgos digitales por edad (0 a 17 años) y cómo prevenirlos: control parental en celulares, tablets, consolas y router; configuración segura de Roblox, Instagram, TikTok, YouTube y WhatsApp; prevención del grooming, el ciberacoso, el sexting y la sextorsión; y acuerdos familiares (pactos digitales).",
    "",
    "## Secciones",
    `- [Inicio](${SITE_URL}/): qué es Tecnofamilias y contenido por etapa.`,
    `- [Caja de herramientas](${SITE_URL}/herramientas): videos, podcasts, guías, apps de control parental y equipos recomendados por edad.`,
    `- [Juegos en familia](${SITE_URL}/juegos): juegos para conversar de pantallas y seguridad digital.`,
    `- [Quiénes somos](${SITE_URL}/quienes-somos): el equipo y su experiencia.`,
    `- [Asesoría y programas](${SITE_URL}/planes): asesoría personalizada para familias y programas para colegios, empresas y entidades públicas.`,
    "",
    "## Herramientas recomendadas",
    ...tools.map((t) => `- [${t.title}](${SITE_URL}/herramientas/${t.slug}): ${TOOL_KINDS[t.kind].label}${t.author ? ` · ${t.author}` : ""}`),
    "",
    "## Juegos gratis",
    ...games.map((g) => `- [${g.title}](${SITE_URL}/juegos/${g.slug}): ${g.description}`),
    "",
    "## Contacto",
    `- Sitio: ${SITE_URL}`,
    "- WhatsApp: +57 300 674 0003",
    "",
  ];
  return new Response(lines.join("\n"), { headers: { "Content-Type": "text/plain; charset=utf-8", "Cache-Control": "public, max-age=3600" } });
}
