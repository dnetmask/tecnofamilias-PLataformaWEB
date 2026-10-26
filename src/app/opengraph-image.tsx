import { ImageResponse } from "next/og";
import { SITE_TAGLINE } from "@/lib/site";

export const alt = "Tecnofamilias · Seguridad digital y control parental para familias";
export const size = { width: 1200, height: 630 };
export const contentType = "image/png";

/** Imagen que se ve al compartir el sitio en WhatsApp, redes y buscadores. */
export default function OpengraphImage() {
  return new ImageResponse(
    (
      <div style={{ width: "100%", height: "100%", display: "flex", flexDirection: "column", justifyContent: "center", padding: "0 90px", background: "#28395f", color: "#fff", position: "relative" }}>
        <div style={{ position: "absolute", right: -80, top: -80, width: 420, height: 420, borderRadius: 999, background: "#3daee4", display: "flex" }} />
        <div style={{ position: "absolute", right: 240, bottom: 40, width: 150, height: 150, borderRadius: 999, background: "#fdbf2e", display: "flex" }} />
        <div style={{ position: "absolute", right: 120, top: 330, width: 90, height: 90, borderRadius: 999, background: "#ee4836", display: "flex" }} />
        <div style={{ display: "flex", fontSize: 44, fontWeight: 800 }}>
          <span style={{ color: "#fdbf2e" }}>Tecno</span>
          <span style={{ color: "#ee4836" }}>familias</span>
        </div>
        <div style={{ display: "flex", fontSize: 72, fontWeight: 800, lineHeight: 1.1, marginTop: 24, maxWidth: 820 }}>Protege a tu familia en el mundo digital</div>
        <div style={{ display: "flex", fontSize: 32, marginTop: 24, color: "#dce6f2" }}>{SITE_TAGLINE}</div>
      </div>
    ),
    size,
  );
}
