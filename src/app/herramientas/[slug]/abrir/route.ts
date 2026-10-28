import { redirect } from "next/navigation";
import { getToolViewer, recordToolUse } from "@/lib/access";
import { getCurrentUser } from "@/lib/auth";
import { readToolFile } from "@/lib/blob";
import { db } from "@/lib/db";
import { canUseTool, isToolExpired } from "@/lib/tools";

export const dynamic = "force-dynamic";

/**
 * Cuenta el uso y entrega la herramienta solo si el usuario tiene acceso y
 * sigue vigente: los PDF se envían desde el almacén privado (la dirección real
 * nunca llega al navegador) y los enlaces se abren con una redirección.
 */
export async function GET(request: Request, { params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const [tool, user] = await Promise.all([db.resource.findUnique({ where: { slug } }), getCurrentUser()]);
  const admin = user?.role === "ADMIN";
  if (!tool || (!tool.published && !admin)) redirect("/herramientas");
  if ((isToolExpired(tool) && !admin) || !canUseTool(await getToolViewer(user), tool)) redirect(`/herramientas/${tool.slug}`);
  if (user) await recordToolUse(user.id, tool.id);

  if (tool.fileUrl) {
    const file = await readToolFile(tool.fileUrl).catch((err) => {
      console.error("No se pudo leer el PDF de Vercel Blob", err);
      return null;
    });
    if (!file) return new Response("El archivo no está disponible en este momento.", { status: 404 });
    const download = new URL(request.url).searchParams.has("descargar");
    const name = (tool.fileName || `${tool.slug}.pdf`).replace(/["\r\n]/g, "");
    const ascii = name.normalize("NFD").replace(/[^\x20-\x7e]/g, "");
    return new Response(file.stream, {
      headers: {
        "Content-Type": "application/pdf",
        "Content-Disposition": `${download ? "attachment" : "inline"}; filename="${ascii}"; filename*=UTF-8''${encodeURIComponent(name)}`,
        "Cache-Control": "private, no-store",
        "X-Robots-Tag": "noindex",
      },
    });
  }
  redirect(tool.url);
}
