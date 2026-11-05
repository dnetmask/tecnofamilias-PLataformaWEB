-- Botón de PayPal de prueba (USD 2) para verificar pagos internacionales de la masterclass.
UPDATE "Setting"
SET "value" = "value"::jsonb || '{"paypalTestButtonId": "CQATKJXTKHQ2S", "paypalTestAmountUsd": 2}'::jsonb, "updatedAt" = CURRENT_TIMESTAMP
WHERE "key" = 'masterclass';
