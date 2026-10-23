import Link from "next/link";
import { notFound } from "next/navigation";
import { requireSubscriber } from "@/lib/access";
import { db } from "@/lib/db";
import { NewThreadForm } from "../../Forms";

export const dynamic = "force-dynamic";
export const metadata = { title: "Nueva conversación" };

export default async function NewThreadPage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  await requireSubscriber(`/comunidad/${slug}/nuevo`);
  const category = await db.forumCategory.findUnique({ where: { slug } });
  if (!category) notFound();

  return (
    <div className="container section" style={{ maxWidth: 800 }}>
      <p className="small"><Link href={`/comunidad/${category.slug}`}>← {category.name}</Link></p>
      <h1>Nueva conversación</h1>
      <div className="card">
        <NewThreadForm categoryId={category.id} />
      </div>
    </div>
  );
}
