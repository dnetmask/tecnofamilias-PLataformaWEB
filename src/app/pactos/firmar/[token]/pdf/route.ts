import { redirect } from "next/navigation";
import { db } from "@/lib/db";
import { pactFileName, renderPactPdf } from "@/lib/pact-pdf";

export const dynamic = "force-dynamic";

/**
 * Descarga el pacto en PDF con sus firmas. Se accede con el mismo enlace del
 * pacto (shareToken), igual que la página de firma, y solo cuando ya hay al
 * menos una firma.
 */
export async function GET(_: Request, { params }: { params: Promise<{ token: string }> }) {
  const { token } = await params;
  const pact = await db.pact.findUnique({ where: { shareToken: token } });
  if (!pact) redirect("/");
  if (!pact.parentSignature) redirect(`/pactos/firmar/${token}`);
  const pdf = await renderPactPdf(pact);
  return new Response(Buffer.from(pdf), {
    headers: {
      "Content-Type": "application/pdf",
      "Content-Disposition": `attachment; filename="${pactFileName(pact)}"`,
      "Cache-Control": "private, no-store",
      "X-Robots-Tag": "noindex",
    },
  });
}
