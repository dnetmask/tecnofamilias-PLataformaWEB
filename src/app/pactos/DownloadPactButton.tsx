/** Descarga el pacto firmado en PDF (ruta /pactos/firmar/<token>/pdf). */
export function DownloadPactButton({ shareToken, signed }: { shareToken: string; signed: boolean }) {
  return (
    <a className="btn btn-sm" href={`/pactos/firmar/${shareToken}/pdf`} download>
      ⬇ Descargar pacto en PDF{signed ? "" : " (con tu firma)"}
    </a>
  );
}
