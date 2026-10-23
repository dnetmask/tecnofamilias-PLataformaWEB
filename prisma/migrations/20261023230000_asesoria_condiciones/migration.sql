-- Asesoría personalizada: condiciones confirmadas (vigencia desde la primera
-- sesión, sesiones virtuales, informe del diagnóstico, comunidad y soporte
-- por WhatsApp en horas hábiles).
UPDATE "Service" SET
  "description" = 'Un mes de acompañamiento uno a uno para proteger a tu familia en el mundo digital: dos sesiones virtuales con un experto, informe del diagnóstico de tu hogar, soporte por WhatsApp y acceso a nuestra comunidad.',
  "unit" = 'por familia · vigencia 1 mes desde la primera sesión',
  "details" = '## Qué incluye
- Vigencia de 1 mes, contado desde la primera sesión.
- Sesión 1 (1 hora) · Diagnóstico y plan: te explicamos los riesgos digitales según la edad de tus hijos, evaluamos tu hogar (dispositivos, conexión, aplicaciones y hábitos) y te entregamos los pasos a seguir.
- Informe escrito del diagnóstico: después de la primera sesión recibes un documento con lo que encontramos en tu hogar y el plan recomendado.
- Sesión 2 (1 hora) · Manos a la obra: profundizamos en esos pasos y los ponemos en práctica contigo, por ejemplo configurando un control parental o resolviendo tus dudas.
- Comunidad Tecnofamilias en WhatsApp: tips, alertas sobre nuevos riesgos y herramientas recomendadas.
- Soporte por WhatsApp con respuesta en máximo 4 horas hábiles (lunes a viernes).

## ¿Para quién es?
Ideal si ya hubo un incidente, si vas a entregar el primer celular o tablet a tus hijos, o si quieres ayuda experta para poner orden en la tecnología de tu hogar.

## Cómo funciona
- Compras la asesoría en línea; no necesitas suscripción.
- Te contactamos para agendar la primera sesión; con la cita recibes el enlace de la videollamada.
- Las sesiones son virtuales, así que puedes conectarte desde cualquier lugar.
- El mes de vigencia empieza con la primera sesión; la segunda se agenda dentro de ese mes.'
WHERE "slug" = 'asesoria-personalizada';
