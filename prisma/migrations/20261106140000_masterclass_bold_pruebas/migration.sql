-- Masterclass: enlaces de prueba de Bold (COP 5.000 y USD 2).
UPDATE "Setting"
SET "value" = "value"::jsonb || '{"testLink": "https://checkout.bold.co/payment/LNK_BZ8GBHNNLJ", "testAmountCop": 5000, "usdTestLink": "https://checkout.bold.co/payment/LNK_NPA5AD95OK", "usdTestAmountUsd": 2}'::jsonb, "updatedAt" = CURRENT_TIMESTAMP
WHERE "key" = 'masterclass';
