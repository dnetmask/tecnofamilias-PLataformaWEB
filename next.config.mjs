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
      { source: "/recursos", destination: "/herramientas", permanent: true },
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
