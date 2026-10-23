# Tecnofamilias · Plataforma web

Plataforma **exclusivamente por suscripción** para familias. La suscripción incluye la base de clases pregrabadas, videos y podcasts recomendados, pactos digitales para firmar con los hijos, juegos en familia y la comunidad de apoyo tipo foro. Algunos cursos especializados son **complementos**: los suscriptores los suman con un pago adicional. No hay nivel gratuito. Incluye registro de usuarios y panel de administración.

**Stack:** Next.js 15 (App Router, Server Actions) · PostgreSQL + Prisma 6 · sesiones JWT en cookie httpOnly · Mercado Pago (COP) · despliegue en Vercel.

## Módulos

| Módulo | Ruta | Quién accede |
|---|---|---|
| Inicio y planes | `/`, `/planes` | Público (vitrina comercial). Con sesión iniciada, “Planes” sale del menú y del inicio; quien no tiene plan ve el botón “Suscribirme” |
| Registro / ingreso | `/registro`, `/ingresar` | Público. Tras registrarse, el usuario va a elegir plan |
| Clases pregrabadas | `/clases` | Catálogo visible como vitrina. Video: **Incluida** → suscriptores · **Complemento** → suscriptores que lo compraron (disponible mientras la suscripción esté activa) |
| Videos y podcasts | `/recursos` | Suscriptores (sin suscripción solo se ven los títulos bloqueados). YouTube, Vimeo y Spotify se ven embebidos |
| Pactos por aplicación | `/pactos` | Suscriptores crean pactos ilimitados desde plantillas por app (Roblox, TikTok, WhatsApp…). Firma con el dedo del adulto y luego del menor (en el mismo dispositivo o por enlace privado), impresión/PDF. Si la suscripción vence, los pactos existentes se pueden seguir viendo, imprimiendo o eliminando |
| Juegos en familia | `/juegos` | Suscriptores. Cada juego es un HTML autocontenido (p. ej. *Modo Familia: cartas para conectar*) que se sirve en `/juegos/<slug>/jugar` solo a suscriptores, dentro de un iframe con sandbox (sin acceso a la sesión ni a la página) |
| Comunidad | `/comunidad` | Solo suscriptores (leer y publicar). Reportes y moderación |
| Mi cuenta | `/cuenta` | Suscripción, clases compradas, historial de pagos, datos y contraseña |
| Administración | `/admin` | Solo rol ADMIN |

**Panel de administración:** resumen (usuarios, suscriptores, ingresos), usuarios (crear, editar rol, activar/desactivar, otorgar meses de cortesía o complementos, restablecer contraseña, eliminar), clases, videos/podcasts, plantillas de pactos, juegos (subir o reemplazar el archivo HTML), comunidad (categorías, reportes, ocultar contenido), planes y precios, pagos (marcar manualmente como pagada una transferencia).

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
