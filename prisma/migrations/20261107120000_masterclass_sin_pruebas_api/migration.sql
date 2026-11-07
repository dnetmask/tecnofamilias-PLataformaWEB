-- Masterclass: se ocultan los botones de prueba con API (se reactivan desde el admin con un valor mayor que 0).
UPDATE "Setting"
SET "value" = "value"::jsonb || '{"boldTestAmountCop": 0, "boldTestAmountUsd": 0}'::jsonb, "updatedAt" = CURRENT_TIMESTAMP
WHERE "key" = 'masterclass';
