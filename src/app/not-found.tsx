import Link from "next/link";

export default function NotFound() {
  return (
    <div className="container section center">
      <h1>No encontramos esta página</h1>
      <p className="muted">Puede que el enlace haya cambiado o ya no exista.</p>
      <Link className="btn" href="/">Ir al inicio</Link>
    </div>
  );
}
