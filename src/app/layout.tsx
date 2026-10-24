import type { Metadata, Viewport } from "next";
import { Nunito } from "next/font/google";
import { Footer } from "@/components/Footer";
import { Header } from "@/components/Header";
import { hasMemberAccess } from "@/lib/access";
import { getCurrentUser } from "@/lib/auth";
import "./globals.css";

const nunito = Nunito({ subsets: ["latin"], variable: "--font-sans", display: "swap" });

export const metadata: Metadata = {
  title: { default: "Tecnofamilias · Plataforma", template: "%s · Tecnofamilias" },
  description:
    "Clases pregrabadas, pactos digitales con tus hijos, una caja de herramientas recomendadas y una comunidad de familias que se apoyan.",
};

export const viewport: Viewport = { themeColor: "#28395f" };

export default async function RootLayout({ children }: { children: React.ReactNode }) {
  const user = await getCurrentUser();
  const member = await hasMemberAccess(user);
  return (
    <html lang="es" className={nunito.variable}>
      <body>
        <Header user={user ? { name: user.name, role: user.role, member } : null} />
        <main>{children}</main>
        <Footer />
      </body>
    </html>
  );
}
