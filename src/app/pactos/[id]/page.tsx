import Link from "next/link";
import { notFound } from "next/navigation";
import { SignaturePad } from "@/components/SignaturePad";
import { requireUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { deletePactAction, duplicatePactAction, regenerateTokenAction, signPactAction } from "../actions";
import { CopyLink } from "../CopyLink";
import { DownloadPactButton } from "../DownloadPactButton";
import { PactDocument } from "../PactDocument";
import { PrintButton } from "../PrintButton";

export const dynamic = "force-dynamic";
export const metadata = { title: "Pacto" };

export default async function PactPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const user = await requireUser(`/pactos/${id}`);
  const pact = await db.pact.findUnique({ where: { id } });
  if (!pact || pact.userId !== user.id) notFound();

  return (
    <div className="container section">
      <p className="small no-print"><Link href="/pactos">← Mis pactos</Link></p>
      <div className="layout-aside">
        <PactDocument pact={pact} />
        <aside className="stack no-print">
          {!pact.parentSignature && (
            <>
              <div className="card stack">
                <h3>1. Revisen el pacto juntos</h3>
                <p className="muted small" style={{ margin: 0 }}>
                  Léanlo en voz alta y ajusten lo que haga falta. Al firmar, el texto queda bloqueado.
                </p>
                <Link className="btn btn-ghost btn-sm" href={`/pactos/${pact.id}/editar`}>Editar pacto</Link>
              </div>
              <SignaturePad
                action={signPactAction}
                fields={{ id: pact.id, who: "parent" }}
                label={`2. Firma de ${pact.parentName}`}
                signerHint="Firma con el dedo o con el mouse."
              />
            </>
          )}

          {pact.parentSignature && !pact.childSignature && (
            <>
              <SignaturePad
                action={signPactAction}
                fields={{ id: pact.id, who: "child" }}
                label={`3. Firma de ${pact.childName}`}
                signerHint="Pásale este dispositivo para que firme aquí…"
              />
              <div className="card stack">
                <h3>…o envíale el enlace</h3>
                <p className="muted small" style={{ margin: 0 }}>
                  Puede abrirlo en su propio celular y firmar sin crear cuenta. Compártelo solo con tu hijo o hija.
                </p>
                <CopyLink path={`/pactos/firmar/${pact.shareToken}`} />
                <form action={regenerateTokenAction}>
                  <input type="hidden" name="id" value={pact.id} />
                  <button className="btn-link small">Generar un enlace nuevo (invalida el anterior)</button>
                </form>
              </div>
            </>
          )}

          {pact.status === "SIGNED" && (
            <div className="alert alert-ok">¡Pacto firmado por los dos! Déjenlo a la vista o imprímanlo.</div>
          )}

          <div className="card stack">
            {pact.parentSignature && <DownloadPactButton shareToken={pact.shareToken} signed={pact.status === "SIGNED"} />}
            <PrintButton />
            <form action={duplicatePactAction}>
              <input type="hidden" name="id" value={pact.id} />
              <button className="btn btn-ghost btn-sm">Renovar (crear una copia editable)</button>
            </form>
            <form action={deletePactAction}>
              <input type="hidden" name="id" value={pact.id} />
              <button className="btn-link btn-danger-link small">Eliminar pacto</button>
            </form>
          </div>
        </aside>
      </div>
    </div>
  );
}
