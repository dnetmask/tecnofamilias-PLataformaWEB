-- Botón alojado de PayPal (USD 60) para la masterclass.
UPDATE "Setting"
SET "value" = "value"::jsonb || '{"paypalButtonId": "A7S5EMQ4D2QV8", "paypalAmountUsd": 60}'::jsonb, "updatedAt" = CURRENT_TIMESTAMP
WHERE "key" = 'masterclass';
