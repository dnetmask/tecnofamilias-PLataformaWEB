-- Caja de herramientas: la medición de madurez pasa a "Diagnóstico de protección digital familiar" (nueva versión del cuestionario).
UPDATE "Resource" SET
  "slug" = 'diagnostico-proteccion-digital-familiar',
  "title" = 'Diagnóstico de protección digital familiar',
  "url" = '/interactivas/diagnostico-proteccion-digital-familiar.html',
  "description" = 'Un cuestionario corto para papás y mamás: en pocos minutos ves qué tan protegida está tu familia en límites, conversación, configuración, acompañamiento y acuerdos digitales, y te llevas tus prioridades para empezar. Se responde aquí mismo, gratis y sin crear cuenta.'
WHERE "slug" = 'medicion-madurez-tecnofamilia';
