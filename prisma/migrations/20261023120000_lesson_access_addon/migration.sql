-- La plataforma es solo por suscripción: se elimina el acceso gratuito y el
-- pago puntual pasa a llamarse complemento (ADDON).
UPDATE "Lesson" SET "access" = 'INCLUDED' WHERE "access" = 'FREE';

ALTER TYPE "LessonAccess" RENAME TO "LessonAccess_old";
CREATE TYPE "LessonAccess" AS ENUM ('INCLUDED', 'ADDON');
ALTER TABLE "Lesson" ALTER COLUMN "access" DROP DEFAULT;
ALTER TABLE "Lesson" ALTER COLUMN "access" TYPE "LessonAccess"
  USING (CASE "access"::text WHEN 'PAID' THEN 'ADDON' ELSE "access"::text END)::"LessonAccess";
ALTER TABLE "Lesson" ALTER COLUMN "access" SET DEFAULT 'INCLUDED';
DROP TYPE "LessonAccess_old";
