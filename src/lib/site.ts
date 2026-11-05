/** Dominio principal (canónico) para buscadores, redes sociales y asistentes de IA. */
export const SITE_URL = (process.env.SITE_URL ?? "https://tecnofamilias.com").replace(/\/$/, "");

export const SITE_NAME = "Tecnofamilias";
export const SITE_TAGLINE = "Seguridad digital y control parental para familias";
export const SITE_DESCRIPTION =
  "Tecnofamilias ayuda a padres y madres de habla hispana a proteger a sus hijos en internet: control parental, ciberseguridad para el hogar, prevención del grooming, ciberacoso y sexting, pactos digitales y recursos por edad.";

/** Datos legales del titular del sitio (RUT). Se muestran en el pie, los términos y los datos estructurados. */
export const LEGAL = {
  name: "Tecnofamilias S.A.S.",
  nit: "901.582.109-9",
  address: "Carrera 27B # 37B Sur 83, oficina 706",
  city: "Envigado",
  region: "Antioquia",
  postalCode: "055421",
  country: "Colombia",
  email: "hola@tecnofamilias.com",
  phone: "+57 300 674 0003",
} as const;

/** Metadatos de una página pública: título, descripción y URL canónica. */
export function pageMeta(path: string, title: string, description: string) {
  const url = `${SITE_URL}${path}`;
  return {
    title,
    description,
    alternates: { canonical: url },
    openGraph: { title, description, url },
  };
}

/** Páginas privadas o de transacción: fuera de los buscadores. */
export const NOINDEX = { robots: { index: false, follow: false } } as const;
