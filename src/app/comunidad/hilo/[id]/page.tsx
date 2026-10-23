import Link from "next/link";
import { notFound } from "next/navigation";
import { Avatar } from "@/components/Avatar";
import { requireSubscriber } from "@/lib/access";
import { db } from "@/lib/db";
import { formatDateTime } from "@/lib/format";
import { deleteOwnPostAction, moderatePostAction, moderateThreadAction, reportAction } from "../../actions";
import { ReplyForm } from "../../Forms";

export const dynamic = "force-dynamic";

export default async function ThreadPage({
  params,
  searchParams,
}: {
  params: Promise<{ id: string }>;
  searchParams: Promise<{ reportado?: string }>;
}) {
  const { id } = await params;
  const { reportado } = await searchParams;
  const user = await requireSubscriber(`/comunidad/hilo/${id}`);
  const isAdmin = user.role === "ADMIN";
  const thread = await db.forumThread.findUnique({
    where: { id },
    include: {
      category: true,
      author: { select: { name: true, role: true } },
      posts: {
        where: isAdmin ? {} : { hidden: false },
        orderBy: { createdAt: "asc" },
        include: { author: { select: { name: true, role: true } } },
      },
    },
  });
  if (!thread || (thread.hidden && !isAdmin)) notFound();

  const ModButton = ({ op, label }: { op: string; label: string }) => (
    <form action={moderateThreadAction}>
      <input type="hidden" name="threadId" value={thread.id} />
      <input type="hidden" name="op" value={op} />
      <button className="btn btn-ghost btn-sm">{label}</button>
    </form>
  );

  return (
    <div className="container section stack" style={{ maxWidth: 900 }}>
      <p className="small"><Link href={`/comunidad/${thread.category.slug}`}>← {thread.category.name}</Link></p>
      {reportado && <div className="alert alert-ok">Gracias. El equipo de moderación revisará el reporte.</div>}
      <h1 style={{ fontSize: "1.8rem" }}>
        {thread.pinned && "📌 "}{thread.title}
      </h1>
      {isAdmin && (
        <div className="row card card-tint" style={{ padding: 12 }}>
          <span className="small label">Moderación:</span>
          <ModButton op="pin" label={thread.pinned ? "Desfijar" : "Fijar"} />
          <ModButton op="lock" label={thread.locked ? "Reabrir" : "Cerrar"} />
          <ModButton op="hide" label={thread.hidden ? "Mostrar" : "Ocultar"} />
          <ModButton op="delete" label="Eliminar" />
        </div>
      )}

      <article className="card post">
        <Avatar name={thread.author.name} />
        <div style={{ flex: 1, minWidth: 0 }}>
          <div className="small">
            <strong>{thread.author.name}</strong>
            {thread.author.role === "ADMIN" && <span className="badge badge-blue" style={{ marginLeft: 6 }}>Equipo</span>}
            <span className="muted"> · {formatDateTime(thread.createdAt)}</span>
          </div>
          <div className="post-body" style={{ marginTop: 8 }}>{thread.body}</div>
          <form action={reportAction} style={{ marginTop: 8 }}>
            <input type="hidden" name="threadId" value={thread.id} />
            <button className="btn-link small muted">Reportar</button>
          </form>
        </div>
      </article>

      <h3>{thread.posts.length} respuestas</h3>
      {thread.posts.map((p) => (
        <article key={p.id} className="card post" style={p.hidden ? { opacity: 0.55 } : undefined}>
          <Avatar name={p.author.name} />
          <div style={{ flex: 1, minWidth: 0 }}>
            <div className="small">
              <strong>{p.author.name}</strong>
              {p.author.role === "ADMIN" && <span className="badge badge-blue" style={{ marginLeft: 6 }}>Equipo</span>}
              <span className="muted"> · {formatDateTime(p.createdAt)}</span>
              {p.hidden && <span className="badge badge-red" style={{ marginLeft: 6 }}>Oculta</span>}
            </div>
            <div className="post-body" style={{ marginTop: 8 }}>{p.body}</div>
            <div className="row" style={{ marginTop: 8 }}>
              <form action={reportAction}>
                <input type="hidden" name="postId" value={p.id} />
                <button className="btn-link small muted">Reportar</button>
              </form>
              {(p.authorId === user.id || isAdmin) && (
                <form action={deleteOwnPostAction}>
                  <input type="hidden" name="postId" value={p.id} />
                  <button className="btn-link small btn-danger-link">Eliminar</button>
                </form>
              )}
              {isAdmin && (
                <form action={moderatePostAction}>
                  <input type="hidden" name="postId" value={p.id} />
                  <button className="btn-link small">{p.hidden ? "Mostrar" : "Ocultar"}</button>
                </form>
              )}
            </div>
          </div>
        </article>
      ))}

      <div className="card">
        {thread.locked && !isAdmin ? (
          <p className="muted" style={{ margin: 0 }}>🔒 Esta conversación está cerrada.</p>
        ) : (
          <ReplyForm threadId={thread.id} />
        )}
      </div>
    </div>
  );
}
