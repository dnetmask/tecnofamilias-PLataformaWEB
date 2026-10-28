import "server-only";
import { del, get } from "@vercel/blob";

/** Lee un PDF del almacén privado de Vercel Blob (null si no existe). */
export async function readToolFile(url: string) {
  return get(url, { access: "private" });
}

/** Borra un archivo del almacén; si falla, solo se registra (no bloquea al administrador). */
export async function deleteToolFile(url: string) {
  try {
    await del(url);
  } catch (err) {
    console.error("No se pudo borrar el archivo de Vercel Blob", err);
  }
}
