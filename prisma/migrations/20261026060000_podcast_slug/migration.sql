-- El podcast "Bullying en redes sociales" conservaba la dirección de la herramienta de ejemplo.
-- La dirección anterior redirige a la nueva (next.config.mjs).
UPDATE "Resource" SET "slug" = 'bullying-en-redes-sociales-mi-mundo-mis-huellas'
WHERE "slug" = 'ejemplo-podcast-para-familias'
  AND NOT EXISTS (SELECT 1 FROM "Resource" WHERE "slug" = 'bullying-en-redes-sociales-mi-mundo-mis-huellas');
