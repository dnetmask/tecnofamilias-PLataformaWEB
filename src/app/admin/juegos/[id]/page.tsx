import Link from "next/link";
import { notFound } from "next/navigation";
import { SubmitButton } from "@/components/SubmitButton";
import { db } from "@/lib/db";
import { deleteGameAction, saveGameAction } from "../../actions";
import { Notice, type NoticeParams } from "../../Notice";

export default async function AdminGamePage({ params, searchParams }: { params: Promise<{ id: string }>; searchParams: NoticeParams }) {
  const { id } = await params;
  const { error, ok } = await searchParams;
  const g =
    id === "nuevo"
      ? null
      : await db.game.findUnique({
          where: { id },
          select: { id: true, slug: true, title: true, description: true, ageLabel: true, emoji: true, color: true, order: true, fullHeight: true, published: true, updatedAt: true },
        });
  if (id !== "nuevo" && !g) notFound();

  return (
    <>
      <p className="small"><Link href="/admin/juegos">← Juegos</Link></p>
      <div className="row between">
        <h1 style={{ margin: 0 }}>{g ? "Editar juego" : "Nuevo juego"}</h1>
        {g && <Link className="btn btn-ghost btn-sm" href={`/juegos/${g.slug}`} target="_blank">Probar ↗</Link>}
      </div>
      <Notice error={error} ok={ok} />
      <form action={saveGameAction} className="card form">
        {g && <input type="hidden" name="id" value={g.id} />}
        <div className="grid grid-2" style={{ gap: 14 }}>
          <div className="field"><label>Título</label><input className="input" name="title" defaultValue={g?.title} required /></div>
          <div className="field"><label>Slug (URL)</label><input className="input" name="slug" defaultValue={g?.slug} placeholder="Se genera del título" /></div>
          <div className="field"><label>Edad recomendada</label><input className="input" name="ageLabel" defaultValue={g?.ageLabel} placeholder="Ej: 8 a 13 años" /></div>
          <div className="field"><label>Emoji</label><input className="input" name="emoji" defaultValue={g?.emoji ?? "🎲"} maxLength={8} /></div>
          <div className="field"><label>Color</label><input className="input" name="color" defaultValue={g?.color ?? "#3DAEE4"} pattern="#[0-9a-fA-F]{6}" /></div>
          <div className="field"><label>Orden</label><input className="input" name="order" type="number" defaultValue={g?.order ?? 0} /></div>
        </div>
        <div className="field"><label>Descripción</label><textarea className="textarea" name="description" defaultValue={g?.description} rows={3} /></div>
        <div className="field">
          <label>Archivo HTML del juego{g ? " (opcional: solo si lo vas a reemplazar)" : ""}</label>
          <input className="input" name="file" type="file" accept=".html,text/html" required={!g} />
          <span className="hint">Un solo archivo .html con sus estilos y scripts incluidos, hasta 1,5 MB.</span>
        </div>
        <label className="check">
          <input type="checkbox" name="fullHeight" defaultChecked={g?.fullHeight ?? false} />
          <span>Pantalla fija: el juego ocupa el alto de la pantalla y tiene su propio scroll (para juegos por pantallas con ventanas emergentes)</span>
        </label>
        <label className="check"><input type="checkbox" name="published" defaultChecked={g?.published ?? true} /> Publicado</label>
        <div><SubmitButton>Guardar juego</SubmitButton></div>
      </form>
      {g && (
        <form action={deleteGameAction}>
          <input type="hidden" name="id" value={g.id} />
          <button className="btn-link btn-danger-link small">Eliminar juego</button>
        </form>
      )}
    </>
  );
}
