-- Masterclass: nuevos enlaces de prueba de Bold (COP 5.000 y USD 2).
UPDATE "Setting"
SET "value" = "value"::jsonb || '{"testLink": "https://checkout.bold.co/payment/LNK_PU6CL27X5X", "testAmountCop": 5000, "usdTestLink": "https://checkout.bold.co/payment/LNK_Z7WFZXW32F", "usdTestAmountUsd": 2}'::jsonb, "updatedAt" = CURRENT_TIMESTAMP
WHERE "key" = 'masterclass';
