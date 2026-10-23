# Tecnofamilias · Plataforma web

Plataforma **exclusivamente por suscripción** para familias. La suscripción incluye la base de clases pregrabadas, videos y podcasts recomendados, pactos digitales para firmar con los hijos, juegos en familia y la comunidad de apoyo tipo foro. Algunos cursos especializados son **complementos**: los suscriptores los suman con un pago adicional. No hay nivel gratuito. Incluye registro de usuarios y panel de administración.

**Stack:** Next.js 15 (App Router, Server Actions) · PostgreSQL + Prisma 6 · sesiones JWT en cookie httpOnly · Mercado Pago (COP) · despliegue en Vercel.

## Módulos

| Módulo | Ruta | Quién accede |
|---|---|---|
| Inicio | `/` | Sin sesión: portada comercial. Con sesión: panel con accesos directos (clases, juegos, pactos, videos, comunidad, otros servicios) y contenido para empezar a usar |
| Planes | `/planes` | Un solo plan: **Anual** (el mensual quedó desactivado). Con sesión iniciada sale del menú; quien no tiene plan ve “Suscribirme” |
| Registro / ingreso | `/registro`, `/ingresar` | Público. Tras registrarse, el usuario va a elegir plan |
| Clases pregrabadas | `/clases` | Catálogo visible como vitrina. Video: **Incluida** → suscriptores · **Complemento** → suscriptores que lo compraron (disponible mientras la suscripción esté activa) |
| Videos y podcasts | `/recursos` | Suscriptores (sin suscripción solo se ven los títulos bloqueados). YouTube, Vimeo y Spotify se ven embebidos |
| Pactos por aplicación | `/pactos` | Suscriptores crean pactos ilimitados desde plantillas por app (Roblox, TikTok, WhatsApp…). Firma con el dedo del adulto y luego del menor (en el mismo dispositivo o por enlace privado), impresión/PDF. Si la suscripción vence, los pactos existentes se pueden seguir viendo, imprimiendo o eliminando |
| Juegos en familia | `/juegos` | Suscriptores. Cada juego es un HTML autocontenido (*Modo Familia*, *La aventura de Tecnito* y *Colorea con Tecnito*). Los juegos se agregan desde el código: archivo en `prisma/games/` y una migración que lo inserta en la tabla `Game` que se sirve en `/juegos/<slug>/jugar` solo a suscriptores, dentro de un iframe con sandbox (sin acceso a la sesión ni a la página) |
| Otros servicios | `/servicios` | En el menú con sesión iniciada; sin sesión aparece dentro de `/planes`. Asesoría personalizada (compra en línea, no requiere suscripción) y programas para colegios, empresas y cajas, alcaldías y gobernaciones (solicitud de cotización). Las solicitudes y las asesorías pagadas llegan a `/admin/solicitudes` |
| Comunidad | `/comunidad` | Solo suscriptores (leer y publicar). Reportes y moderación |
| Mi cuenta | `/cuenta` | Suscripción, clases compradas, historial de pagos, datos y contraseña |
| Administración | `/admin` | Solo rol ADMIN |

**Panel de administración:** resumen (usuarios, suscriptores, ingresos), usuarios (crear, editar rol, activar/desactivar, otorgar meses de cortesía o complementos, restablecer contraseña, eliminar), clases, videos/podcasts, plantillas de pactos, comunidad, monedas (tasas de cambio) (categorías, reportes, ocultar contenido), planes y precios, pagos (marcar manualmente como pagada una transferencia).

## Masterclass

- Landing pública en **/masterclass** (app.tecnofamilias.com/masterclass) con el contenido de la masterclass "Crianza digital segura" y una barra de cupos.
- Los dos inicios (con y sin sesión) muestran el aviso "Nuestra próxima masterclass" con enlace a la landing. El aviso se oculta solo cuando pasa la fecha.
- El cupo se compra como un servicio (`masterclass-crianza-digital-segura`, USD 50, editable en Admin → Otros servicios). Las compras aparecen en Admin → Solicitudes.
- En Admin → Masterclass se editan la fecha, el horario, la modalidad, la duración, los días de grabación, el % de cupos ocupados y si el aviso se muestra en los inicios.

## Monedas

- **Precio base en dólares** para todo: plan anual USD 70, asesoría USD 300, complementos USD 30 y rangos de servicios en USD.
- **Precio fijo en COP (opcional)** por plan o servicio: si existe, en pesos colombianos se muestra y se cobra ese valor en lugar de convertir el dólar. Hoy: plan anual COP 200.000 y asesoría COP 1.000.000. Se edita en Admin → Planes y Admin → Otros servicios.
- Se muestran convertidos a **COP, MXN o PEN** según la moneda que elija el visitante (selector) o la de su país (cabecera `x-vercel-ip-country`: CO→COP, MX→MXN, PE→PEN, otros→USD).
- **Tasa del día automática** desde [ExchangeRate-API](https://www.exchangerate-api.com) (acceso abierto, cacheada 6 h). Si no responde, o si se elige modo manual en `/admin/monedas`, se usan las tasas manuales.
- **Cobro:** Mercado Pago Colombia solo cobra en COP y no convierte precios en dólares, así que al pagar se convierte el precio en USD a COP con la tasa del día. Cada orden guarda `amountUsd`, `fxRate` y el `amountCop` cobrado. Si más adelante se habilita *Cross Border* con Mercado Pago, el cobro sigue en moneda local y la liquidación llega en USD.

## Cómo funciona la suscripción

Es **prepagada**: cada pago aprobado del plan mensual o anual extiende la fecha de vencimiento. El usuario renueva desde `/planes`. Los complementos se compran una vez (solo con suscripción activa) y se pueden ver mientras la suscripción siga activa.

Pagos con **Mercado Pago Checkout Pro** (tarjeta, PSE, Nequi, efectivo). El acceso se entrega cuando llega el webhook `/api/webhooks/mercadopago` (o cuando el usuario vuelve a `/checkout/resultado`); en ambos casos el pago se vuelve a consultar en la API de Mercado Pago y se valida monto y moneda antes de activar nada.

Con `PAYMENTS_MODE="demo"` no hay cobros: aparece una pantalla para simular el pago aprobado. **No usar demo en producción.**

## Desarrollo local

```bash
cp .env.example .env        # completar DATABASE_URL, AUTH_SECRET, etc.
npm install
npx prisma migrate dev      # crea las tablas
npm run db:seed             # admin + planes + clases + plantillas + categorías de ejemplo
npm run dev
```

## Despliegue en Vercel

1. **Importar el repositorio** en Vercel (framework: Next.js; el comando `build` ya corre `prisma generate && prisma migrate deploy && next build`).
2. **Base de datos:** en el proyecto → *Storage* → *Create database* → **Neon (Postgres)**. Crea `DATABASE_URL` y `DATABASE_URL_UNPOOLED` automáticamente.
3. **Variables de entorno** (Settings → Environment Variables):
   - `AUTH_SECRET` — `openssl rand -base64 32`
   - `APP_URL` — `https://tecnofamilias.com` (o el dominio de Vercel)
   - `PAYMENTS_MODE` — `mercadopago`
   - `MP_ACCESS_TOKEN` — token de producción de Mercado Pago Colombia
   - `MP_WEBHOOK_SECRET` — clave secreta de webhooks (Mercado Pago → Tus integraciones → Webhooks, evento *Pagos*, URL `https://<dominio>/api/webhooks/mercadopago`)
4. **Administrador inicial:** agregar `ADMIN_EMAIL` y `ADMIN_PASSWORD` (tipo *Sensitive*) y desplegar. El build ejecuta `prisma/seed.mjs`, que crea el administrador y, si la base está vacía, carga el contenido de ejemplo. Después del primer ingreso se puede borrar `ADMIN_PASSWORD` (cambiar la clave desde *Mi cuenta*).
5. Ingresar a `/admin` y reemplazar el contenido de ejemplo (videos de las clases, recursos, precios).

## Videos de las clases

Cada clase guarda una URL de video. Recomendado: **Vimeo** con privacidad “Ocultar de Vimeo” y **dominio de inserción restringido** a tu dominio, para que el video no se pueda ver fuera de la plataforma. También funciona YouTube “no listado” (más fácil de compartir por fuera) o un archivo `.mp4`/`.m3u8` por https (Mux, Bunny Stream). La URL solo se envía al navegador de quien tiene acceso.

## Pendientes antes de lanzar

- Revisión legal de `/terminos` (Ley 1581 de 2012) — el texto actual es una base.
- Recuperación de contraseña por correo (hoy la restablece un administrador desde `/admin/usuarios`); requiere un proveedor de correo (p. ej. Resend).
- Cobro recurrente automático (preapprovals de Mercado Pago) si se quiere débito mensual sin intervención del usuario.
- En reembolsos el webhook marca la orden como *Reembolsado*, pero no retira el acceso: hacerlo desde la ficha del usuario.
