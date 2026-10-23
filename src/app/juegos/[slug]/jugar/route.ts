import { hasMemberAccess } from "@/lib/access";
import { getCurrentUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { GAME_SANDBOX, withHeightReporter } from "@/lib/games";

export const dynamic = "force-dynamic";

function deny(status: number, message: string) {
  return new Response(
    `<!doctype html><meta charset="utf-8"><body style="font-family:system-ui;padding:24px;color:#28395f">${message}</body>`,
    { status, headers: { "Content-Type": "text/html; charset=utf-8", "Cache-Control": "no-store" } },
  );
}

/** Entrega el HTML del juego solo a suscriptores, y siempre aislado. */
export async function GET(_: Request, { params }: { params: Promise<{ slug: string }> }) {
  const user = await getCurrentUser();
  if (!(await hasMemberAccess(user))) return deny(403, "Necesitas una suscripción activa para jugar.");

  const { slug } = await params;
  const game = await db.game.findUnique({ where: { slug } });
  if (!game || (!game.published && user?.role !== "ADMIN")) return deny(404, "Juego no encontrado.");

  return new Response(withHeightReporter(game.html), {
    headers: {
      "Content-Type": "text/html; charset=utf-8",
      "Cache-Control": "private, no-store",
      // Aunque se abra la URL directamente, el navegador lo ejecuta aislado.
      "Content-Security-Policy": `sandbox ${GAME_SANDBOX}; frame-ancestors 'self'`,
      "X-Robots-Tag": "noindex",
    },
  });
}
