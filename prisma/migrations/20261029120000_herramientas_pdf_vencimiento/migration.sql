-- Caja de herramientas: PDF subidos (Vercel Blob privado) y fecha máxima de disponibilidad.
-- AlterTable
ALTER TABLE "Resource" ADD COLUMN     "availableUntil" TIMESTAMP(3),
ADD COLUMN     "fileName" TEXT NOT NULL DEFAULT '',
ADD COLUMN     "fileSize" INTEGER,
ADD COLUMN     "fileUrl" TEXT NOT NULL DEFAULT '',
ALTER COLUMN "url" SET DEFAULT '';
