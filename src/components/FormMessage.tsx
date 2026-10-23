export type FormState = { error?: string; ok?: string } | undefined;

export function FormMessage({ state }: { state: FormState }) {
  if (state?.error) return <div className="alert alert-error" role="alert">{state.error}</div>;
  if (state?.ok) return <div className="alert alert-ok" role="status">{state.ok}</div>;
  return null;
}
