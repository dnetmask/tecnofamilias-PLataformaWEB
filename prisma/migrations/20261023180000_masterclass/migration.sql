-- Masterclass "Crianza digital segura" (26 de noviembre): el cupo se compra como servicio.
INSERT INTO "Service" ("id", "slug", "audience", "name", "description", "details", "priceUsd", "priceFromUsd", "priceToUsd", "unit", "featured", "active", "order") VALUES
('svc_masterclass_nov', 'masterclass-crianza-digital-segura', 'FAMILIAS', 'Masterclass en vivo: Crianza digital segura',
 'Riesgos reales por edad y configuración en vivo de Roblox, Instagram, YouTube, WhatsApp y los celulares de tus hijos.',
 'Cupo para la masterclass en vivo. Después del pago recibirás por correo el enlace de conexión y el kit de materiales.',
 50, 50, 50, 'por persona · en vivo', false, true, 0)
ON CONFLICT ("slug") DO NOTHING;

-- Datos editables del evento (Admin → Masterclass).
INSERT INTO "Setting" ("key", "value", "updatedAt") VALUES
('masterclass', '{"serviceSlug":"masterclass-crianza-digital-segura","date":"2026-11-26","time":"6:00 p. m. a 9:00 p. m.","timezone":"hora de Colombia","modality":"En vivo por Zoom","duration":"3 horas","seatsPct":63,"recordingDays":30,"showOnHome":true}', CURRENT_TIMESTAMP)
ON CONFLICT ("key") DO NOTHING;
