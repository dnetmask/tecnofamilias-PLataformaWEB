"use client";

import { upload } from "@vercel/blob/client";
import { useState } from "react";

const MAX_MB = 50;

function size(bytes: number) {
  return bytes >= 1024 * 1024 ? `${(bytes / 1024 / 1024).toFixed(1).replace(".", ",")} MB` : `${Math.max(1, Math.round(bytes / 1024))} KB`;
}

/** Sube un PDF a Vercel Blob desde el navegador y deja su dirección en campos ocultos del formulario. */
export function FileField({ initial }: { initial: { url: string; name: string; size: number | null } }) {
  const [file, setFile] = useState(initial);
  const [status, setStatus] = useState<{ busy?: boolean; progress?: number; error?: string }>({});

  async function onChange(e: React.ChangeEvent<HTMLInputElement>) {
    const f = e.target.files?.[0];
    e.target.value = "";
    if (!f) return;
    if (f.type !== "application/pdf") return setStatus({ error: "Solo se aceptan archivos PDF." });
    if (f.size > MAX_MB * 1024 * 1024) return setStatus({ error: `El PDF pesa más de ${MAX_MB} MB.` });
    setStatus({ busy: true, progress: 0 });
    try {
      const safe = f.name.normalize("NFD").replace(/[̀-ͯ]/g, "").replace(/[^\w.-]+/g, "-").toLowerCase();
      const blob = await upload(`herramientas/${safe}`, f, {
        access: "private",
        handleUploadUrl: "/api/admin/upload",
        contentType: "application/pdf",
        onUploadProgress: ({ percentage }) => setStatus({ busy: true, progress: Math.round(percentage) }),
      });
      setFile({ url: blob.url, name: f.name, size: f.size });
      setStatus({});
    } catch (err) {
      setStatus({ error: err instanceof Error ? err.message : "No se pudo subir el archivo." });
    }
  }

  return (
    <div className="field">
      <label>Archivo PDF (opcional)</label>
      <input type="hidden" name="fileUrl" value={file.url} />
      <input type="hidden" name="fileName" value={file.name} />
      <input type="hidden" name="fileSize" value={file.size ?? ""} />
      {file.url ? (
        <div className="row" style={{ gap: 10 }}>
          <span className="badge badge-blue">📄 {file.name || "PDF"}{file.size ? ` · ${size(file.size)}` : ""}</span>
          <label className="btn btn-ghost btn-sm" style={{ cursor: "pointer" }}>
            Reemplazar
            <input type="file" accept="application/pdf" onChange={onChange} hidden disabled={status.busy} />
          </label>
          <button type="button" className="btn-link btn-danger-link small" onClick={() => setFile({ url: "", name: "", size: null })} disabled={status.busy}>
            Quitar
          </button>
        </div>
      ) : (
        <input className="input" type="file" accept="application/pdf" onChange={onChange} disabled={status.busy} />
      )}
      {status.busy && <span className="hint">Subiendo… {status.progress ?? 0}%</span>}
      {status.error && <span className="hint" style={{ color: "var(--red)" }}>{status.error}</span>}
      <span className="hint">
        Hasta {MAX_MB} MB. Se guarda en un almacén privado: solo lo abre quien tenga acceso a la herramienta y nunca se ve la
        dirección real del archivo. Si subes un PDF, el enlace de arriba es opcional. Recuerda guardar después de subirlo.
      </span>
    </div>
  );
}
