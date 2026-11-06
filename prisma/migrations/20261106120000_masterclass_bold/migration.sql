-- Masterclass: pagos con enlaces de Bold (pesos y dólares) mientras se resuelven PayPal y el PSE de Mercado Pago.
UPDATE "Setting"
SET "value" = "value"::jsonb || '{"paymentLink": "https://checkout.bold.co/payment/LNK_T2129MVLCM", "usdLink": "https://checkout.bold.co/payment/LNK_YIB3XFGAGO"}'::jsonb, "updatedAt" = CURRENT_TIMESTAMP
WHERE "key" = 'masterclass';
