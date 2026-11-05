-- Botón de PayPal de prueba de Tecnofamilias S.A.S. (USD 3).
UPDATE "Setting"
SET "value" = "value"::jsonb || '{"paypalTestButtonId": "3FSMKYMQ93TLG", "paypalTestAmountUsd": 3}'::jsonb, "updatedAt" = CURRENT_TIMESTAMP
WHERE "key" = 'masterclass';
