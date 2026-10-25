import { redirect } from "next/navigation";
import { getCurrentUser } from "@/lib/auth";
import { isPlatformOpen, isServiceCheckout } from "@/lib/launch";
import { safeNext } from "@/lib/url";
import { LoginForm } from "../AuthForms";

export const metadata = { title: "Ingresar" };

export default async function LoginPage({ searchParams }: { searchParams: Promise<{ next?: string }> }) {
  const { next } = await searchParams;
  if (await getCurrentUser()) redirect(safeNext(next, "/"));
  return (
    <div className="container">
      <div className="card auth-card">
        <h1 style={{ fontSize: "1.8rem" }}>Ingresar</h1>
        <p className="muted">Bienvenido de nuevo a Tecnofamilias.</p>
        <LoginForm next={next ? safeNext(next) : undefined} allowRegister={(await isPlatformOpen()) || isServiceCheckout(next)} />
      </div>
    </div>
  );
}
