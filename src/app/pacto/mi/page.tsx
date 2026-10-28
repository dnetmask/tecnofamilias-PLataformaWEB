import Link from "next/link";
import { cookies } from "next/headers";
import { SignaturePad } from "@/components/SignaturePad";
import { db } from "@/lib/db";
import { PUBLIC_PACT_COOKIE } from "@/lib/pacts";
import { NOINDEX } from "@/lib/site";
import { CopyLink } from "../../pactos/CopyLink";
import { PactDocument } from "../../pactos/PactDocument";
import { PrintButton } from "../../pactos/PrintButton";
import { deletePublicPactAction, signPublicParentAction } from "../actions";

export const dynamic = "force-dynamic";
export const metadata = { title: "Mi pacto", ...NOINDEX };

/** Pacto creado sin cuenta, abierto con el enlace privado (guardado en una cookie). */
export default async function MyPublicPactPage({ searchParams }: { searchParams: Promise<{ nuevo?: string; eliminado?: string }> }) {
  const { nuevo, eliminado } = await searchParams;
  const token = (await cookies()).get(PUBLIC_PACT_COOKIE)?.value;
  const pact = token ? await db.pact.findUnique({ where: { manageToken: token } }) : null;

  if (!pact) {
    const template = await db.pactTemplate.findFirst({ where: { published: true, public: true }, orderBy: { order: "asc" }, select: { slug: true } });
    return (
      <div className="container">
        <div className="card auth-card stack center">
          <h1 style={{ fontSize: "1.6rem" }}>{eliminado ? "Pacto eliminado" : "No encontramos tu pacto"}</h1>
          <p className="muted">
            {eliminado
              ? "Borramos el pacto y sus firmas."
              : "Ábrelo con el enlace privado que te dimos al crearlo. Si lo perdiste, puedes crear uno nuevo."}
          </p>
          <Link className="btn" href={template ? `/pacto/${template.slug}` : "/"}>{template ? "Crear un pacto" : "Ir al inicio"}</Link>
        </div>
      </div>
    );
  }

  return (
    <div className="container section">
      {nuevo && (
        <div className="alert alert-ok no-print" style={{ marginBottom: 20 }}>
          ¡Listo! Tu pacto quedó creado. Guarda tu enlace privado (en «Tu enlace privado», más abajo) para volver a él desde cualquier dispositivo.
        </div>
      )}
      <div className="layout-aside">
        <PactDocument pact={pact} />
        <aside className="stack no-print">
          {!pact.parentSignature && (
            <SignaturePad
              action={signPublicParentAction}
              fields={{}}
              label={`1. Firma de ${pact.parentName}`}
              signerHint="Léanlo juntos en voz alta y, si están de acuerdo, firma con el dedo o con el mouse."
            />
          )}
          {pact.parentSignature && !pact.childSignature && (
            <div className="card stack">
              <h3>2. Ahora firma {pact.childName}</h3>
              <p className="muted small" style={{ margin: 0 }}>Pásale este enlace para que firme desde su celular, o ábrelo aquí mismo.</p>
              <CopyLink path={`/pactos/firmar/${pact.shareToken}`} />
              <Link className="btn btn-ghost btn-sm" href={`/pactos/firmar/${pact.shareToken}`}>Firmar en este dispositivo</Link>
            </div>
          )}
          {pact.status === "SIGNED" && <div className="alert alert-ok">¡Pacto firmado por los dos! Déjenlo a la vista o imprímanlo.</div>}

          <div className="card stack">
            <h3>Tu enlace privado</h3>
            <p className="muted small" style={{ margin: 0 }}>Con él vuelves a este pacto. No lo compartas: quien lo tenga puede firmarlo como adulto o borrarlo.</p>
            <CopyLink path={`/pacto/mi/${pact.manageToken}`} />
          </div>

          <div className="card stack">
            <PrintButton />
            <form action={deletePublicPactAction}>
              <button className="btn-link btn-danger-link small">Eliminar este pacto</button>
            </form>
          </div>

          <div className="card card-tint stack">
            <h3>¿Más pactos para tu familia?</h3>
            <p className="muted small" style={{ margin: 0 }}>Con la suscripción guardas tus pactos en tu cuenta y tienes plantillas para Roblox, TikTok, WhatsApp y más.</p>
            <Link className="btn btn-sm" href="/planes">Conocer los planes</Link>
          </div>
        </aside>
      </div>
    </div>
  );
}
