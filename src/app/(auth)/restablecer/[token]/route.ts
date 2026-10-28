import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import { RESET_COOKIE } from "@/lib/account";

/**
 * El enlace del correo pasa el token a una cookie privada y redirige a
 * /restablecer, para que el token no quede en la dirección que ven la
 * analítica, el historial o quien mire la pantalla.
 */
export async function GET(_: Request, { params }: { params: Promise<{ token: string }> }) {
  const { token } = await params;
  (await cookies()).set(RESET_COOKIE, token.slice(0, 100), {
    httpOnly: true,
    secure: process.env.NODE_ENV === "production",
    sameSite: "lax",
    path: "/",
    maxAge: 60 * 60,
  });
  redirect("/restablecer");
}
