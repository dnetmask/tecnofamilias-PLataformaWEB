// Política de contenido: solo se cargan recursos del sitio y de los servicios que usa
// (Tag Manager y Google Analytics, analítica de Vercel, videos y podcasts incrustados,
// subida de archivos a Vercel Blob el formulario de pago de PayPal y el checkout embebido de Bold). Mercado Pago es un enlace externo.
const CSP = [
  "default-src 'self'",
  `script-src 'self' 'unsafe-inline'${process.env.NODE_ENV === "production" ? "" : " 'unsafe-eval'"} https://www.googletagmanager.com https://*.googletagmanager.com https://www.paypal.com https://*.paypal.com https://*.paypalobjects.com https://checkout.bold.co https://*.bold.co`,
  "style-src 'self' 'unsafe-inline'",
  "img-src 'self' data: blob: https:",
  "font-src 'self' data:",
  "media-src 'self' blob: https:",
  "connect-src 'self' https://*.google-analytics.com https://*.analytics.google.com https://*.googletagmanager.com https://vercel.com https://*.vercel-storage.com https://*.paypal.com https://*.paypalobjects.com https://*.bold.co",
  "frame-src 'self' https://www.youtube-nocookie.com https://www.youtube.com https://player.vimeo.com https://open.spotify.com https://www.googletagmanager.com https://www.paypal.com https://*.paypal.com https://*.paypalobjects.com https://checkout.bold.co https://*.bold.co",
  "worker-src 'self' blob:",
  "object-src 'none'",
  "base-uri 'self'",
  "form-action 'self' https://checkout.bold.co https://*.bold.co",
  "frame-ancestors 'self'",
  "upgrade-insecure-requests",
].join("; ");

/** @type {import('next').NextConfig} */
const nextConfig = {
  poweredByHeader: false,
  experimental: {
    // Las firmas de los pactos se envían como imagen en base64.
    serverActions: { bodySizeLimit: "2mb" },
  },
  async redirects() {
    // Videos y podcasts pasó a llamarse Caja de herramientas.
    return [
      // Dominio principal: www.tecnofamilias.com redirige (301) a tecnofamilias.com.
      {
        source: "/:path*",
        has: [{ type: "host", value: "www.tecnofamilias.com" }],
        destination: "https://tecnofamilias.com/:path*",
        statusCode: 301,
      },
      // El dominio de Vercel de producción también lleva a tecnofamilias.com (308 conserva POST de webhooks).
      {
        source: "/:path*",
        has: [{ type: "host", value: "tecnofamilias-plataforma.vercel.app" }],
        destination: "https://tecnofamilias.com/:path*",
        statusCode: 308,
      },
      { source: "/recursos", destination: "/herramientas", permanent: true },
      // El podcast "Bullying en redes sociales" tenía la dirección de la herramienta de ejemplo.
      { source: "/herramientas/ejemplo-podcast-para-familias", destination: "/herramientas/bullying-en-redes-sociales-mi-mundo-mis-huellas", permanent: true },
      // Otros servicios ahora vive dentro de Planes.
      { source: "/servicios", destination: "/planes#servicios", permanent: false },
    ];
  },
  async headers() {
    return [
      {
        source: "/(.*)",
        headers: [
          { key: "X-Content-Type-Options", value: "nosniff" },
          { key: "Referrer-Policy", value: "strict-origin-when-cross-origin" },
          { key: "X-Frame-Options", value: "SAMEORIGIN" },
          // HTTPS obligatorio en el dominio y sus subdominios (apto para la lista de precarga de los navegadores).
          { key: "Strict-Transport-Security", value: "max-age=63072000; includeSubDomains; preload" },
          { key: "Permissions-Policy", value: "camera=(), microphone=(), geolocation=(), payment=(), usb=(), serial=(), bluetooth=(), interest-cohort=()" },
          { key: "Cross-Origin-Opener-Policy", value: "same-origin-allow-popups" },
          { key: "X-Permitted-Cross-Domain-Policies", value: "none" },
        ],
      },
      {
        // Los juegos (/juegos/<slug>/jugar) traen su propia política aislada (sandbox) y cargan librerías externas.
        source: "/((?!juegos/[^/]+/jugar).*)",
        headers: [{ key: "Content-Security-Policy", value: CSP }],
      },
    ];
  },
};

export default nextConfig;
