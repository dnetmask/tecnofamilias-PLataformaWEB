-- Contador de descargas de pactos en PDF (sin datos personales).
-- CreateEnum
CREATE TYPE "PactSigner" AS ENUM ('ADULT', 'CHILD');
-- CreateTable
CREATE TABLE "PactDownload" (
    "id" TEXT NOT NULL,
    "pactId" TEXT,
    "templateId" TEXT,
    "appName" TEXT NOT NULL,
    "by" "PactSigner" NOT NULL,
    "withAccount" BOOLEAN NOT NULL,
    "fullySigned" BOOLEAN NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "PactDownload_pkey" PRIMARY KEY ("id")
);
-- CreateIndex
CREATE INDEX "PactDownload_templateId_idx" ON "PactDownload"("templateId");
-- CreateIndex
CREATE INDEX "PactDownload_createdAt_idx" ON "PactDownload"("createdAt");
-- AddForeignKey
ALTER TABLE "PactDownload" ADD CONSTRAINT "PactDownload_pactId_fkey" FOREIGN KEY ("pactId") REFERENCES "Pact"("id") ON DELETE SET NULL ON UPDATE CASCADE;
-- AddForeignKey
ALTER TABLE "PactDownload" ADD CONSTRAINT "PactDownload_templateId_fkey" FOREIGN KEY ("templateId") REFERENCES "PactTemplate"("id") ON DELETE SET NULL ON UPDATE CASCADE;
