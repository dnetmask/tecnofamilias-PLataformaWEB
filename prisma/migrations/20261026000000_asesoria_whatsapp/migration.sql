-- La asesoría personalizada se atiende por ahora por WhatsApp (no se compra en línea).
UPDATE "Service"
SET "details" = REPLACE(
  REPLACE("details",
    '- Compras la asesoría en línea; no necesitas suscripción.',
    '- Nos escribes por WhatsApp y te contamos cómo empezar; no necesitas suscripción.'),
  '- Te contactamos para agendar la primera sesión;',
  '- Agendamos contigo la primera sesión;')
WHERE "slug" = 'asesoria-personalizada';
