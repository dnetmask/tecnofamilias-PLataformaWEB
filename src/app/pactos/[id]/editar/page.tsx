import Link from "next/link";
import { notFound, redirect } from "next/navigation";
import { requireUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { updatePactAction } from "../../actions";
import { PactForm } from "../../PactForm";

export const dynamic = "force-dynamic";
export const metadata = { title: "Editar pacto" };

export default async function EditPactPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const user = await requireUser(`/pactos/${id}/editar`);
  const pact = await db.pact.findUnique({ where: { id } });
  if (!pact || pact.userId !== user.id) notFound();
  if (pact.status !== "DRAFT") redirect(`/pactos/${pact.id}`);

  return (
    <div className="container section" style={{ maxWidth: 860 }}>
      <p className="small"><Link href={`/pactos/${pact.id}`}>← Volver al pacto</Link></p>
      <h1>Editar pacto</h1>
      <div className="card">
        <PactForm
          action={updatePactAction}
          submitLabel="Guardar cambios"
          initial={{
            id: pact.id,
            appName: pact.appName,
            childName: pact.childName,
            childAge: pact.childAge?.toString() ?? "",
            parentName: pact.parentName,
            clauses: Array.isArray(pact.clauses) ? (pact.clauses as string[]) : [],
            rewards: pact.rewards,
            consequences: pact.consequences,
            reviewDate: pact.reviewDate ? pact.reviewDate.toISOString().slice(0, 10) : "",
          }}
        />
      </div>
    </div>
  );
}
