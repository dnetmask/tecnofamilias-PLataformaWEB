import "server-only";
import { cache } from "react";
import { db } from "./db";

/** Lanzamiento de la plataforma: mientras está cerrada, el plan y la creación de cuentas se muestran como "Próximamente". */
export const PLATFORM_KEY = "platform";

export const isPlatformOpen = cache(async () => {
  const row = await db.setting.findUnique({ where: { key: PLATFORM_KEY } });
  return (row?.value as { open?: boolean } | null)?.open === true;
});

/** Con la plataforma cerrada solo se crean cuentas para comprar un servicio (p. ej. la asesoría). */
export function isServiceCheckout(next: unknown) {
  return typeof next === "string" && next.startsWith("/checkout?servicio=");
}
