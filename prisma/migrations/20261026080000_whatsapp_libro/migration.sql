-- Número de WhatsApp actualizado (+57 300 674 0003) en los juegos y el libro de Tecnito.
UPDATE "Game" SET "html" = REPLACE(REPLACE("html", '313 874 3101', '300 674 0003'), '573138743101', '573006740003'), "updatedAt" = CURRENT_TIMESTAMP
WHERE "html" LIKE '%313 874 3101%' OR "html" LIKE '%573138743101%';
