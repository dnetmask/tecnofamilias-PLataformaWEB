import type { Metadata, Viewport } from "next";
import { Nunito } from "next/font/google";
import { Footer } from "@/components/Footer";
import { Header } from "@/components/Header";
import { WhatsAppButton } from "@/components/WhatsAppButton";
import { isPlatformOpen } from "@/lib/launch";
import { hasMemberAccess } from "@/lib/access";
import { getCurrentUser } from "@/lib/auth";
import "./globals.css";
import { SITE_DESCRIPTION, SITE_NAME, SITE_TAGLINE, SITE_URL } from "@/lib/site";
import { Analytics } from "@vercel/analytics/next";
import { SpeedInsights } from "@vercel/speed-insights/next";
import { ClickTracker } from "@/components/ClickTracker";

const nunito = Nunito({ subsets: ["latin"], variable: "--font-sans", display: "swap" });

export const metadata: Metadata = {
  metadataBase: new URL(SITE_URL),
  title: { default: `${SITE_NAME} · ${SITE_TAGLINE}`, template: `%s · ${SITE_NAME}` },
  description: SITE_DESCRIPTION,
  applicationName: SITE_NAME,
  keywords: [
    "control parental", "seguridad en internet para niños", "ciberseguridad para el hogar", "crianza digital",
    "grooming", "ciberacoso", "sexting", "sextorsión", "Roblox seguro", "pacto digital familiar",
  ],
  openGraph: { type: "website", siteName: SITE_NAME, locale: "es_419", url: SITE_URL, title: `${SITE_NAME} · ${SITE_TAGLINE}`, description: SITE_DESCRIPTION },
  twitter: { card: "summary_large_image" },
};

// Datos estructurados del sitio (Google, Bing y asistentes de IA).
const ORG_JSON_LD = {
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "Organization",
      "@id": `${SITE_URL}/#organization`,
      name: SITE_NAME,
      url: SITE_URL,
      logo: `${SITE_URL}/icon.svg`,
      description: SITE_DESCRIPTION,
      areaServed: ["Latinoamérica", "España", "Estados Unidos"],
      knowsLanguage: "es",
      knowsAbout: ["Control parental", "Ciberseguridad para el hogar", "Seguridad en internet para niños", "Grooming", "Ciberacoso", "Crianza digital"],
      contactPoint: { "@type": "ContactPoint", telephone: "+57-300-674-0003", contactType: "customer service", availableLanguage: "es" },
    },
    { "@type": "WebSite", "@id": `${SITE_URL}/#website`, url: SITE_URL, name: SITE_NAME, inLanguage: "es", publisher: { "@id": `${SITE_URL}/#organization` } },
  ],
};

export const viewport: Viewport = { themeColor: "#28395f" };

export default async function RootLayout({ children }: { children: React.ReactNode }) {
  const user = await getCurrentUser();
  const [member, open] = await Promise.all([hasMemberAccess(user), isPlatformOpen()]);
  return (
    <html lang="es" className={nunito.variable}>
      <body>
        <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(ORG_JSON_LD) }} />
        <Header user={user ? { name: user.name, role: user.role, member } : null} platformOpen={open} />
        <main>{children}</main>
        <Footer />
        <WhatsAppButton />
        <ClickTracker />
        <Analytics />
        <SpeedInsights />
      </body>
    </html>
  );
}
