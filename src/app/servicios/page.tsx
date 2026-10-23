import { ServicesCatalog } from "@/components/ServicesCatalog";

export const dynamic = "force-dynamic";
export const metadata = { title: "Otros servicios" };

export default function ServicesPage() {
  return (
    <>
      <div className="page-head">
        <div className="container">
          <h1>Otros servicios</h1>
          <p>Asesoría personalizada para tu familia y programas para colegios, empresas y entidades públicas.</p>
        </div>
      </div>
      <div className="container section">
        <ServicesCatalog />
      </div>
    </>
  );
}
