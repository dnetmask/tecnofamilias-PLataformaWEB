-- La masterclass "Crianza digital segura" pasa al martes 15 de diciembre de 2026.
UPDATE "Setting"
SET "value" = jsonb_set("value"::jsonb, '{date}', '"2026-12-15"'), "updatedAt" = CURRENT_TIMESTAMP
WHERE "key" = 'masterclass';
