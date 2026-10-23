/** Barra de cupos ocupados con los colores de Tecnofamilias. */
export function SeatsBar({ pct, label = "Cupos limitados para esta edición" }: { pct: number; label?: string }) {
  return (
    <div className="seats" role="img" aria-label={`${label}: ${pct} % ocupado`}>
      <span className="seats-icon" aria-hidden>
        <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
          <path d="M6 2h12M6 22h12M7 2c0 5 10 5 10 10S7 17 7 22M17 2c0 5-10 5-10 10s10 5 10 10" />
        </svg>
      </span>
      <div className="seats-body">
        <span className="seats-label">{label}</span>
        <span className="seats-track">
          <span className="seats-fill" style={{ ["--pct" as string]: `${pct}%` }} />
        </span>
      </div>
      <div className="seats-num">
        <span className="seats-pct">{pct}<small>%</small></span>
        <span className="seats-cap">Ocupado</span>
      </div>
    </div>
  );
}
