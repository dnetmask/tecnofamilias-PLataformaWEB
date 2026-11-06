import { redirect } from "next/navigation";

export const dynamic = "force-dynamic";

/** Dirección de retorno anterior del checkout de Bold: lleva a la página de felicitaciones con los mismos datos. */
export default async function BoldReturnRedirect({ searchParams }: { searchParams: Promise<Record<string, string | undefined>> }) {
  const params = await searchParams;
  const qs = new URLSearchParams(Object.entries(params).filter((e): e is [string, string] => typeof e[1] === "string")).toString();
  redirect(`/masterclass/felicitaciones${qs ? `?${qs}` : ""}`);
}
