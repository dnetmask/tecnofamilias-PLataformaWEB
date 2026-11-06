import { NextResponse } from "next/server";
import { getCurrentUser } from "@/lib/auth";
import { boldEnabled, createBoldMasterclassOrder } from "@/lib/bold";

export const dynamic = "force-dynamic";

/** Crea la orden de la masterclass y devuelve los datos firmados para el checkout de Bold (el valor lo pone el servidor). */
export async function POST(request: Request) {
  if (!boldEnabled()) return NextResponse.json({ error: "Bold no está disponible" }, { status: 503 });
  const body = (await request.json().catch(() => ({}))) as { currency?: string };
  const currency = body.currency === "USD" ? "USD" : body.currency === "COP" ? "COP" : null;
  if (!currency) return NextResponse.json({ error: "Moneda no válida" }, { status: 400 });
  try {
    const user = await getCurrentUser();
    return NextResponse.json(await createBoldMasterclassOrder(currency, user?.id ?? null));
  } catch (err) {
    console.error(err);
    return NextResponse.json({ error: "No pudimos iniciar el pago" }, { status: 500 });
  }
}
