import { handleUpload, type HandleUploadBody } from "@vercel/blob/client";
import { NextResponse } from "next/server";
import { getCurrentUser } from "@/lib/auth";
import { MAX_PDF_MB } from "@/lib/tools";

/**
 * Emite el permiso para que el navegador del administrador suba un PDF
 * directamente a Vercel Blob (almacén privado), sin pasar por el servidor
 * ni por el límite de tamaño de las acciones.
 */
export async function POST(request: Request) {
  const body = (await request.json()) as HandleUploadBody;
  try {
    const result = await handleUpload({
      body,
      request,
      onBeforeGenerateToken: async (pathname) => {
        const user = await getCurrentUser();
        if (user?.role !== "ADMIN") throw new Error("Solo los administradores pueden subir archivos");
        if (!pathname.startsWith("herramientas/")) throw new Error("Ruta no permitida");
        return {
          allowedContentTypes: ["application/pdf"],
          maximumSizeInBytes: MAX_PDF_MB * 1024 * 1024,
          addRandomSuffix: true,
        };
      },
    });
    return NextResponse.json(result);
  } catch (err) {
    return NextResponse.json({ error: err instanceof Error ? err.message : "No se pudo subir el archivo" }, { status: 400 });
  }
}
