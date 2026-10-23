import { redirect } from "next/navigation";
import { getCurrentUser } from "@/lib/auth";
import { safeNext } from "@/lib/url";
import { RegisterForm } from "../AuthForms";

export const metadata = { title: "Crear cuenta" };

export default async function RegisterPage({ searchParams }: { searchParams: Promise<{ next?: string }> }) {
  const { next } = await searchParams;
  if (await getCurrentUser()) redirect(safeNext(next));
  return (
    <div className="container">
      <div className="card auth-card">
        <h1 style={{ fontSize: "1.8rem" }}>Crea tu cuenta</h1>
        <p className="muted">Crea tu cuenta y elige tu plan para acceder a todo el contenido.</p>
        <RegisterForm next={next ? safeNext(next) : undefined} />
      </div>
    </div>
  );
}
