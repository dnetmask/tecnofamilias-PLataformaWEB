import Link from "next/link";

export function Footer() {
  return (
    <footer className="footer">
      <div className="container row between" style={{ alignItems: "flex-start", gap: 24 }}>
        <div style={{ maxWidth: 360 }}>
          <img src="/logo-light.svg" alt="Tecnofamilias" width={120} height={40} style={{ height: 40, width: "auto", marginBottom: 12 }} />
          <p>Protegemos a las familias en el mundo digital.</p>
        </div>
        <div className="stack small">
          <div><Link href="/clases">Clases</Link> · <Link href="/recursos">Videos y podcasts</Link> · <Link href="/pactos">Pactos</Link> · <Link href="/comunidad">Comunidad</Link></div>
          <div><Link href="/terminos">Términos y tratamiento de datos</Link></div>
          <div>www.tecnofamilias.com · +57 313 874 3101</div>
        </div>
      </div>
    </footer>
  );
}
