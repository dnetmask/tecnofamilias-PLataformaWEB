import "server-only";
import type { Pact } from "@prisma/client";
import { PDFDocument, type PDFFont, type PDFPage, rgb, StandardFonts } from "pdf-lib";
import { formatDate, formatDateTime, slugify } from "./format";

const NAVY = rgb(0x28 / 255, 0x3a / 255, 0x60 / 255);
const INK = rgb(0.16, 0.2, 0.3);
const MUTED = rgb(0.42, 0.47, 0.57);
const BLUE = rgb(0x3d / 255, 0xae / 255, 0xe4 / 255);
const YELLOW = rgb(0xfd / 255, 0xbe / 255, 0x30 / 255);
const RED = rgb(0xef / 255, 0x4a / 255, 0x37 / 255);

const PAGE = { w: 595.28, h: 841.89 }; // A4 vertical
const MARGIN = 50;
const FOOTER = 28;
const SIGN_BLOCK = 128; // alto del bloque de firmas (lado a lado)

// Signos tipográficos que sí existen en las fuentes estándar del PDF (WinAnsi).
const EXTRA = new Set([0x201c, 0x201d, 0x2018, 0x2019, 0x2013, 0x2014, 0x2026, 0x2022, 0x20ac]);

/** Las fuentes estándar del PDF solo cubren Latin-1 y algunos signos: se quitan emojis y símbolos raros. */
function safe(text: string) {
  let out = "";
  for (const ch of text.replace(/\r/g, "")) {
    const c = ch.codePointAt(0)!;
    if (c === 0x2028 || c === 0x2029) out += "\n";
    else if (c === 10 || (c >= 0x20 && c <= 0x7e) || (c >= 0xa0 && c <= 0xff) || EXTRA.has(c)) out += ch;
  }
  // Al quitar un emoji no debe quedar un espacio suelto antes de la puntuación.
  return out.replace(/ +([.,;:!?])/g, "$1");
}

function wrap(text: string, font: PDFFont, size: number, width: number) {
  const lines: string[] = [];
  for (const para of safe(text).split("\n")) {
    let line = "";
    for (const word of para.split(/\s+/).filter(Boolean)) {
      const next = line ? `${line} ${word}` : word;
      if (font.widthOfTextAtSize(next, size) <= width) line = next;
      else {
        if (line) lines.push(line);
        line = word;
      }
    }
    lines.push(line);
  }
  return lines;
}

/** Nombre de archivo para descargar el pacto. */
export function pactFileName(pact: Pick<Pact, "appName" | "childName">) {
  return `pacto-${slugify(`${pact.appName} ${pact.childName}`) || "tecnofamilias"}.pdf`;
}

type Fonts = { regular: PDFFont; bold: PDFFont };

/**
 * Escribe el cuerpo del pacto con la escala de letra dada y devuelve dónde
 * terminó. Con page = null solo mide, para elegir la escala que cabe en una hoja.
 */
function layoutBody(pact: Pact, f: Fonts, k: number, page: PDFPage | null) {
  const width = PAGE.w - MARGIN * 2;
  let y = PAGE.h - MARGIN - 44; // debajo del encabezado
  const text = (t: string, o: { bold?: boolean; size: number; color?: typeof INK; x?: number; gap?: number }) => {
    const font = o.bold ? f.bold : f.regular;
    const size = o.size * k;
    const x = o.x ?? MARGIN;
    for (const line of wrap(t, font, size, width - (x - MARGIN))) {
      page?.drawText(line, { x, y: y - size, size, font, color: o.color ?? INK });
      y -= size * 1.42;
    }
    y -= (o.gap ?? 0) * k;
  };

  text(`Pacto para usar ${pact.appName}`, { bold: true, size: 20, color: NAVY, gap: 6 });
  text(`Nosotros, ${pact.parentName} y ${pact.childName}${pact.childAge != null ? ` (${pact.childAge} años)` : ""}, acordamos lo siguiente:`, { size: 11.5, gap: 6 });
  const clauses = Array.isArray(pact.clauses) ? (pact.clauses as string[]) : [];
  clauses.forEach((c, i) => {
    page?.drawText(`${i + 1}.`, { x: MARGIN + 4, y: y - 11.5 * k, size: 11.5 * k, font: f.bold, color: NAVY });
    text(c, { size: 11.5, x: MARGIN + 26, gap: 3 });
  });
  y -= 4 * k;
  for (const [title, body] of [["Si cumplimos", pact.rewards], ["Si no cumplimos", pact.consequences]] as const) {
    if (!body) continue;
    text(title, { bold: true, size: 12.5, color: NAVY, gap: 1 });
    text(body, { size: 11.5, gap: 6 });
  }
  if (pact.reviewDate) text(`Revisaremos este pacto juntos el ${formatDate(pact.reviewDate)}.`, { size: 11, color: MUTED, gap: 4 });
  return y;
}

/** Arma el pacto con sus firmas en un PDF A4 vertical de una sola hoja. */
export async function renderPactPdf(pact: Pact) {
  const doc = await PDFDocument.create();
  doc.setTitle(safe(`Pacto para usar ${pact.appName}`));
  doc.setAuthor("Tecnofamilias");
  doc.setCreator("tecnofamilias.com");
  const fonts = { regular: await doc.embedFont(StandardFonts.Helvetica), bold: await doc.embedFont(StandardFonts.HelveticaBold) };

  // La letra se reduce lo necesario para que todo quepa en una sola hoja.
  const floor = MARGIN + FOOTER + SIGN_BLOCK + 14;
  let k = 1;
  while (k > 0.55 && layoutBody(pact, fonts, k, null) < floor) k -= 0.03;

  const page = doc.addPage([PAGE.w, PAGE.h]);
  let y = PAGE.h - MARGIN;
  [BLUE, YELLOW, RED].forEach((c, i) => page.drawCircle({ x: MARGIN + 6 + i * 13, y: y - 8, size: 5, color: c }));
  page.drawText("Tecnofamilias", { x: MARGIN + 46, y: y - 13, size: 15, font: fonts.bold, color: NAVY });
  const tag = "Pacto digital familiar";
  page.drawText(tag, { x: PAGE.w - MARGIN - fonts.regular.widthOfTextAtSize(tag, 10), y: y - 12, size: 10, font: fonts.regular, color: MUTED });
  y = layoutBody(pact, fonts, k, page);

  // Firmas una al lado de la otra, justo debajo del texto (o al pie si sobra espacio).
  const width = PAGE.w - MARGIN * 2;
  const colW = (width - 30) / 2;
  const top = Math.min(y - 16, MARGIN + FOOTER + SIGN_BLOCK + 60);
  const signers = [
    { sig: pact.parentSignature, name: pact.parentName, role: "Adulto responsable", at: pact.parentSignedAt },
    { sig: pact.childSignature, name: pact.childName, role: "Hijo/a", at: pact.childSignedAt },
  ];
  for (const [i, s] of signers.entries()) {
    const x = MARGIN + i * (colW + 30);
    if (s.sig?.startsWith("data:image/png;base64,")) {
      try {
        const img = await doc.embedPng(Buffer.from(s.sig.slice("data:image/png;base64,".length), "base64"));
        const scale = Math.min(colW / img.width, 76 / img.height, 1);
        page.drawImage(img, { x, y: top - 82, width: img.width * scale, height: img.height * scale });
      } catch {
        // Firma ilegible: se deja el espacio en blanco.
      }
    }
    page.drawLine({ start: { x, y: top - 88 }, end: { x: x + colW, y: top - 88 }, thickness: 1.2, color: INK });
    page.drawText(safe(s.name).slice(0, 50), { x, y: top - 104, size: 11.5, font: fonts.bold, color: INK });
    page.drawText(safe(`${s.role}${s.at ? ` · firmó el ${formatDateTime(s.at)}` : " · pendiente de firma"}`), { x, y: top - 119, size: 8.5, font: fonts.regular, color: MUTED });
  }

  page.drawText(safe(`Generado en tecnofamilias.com el ${formatDateTime(new Date())}`), { x: MARGIN, y: MARGIN - 20, size: 8.5, font: fonts.regular, color: MUTED });
  return doc.save();
}
