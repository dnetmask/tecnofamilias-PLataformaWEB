-- Caja de herramientas: cuestionario interactivo gratuito "Medición de madurez de la Tecnofamilia" (va de primero).
INSERT INTO "Resource" ("id", "slug", "kind", "title", "author", "description", "url", "ageStage", "access", "published", "order")
SELECT 'res_madurez_tecnofamilia', 'medicion-madurez-tecnofamilia', 'SOFTWARE', 'Medición de madurez de la Tecnofamilia', 'Tecnofamilias',
       'Un cuestionario corto para papás y mamás: en pocos minutos ves qué tan preparada está tu familia en límites, conversación, configuración, acompañamiento y acuerdos digitales, y te llevas tus tres prioridades para empezar. Ideal antes de entregar el primer celular. Se responde aquí mismo, gratis y sin crear cuenta.',
       '/interactivas/medicion-madurez-tecnofamilia.html', 'ALL', 'FREE', true,
       COALESCE((SELECT MIN("order") FROM "Resource"), 0) - 1
ON CONFLICT ("slug") DO NOTHING;
