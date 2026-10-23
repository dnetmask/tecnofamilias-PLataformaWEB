"use client";

import Link from "next/link";
import { useActionState } from "react";
import { FormMessage } from "@/components/FormMessage";
import { SubmitButton } from "@/components/SubmitButton";
import { loginAction, registerAction } from "./actions";

export function LoginForm({ next }: { next?: string }) {
  const [state, action] = useActionState(loginAction, undefined);
  return (
    <form action={action} className="form">
      <FormMessage state={state} />
      {next && <input type="hidden" name="next" value={next} />}
      <div className="field">
        <label htmlFor="email">Correo</label>
        <input className="input" id="email" name="email" type="email" autoComplete="email" required />
      </div>
      <div className="field">
        <label htmlFor="password">Contraseña</label>
        <input className="input" id="password" name="password" type="password" autoComplete="current-password" required />
      </div>
      <SubmitButton pendingText="Ingresando…">Ingresar</SubmitButton>
      <p className="small muted center">
        ¿No tienes cuenta? <Link href={next ? `/registro?next=${encodeURIComponent(next)}` : "/registro"}>Créala aquí</Link>
      </p>
    </form>
  );
}

export function RegisterForm({ next }: { next?: string }) {
  const [state, action] = useActionState(registerAction, undefined);
  return (
    <form action={action} className="form">
      <FormMessage state={state} />
      {next && <input type="hidden" name="next" value={next} />}
      <div className="field">
        <label htmlFor="name">Nombre completo</label>
        <input className="input" id="name" name="name" autoComplete="name" required />
      </div>
      <div className="field">
        <label htmlFor="email">Correo</label>
        <input className="input" id="email" name="email" type="email" autoComplete="email" required />
      </div>
      <div className="field">
        <label htmlFor="password">Contraseña</label>
        <input className="input" id="password" name="password" type="password" minLength={8} autoComplete="new-password" required />
        <span className="hint">Mínimo 8 caracteres.</span>
      </div>
      <label className="check">
        <input type="checkbox" name="terms" required />
        <span>
          Acepto los <Link href="/terminos" target="_blank">términos y la política de tratamiento de datos</Link>.
        </span>
      </label>
      <SubmitButton pendingText="Creando cuenta…">Crear cuenta</SubmitButton>
      <p className="small muted center">
        ¿Ya tienes cuenta? <Link href="/ingresar">Ingresa</Link>
      </p>
    </form>
  );
}
