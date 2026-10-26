export const metadata = { title: "Términos y tratamiento de datos", alternates: { canonical: "/terminos" } };

export default function TermsPage() {
  return (
    <div className="container section" style={{ maxWidth: 800 }}>
      <h1>Términos y tratamiento de datos</h1>
      <p className="alert alert-info">
        Texto base para revisión legal antes de publicar. Debe ajustarse a la Ley 1581 de 2012 (Habeas Data) y sus
        decretos reglamentarios.
      </p>
      <h3>Responsable del tratamiento</h3>
      <p>Tecnofamilias · www.tecnofamilias.com · +57 300 674 0003.</p>
      <h3>Datos que recolectamos</h3>
      <p>
        Nombre, correo y contraseña cifrada para la cuenta; historial de compras; mensajes que publiques en la
        comunidad; y los pactos que crees, que pueden incluir el nombre y la edad de tus hijos y las firmas dibujadas.
      </p>
      <h3>Finalidad</h3>
      <p>
        Prestar el servicio de la plataforma, procesar pagos, moderar la comunidad y enviarte información sobre tu
        cuenta. No vendemos ni cedemos tus datos a terceros.
      </p>
      <h3>Datos de menores</h3>
      <p>
        La cuenta la crea y administra un adulto responsable. Los datos de menores en los pactos solo son visibles para
        el titular de la cuenta y para quien reciba el enlace de firma que el titular comparta.
      </p>
      <h3>Comunidad</h3>
      <p>
        No publiques nombres completos, fotos, colegios ni datos que permitan identificar a menores. Los moderadores
        pueden ocultar contenido que incumpla estas reglas.
      </p>
      <h3>Tus derechos</h3>
      <p>
        Puedes conocer, actualizar, rectificar y solicitar la eliminación de tus datos escribiéndonos. También puedes
        eliminar tus pactos desde la plataforma en cualquier momento.
      </p>
    </div>
  );
}
