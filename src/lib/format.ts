import type { AgeStage, LessonAccess, ResourceKind } from "@prisma/client";

/** Montos realmente cobrados o administrativos (siempre en COP). */
export function formatCop(value: number) {
  return new Intl.NumberFormat("es-CO", {
    style: "currency",
    currency: "COP",
    currencyDisplay: "code",
    maximumFractionDigits: 0,
  }).format(value);
}

export function formatDate(value: Date | string) {
  return new Intl.DateTimeFormat("es-CO", { dateStyle: "long", timeZone: "America/Bogota" }).format(
    new Date(value),
  );
}

export function formatDateTime(value: Date | string) {
  return new Intl.DateTimeFormat("es-CO", {
    dateStyle: "medium",
    timeStyle: "short",
    timeZone: "America/Bogota",
  }).format(new Date(value));
}

export const AGE_STAGES: { value: AgeStage; label: string; short: string; hint: string }[] = [
  { value: "ALL", label: "Todas las edades", short: "Todas", hint: "Riesgos principales y plan familiar" },
  { value: "AGE_0_5", label: "0 a 5 años · Inicio digital", short: "0–5", hint: "Videos, series y YouTube Kids" },
  { value: "AGE_6_10", label: "6 a 10 años · Juego online", short: "6–10", hint: "Roblox, Minecraft y chats de juego" },
  { value: "AGE_11_13", label: "11 a 13 años · Móvil propio", short: "11–13", hint: "Primeras redes y contacto con extraños" },
  { value: "AGE_14_17", label: "14 a 17 años · Socialización intensa", short: "14–17", hint: "Sexting, apuestas y ciberacoso" },
];

export function stageLabel(stage: AgeStage) {
  return AGE_STAGES.find((s) => s.value === stage)?.label ?? stage;
}

export function stageShort(stage: AgeStage) {
  return AGE_STAGES.find((s) => s.value === stage)?.short ?? stage;
}

export const ACCESS_LABELS: Record<LessonAccess, string> = {
  INCLUDED: "Incluida en la suscripción",
  ADDON: "Complemento",
};

export const RESOURCE_LABELS: Record<ResourceKind, string> = {
  VIDEO: "Video",
  PODCAST: "Podcast",
};

export function slugify(text: string) {
  return text
    .normalize("NFD")
    .replace(/[̀-ͯ]/g, "")
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .slice(0, 80);
}
