import Link from "next/link";
import { toggleFavoriteAction } from "./actions";

/** Estrella para guardar la herramienta en Mis favoritos. Sin sesión lleva a ingresar. */
export function FavoriteButton({ id, favorite, loggedIn, back }: { id: string; favorite: boolean; loggedIn: boolean; back: string }) {
  if (!loggedIn) {
    return (
      <Link href={`/ingresar?next=${encodeURIComponent(back)}`} className="fav-btn" title="Ingresa para guardar en favoritos" aria-label="Guardar en favoritos">
        ☆
      </Link>
    );
  }
  return (
    <form action={toggleFavoriteAction}>
      <input type="hidden" name="id" value={id} />
      <input type="hidden" name="back" value={back} />
      <button
        type="submit"
        className={`fav-btn${favorite ? " on" : ""}`}
        title={favorite ? "Quitar de favoritos" : "Guardar en favoritos"}
        aria-label={favorite ? "Quitar de favoritos" : "Guardar en favoritos"}
        aria-pressed={favorite}
      >
        {favorite ? "★" : "☆"}
      </button>
    </form>
  );
}
