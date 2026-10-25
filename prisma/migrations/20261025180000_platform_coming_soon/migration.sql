-- La plataforma (plan de suscripción y creación de cuentas) queda en "Próximamente".
-- Se abre en Admin → Planes.
INSERT INTO "Setting" ("key", "value", "updatedAt")
VALUES ('platform', '{"open": false}'::jsonb, CURRENT_TIMESTAMP)
ON CONFLICT ("key") DO UPDATE SET "value" = '{"open": false}'::jsonb, "updatedAt" = CURRENT_TIMESTAMP;
