import { NextResponse } from "next/server";
import { getCurrentUser } from "@/lib/auth";
import { createMasterclassOrder, paypalClientId } from "@/lib/paypal";

export const dynamic = "force-dynamic";

/** Crea la orden de PayPal de la masterclass (el valor lo pone el servidor). */
export async function POST() {
  if (!paypalClientId()) return NextResponse.json({ error: "PayPal no está disponible" }, { status: 503 });
  try {
    const user = await getCurrentUser();
    const id = await createMasterclassOrder(user?.id ?? null);
    return NextResponse.json({ id });
  } catch (err) {
    console.error(err);
    return NextResponse.json({ error: "No pudimos iniciar el pago con PayPal" }, { status: 500 });
  }
}
