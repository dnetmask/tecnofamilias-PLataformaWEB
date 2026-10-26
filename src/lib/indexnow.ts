import "server-only";
import { SITE_URL } from "./site";

/** Clave de IndexNow (el archivo public/<clave>.txt demuestra que el sitio es nuestro). */
export const INDEXNOW_KEY = "b6c69f2b70cc98e4a512007219e4ba97";

/**
 * Avisa a Bing (y a los demás buscadores de IndexNow: Yandex, Seznam, Naver)
 * que estas URLs son nuevas o cambiaron. Solo corre en producción.
 */
export async function notifyIndexNow(urls: string[]): Promise<{ ok: boolean; status: number | null; count: number }> {
  const list = [...new Set(urls)].filter((u) => u.startsWith(SITE_URL)).slice(0, 10000);
  if (!list.length || process.env.VERCEL_ENV !== "production") return { ok: false, status: null, count: 0 };
  try {
    const res = await fetch("https://api.indexnow.org/indexnow", {
      method: "POST",
      headers: { "Content-Type": "application/json; charset=utf-8" },
      body: JSON.stringify({ host: new URL(SITE_URL).host, key: INDEXNOW_KEY, keyLocation: `${SITE_URL}/${INDEXNOW_KEY}.txt`, urlList: list }),
      signal: AbortSignal.timeout(8000),
    });
    return { ok: res.ok, status: res.status, count: list.length };
  } catch {
    return { ok: false, status: null, count: list.length };
  }
}
