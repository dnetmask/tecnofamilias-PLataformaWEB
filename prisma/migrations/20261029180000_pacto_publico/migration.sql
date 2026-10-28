-- Pactos sin cuenta desde un enlace público por plantilla.
-- AlterTable
ALTER TABLE "Pact" ADD COLUMN     "manageToken" TEXT,
ALTER COLUMN "userId" DROP NOT NULL;
-- AlterTable
ALTER TABLE "PactTemplate" ADD COLUMN     "public" BOOLEAN NOT NULL DEFAULT false;
-- CreateIndex
CREATE UNIQUE INDEX "Pact_manageToken_key" ON "Pact"("manageToken");

-- La plantilla del primer celular se comparte desde el inicio.
UPDATE "PactTemplate" SET "public" = true WHERE "slug" = 'celular';
