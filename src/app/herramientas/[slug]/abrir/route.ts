import { redirect } from "next/navigation";
import { getToolViewer, recordToolUse } from "@/lib/access";
import { getCurrentUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { canUseTool } from "@/lib/tools";

export const dynamic = "force-dynamic";

/** Cuenta el uso y lleva al enlace de la herramienta, solo si el usuario tiene acceso. */
export async function GET(_: Request, { params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const [tool, user] = await Promise.all([db.resource.findUnique({ where: { slug } }), getCurrentUser()]);
  if (!tool || (!tool.published && user?.role !== "ADMIN")) redirect("/herramientas");
  if (!canUseTool(await getToolViewer(user), tool)) redirect(`/herramientas/${tool.slug}`);
  if (user) await recordToolUse(user.id, tool.id);
  redirect(tool.url);
}
