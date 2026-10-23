import type { ServiceAudience, ServiceRequestStatus } from "@prisma/client";

export const AUDIENCES: Record<ServiceAudience, { label: string; icon: string; color: string; intro: string }> = {
  FAMILIAS: {
    label: "Familias",
    icon: "🏡",
    color: "var(--red)",
    intro: "Acompañamiento uno a uno para tu hogar.",
  },
  COLEGIOS: {
    label: "Colegios",
    icon: "🏫",
    color: "var(--blue)",
    intro: "Programas de ciudadanía digital para padres, docentes y estudiantes.",
  },
  EMPRESAS: {
    label: "Empresas y cajas de compensación",
    icon: "🏢",
    color: "var(--yellow)",
    intro: "Bienestar digital para los hogares de tus colaboradores.",
  },
  GOBIERNO: {
    label: "Alcaldías y gobernaciones",
    icon: "🏛️",
    color: "var(--navy-soft)",
    intro: "Programa social de seguridad digital familiar para colegios públicos.",
  },
};

export const AUDIENCE_ORDER: ServiceAudience[] = ["FAMILIAS", "COLEGIOS", "EMPRESAS", "GOBIERNO"];

export const REQUEST_STATUS: Record<ServiceRequestStatus, [string, string]> = {
  NEW: ["Nueva", "badge-yellow"],
  PAID: ["Pagado · agendar", "badge-red"],
  CONTACTED: ["Contactado", "badge-blue"],
  WON: ["Contratado", "badge-green"],
  LOST: ["No se concretó", "badge-gray"],
};
