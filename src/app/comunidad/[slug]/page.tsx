import Link from "next/link";
import { notFound } from "next/navigation";
import { Avatar } from "@/components/Avatar";
import { requireSubscriber } from "@/lib/access";
import { db } from "@/lib/db";
import { formatDateTime } from "@/lib/format";

export const dynamic = "force-dynamic";
const PAGE_SIZE = 20;

export default async function CategoryPage({
  params,
  searchParams,
}: {
  params: Promise<{ slug: string }>;
  searchParams: Promise<{ pagina?: string }>;
}) {
  const { slug } = await params;
  const user = await requireSubscriber(`/comunidad/${slug}`);
  const page = Math.max(1, Number((await searchParams).pagina) || 1);
  const category = await db.forumCategory.findUnique({ where: { slug } });
  if (!category) notFound();

  const where = { categoryId: category.id, ...(user.role === "ADMIN" ? {} : { hidden: false }) };
  const [threads, total] = await Promise.all([
    db.forumThread.findMany({
      where,
      orderBy: [{ pinned: "desc" }, { lastPostAt: "desc" }],
      skip: (page - 1) * PAGE_SIZE,
      take: PAGE_SIZE,
      include: { author: { select: { name: true } }, _count: { select: { posts: { where: { hidden: false } } } } },
    }),
    db.forumThread.count({ where }),
  ]);
  const pages = Math.max(1, Math.ceil(total / PAGE_SIZE));

  return (
    <div className="container section stack">
      <p className="small"><Link href="/comunidad">← Comunidad</Link></p>
      <div className="row between">
        <div>
          <h1 style={{ marginBottom: 4 }}>{category.name}</h1>
          <p className="muted" style={{ margin: 0 }}>{category.description}</p>
        </div>
        <Link className="btn" href={`/comunidad/${category.slug}/nuevo`}>Nueva conversación</Link>
      </div>
      <div className="card">
        {threads.length === 0 && <p className="muted" style={{ margin: 0 }}>Todavía no hay conversaciones en este tema.</p>}
        {threads.map((t) => (
          <Link key={t.id} href={`/comunidad/hilo/${t.id}`} className="thread-item" style={{ color: "inherit" }}>
            <Avatar name={t.author.name} />
            <div style={{ flex: 1, minWidth: 0 }}>
              <div style={{ fontWeight: 700, color: "var(--navy)" }}>
                {t.pinned && "📌 "}{t.locked && "🔒 "}{t.title}
                {t.hidden && <span className="badge badge-red" style={{ marginLeft: 8 }}>Oculta</span>}
              </div>
              <div className="small muted">{t.author.name} · {formatDateTime(t.createdAt)}</div>
            </div>
            <div className="small muted" style={{ whiteSpace: "nowrap" }}>{t._count.posts} resp.</div>
          </Link>
        ))}
      </div>
      {pages > 1 && (
        <div className="row">
          {page > 1 && <Link className="btn btn-ghost btn-sm" href={`?pagina=${page - 1}`}>← Anterior</Link>}
          <span className="small muted">Página {page} de {pages}</span>
          {page < pages && <Link className="btn btn-ghost btn-sm" href={`?pagina=${page + 1}`}>Siguiente →</Link>}
        </div>
      )}
    </div>
  );
}
