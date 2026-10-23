"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { useState } from "react";
import { logoutAction } from "@/app/(auth)/actions";

type Props = { user: { name: string; role: "USER" | "ADMIN"; member: boolean } | null };

const LINKS = [
  { href: "/", label: "Inicio" },
  { href: "/clases", label: "Clases" },
  { href: "/recursos", label: "Videos y podcasts" },
  { href: "/pactos", label: "Pactos" },
  { href: "/juegos", label: "Juegos" },
  { href: "/comunidad", label: "Comunidad" },
  { href: "/quienes-somos", label: "Quiénes somos" },
];

export function Header({ user }: Props) {
  const pathname = usePathname();
  const [open, setOpen] = useState(false);
  const isActive = (href: string) => pathname === href || (href !== "/" && pathname.startsWith(`${href}/`));

  return (
    <header className="header">
      <div className="container header-inner">
        <Link href="/" className="brand" aria-label="Tecnofamilias, inicio">
          <img src="/logo-light.svg" alt="Tecnofamilias" width={120} height={40} />
        </Link>
        <button
          className="btn btn-light btn-sm menu-toggle"
          aria-expanded={open}
          aria-controls="main-nav"
          onClick={() => setOpen((v) => !v)}
        >
          Menú
        </button>
        <nav id="main-nav" className={`nav${open ? " open" : ""}`} onClick={() => setOpen(false)}>
          {LINKS.map((l) => (
            <Link key={l.href} href={l.href} className={isActive(l.href) ? "active" : undefined}>
              {l.label}
            </Link>
          ))}
          {/* Sin sesión: Planes (incluye otros servicios). Con sesión: Otros servicios. */}
          {user ? (
            <Link href="/servicios" className={isActive("/servicios") ? "active" : undefined}>
              Otros servicios
            </Link>
          ) : (
            <Link href="/planes" className={isActive("/planes") ? "active" : undefined}>
              Planes
            </Link>
          )}
          {user?.role === "ADMIN" && (
            <Link href="/admin" className={isActive("/admin") ? "active" : undefined}>
              Admin
            </Link>
          )}
          {user ? (
            <>
              {!user.member && (
                <Link href="/planes" className="btn btn-yellow btn-sm" style={{ color: "var(--navy-dark)" }}>
                  Suscribirme
                </Link>
              )}
              <Link href="/cuenta" className={isActive("/cuenta") ? "active" : undefined}>
                Mi cuenta
              </Link>
              <form action={logoutAction}>
                <button className="btn btn-ghost btn-sm" style={{ color: "#fff", borderColor: "rgb(255 255 255 / 30%)" }}>
                  Salir
                </button>
              </form>
            </>
          ) : (
            <>
              <Link href="/ingresar">Ingresar</Link>
              <Link href="/registro" className="btn btn-yellow btn-sm" style={{ color: "var(--navy-dark)" }}>
                Crear cuenta
              </Link>
            </>
          )}
        </nav>
      </div>
    </header>
  );
}
