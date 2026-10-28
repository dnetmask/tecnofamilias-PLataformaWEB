import "server-only";
import { randomBytes } from "node:crypto";
import { z } from "zod";

/** Utilidades compartidas por los pactos con cuenta y los creados sin cuenta (/pacto). */

export const newShareToken = () => randomBytes(24).toString("base64url");

export const pactSchema = z.object({
  templateId: z.string().optional(),
  appName: z.string().trim().min(2, "Indica la aplicación o el dispositivo").max(60),
  childName: z.string().trim().min(1, "Escribe el nombre de tu hijo o hija").max(60),
  childAge: z.preprocess((v) => (v === "" ? undefined : v), z.coerce.number().int().min(0).max(25).optional()),
  parentName: z.string().trim().min(2, "Escribe tu nombre").max(80),
  rewards: z.string().trim().max(1000).default(""),
  consequences: z.string().trim().max(1000).default(""),
  reviewDate: z.string().optional(),
});

export function readClauses(formData: FormData) {
  return formData
    .getAll("clause")
    .map((c) => String(c).trim())
    .filter(Boolean)
    .slice(0, 30)
    .map((c) => c.slice(0, 400));
}

export function parseReviewDate(value?: string) {
  if (!value) return null;
  const d = new Date(`${value}T12:00:00-05:00`);
  return Number.isNaN(d.getTime()) ? null : d;
}

export const signatureSchema = z
  .string()
  .startsWith("data:image/png;base64,", "Firma no válida")
  .max(400_000, "La firma es demasiado grande");

/** Cookie con el enlace privado del último pacto creado sin cuenta en este navegador. */
export const PUBLIC_PACT_COOKIE = "tf_pacto";
