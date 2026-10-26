import Link from "next/link";
import { getPricing } from "@/lib/pricing";
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
          <div><Link href="/quienes-somos">Quiénes somos</Link> · <Link href="/terminos">Términos y tratamiento de datos</Link></div>
          <div>www.tecnofamilias.com · WhatsApp <a href={whatsappUrl()} target="_blank" rel="noopener noreferrer">+57 300 674 0003</a></div>
          <div><CurrencySwitcher current={currency} dark /></div>
        </div>
      </div>
    </footer>
  );
}
