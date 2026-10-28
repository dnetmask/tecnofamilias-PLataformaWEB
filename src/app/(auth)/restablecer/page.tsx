import Link from "next/link";
import { cookies } from "next/headers";
import { findValidResetToken, RESET_COOKIE } from "@/lib/account";
import { NOINDEX } from "@/lib/site";
import { ResetPasswordForm } from "../AuthForms";

export const dynamic = "force-dynamic";
export const metadata = { title: "Nueva contraseña", ...NOINDEX };

export default async function ResetPasswordPage() {
  const row = await findValidResetToken((await cookies()).get(RESET_COOKIE)?.value ?? "");
  return (
    <div className="container">
      <div className="card auth-card">
        <h1 style={{ fontSize: "1.8rem" }}>Nueva contraseña</h1>
        {row ? (
          <>
            <p className="muted">Crea una nueva contraseña para {row.user.email}. Al guardarla se cierra la sesión en tus otros dispositivos.</p>
            <ResetPasswordForm />
          </>
        ) : (
          <>
            <p className="muted">Este enlace venció o ya se usó. Los enlaces sirven una sola vez durante 1 hora.</p>
            <Link className="btn" href="/recuperar">Pedir un enlace nuevo</Link>
          </>
        )}
      </div>
    </div>
  );
}
