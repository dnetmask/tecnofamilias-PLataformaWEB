import { NOINDEX } from "@/lib/site";
import { RequestResetForm } from "../AuthForms";

export const metadata = { title: "Recuperar contraseña", ...NOINDEX };

export default function RequestResetPage() {
  return (
    <div className="container">
      <div className="card auth-card">
        <h1 style={{ fontSize: "1.8rem" }}>Recuperar contraseña</h1>
        <p className="muted">Escribe el correo de tu cuenta y te enviaremos un enlace para crear una nueva contraseña.</p>
        <RequestResetForm />
      </div>
    </div>
  );
}
