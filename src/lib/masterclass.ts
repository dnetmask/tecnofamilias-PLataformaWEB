import "server-only";
import { cache } from "react";
import { db } from "./db";

export const MASTERCLASS_KEY = "masterclass";

export type MasterclassSetting = {
  serviceSlug: string;
  /** Fecha del evento (AAAA-MM-DD, hora de Colombia). */
  date: string;
  time: string;
  timezone: string;
  modality: string;
  duration: string;
  /** Porcentaje de cupos ocupados que se muestra en la barra. */
  seatsPct: number;
  recordingDays: number;
  showOnHome: boolean;
  /** Enlace de pago en pesos (Bold o Mercado Pago). Vacío: se compra con el checkout de la plataforma. */
  paymentLink: string;
  /** Enlace de pago en dólares (Bold). Si está, reemplaza al checkout de PayPal. */
  usdLink: string;
  /** Valor en pesos que cobra el enlace de pago (se muestra en la landing). */
  paymentAmountCop: number;
  /** Enlace de pago de prueba (valor bajo) para verificar el flujo; vacío lo oculta. */
  testLink: string;
  testAmountCop: number;
  /** Pago en dólares con un botón de PayPal (su página de pago); sin ID no se muestra. */
  paypalButtonId: string;
  paypalAmountUsd: number;
  /** Botón de PayPal de prueba (valor bajo) para verificar pagos internacionales; vacío lo oculta. */
  paypalTestButtonId: string;
  paypalTestAmountUsd: number;
  /** Enlace de pago de prueba en dólares (Bold, valor bajo); si está, reemplaza al botón de prueba de PayPal. */
  usdTestLink: string;
  usdTestAmountUsd: number;
  /** Pagos de prueba con el checkout embebido de Bold (webhook y API completos, no reservan cupo); 0 los oculta. */
  boldTestAmountCop: number;
  boldTestAmountUsd: number;
};

/** Solo se aceptan enlaces de pago de Bold o de Mercado Pago. */
export const PAY_LINK_PATTERN =
  /^https:\/\/(checkout\.bold\.co\/payment\/[A-Za-z0-9_-]+|(mpago\.(li|la)|link\.mercadopago\.com(\.[a-z]{2})?|(www\.)?mercadopago\.com(\.[a-z]{2})?)\/\S+)$/;

/** Nombre de la pasarela de un enlace de pago, para mostrarlo en la landing. */
export function payLinkProvider(url: string) {
  return url.startsWith("https://checkout.bold.co/") ? "Bold" : "Mercado Pago";
}

export const MASTERCLASS_DEFAULTS: MasterclassSetting = {
  serviceSlug: "masterclass-crianza-digital-segura",
  date: "2026-12-15",
  time: "6:00 p. m. a 9:00 p. m.",
  timezone: "hora de Colombia",
  modality: "En vivo por Zoom",
  duration: "3 horas",
  seatsPct: 13,
  recordingDays: 30,
  showOnHome: true,
  paymentLink: "https://checkout.bold.co/payment/LNK_T2129MVLCM",
  usdLink: "https://checkout.bold.co/payment/LNK_YIB3XFGAGO",
  paymentAmountCop: 165000,
  testLink: "",
  testAmountCop: 5000,
  paypalButtonId: "",
  paypalAmountUsd: 60,
  paypalTestButtonId: "",
  paypalTestAmountUsd: 3,
  usdTestLink: "",
  usdTestAmountUsd: 2,
  boldTestAmountCop: 0,
  boldTestAmountUsd: 0,
};

export const getMasterclass = cache(async () => {
  const row = await db.setting.findUnique({ where: { key: MASTERCLASS_KEY } });
  const setting = { ...MASTERCLASS_DEFAULTS, ...((row?.value ?? {}) as Partial<MasterclassSetting>) };
  const service = await db.service.findUnique({ where: { slug: setting.serviceSlug } });
  // Mediodía en Bogotá para que la fecha no cambie por zona horaria.
  const day = new Date(`${setting.date}T12:00:00-05:00`);
  const dateLabel = new Intl.DateTimeFormat("es-CO", { weekday: "long", day: "numeric", month: "long", timeZone: "America/Bogota" }).format(day);
  const shortDate = new Intl.DateTimeFormat("es-CO", { day: "numeric", month: "long", timeZone: "America/Bogota" }).format(day);
  const endOfDay = new Date(`${setting.date}T23:59:59-05:00`);
  return {
    ...setting,
    seatsPct: Math.max(0, Math.min(100, Math.round(setting.seatsPct))),
    service,
    dateLabel: dateLabel.charAt(0).toUpperCase() + dateLabel.slice(1),
    shortDate,
    isPast: endOfDay < new Date(),
  };
});
