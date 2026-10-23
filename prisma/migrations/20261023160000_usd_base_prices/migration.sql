-- Los precios base pasan a dólares; el cobro se convierte a COP con la tasa del día.

-- Planes
ALTER TABLE "Plan" RENAME COLUMN "priceCop" TO "priceUsd";
UPDATE "Plan" SET "priceUsd" = 60 WHERE "slug" = 'anual';
UPDATE "Plan" SET "priceUsd" = GREATEST(1, ROUND("priceUsd" / 4000.0)) WHERE "slug" <> 'anual';

-- Clases complementarias
ALTER TABLE "Lesson" RENAME COLUMN "priceCop" TO "priceUsd";
UPDATE "Lesson" SET "priceUsd" = CASE WHEN "priceUsd" > 0 THEN GREATEST(1, ROUND("priceUsd" / 4000.0)) ELSE 0 END;

-- Servicios
ALTER TABLE "Service" RENAME COLUMN "priceCop" TO "priceUsd";
ALTER TABLE "Service" RENAME COLUMN "priceFromCop" TO "priceFromUsd";
ALTER TABLE "Service" RENAME COLUMN "priceToCop" TO "priceToUsd";
UPDATE "Service" SET "priceUsd" = ROUND("priceUsd" / 4000.0) WHERE "priceUsd" IS NOT NULL;
UPDATE "Service" SET "priceFromUsd" = ROUND("priceFromUsd" / 4000.0), "priceToUsd" = ROUND("priceToUsd" / 4000.0);
-- Precios estandarizados en dólares
UPDATE "Service" SET "priceUsd" = 300, "priceFromUsd" = 300,   "priceToUsd" = 300    WHERE "slug" = 'asesoria-personalizada';
UPDATE "Service" SET "priceFromUsd" = 750,   "priceToUsd" = 1250   WHERE "slug" = 'colegios-masterclass-institucional';
UPDATE "Service" SET "priceFromUsd" = 3000,  "priceToUsd" = 5000   WHERE "slug" = 'colegios-programa-anual';
UPDATE "Service" SET "priceFromUsd" = 1000,  "priceToUsd" = 1500   WHERE "slug" = 'empresas-sesion-empleados';
UPDATE "Service" SET "priceFromUsd" = 5000,  "priceToUsd" = 6250   WHERE "slug" = 'empresas-programa-bienestar';
UPDATE "Service" SET "priceFromUsd" = 15000, "priceToUsd" = 37500  WHERE "slug" = 'alcaldias-programa-social';
UPDATE "Service" SET "priceFromUsd" = 50000, "priceToUsd" = 125000 WHERE "slug" = 'gobernaciones-programa-departamental';

-- Órdenes: registro del precio base y la tasa usada
ALTER TABLE "Order" ADD COLUMN "amountUsd" INTEGER;
ALTER TABLE "Order" ADD COLUMN "fxRate" DOUBLE PRECISION;

-- Las tasas guardadas antes eran COP por unidad de cada moneda; ahora son por dólar.
DELETE FROM "Setting" WHERE "key" = 'fx';
