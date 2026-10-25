-- Juegos libres y gratis para todos (sin cuenta ni suscripción).
ALTER TABLE "Game" ADD COLUMN "free" BOOLEAN NOT NULL DEFAULT false;
UPDATE "Game" SET "free" = true WHERE "slug" = 'farmea-aura';

-- Se oculta el aviso de la masterclass en los inicios (se reactiva en Admin → Masterclass).
-- La landing /masterclass sigue publicada.
UPDATE "Setting" SET "value" = jsonb_set("value"::jsonb, '{showOnHome}', 'false'::jsonb) WHERE "key" = 'masterclass';
INSERT INTO "Setting" ("key", "value", "updatedAt")
VALUES ('masterclass', '{"showOnHome": false}'::jsonb, CURRENT_TIMESTAMP)
ON CONFLICT ("key") DO NOTHING;
