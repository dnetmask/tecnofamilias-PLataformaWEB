import Link from "next/link";
import { requireAdmin } from "@/lib/auth";

export const dynamic = "force-dynamic";
export const metadata = { title: "Administración", robots: { index: false } };

const NAV = [
  ["/admin", "Resumen"],
  ["/admin/usuarios", "Usuarios"],
  ["/admin/clases", "Clases"],
  ["/admin/recursos", "Videos y podcasts"],
  ["/admin/pactos", "Plantillas de pactos"],
  ["/admin/juegos", "Juegos"],
  ["/admin/comunidad", "Comunidad"],
  ["/admin/servicios", "Otros servicios"],
  ["/admin/solicitudes", "Solicitudes"],
  ["/admin/planes", "Planes"],
  ["/admin/pagos", "Pagos"],
];

export default async function AdminLayout({ children }: { children: React.ReactNode }) {
  await requireAdmin();
  return (
    <div className="container admin-layout">
      <nav className="admin-nav card" style={{ padding: 10, alignSelf: "start" }}>
        {NAV.map(([href, label]) => (
          <Link key={href} href={href}>{label}</Link>
        ))}
      </nav>
      <div className="stack" style={{ minWidth: 0 }}>{children}</div>
    </div>
  );
}
