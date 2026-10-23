"use client";

export default function ErrorPage({ reset }: { error: Error; reset: () => void }) {
  return (
    <div className="container section center">
      <h1>Algo salió mal</h1>
      <p className="muted">Intenta de nuevo en unos segundos.</p>
      <button className="btn" onClick={reset}>Reintentar</button>
    </div>
  );
}
