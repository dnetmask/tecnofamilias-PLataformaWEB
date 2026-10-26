/** WhatsApp de Tecnofamilias (botón flotante y servicios que se atienden por chat). */
export const WHATSAPP_NUMBER = "573006740003";

/** Servicios que por ahora se atienden por WhatsApp en lugar de comprarse en línea. */
export const WHATSAPP_SERVICES = new Set(["asesoria-personalizada"]);

/** Mensaje prellenado para pedir información o cotización de un servicio. */
export function serviceWhatsappUrl(service: { slug: string; name: string; priceUsd: number | null }) {
  const text = WHATSAPP_SERVICES.has(service.slug) || service.priceUsd
    ? `Hola Tecnofamilias, quiero información sobre ${service.name}.`
    : `Hola Tecnofamilias, quiero solicitar una cotización de “${service.name}”.`;
  return whatsappUrl(text);
}

export function whatsappUrl(text?: string) {
  return `https://wa.me/${WHATSAPP_NUMBER}${text ? `?text=${encodeURIComponent(text)}` : ""}`;
}
