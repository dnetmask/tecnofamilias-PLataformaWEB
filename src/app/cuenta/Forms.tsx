"use client";

import { useActionState } from "react";
import { FormMessage } from "@/components/FormMessage";
import { SubmitButton } from "@/components/SubmitButton";
import { changePasswordAction, updateProfileAction } from "./actions";

export function ProfileForm({ name, email }: { name: string; email: string }) {
  const [state, action] = useActionState(updateProfileAction, undefined);
  return (
    <form action={action} className="form">
      <div className="field">
        <label htmlFor="name">Nombre</label>
        <input className="input" id="name" name="name" defaultValue={name} required />
      </div>
      <div className="field">
        <label>Correo</label>
        <input className="input" value={email} disabled />
      </div>
      <FormMessage state={state} />
      <div><SubmitButton className="btn btn-sm">Guardar</SubmitButton></div>
    </form>
  );
}

export function PasswordForm() {
  const [state, action] = useActionState(changePasswordAction, undefined);
  return (
    <form action={action} className="form">
      <div className="field">
        <label htmlFor="current">Contraseña actual</label>
        <input className="input" id="current" name="current" type="password" autoComplete="current-password" required />
      </div>
      <div className="field">
        <label htmlFor="next">Nueva contraseña</label>
        <input className="input" id="next" name="next" type="password" minLength={8} autoComplete="new-password" required />
      </div>
      <FormMessage state={state} />
      <div><SubmitButton className="btn btn-sm">Cambiar contraseña</SubmitButton></div>
    </form>
  );
}
