"use server";

import { z } from "zod";
import type { FormState } from "@/components/FormMessage";
import { getCurrentUser } from "@/lib/auth";
import { db } from "@/lib/db";

const requestSchema = z.object({
  serviceId: z.string().min(1),
  name: z.string().trim().min(2, "Escribe tu nombre").max(100),
  email: z.string().trim().toLowerCase().email("Correo no válido"),
  phone: z.string().trim().min(7, "Escribe un teléfono de contacto").max(30),
  organization: z.string().trim().max(150).default(""),
  city: z.string().trim().max(80).default(""),
  message: z.string().trim().max(3000).default(""),
  consent: z.literal("on", { errorMap: () => ({ message: "Debes autorizar el tratamiento de datos para que te contactemos" }) }),
});

export async function requestQuoteAction(_: FormState, formData: FormData): Promise<FormState> {
  // Campo trampa: los bots lo llenan, las personas no lo ven.
  if (formData.get("website")) return { ok: "¡Gracias! Te contactaremos pronto." };

  const parsed = requestSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) return { error: parsed.error.issues[0].message };
  const { consent: _c, serviceId, ...data } = parsed.data;

  const service = await db.service.findUnique({ where: { id: serviceId } });
  if (!service || !service.active) return { error: "Servicio no disponible" };
  if (service.audience !== "FAMILIAS" && !data.organization) {
    return { error: "Escribe el nombre de la institución o empresa" };
  }

  // Freno básico contra envíos repetidos.
  const recent = await db.serviceRequest.count({
    where: { email: data.email, createdAt: { gt: new Date(Date.now() - 10 * 60_000) } },
  });
  if (recent >= 3) return { error: "Ya recibimos tus solicitudes. Te contactaremos pronto." };

  const user = await getCurrentUser();
  await db.serviceRequest.create({ data: { ...data, serviceId: service.id, userId: user?.id ?? null } });
  return { ok: "¡Gracias! Recibimos tu solicitud y te contactaremos en los próximos días hábiles." };
}
