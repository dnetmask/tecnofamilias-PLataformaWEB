-- Masterclass: se quitan los enlaces de prueba (Bold COP 5.000, Bold USD 2 y el botón de prueba de PayPal).
-- Quedan los pagos de prueba con el checkout embebido de Bold (API).
UPDATE "Setting"
SET "value" = "value"::jsonb || '{"testLink": "", "usdTestLink": "", "paypalTestButtonId": ""}'::jsonb, "updatedAt" = CURRENT_TIMESTAMP
WHERE "key" = 'masterclass';
