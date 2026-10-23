export function Notice({ error, ok }: { error?: string; ok?: string }) {
  if (error) return <div className="alert alert-error">{error}</div>;
  if (ok) return <div className="alert alert-ok">{ok}</div>;
  return null;
}

export type NoticeParams = Promise<{ error?: string; ok?: string }>;
