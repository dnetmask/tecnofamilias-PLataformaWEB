import Link from "next/link";
import { getMasterclass } from "@/lib/masterclass";
import { getPricing } from "@/lib/pricing";
import { SeatsBar } from "./SeatsBar";

/** Aviso de la próxima masterclass para los dos inicios (con y sin sesión). */
export async function MasterclassPromo({ compact = false }: { compact?: boolean }) {
  const mc = await getMasterclass();
  if (!mc.showOnHome || mc.isPast || !mc.service?.active) return null;
  const pricing = await getPricing();
  return (
    <section className={`mc-promo${compact ? " compact" : ""}`}>
      <div className="mc-promo-inner">
        <div className="mc-promo-text">
          <span className="mc-kicker">Nuestra próxima masterclass · {mc.shortDate}</span>
          <h2>Crianza digital segura</h2>
          <p>
            Riesgos reales por edad y configuración en vivo de Roblox, Instagram, YouTube y los celulares de tus hijos.
            {" "}{mc.dateLabel} · {mc.time} ({mc.timezone}) · {mc.modality}.
          </p>
          <div className="row" style={{ marginTop: 6 }}>
            <Link href="/masterclass" className="btn btn-yellow">Reservar mi cupo · {pricing.price(mc.service.priceUsd ?? 0)}</Link>
            <Link href="/masterclass#contenido" className="btn btn-light">Ver el contenido</Link>
          </div>
        </div>
        <div className="mc-promo-seats">
          <SeatsBar pct={mc.seatsPct} />
        </div>
      </div>
    </section>
  );
}
