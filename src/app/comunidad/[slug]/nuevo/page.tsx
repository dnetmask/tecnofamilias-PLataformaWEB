import Link from "next/link";
import { notFound } from "next/navigation";
import { isSubscriber } from "@/lib/access";
import { requireUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { NewThreadForm } from "../../Forms";

export const dynamic = "force-dynamic";
export const metadata = { title: "Nueva conversación" };

export default async function NewThreadPage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const user = await requireUser(`/comunidad/${slug}/nuevo`);
  const category = await db.forumCategory.findUnique({ where: { slug } });
  if (!category) notFound();
  const canPost = user.role === "ADMIN" || (await isSubscriber(user.id));

  return (
    <div className="container section" style={{ maxWidth: 800 }}>
      <p className="small"><Link href={`/comunidad/${category.slug}`}>← {category.name}</Link></p>
      <h1>Nueva conversación</h1>
      <div className="card">
        {canPost ? (
          <NewThreadForm categoryId={category.id} />
        ) : (
          <div className="stack">
            <p>Para publicar en la comunidad necesitas una suscripción activa.</p>
            <Link className="btn" href="/planes" style={{ alignSelf: "flex-start" }}>Ver planes</Link>
          </div>
        )}
      </div>
    </div>
  );
}
