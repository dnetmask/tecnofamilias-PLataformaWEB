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
          { key: "Permissions-Policy", value: "camera=(), microphone=(), geolocation=()" },
        ],
      },
    ];
  },
};

export default nextConfig;
