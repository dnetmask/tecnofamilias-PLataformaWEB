import { CurrencyNote } from "@/components/CurrencyNote";
import { CurrencySwitcher } from "@/components/CurrencySwitcher";
import { ServicesCatalog } from "@/components/ServicesCatalog";
import { getPricing } from "@/lib/pricing";

export const dynamic = "force-dynamic";
export const metadata = { title: "Otros servicios" };

export default async function ServicesPage() {
  const pricing = await getPricing();
  return (
    <>
      <div className="page-head">
        <div className="container">
          <h1>Otros servicios</h1>
          <p>Asesoría personalizada para tu familia y programas para colegios, empresas y entidades públicas.</p>
          <div style={{ marginTop: 16 }}><CurrencySwitcher current={pricing.currency} dark /></div>
        </div>
      </div>
      <div className="container section stack">
        <CurrencyNote currency={pricing.currency} />
        <ServicesCatalog />
      </div>
    </>
  );
}
