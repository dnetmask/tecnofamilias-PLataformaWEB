import { NextResponse } from "next/server";
import { boldEnabled, handleBoldEvent, verifyBoldSignature, type BoldEvent } from "@/lib/bold";

export const dynamic = "force-dynamic";

/** Avisos de Bold (venta aprobada, rechazada o anulada). Solo se aceptan si la firma x-bold-signature es válida. */
export async function POST(request: Request) {
  if (!boldEnabled()) return NextResponse.json({ ok: true });
  const raw = await request.text();
  if (!verifyBoldSignature(raw, request.headers.get("x-bold-signature"))) {
    return NextResponse.json({ error: "firma inválida" }, { status: 401 });
  }
  let event: BoldEvent;
  try {
    event = JSON.parse(raw) as BoldEvent;
  } catch {
    return NextResponse.json({ error: "cuerpo inválido" }, { status: 400 });
  }
  try {
    const result = await handleBoldEvent(event);
    if (!result.ok) console.warn("Bold: evento sin efecto", { id: event.id, type: event.type, reason: result.reason });
    return NextResponse.json({ ok: true });
  } catch (err) {
    console.error(err);
    // 500 para que Bold reintente.
    return NextResponse.json({ error: "error procesando" }, { status: 500 });
  }
}
