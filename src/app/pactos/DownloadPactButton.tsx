/** Descarga el pacto firmado en PDF (ruta /pactos/firmar/<token>/pdf); `by` alimenta el contador del admin. */
export function DownloadPactButton({ shareToken, signed, by = "adulto" }: { shareToken: string; signed: boolean; by?: "adulto" | "menor" }) {
  return (
    <a className="btn btn-sm" href={`/pactos/firmar/${shareToken}/pdf?por=${by}`} download>
      ⬇ Descargar pacto en PDF{signed ? "" : " (con tu firma)"}
    </a>
  );
}
