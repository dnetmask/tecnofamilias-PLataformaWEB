import type { Pact } from "@prisma/client";
import { formatDate, formatDateTime } from "@/lib/format";

export function PactDocument({ pact }: { pact: Pact }) {
  const clauses = Array.isArray(pact.clauses) ? (pact.clauses as string[]) : [];
  return (
    <article className="pact-doc stack">
      <div className="row between">
        <img src="/logo.svg" alt="Tecnofamilias" style={{ height: 44, width: "auto" }} />
        <span className="small muted">Pacto digital familiar</span>
      </div>
      <h1 style={{ fontSize: "1.7rem", marginTop: 12 }}>Pacto para usar {pact.appName}</h1>
      <p>
        Nosotros, <strong>{pact.parentName}</strong> y <strong>{pact.childName}</strong>
        {pact.childAge != null && <> ({pact.childAge} años)</>}, acordamos lo siguiente:
      </p>
      <ol>
        {clauses.map((c, i) => (
          <li key={i}>{c}</li>
        ))}
      </ol>
      {pact.rewards && (
        <div>
          <h3>Si cumplimos</h3>
          <p style={{ whiteSpace: "pre-wrap" }}>{pact.rewards}</p>
        </div>
      )}
      {pact.consequences && (
        <div>
          <h3>Si no cumplimos</h3>
          <p style={{ whiteSpace: "pre-wrap" }}>{pact.consequences}</p>
        </div>
      )}
      {pact.reviewDate && (
        <p className="muted">Revisaremos este pacto juntos el {formatDate(pact.reviewDate)}.</p>
      )}
      <div className="grid grid-2" style={{ marginTop: 16 }}>
        <div>
          {pact.parentSignature ? (
            <img className="sig-img" src={pact.parentSignature} alt={`Firma de ${pact.parentName}`} />
          ) : (
            <div className="sig-img" />
          )}
          <div style={{ borderTop: "1.5px solid var(--ink)", paddingTop: 6 }}>
            <strong>{pact.parentName}</strong>
            <div className="small muted">
              Adulto responsable{pact.parentSignedAt && <> · {formatDateTime(pact.parentSignedAt)}</>}
            </div>
          </div>
        </div>
        <div>
          {pact.childSignature ? (
            <img className="sig-img" src={pact.childSignature} alt={`Firma de ${pact.childName}`} />
          ) : (
            <div className="sig-img" />
          )}
          <div style={{ borderTop: "1.5px solid var(--ink)", paddingTop: 6 }}>
            <strong>{pact.childName}</strong>
            <div className="small muted">
              Hijo/a{pact.childSignedAt && <> · {formatDateTime(pact.childSignedAt)}</>}
            </div>
          </div>
        </div>
      </div>
    </article>
  );
}
