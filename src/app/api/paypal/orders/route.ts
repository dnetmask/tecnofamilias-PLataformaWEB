import { NextResponse } from "next/server";
import { getCurrentUser } from "@/lib/auth";
import { createMasterclassOrder, paypalEnabled } from "@/lib/paypal";

export const dynamic = "force-dynamic";

/** Crea la orden de PayPal de la masterclass (el valor lo pone el servidor) y devuelve su página de pago. */
export async function POST() {
  if (!paypalEnabled()) return NextResponse.json({ error: "PayPal no está disponible" }, { status: 503 });
  try {
    const user = await getCurrentUser();
    const url = await createMasterclassOrder(user?.id ?? null);
    return NextResponse.json({ url });
  } catch (err) {
    console.error(err);
    return NextResponse.json({ error: "No pudimos iniciar el pago con PayPal" }, { status: 500 });
  }
}
