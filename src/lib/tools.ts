import type { ResourceAccess, ResourceKind } from "@prisma/client";

/** Tipos de herramienta de la Caja de herramientas. */
export const TOOL_KINDS: Record<ResourceKind, { label: string; plural: string; icon: string; color: string; open: string }> = {
  VIDEO: { label: "Video", plural: "Videos", icon: "🎬", color: "var(--blue)", open: "Ver video" },
  PODCAST: { label: "Podcast", plural: "Podcasts", icon: "🎧", color: "var(--red)", open: "Escuchar podcast" },
  BOOK: { label: "Libro", plural: "Libros", icon: "📚", color: "var(--navy-soft)", open: "Ver libro" },
  EBOOK: { label: "Ebook", plural: "Ebooks", icon: "📱", color: "var(--blue-dark)", open: "Abrir ebook" },
  DOCUMENT: { label: "Documento", plural: "Documentos", icon: "📄", color: "var(--yellow)", open: "Abrir documento" },
  SOFTWARE: { label: "Software", plural: "Software", icon: "💻", color: "var(--navy)", open: "Ver software" },
  HARDWARE: { label: "Hardware", plural: "Hardware", icon: "⌚", color: "var(--red)", open: "Ver producto" },
};

export const TOOL_KIND_ORDER: ResourceKind[] = ["VIDEO", "PODCAST", "BOOK", "EBOOK", "DOCUMENT", "SOFTWARE", "HARDWARE"];

export const TOOL_ACCESS: Record<ResourceAccess, { label: string; badge: string }> = {
  FREE: { label: "Libre acceso", badge: "badge-green" },
  SUBSCRIPTION: { label: "Incluida en la suscripción", badge: "badge-blue" },
  PAID: { label: "Pago adicional", badge: "badge-yellow" },
  EXTERNAL: { label: "Se compra por fuera", badge: "badge-gray" },
};

export type ToolViewer = {
  loggedIn: boolean;
  /** Suscripción activa o administrador. */
  member: boolean;
  admin: boolean;
  /** Ids de las herramientas pagas que el usuario ya compró. */
  purchased: Set<string>;
};

/**
 * ¿Puede el usuario abrir la herramienta? Las de libre acceso y las que se
 * compran por fuera están abiertas para todos; las pagas exigen suscripción
 * activa y haberlas comprado.
 */
export function canUseTool(viewer: ToolViewer, tool: { id: string; access: ResourceAccess }) {
  if (tool.access === "FREE" || tool.access === "EXTERNAL") return true;
  if (viewer.admin) return true;
  if (!viewer.member) return false;
  return tool.access === "SUBSCRIPTION" || viewer.purchased.has(tool.id);
}

export function usesLabel(uses: number) {
  return uses === 1 ? "1 familia la usó" : `${uses.toLocaleString("es-CO")} familias la usaron`;
}
