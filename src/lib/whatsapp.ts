/** WhatsApp de Tecnofamilias (botón flotante y servicios que se atienden por chat). */
export const WHATSAPP_NUMBER = "573006740003";

/** Servicios que por ahora se atienden por WhatsApp en lugar de comprarse en línea. */
export const WHATSAPP_SERVICES = new Set(["asesoria-personalizada"]);

export function whatsappUrl(text?: string) {
  return `https://wa.me/${WHATSAPP_NUMBER}${text ? `?text=${encodeURIComponent(text)}` : ""}`;
}
