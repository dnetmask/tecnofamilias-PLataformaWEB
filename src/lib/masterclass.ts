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
  /** Enlace de pago de Mercado Pago. Vacío: se compra con el checkout de la plataforma. */
  paymentLink: string;
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
};

/** Solo se aceptan enlaces de pago de Mercado Pago. */
export const MP_LINK_PATTERN = /^https:\/\/(mpago\.(li|la)|link\.mercadopago\.com(\.[a-z]{2})?|(www\.)?mercadopago\.com(\.[a-z]{2})?)\/\S+$/;

export const MASTERCLASS_DEFAULTS: MasterclassSetting = {
  serviceSlug: "masterclass-crianza-digital-segura",
  date: "2026-12-15",
  time: "6:00 p. m. a 9:00 p. m.",
  timezone: "hora de Colombia",
  modality: "En vivo por Zoom",
  duration: "3 horas",
  seatsPct: 63,
  recordingDays: 30,
  showOnHome: true,
  paymentLink: "https://mpago.li/2TeDwDw",
  paymentAmountCop: 165000,
  testLink: "https://mpago.li/1WMMqMR",
  testAmountCop: 5000,
  paypalButtonId: "A7S5EMQ4D2QV8",
  paypalAmountUsd: 60,
  paypalTestButtonId: "",
  paypalTestAmountUsd: 2,
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
