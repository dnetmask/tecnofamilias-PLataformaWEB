import { NextResponse } from "next/server";
import { captureOrder } from "@/lib/paypal";

export const dynamic = "force-dynamic";

/** Captura el pago aprobado en PayPal y reserva el cupo. */
export async function POST(_: Request, { params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  if (!/^[A-Z0-9]{5,40}$/.test(id)) return NextResponse.json({ error: "Orden no válida" }, { status: 400 });
  try {
    const result = await captureOrder(id);
    return NextResponse.json(result, { status: result.ok ? 200 : 402 });
  } catch (err) {
    console.error(err);
    return NextResponse.json({ ok: false, reason: "error" }, { status: 500 });
  }
}
