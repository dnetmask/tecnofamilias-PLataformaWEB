-- El botón de PayPal de USD 60 era de la cuenta de Netmask: se quita hasta tener el de Tecnofamilias S.A.S.
-- Mientras tanto "Pagar en dólares" usa el checkout propio con la API de PayPal.
UPDATE "Setting"
SET "value" = "value"::jsonb || '{"paypalButtonId": ""}'::jsonb, "updatedAt" = CURRENT_TIMESTAMP
WHERE "key" = 'masterclass' AND "value"->>'paypalButtonId' = 'A7S5EMQ4D2QV8';
