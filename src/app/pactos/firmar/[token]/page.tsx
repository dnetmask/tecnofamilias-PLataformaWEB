import { notFound } from "next/navigation";
import { SignaturePad } from "@/components/SignaturePad";
import { db } from "@/lib/db";
import { signByTokenAction } from "../../actions";
import { DownloadPactButton } from "../../DownloadPactButton";
import { PactDocument } from "../../PactDocument";

export const dynamic = "force-dynamic";
export const metadata = { title: "Firmar pacto", robots: { index: false, follow: false } };

export default async function SignByTokenPage({ params }: { params: Promise<{ token: string }> }) {
  const { token } = await params;
  const pact = await db.pact.findUnique({ where: { shareToken: token } });
  if (!pact) notFound();

  return (
    <div className="container section" style={{ maxWidth: 820 }}>
      <div className="stack">
        <PactDocument pact={pact} />
        {!pact.parentSignature ? (
          <div className="alert alert-info">Este pacto todavía no está listo: primero debe firmarlo el adulto responsable.</div>
        ) : !pact.childSignature ? (
          <SignaturePad
            action={signByTokenAction}
            fields={{ token }}
            label={`Firma de ${pact.childName}`}
            signerHint="Si estás de acuerdo con todo, firma con el dedo aquí."
          />
        ) : (
          <div className="card stack center">
            <div className="alert alert-ok" style={{ margin: 0 }}>¡Este pacto ya está firmado por los dos!</div>
            <div><DownloadPactButton shareToken={token} signed by="menor" /></div>
            <p className="small muted" style={{ margin: 0 }}>Guárdalo en tu celular para tenerlo siempre a mano.</p>
          </div>
        )}
      </div>
    </div>
  );
}
