import Link from "next/link";
import { hasMemberAccess } from "@/lib/access";
import type { CurrentUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { stageShort } from "@/lib/format";
import { TOOL_KINDS } from "@/lib/tools";
import { MasterclassPromo } from "@/components/MasterclassPromo";

const SHORTCUTS = [
  { href: "/clases", icon: "▶", label: "Clases", color: "var(--blue)" },
  { href: "/juegos", icon: "🎲", label: "Juegos", color: "var(--red)" },
  { href: "/pactos", icon: "✍", label: "Pactos", color: "var(--yellow)" },
  { href: "/herramientas", icon: "🧰", label: "Caja de herramientas", color: "var(--navy-soft)" },
  { href: "/comunidad", icon: "💬", label: "Comunidad", color: "var(--blue-dark)" },
  { href: "/planes", icon: "🤝", label: "Planes", color: "var(--ok)" },
];

function SectionHead({ title, href, cta }: { title: string; href: string; cta: string }) {
  return (
    <div className="row between" style={{ marginBottom: 12 }}>
      <h2 style={{ margin: 0, fontSize: "1.4rem" }}>{title}</h2>
      <Link href={href} className="small" style={{ fontWeight: 700 }}>{cta} →</Link>
    </div>
  );
}

/** Inicio para usuarios con sesión: accesos directos al contenido, poco texto. */
export async function MemberHome({ user }: { user: CurrentUser }) {
  const member = await hasMemberAccess(user);
  const [lessons, games, pacts, pactCount, threads, resources] = await Promise.all([
    db.lesson.findMany({
      where: { published: true },
      orderBy: [{ order: "asc" }, { createdAt: "desc" }],
      take: 4,
      select: { id: true, slug: true, title: true, ageStage: true, access: true, durationMin: true, thumbnailUrl: true },
    }),
    db.game.findMany({
      where: { published: true },
      orderBy: [{ order: "asc" }, { createdAt: "desc" }],
      select: { id: true, slug: true, title: true, emoji: true, color: true, ageLabel: true },
    }),
    db.pact.findMany({ where: { userId: user.id }, orderBy: { updatedAt: "desc" }, take: 2, select: { id: true, appName: true, childName: true, status: true } }),
    db.pact.count({ where: { userId: user.id } }),
    member
      ? db.forumThread.findMany({
          where: { hidden: false },
          orderBy: { lastPostAt: "desc" },
          take: 3,
          select: { id: true, title: true, category: { select: { name: true } }, _count: { select: { posts: { where: { hidden: false } } } } },
        })
      : [],
    db.resource.findMany({ where: { published: true }, orderBy: [{ uses: "desc" }, { order: "asc" }, { createdAt: "desc" }], take: 3, select: { id: true, slug: true, title: true, kind: true, author: true } }),
  ]);
  const lock = (href: string) => (member ? href : "/planes");

  return (
    <>
      <section className="member-hero">
        <div className="container">
          <h1>Hola, {user.name.split(" ")[0]} 👋</h1>
          <p>¿Qué quieren hacer hoy en familia?</p>
          <div className="shortcuts">
            {SHORTCUTS.map((s) => (
              <Link key={s.href} href={s.href} className="shortcut">
                <span className="icon-dot" style={{ background: s.color }}>{s.icon}</span>
                <span>{s.label}</span>
              </Link>
            ))}
          </div>
        </div>
      </section>

      <div className="container section stack" style={{ gap: 40 }}>
        {!member && (
          <div className="card row between" style={{ background: "var(--yellow)", borderColor: "transparent" }}>
            <strong style={{ color: "var(--navy-dark)" }}>Activa tu suscripción para desbloquear clases, juegos, pactos y la comunidad.</strong>
            <Link href="/planes" className="btn btn-sm" style={{ background: "var(--navy)" }}>Suscribirme</Link>
          </div>
        )}

        <MasterclassPromo compact />

        <section>
          <SectionHead title="Sigue aprendiendo" href="/clases" cta="Todas las clases" />
          <div className="grid grid-4">
            {lessons.map((l) => (
              <Link key={l.id} href={`/clases/${l.slug}`} className="card card-link" style={{ padding: 12 }}>
                <div className="lesson-thumb" style={{ marginBottom: 10, fontSize: "1.8rem" }}>
                  {l.thumbnailUrl ? <img src={l.thumbnailUrl} alt="" /> : <span>{member && l.access === "INCLUDED" ? "▶" : "🔒"}</span>}
                </div>
                <div className="small muted">
                  {stageShort(l.ageStage)}{l.ageStage !== "ALL" ? " años" : ""}{l.durationMin ? ` · ${l.durationMin} min` : ""}
                  {l.access === "ADDON" && " · Complemento"}
                </div>
                <strong style={{ color: "var(--navy)", lineHeight: 1.25, display: "block" }}>{l.title}</strong>
              </Link>
            ))}
          </div>
        </section>

        <section>
          <SectionHead title="Jueguen juntos" href="/juegos" cta="Todos los juegos" />
          <div className="grid grid-3">
            {games.map((g) => (
              <Link key={g.id} href={lock(`/juegos/${g.slug}`)} className="card card-link row" style={{ flexWrap: "nowrap" }}>
                <span className="icon-dot" style={{ background: g.color, width: 56, height: 56, fontSize: "1.7rem" }}>{g.emoji}</span>
                <div style={{ minWidth: 0 }}>
                  <strong style={{ color: "var(--navy)", display: "block", lineHeight: 1.2 }}>{g.title}</strong>
                  <span className="small muted">{g.ageLabel}</span>
                </div>
                <span className="btn btn-sm" style={{ marginLeft: "auto" }}>{member ? "Jugar" : "🔒"}</span>
              </Link>
            ))}
          </div>
        </section>

        <div className="grid grid-2" style={{ alignItems: "start" }}>
          <section className="card">
            <SectionHead title="Mis pactos" href="/pactos" cta={pactCount ? `Ver los ${pactCount}` : "Plantillas"} />
            {pacts.length === 0 ? (
              <p className="muted" style={{ marginTop: 0 }}>Aún no tienen pactos. Creen el primero para una app que usen mucho.</p>
            ) : (
              <div className="stack" style={{ marginBottom: 12 }}>
                {pacts.map((p) => (
                  <Link key={p.id} href={`/pactos/${p.id}`} className="row between" style={{ color: "inherit" }}>
                    <span>✍ {p.appName} · {p.childName}</span>
                    <span className={`badge ${p.status === "SIGNED" ? "badge-green" : "badge-yellow"}`}>{p.status === "SIGNED" ? "Firmado" : "Por firmar"}</span>
                  </Link>
                ))}
              </div>
            )}
            <Link href={lock("/pactos/nuevo")} className="btn btn-sm btn-yellow">+ Nuevo pacto</Link>
          </section>

          <section className="card">
            <SectionHead title="En la comunidad" href="/comunidad" cta="Ir al foro" />
            {threads.length === 0 ? (
              <p className="muted" style={{ marginTop: 0 }}>{member ? "Sé la primera familia en abrir una conversación." : "Únete para leer y conversar con otras familias."}</p>
            ) : (
              <div className="stack">
                {threads.map((t) => (
                  <Link key={t.id} href={`/comunidad/hilo/${t.id}`} style={{ color: "inherit", display: "block" }}>
                    <strong style={{ color: "var(--navy)" }}>{t.title}</strong>
                    <div className="small muted">{t.category.name} · {t._count.posts} respuestas</div>
                  </Link>
                ))}
              </div>
            )}
          </section>
        </div>

        {resources.length > 0 && (
          <section>
            <SectionHead title="Las herramientas más usadas" href="/herramientas" cta="Caja de herramientas" />
            <div className="grid grid-3">
              {resources.map((r) => (
                <Link key={r.id} href={`/herramientas/${r.slug}`} className="card card-link row" style={{ flexWrap: "nowrap" }}>
                  <span className="icon-dot" style={{ background: TOOL_KINDS[r.kind].color }}>{TOOL_KINDS[r.kind].icon}</span>
                  <div style={{ minWidth: 0 }}>
                    <strong style={{ color: "var(--navy)", display: "block", lineHeight: 1.2 }}>{r.title}</strong>
                    <span className="small muted">{TOOL_KINDS[r.kind].label}{r.author ? ` · ${r.author}` : ""}</span>
                  </div>
                </Link>
              ))}
            </div>
          </section>
        )}
      </div>
    </>
  );
}
