/** Dominio principal (canónico) para buscadores, redes sociales y asistentes de IA. */
export const SITE_URL = (process.env.SITE_URL ?? "https://tecnofamilias.com").replace(/\/$/, "");

export const SITE_NAME = "Tecnofamilias";
export const SITE_TAGLINE = "Seguridad digital y control parental para familias";
export const SITE_DESCRIPTION =
  "Tecnofamilias ayuda a padres y madres de habla hispana a proteger a sus hijos en internet: control parental, ciberseguridad para el hogar, prevención del grooming, ciberacoso y sexting, pactos digitales y recursos por edad.";

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
