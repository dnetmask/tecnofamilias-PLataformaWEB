"use server";

import { randomBytes } from "node:crypto";
import { revalidatePath } from "next/cache";
import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import type { FormState } from "@/components/FormMessage";
import { getCurrentUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { newShareToken, pactSchema, parseReviewDate, PUBLIC_PACT_COOKIE, readClauses, signatureSchema } from "@/lib/pacts";

const COOKIE_MAX_AGE = 60 * 60 * 24 * 365; // 1 año

/**
 * Crea un pacto desde el enlace público de una plantilla. Sin sesión queda sin
 * dueño y con un enlace privado (manageToken) para volver; con sesión queda en
 * la cuenta como cualquier otro pacto.
 */
export async function createPublicPactAction(_: FormState, formData: FormData): Promise<FormState> {
  if (formData.get("website")) return { error: "No se pudo crear el pacto." }; // campo trampa para bots
  const template = await db.pactTemplate.findUnique({ where: { id: String(formData.get("templateId") ?? "") } });
  if (!template || !template.published || !template.public) return { error: "Este pacto ya no está disponible." };
  if (formData.get("terms") !== "on") return { error: "Debes aceptar los términos y el tratamiento de datos" };
  const parsed = pactSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) return { error: parsed.error.issues[0].message };
  const clauses = readClauses(formData);
  if (clauses.length === 0) return { error: "Agrega al menos una cláusula" };

  const user = await getCurrentUser();
  const { templateId: _t, reviewDate, childAge, ...data } = parsed.data;
  const manageToken = user ? null : randomBytes(24).toString("base64url");
  const pact = await db.pact.create({
    data: {
      ...data,
      childAge: childAge ?? null,
      clauses,
      reviewDate: parseReviewDate(reviewDate),
      templateId: template.id,
      userId: user?.id ?? null,
      shareToken: newShareToken(),
      manageToken,
    },
  });
  if (user) redirect(`/pactos/${pact.id}`);
  (await cookies()).set(PUBLIC_PACT_COOKIE, manageToken!, { httpOnly: true, secure: process.env.NODE_ENV === "production", sameSite: "lax", path: "/", maxAge: COOKIE_MAX_AGE });
  redirect("/pacto/mi?nuevo=1");
}

async function cookiePact() {
  const token = (await cookies()).get(PUBLIC_PACT_COOKIE)?.value;
  return token ? db.pact.findUnique({ where: { manageToken: token } }) : null;
}

/** Firma del adulto en un pacto creado sin cuenta. */
export async function signPublicParentAction(_: FormState, formData: FormData): Promise<FormState> {
  const pact = await cookiePact();
  if (!pact) return { error: "No encontramos tu pacto. Ábrelo de nuevo con tu enlace privado." };
  if (pact.parentSignature) return { error: "Ya firmaste este pacto" };
  const sig = signatureSchema.safeParse(formData.get("signature"));
  if (!sig.success) return { error: "Dibuja la firma antes de confirmar" };
  await db.pact.update({ where: { id: pact.id }, data: { parentSignature: sig.data, parentSignedAt: new Date(), status: "PARENT_SIGNED" } });
  revalidatePath("/pacto/mi");
  return { ok: "¡Firma guardada!" };
}

/** Borra el pacto creado sin cuenta (sus datos y firmas). */
export async function deletePublicPactAction() {
  const pact = await cookiePact();
  if (pact) await db.pact.delete({ where: { id: pact.id } });
  (await cookies()).delete(PUBLIC_PACT_COOKIE);
  redirect("/pacto/mi?eliminado=1");
}
