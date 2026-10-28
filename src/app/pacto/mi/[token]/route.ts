import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import { PUBLIC_PACT_COOKIE } from "@/lib/pacts";

/**
 * Enlace privado de un pacto creado sin cuenta: guarda el token en una cookie
 * y redirige a /pacto/mi, para que no quede en la dirección que ve la analítica.
 */
export async function GET(_: Request, { params }: { params: Promise<{ token: string }> }) {
  const { token } = await params;
  (await cookies()).set(PUBLIC_PACT_COOKIE, token.slice(0, 100), {
    httpOnly: true,
    secure: process.env.NODE_ENV === "production",
    sameSite: "lax",
    path: "/",
    maxAge: 60 * 60 * 24 * 365,
  });
  redirect("/pacto/mi");
}
