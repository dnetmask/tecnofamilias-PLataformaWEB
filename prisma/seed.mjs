// Datos iniciales. Corre en cada build de Vercel y también con `npm run db:seed`.
// - El contenido de ejemplo solo se carga si la base está vacía (sin planes),
//   para no recrear lo que se haya borrado desde /admin.
// - El administrador se crea solo si existen ADMIN_EMAIL y ADMIN_PASSWORD; si el
//   correo ya existe, se asegura que sea ADMIN y esté activo (no cambia su clave).
import { PrismaClient } from "@prisma/client";
import bcrypt from "bcryptjs";

const db = new PrismaClient();

const PLANS = [
  { slug: "anual", name: "Anual", priceCop: 200000, interval: "YEAR", order: 1, description: "Acceso completo durante 12 meses." },
];

// Precios y textos de referencia: ajustarlos desde /admin antes de lanzar.
const LESSONS = [
  {
    slug: "bienvenida-plan-familiar-digital",
    title: "Bienvenida: arma tu plan familiar digital",
    summary: "Los riesgos principales y los primeros cinco pasos para proteger a tu familia hoy mismo.",
    ageStage: "ALL",
    access: "INCLUDED",
    durationMin: 15,
    order: 1,
  },
  {
    slug: "control-parental-android-iphone",
    title: "Control parental en Android y iPhone, paso a paso",
    summary: "Configura Family Link y Tiempo en pantalla: límites, filtros, compras y ubicación.",
    ageStage: "ALL",
    access: "INCLUDED",
    durationMin: 35,
    order: 2,
  },
  {
    slug: "inicio-digital-0-5",
    title: "Inicio digital (0 a 5 años): YouTube Kids y supervisión",
    summary: "Cómo elegir contenido, configurar YouTube Kids y crear rutinas de pantalla desde pequeños.",
    ageStage: "AGE_0_5",
    access: "INCLUDED",
    durationMin: 25,
    order: 3,
  },
  {
    slug: "juego-online-roblox-minecraft",
    title: "Juego online (6 a 10 años): Roblox, Minecraft y chats",
    summary: "Configura chats, amigos y compras en los juegos más usados, y enséñales a reconocer a un extraño.",
    ageStage: "AGE_6_10",
    access: "INCLUDED",
    durationMin: 40,
    order: 4,
  },
  {
    slug: "primer-celular-redes",
    title: "Primer celular y primeras redes (11 a 13 años)",
    summary: "Privacidad en TikTok, Instagram y WhatsApp, identidad digital y contacto con extraños.",
    ageStage: "AGE_11_13",
    access: "INCLUDED",
    durationMin: 45,
    order: 5,
  },
  {
    slug: "masterclass-grooming",
    title: "Masterclass: grooming, cómo detectarlo y qué hacer",
    summary: "Señales de alerta, cómo hablarlo con tus hijos y los pasos para denunciar y preservar evidencia.",
    ageStage: "ALL",
    access: "ADDON",
    priceCop: 120000,
    durationMin: 60,
    order: 6,
  },
  {
    slug: "masterclass-adolescentes-sexting-apuestas",
    title: "Masterclass 14 a 17: sexting, apuestas y loot boxes",
    summary: "Conversaciones difíciles sin pelear: sexting, apuestas en línea, cajas de botín y ciberacoso.",
    ageStage: "AGE_14_17",
    access: "ADDON",
    priceCop: 120000,
    durationMin: 75,
    order: 7,
  },
];

// Ejemplos: reemplazar por videos y episodios concretos desde /admin/recursos.
const RESOURCES = [
  {
    kind: "VIDEO",
    title: "Ejemplo · En TIC Confío+ (MinTIC)",
    author: "Ministerio TIC de Colombia",
    description: "Reemplaza este ejemplo por un video concreto que el equipo recomiende.",
    url: "https://www.enticconfio.gov.co/",
    ageStage: "ALL",
    order: 1,
  },
  {
    kind: "PODCAST",
    title: "Ejemplo · Podcast para familias",
    author: "Por definir",
    description: "Pega aquí un episodio de Spotify (open.spotify.com/episode/…) para que se reproduzca embebido.",
    url: "https://open.spotify.com/",
    ageStage: "ALL",
    order: 2,
  },
];

const TEMPLATES = [
  {
    slug: "celular",
    appName: "Mi primer celular",
    color: "#28395F",
    minAge: 10,
    description: "Reglas básicas para el primer dispositivo propio.",
    clauses: [
      "El celular es una herramienta de la familia; mamá o papá conocen la clave de desbloqueo.",
      "De lunes a viernes lo uso máximo ___ horas, después de terminar las tareas.",
      "En la noche el celular duerme fuera de mi cuarto, cargando en ___ desde las ___.",
      "No uso el celular en la mesa ni cuando estamos compartiendo en familia.",
      "Antes de descargar una app o un juego, lo pregunto.",
      "No comparto mi ubicación, dirección, colegio ni fotos con desconocidos.",
      "Si algo me hace sentir incómodo, asustado o confundido, se lo cuento a un adulto de confianza y no me van a regañar por contarlo.",
      "Mamá o papá pueden revisar el celular conmigo, con respeto y avisándome antes.",
    ],
  },
  {
    slug: "roblox",
    appName: "Roblox",
    color: "#EE4836",
    minAge: 7,
    description: "Chats, amigos y compras de Robux bajo control.",
    clauses: [
      "Juego Roblox con la cuenta configurada con mi edad real y control parental activo.",
      "Solo acepto como amigos a personas que conozco en la vida real.",
      "No salgo del juego a otras apps (Discord, WhatsApp, Snapchat) con nadie que conocí jugando.",
      "Nunca comparto mi contraseña, mi nombre completo, mi colegio ni fotos.",
      "No compro Robux ni acepto regalos de desconocidos; las compras las hacemos juntos.",
      "Si alguien me pide secretos, fotos o me ofrece Robux a cambio de algo, le cuento a mamá o papá enseguida.",
      "Juego en un espacio común de la casa, máximo ___ minutos por día.",
    ],
  },
  {
    slug: "minecraft",
    appName: "Minecraft",
    color: "#3DAEE4",
    minAge: 6,
    description: "Servidores seguros y tiempo de juego acordado.",
    clauses: [
      "Juego en modo un jugador o en servidores/Realms que mis papás aprueben.",
      "El chat con desconocidos está desactivado.",
      "No descargo mods ni archivos de páginas desconocidas sin preguntar.",
      "Juego máximo ___ minutos y aviso cuando falten 10 minutos para terminar.",
      "Si alguien es grosero o me pide datos personales, lo bloqueo, lo reporto y le cuento a un adulto.",
    ],
  },
  {
    slug: "youtube",
    appName: "YouTube / YouTube Kids",
    color: "#EE4836",
    minAge: 0,
    description: "Qué vemos, cuánto y dónde.",
    clauses: [
      "Uso YouTube Kids (o una cuenta supervisada) con el nivel de contenido acordado.",
      "Veo videos en la sala o en espacios comunes, no a solas en mi cuarto.",
      "Si aparece algo que me asusta o me incomoda, cierro el video y le cuento a un adulto.",
      "No comento ni subo videos sin permiso.",
      "Máximo ___ minutos al día y nada de pantallas una hora antes de dormir.",
    ],
  },
  {
    slug: "tiktok",
    appName: "TikTok",
    color: "#1E2B47",
    minAge: 13,
    description: "Cuenta privada, sincronización familiar y retos peligrosos.",
    clauses: [
      "Mi cuenta es privada y está vinculada con Sincronización familiar.",
      "Los mensajes directos solo los recibo de amigos, o están desactivados.",
      "No publico videos con el uniforme del colegio, mi casa o lugares que permitan ubicarme.",
      "No hago retos que pongan en riesgo mi salud o la de otros.",
      "Antes de publicar, me pregunto: ¿me sentiría bien si lo viera toda mi familia y mi colegio?",
      "Uso TikTok máximo ___ minutos al día con el límite de tiempo activado.",
      "Si alguien me molesta o me presiona, lo bloqueo, lo reporto y lo hablo en casa.",
    ],
  },
  {
    slug: "instagram",
    appName: "Instagram",
    color: "#FDBF2E",
    minAge: 13,
    description: "Privacidad, mensajes y supervisión acordada.",
    clauses: [
      "Mi cuenta es privada y activamos juntos la supervisión familiar.",
      "Solo acepto seguidores que conozco en la vida real.",
      "No envío ni pido fotos íntimas, y si alguien me las pide o me las envía, se lo cuento a un adulto.",
      "No comparto mi ubicación en historias ni publicaciones.",
      "No participo en cuentas o grupos para burlarse de otras personas.",
      "Uso Instagram máximo ___ minutos al día.",
    ],
  },
  {
    slug: "whatsapp",
    appName: "WhatsApp",
    color: "#1F7FB0",
    minAge: 12,
    description: "Grupos, privacidad y respeto en los chats.",
    clauses: [
      "Mi foto de perfil, estado y última conexión solo los ven mis contactos.",
      "Solo me pueden agregar a grupos mis contactos.",
      "No reenvío fotos, audios o capturas de otras personas sin su permiso.",
      "En los grupos del colegio trato a todos con respeto; si hay burlas, no participo y aviso.",
      "No contesto mensajes ni llamadas de números desconocidos.",
      "Después de las ___ silencio el celular y no reviso mensajes.",
    ],
  },
  {
    slug: "free-fire",
    appName: "Free Fire",
    color: "#EE4836",
    minAge: 12,
    description: "Partidas, compras de diamantes y contacto con extraños.",
    clauses: [
      "Juego máximo ___ partidas o ___ minutos al día, después de las tareas.",
      "No hago compras de diamantes sin permiso; las compras las hacemos juntos.",
      "No acepto ofertas de cuentas, diamantes o skins gratis de desconocidos.",
      "Si en el chat de voz alguien es agresivo o me pide datos, lo silencio, lo reporto y lo cuento.",
      "No paso a otras redes con personas que conocí en el juego.",
    ],
  },
];

const CATEGORIES = [
  { slug: "primeros-pasos", name: "Primeros pasos", description: "Preséntate y cuéntanos qué te preocupa.", order: 1 },
  { slug: "control-parental", name: "Control parental y configuración", description: "Ayuda con dispositivos, apps y filtros.", order: 2 },
  { slug: "juegos-en-linea", name: "Juegos en línea", description: "Roblox, Minecraft, Free Fire y compañía.", order: 3 },
  { slug: "redes-sociales", name: "Redes sociales", description: "TikTok, Instagram, WhatsApp y el primer celular.", order: 4 },
  { slug: "situaciones-dificiles", name: "Situaciones difíciles", description: "Ciberacoso, grooming, sexting: apoyo y orientación.", order: 5 },
  { slug: "acuerdos-en-casa", name: "Acuerdos y rutinas en casa", description: "Pactos, horarios y cómo negociar sin pelear.", order: 6 },
];

async function main() {
  const email = process.env.ADMIN_EMAIL?.toLowerCase();
  const password = process.env.ADMIN_PASSWORD;
  if (email && password) {
    if (password.length < 8) throw new Error("ADMIN_PASSWORD debe tener al menos 8 caracteres");
    const existing = await db.user.findUnique({ where: { email } });
    if (existing) {
      await db.user.update({ where: { email }, data: { role: "ADMIN", active: true } });
      console.log(`Administrador existente: ${email}`);
    } else {
      await db.user.create({
        data: { email, name: "Administrador", role: "ADMIN", passwordHash: await bcrypt.hash(password, 12), acceptedTermsAt: new Date() },
      });
      console.log(`Administrador creado: ${email}`);
    }
  } else {
    console.log("ADMIN_EMAIL / ADMIN_PASSWORD no definidos: no se creó administrador");
  }

  if ((await db.plan.count()) > 0) {
    console.log("La base ya tiene contenido: no se cargan datos de ejemplo");
    return;
  }
  for (const p of PLANS) await db.plan.upsert({ where: { slug: p.slug }, create: p, update: {} });
  for (const l of LESSONS) {
    await db.lesson.upsert({ where: { slug: l.slug }, create: { ...l, published: true, instructor: "Equipo Tecnofamilias" }, update: {} });
  }
  if ((await db.resource.count()) === 0) await db.resource.createMany({ data: RESOURCES });
  for (const [i, t] of TEMPLATES.entries()) {
    await db.pactTemplate.upsert({ where: { slug: t.slug }, create: { ...t, order: i + 1 }, update: {} });
  }
  for (const c of CATEGORIES) await db.forumCategory.upsert({ where: { slug: c.slug }, create: c, update: {} });
  console.log("Datos de ejemplo cargados");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(() => db.$disconnect());
