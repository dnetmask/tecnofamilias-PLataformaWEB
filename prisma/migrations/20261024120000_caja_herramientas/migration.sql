-- Caja de herramientas: nuevos tipos, formas de acceso, compras dentro de la
-- plataforma, favoritos y métrica de uso.
CREATE TYPE "ResourceAccess" AS ENUM ('FREE', 'SUBSCRIPTION', 'PAID', 'EXTERNAL');

ALTER TYPE "OrderKind" ADD VALUE 'RESOURCE';

ALTER TYPE "ResourceKind" ADD VALUE 'BOOK';
ALTER TYPE "ResourceKind" ADD VALUE 'EBOOK';
ALTER TYPE "ResourceKind" ADD VALUE 'DOCUMENT';
ALTER TYPE "ResourceKind" ADD VALUE 'SOFTWARE';
ALTER TYPE "ResourceKind" ADD VALUE 'HARDWARE';

ALTER TABLE "Order" ADD COLUMN "resourceId" TEXT;

ALTER TABLE "Resource" ADD COLUMN "access" "ResourceAccess" NOT NULL DEFAULT 'SUBSCRIPTION',
ADD COLUMN "imageUrl" TEXT NOT NULL DEFAULT '',
ADD COLUMN "priceCop" INTEGER,
ADD COLUMN "priceUsd" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN "slug" TEXT,
ADD COLUMN "uses" INTEGER NOT NULL DEFAULT 0;

-- Slug a partir del título para las herramientas que ya existen; si se repite,
-- se agrega el final del id.
UPDATE "Resource" SET "slug" = trim(BOTH '-' FROM regexp_replace(
  lower(translate("title", 'áéíóúüñÁÉÍÓÚÜÑ', 'aeiouunAEIOUUN')), '[^a-z0-9]+', '-', 'g'));
UPDATE "Resource" SET "slug" = 'herramienta' WHERE "slug" = '';
UPDATE "Resource" r SET "slug" = r."slug" || '-' || right(r."id", 6)
FROM (SELECT "id", row_number() OVER (PARTITION BY "slug" ORDER BY "createdAt") AS n FROM "Resource") d
WHERE d."id" = r."id" AND d.n > 1;
ALTER TABLE "Resource" ALTER COLUMN "slug" SET NOT NULL;

CREATE TABLE "ResourcePurchase" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "resourceId" TEXT NOT NULL,
    "orderId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "ResourcePurchase_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "ResourceFavorite" (
    "userId" TEXT NOT NULL,
    "resourceId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "ResourceFavorite_pkey" PRIMARY KEY ("userId","resourceId")
);

CREATE TABLE "ResourceUse" (
    "userId" TEXT NOT NULL,
    "resourceId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "ResourceUse_pkey" PRIMARY KEY ("userId","resourceId")
);

CREATE UNIQUE INDEX "ResourcePurchase_orderId_key" ON "ResourcePurchase"("orderId");
CREATE UNIQUE INDEX "ResourcePurchase_userId_resourceId_key" ON "ResourcePurchase"("userId", "resourceId");
CREATE UNIQUE INDEX "Resource_slug_key" ON "Resource"("slug");
CREATE INDEX "Resource_uses_idx" ON "Resource"("uses");

ALTER TABLE "Order" ADD CONSTRAINT "Order_resourceId_fkey" FOREIGN KEY ("resourceId") REFERENCES "Resource"("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "ResourcePurchase" ADD CONSTRAINT "ResourcePurchase_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ResourcePurchase" ADD CONSTRAINT "ResourcePurchase_resourceId_fkey" FOREIGN KEY ("resourceId") REFERENCES "Resource"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ResourceFavorite" ADD CONSTRAINT "ResourceFavorite_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ResourceFavorite" ADD CONSTRAINT "ResourceFavorite_resourceId_fkey" FOREIGN KEY ("resourceId") REFERENCES "Resource"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ResourceUse" ADD CONSTRAINT "ResourceUse_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ResourceUse" ADD CONSTRAINT "ResourceUse_resourceId_fkey" FOREIGN KEY ("resourceId") REFERENCES "Resource"("id") ON DELETE CASCADE ON UPDATE CASCADE;
