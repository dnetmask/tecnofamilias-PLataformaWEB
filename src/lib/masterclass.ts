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
};

export const MASTERCLASS_DEFAULTS: MasterclassSetting = {
  serviceSlug: "masterclass-crianza-digital-segura",
  date: "2026-11-26",
  time: "6:00 p. m. a 9:00 p. m.",
  timezone: "hora de Colombia",
  modality: "En vivo por Zoom",
  duration: "3 horas",
  seatsPct: 63,
  recordingDays: 30,
  showOnHome: true,
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
