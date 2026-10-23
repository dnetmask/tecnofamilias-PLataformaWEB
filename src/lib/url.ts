/** Solo permite redirecciones internas (evita redirecciones abiertas). */
export function safeNext(value: unknown, fallback = "/cuenta") {
  const next = typeof value === "string" ? value : "";
  return next.startsWith("/") && !next.startsWith("//") && !next.startsWith("/\\") ? next : fallback;
}
