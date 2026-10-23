import Link from "next/link";
import { requireSubscriber } from "@/lib/access";
import { db } from "@/lib/db";
import { createPactAction } from "../actions";
import { PactForm } from "../PactForm";

export const dynamic = "force-dynamic";
export const metadata = { title: "Nuevo pacto" };

export default async function NewPactPage({ searchParams }: { searchParams: Promise<{ plantilla?: string }> }) {
  const { plantilla } = await searchParams;
  const user = await requireSubscriber(plantilla ? `/pactos/nuevo?plantilla=${plantilla}` : "/pactos/nuevo");
  const template = plantilla ? await db.pactTemplate.findUnique({ where: { slug: plantilla } }) : null;

  return (
    <div className="container section" style={{ maxWidth: 860 }}>
      <p className="small"><Link href="/pactos">← Pactos</Link></p>
      <h1>{template ? `Pacto para ${template.appName}` : "Nuevo pacto"}</h1>
      {template?.description && <p className="muted">{template.description}</p>}
      <div className="card">
        <PactForm
          action={createPactAction}
          submitLabel="Crear pacto"
          initial={{
            templateId: template?.id,
            appName: template?.appName ?? "",
            childName: "",
            childAge: "",
            parentName: user.name,
            clauses: Array.isArray(template?.clauses) ? (template.clauses as string[]) : [],
            rewards: "",
            consequences: "",
            reviewDate: "",
          }}
        />
      </div>
    </div>
  );
}
