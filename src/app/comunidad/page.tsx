import Link from "next/link";
import { Avatar } from "@/components/Avatar";
import { requireSubscriber } from "@/lib/access";
import { db } from "@/lib/db";
import { formatDateTime } from "@/lib/format";
import { NOINDEX } from "@/lib/site";

export const dynamic = "force-dynamic";
export const metadata = { title: "Comunidad", ...NOINDEX };

export default async function CommunityPage() {
  await requireSubscriber("/comunidad");
  const [categories, recent] = await Promise.all([
    db.forumCategory.findMany({
      orderBy: { order: "asc" },
      include: { _count: { select: { threads: { where: { hidden: false } } } } },
    }),
    db.forumThread.findMany({
      where: { hidden: false },
      orderBy: { lastPostAt: "desc" },
      take: 8,
      include: { author: { select: { name: true } }, category: true, _count: { select: { posts: { where: { hidden: false } } } } },
    }),
  ]);

  return (
    <>
      <div className="page-head">
        <div className="container">
          <h1>Comunidad de apoyo</h1>
          <p>Familias que se ayudan entre sí. Pregunta, comparte y aprende de otras experiencias.</p>
        </div>
      </div>
      <div className="container section layout-aside">
        <div className="stack">
          <h2>Temas</h2>
          <div className="grid grid-2">
            {categories.map((c) => (
              <Link key={c.id} href={`/comunidad/${c.slug}`} className="card card-link">
                <h3>{c.name}</h3>
                <p className="muted small">{c.description}</p>
                <span className="badge">{c._count.threads} conversaciones</span>
              </Link>
            ))}
          </div>
        </div>
        <aside className="card">
          <h3>Actividad reciente</h3>
          {recent.length === 0 && <p className="muted small">Aún no hay conversaciones. ¡Empieza la primera!</p>}
          {recent.map((t) => (
            <Link key={t.id} href={`/comunidad/hilo/${t.id}`} className="thread-item" style={{ color: "inherit" }}>
              <Avatar name={t.author.name} />
              <div style={{ minWidth: 0 }}>
                <div style={{ fontWeight: 700, color: "var(--navy)" }}>{t.title}</div>
                <div className="small muted">
                  {t.category.name} · {t._count.posts} respuestas · {formatDateTime(t.lastPostAt)}
                </div>
              </div>
            </Link>
          ))}
        </aside>
      </div>
      <div className="container">
        <div className="card card-tint small">
          <strong>Normas de la comunidad:</strong> respeto ante todo; no compartas datos que identifiquen a menores; nada de
          publicidad. Si ves algo inapropiado, usa “Reportar”. Ante un caso de riesgo inmediato, contacta a las autoridades
          (en Colombia: Línea 141 del ICBF o el CAI Virtual de la Policía).
        </div>
      </div>
    </>
  );
}
