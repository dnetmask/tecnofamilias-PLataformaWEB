import Link from "next/link";
import { getPricing } from "@/lib/pricing";
import { LEGAL } from "@/lib/site";
import { whatsappUrl } from "@/lib/whatsapp";
import { CurrencySwitcher } from "./CurrencySwitcher";

export async function Footer() {
  const { currency } = await getPricing();
  return (
    <footer className="footer">
      <div className="container row between" style={{ alignItems: "flex-start", gap: 24 }}>
        <div style={{ maxWidth: 360 }}>
          <img src="/logo-light.svg" alt="Tecnofamilias" width={120} height={40} style={{ height: 40, width: "auto", marginBottom: 12 }} />
          <p>Protegemos a las familias en el mundo digital.</p>
        </div>
        <div className="stack small">
          <div><Link href="/clases">Clases</Link> · <Link href="/herramientas">Caja de herramientas</Link> · <Link href="/pactos">Pactos</Link> · <Link href="/juegos">Juegos</Link> · <Link href="/comunidad">Comunidad</Link></div>
          <div><Link href="/quienes-somos">Quiénes somos</Link> · <Link href="/terminos">Términos y tratamiento de datos</Link> · <Link href="/eliminar-cuenta">Eliminar cuenta</Link></div>
          <div><a href={`mailto:${LEGAL.email}`}>{LEGAL.email}</a> · WhatsApp <a href={whatsappUrl()} target="_blank" rel="noopener noreferrer">{LEGAL.phone}</a></div>
          <div>{LEGAL.name} · NIT {LEGAL.nit} · {LEGAL.address}, {LEGAL.city}, {LEGAL.region}, {LEGAL.country}</div>
          <div><CurrencySwitcher current={currency} dark /></div>
        </div>
      </div>
    </footer>
  );
}
