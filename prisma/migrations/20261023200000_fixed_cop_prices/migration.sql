-- Precio fijo opcional en COP para planes y servicios (reemplaza la conversión del dólar).
ALTER TABLE "Plan" ADD COLUMN "priceCop" INTEGER;
ALTER TABLE "Service" ADD COLUMN "priceCop" INTEGER;

-- Plan anual: USD 70 (se convierte a MXN y PEN) y COP 200.000 fijo.
UPDATE "Plan" SET "priceUsd" = 70, "priceCop" = 200000 WHERE "slug" = 'anual';

-- Asesoría personalizada: COP 1.000.000 fijo (sigue en USD 300 para las demás monedas).
UPDATE "Service" SET "priceCop" = 1000000 WHERE "slug" = 'asesoria-personalizada';
