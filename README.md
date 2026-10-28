# Tecnofamilias · Plataforma web

Plataforma **exclusivamente por suscripción** para familias. La suscripción incluye la base de clases pregrabadas, la Caja de herramientas, pactos digitales para firmar con los hijos, juegos en familia y la comunidad de apoyo tipo foro. Algunos cursos especializados son **complementos**: los suscriptores los suman con un pago adicional. No hay nivel gratuito. Incluye registro de usuarios y panel de administración.

**Stack:** Next.js 15 (App Router, Server Actions) · PostgreSQL + Prisma 6 · sesiones JWT en cookie httpOnly · Mercado Pago (COP) · despliegue en Vercel.

## Módulos

| Módulo | Ruta | Quién accede |
|---|---|---|
| Inicio | `/` | Sin sesión: portada comercial. Con sesión: panel con accesos directos (clases, juegos, pactos, caja de herramientas, comunidad, planes) y contenido para empezar a usar |
| Planes | `/planes` | Un solo plan: **Anual** (el mensual quedó desactivado). Con sesión iniciada sale del menú; quien no tiene plan ve “Suscribirme” |
| Registro / ingreso | `/registro`, `/ingresar` | Público. Tras registrarse, el usuario va a elegir plan |
| Recuperar contraseña | `/recuperar` → correo → `/restablecer` | Enlace de un solo uso que vence en 1 hora (el token pasa a una cookie privada para que no quede en la dirección ni en la analítica). Al cambiar o recuperar la contraseña se cierran las sesiones de los otros dispositivos. Envía desde un buzón de Microsoft 365 con Microsoft Graph (variables `MS_*`) |
| Eliminar cuenta | `/eliminar-cuenta` | Pública (enlazada en el pie y en Mi cuenta, como piden las tiendas de apps). Con sesión, se elimina confirmando contraseña y escribiendo ELIMINAR. Se borran datos personales, suscripción, compras, pactos, favoritos y publicaciones; los pagos se conservan sin usuario (obligación contable) y las solicitudes de servicios quedan anonimizadas |
| Clases pregrabadas | `/clases` | Catálogo visible como vitrina. Video: **Incluida** → suscriptores · **Complemento** → suscriptores que lo compraron (disponible mientras la suscripción esté activa) |
| Caja de herramientas | `/herramientas` (antes `/recursos`, que redirige) | Videos, podcasts, libros, ebooks, documentos, software y hardware. Cada herramienta es de libre acceso, incluida en la suscripción, de pago adicional dentro de la plataforma (página propia y pago en `/checkout?herramienta=<slug>`) o se compra por fuera. El admin puede subir un **PDF** (hasta 50 MB, a un almacén privado de Vercel Blob; solo se entrega por `/herramientas/<slug>/abrir` a quien tenga acceso, para ver o descargar) y fijar una fecha **Disponible hasta**: después de ese día la herramienta sale de los listados, del sitemap y no se abre. Los usuarios marcan favoritos (★) y arriba se muestran las 4 más usadas (familias distintas que la abrieron, vieron o descargaron). YouTube, Vimeo y Spotify se ven embebidos |
| Pactos por aplicación | `/pactos` | Suscriptores crean pactos ilimitados desde plantillas por app (Roblox, TikTok, WhatsApp…). Firma con el dedo del adulto y luego del menor (en el mismo dispositivo o por enlace privado), impresión/PDF. Los acuerdos de las plantillas pueden llevar campos entre llaves (`{horas}`, `{minutos}`, `{partidas}`, `{lugar}`, `{hora}` u otros): el formulario muestra un campo por cada uno después de la edad y lo completa en el acuerdo mientras se escribe. Después de cada firma se puede **descargar el pacto en PDF** (A4 vertical, siempre en una sola hoja con las dos firmas lado a lado; la letra se ajusta si el pacto es largo) desde `/pactos/firmar/<token>/pdf`. Cada descarga queda registrada sin datos personales (plantilla, adulto o menor, con cuenta o enlace público, firmas) y Admin → Pactos muestra el total, los pactos distintos descargados, los últimos 30 días, las descargas por plantilla y las últimas descargas. Si la suscripción vence, los pactos existentes se pueden seguir viendo, imprimiendo o eliminando |
| Pacto sin cuenta | `/pacto/<slug>` (p. ej. `/pacto/celular`) | Plantillas marcadas como *Enlace público* en Admin → Pactos: cualquiera crea el pacto sin cuenta ni suscripción (acepta términos), firma como adulto y comparte el enlace de firma del menor. Recibe un enlace privado `/pacto/mi/<token>` (pasa a una cookie y redirige a `/pacto/mi`) para volver, imprimir o borrarlo. Con sesión el pacto queda en su cuenta; los suscriptores van al flujo normal. `/pactos/nuevo?plantilla=<slug>` redirige aquí a quien no tiene suscripción |
| Juegos en familia | `/juegos` | Suscriptores. Cada juego es un HTML autocontenido (*Modo Familia*, *La aventura de Tecnito*, *Colorea con Tecnito* y *Farmea aura*). Los juegos se agregan desde el código: archivo en `prisma/games/` y una migración que lo inserta en la tabla `Game` que se sirve en `/juegos/<slug>/jugar` solo a suscriptores, dentro de un iframe con sandbox (sin acceso a la sesión ni a la página) |
| Otros servicios | `/planes#servicios` (`/servicios` redirige) | Dentro de Planes, con o sin sesión; en el menú todo aparece como Planes. Asesoría personalizada (compra en línea, no requiere suscripción) y programas para colegios, empresas y cajas, alcaldías y gobernaciones (solicitud de cotización). Las solicitudes y las asesorías pagadas llegan a `/admin/solicitudes` |
| Comunidad | `/comunidad` | Solo suscriptores (leer y publicar). Reportes y moderación |
| Mi cuenta | `/cuenta` | Suscripción, clases compradas, historial de pagos, datos, contraseña y enlace para eliminar la cuenta |
| Administración | `/admin` | Solo rol ADMIN |

**Panel de administración:** resumen (usuarios, suscriptores, ingresos), usuarios (crear, editar rol, activar/desactivar, otorgar meses de cortesía o complementos, restablecer contraseña, eliminar), clases, caja de herramientas (acceso, precio, usos, favoritos y ventas), plantillas de pactos, comunidad, monedas (tasas de cambio) (categorías, reportes, ocultar contenido), planes y precios, pagos (marcar manualmente como pagada una transferencia).

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
   - `BLOB_READ_WRITE_TOKEN` — lo crea Vercel al conectar un almacén **Blob privado** al proyecto (Storage → Create → Blob, acceso *Private*); necesario para subir los PDF de la Caja de herramientas
   - `MS_TENANT_ID`, `MS_CLIENT_ID`, `MS_CLIENT_SECRET` y `MS_SENDER` — correos (recuperación de contraseña) desde un buzón de **Microsoft 365** con Microsoft Graph. En Microsoft Entra → Registros de aplicaciones: crear la app, darle el permiso de **aplicación** `Mail.Send` (Microsoft Graph) con consentimiento de administrador y crear un secreto de cliente. `MS_SENDER` es el buzón que envía (p. ej. `hola@tecnofamilias.com`). Recomendado: limitar la app a ese buzón con una directiva de acceso de Exchange (RBAC para aplicaciones). Opcional: `EMAIL_FROM_NAME` (por defecto "Tecnofamilias")
4. **Administrador inicial:** agregar `ADMIN_EMAIL` y `ADMIN_PASSWORD` (tipo *Sensitive*) y desplegar. El build ejecuta `prisma/seed.mjs`, que crea el administrador y, si la base está vacía, carga el contenido de ejemplo. Después del primer ingreso se puede borrar `ADMIN_PASSWORD` (cambiar la clave desde *Mi cuenta*).
5. Ingresar a `/admin` y reemplazar el contenido de ejemplo (videos de las clases, recursos, precios).

## Videos de las clases

Cada clase guarda una URL de video. Recomendado: **Vimeo** con privacidad “Ocultar de Vimeo” y **dominio de inserción restringido** a tu dominio, para que el video no se pueda ver fuera de la plataforma. También funciona YouTube “no listado” (más fácil de compartir por fuera) o un archivo `.mp4`/`.m3u8` por https (Mux, Bunny Stream). La URL solo se envía al navegador de quien tiene acceso.

## Pendientes antes de lanzar

- Revisión legal de `/terminos` (Ley 1581 de 2012) — el texto actual es una base.
- Cobro recurrente automático (preapprovals de Mercado Pago) si se quiere débito mensual sin intervención del usuario.
- En reembolsos el webhook marca la orden como *Reembolsado*, pero no retira el acceso: hacerlo desde la ficha del usuario.
