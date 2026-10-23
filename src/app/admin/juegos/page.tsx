import Link from "next/link";
import { db } from "@/lib/db";
import { Notice, type NoticeParams } from "../Notice";

export default async function AdminGamesPage({ searchParams }: { searchParams: NoticeParams }) {
  const { error, ok } = await searchParams;
  const games = await db.game.findMany({
    orderBy: [{ order: "asc" }, { createdAt: "desc" }],
    select: { id: true, slug: true, title: true, ageLabel: true, emoji: true, published: true, order: true, updatedAt: true },
  });
  return (
    <>
      <div className="row between">
        <h1 style={{ margin: 0 }}>Juegos</h1>
        <Link className="btn btn-sm" href="/admin/juegos/nuevo">+ Nuevo juego</Link>
      </div>
      <Notice error={error} ok={ok} />
      <p className="small muted">
        Cada juego es un archivo HTML autocontenido. Se muestra aislado (sandbox) y solo a suscriptores.
      </p>
      <div className="table-wrap card" style={{ padding: 0 }}>
        <table className="table">
          <thead><tr><th>Orden</th><th>Juego</th><th>Edad</th><th>Estado</th><th></th></tr></thead>
          <tbody>
            {games.map((g) => (
              <tr key={g.id}>
                <td>{g.order}</td>
                <td>{g.emoji} <Link href={`/admin/juegos/${g.id}`}>{g.title}</Link></td>
                <td>{g.ageLabel}</td>
                <td>{g.published ? <span className="badge badge-green">Publicado</span> : <span className="badge badge-gray">Oculto</span>}</td>
                <td><Link className="small" href={`/juegos/${g.slug}`} target="_blank">Probar ↗</Link></td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </>
  );
}
