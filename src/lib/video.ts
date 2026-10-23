export type VideoSource =
  | { type: "iframe"; src: string }
  | { type: "file"; src: string }
  | { type: "none" };

/** Convierte una URL de YouTube, Vimeo o archivo de video en algo reproducible. */
export function resolveVideo(url: string): VideoSource {
  if (!url) return { type: "none" };
  let parsed: URL;
  try {
    parsed = new URL(url);
  } catch {
    return { type: "none" };
  }
  if (parsed.protocol !== "https:") return { type: "none" };
  const host = parsed.hostname.replace(/^www\./, "");

  if (host === "youtube.com" || host === "m.youtube.com") {
    const id = parsed.searchParams.get("v") ?? parsed.pathname.match(/^\/(?:embed|shorts|live)\/([\w-]+)/)?.[1];
    if (id) return { type: "iframe", src: `https://www.youtube-nocookie.com/embed/${id}?rel=0` };
  }
  if (host === "youtu.be") {
    const id = parsed.pathname.slice(1);
    if (id) return { type: "iframe", src: `https://www.youtube-nocookie.com/embed/${id}?rel=0` };
  }
  if (host === "vimeo.com") {
    const [, id, hash] = parsed.pathname.split("/");
    if (id && /^\d+$/.test(id)) {
      const h = hash ? `?h=${hash}` : parsed.searchParams.get("h") ? `?h=${parsed.searchParams.get("h")}` : "";
      return { type: "iframe", src: `https://player.vimeo.com/video/${id}${h}` };
    }
  }
  if (host === "player.vimeo.com" || host === "youtube-nocookie.com" || host === "open.spotify.com") {
    return { type: "iframe", src: parsed.toString() };
  }
  if (/\.(mp4|webm|m3u8)$/i.test(parsed.pathname)) return { type: "file", src: parsed.toString() };
  return { type: "none" };
}

/** Embebido de podcast para Spotify; otras plataformas se abren como enlace. */
export function resolvePodcastEmbed(url: string): string | null {
  try {
    const parsed = new URL(url);
    if (parsed.hostname === "open.spotify.com" && /^\/(episode|show)\//.test(parsed.pathname)) {
      return `https://open.spotify.com/embed${parsed.pathname}`;
    }
  } catch {}
  return null;
}
