-- Masterclass: la barra de cupos muestra 13 % ocupado.
UPDATE "Setting"
SET "value" = "value"::jsonb || '{"seatsPct": 13}'::jsonb, "updatedAt" = CURRENT_TIMESTAMP
WHERE "key" = 'masterclass';
