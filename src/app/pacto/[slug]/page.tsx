import Link from "next/link";
import { notFound, redirect } from "next/navigation";
import { hasMemberAccess } from "@/lib/access";
import { getCurrentUser } from "@/lib/auth";
import { db } from "@/lib/db";
import { pageMeta } from "@/lib/site";
import { PactForm } from "../../pactos/PactForm";
import { createPublicPactAction } from "../actions";

export const dynamic = "force-dynamic";

async function publicTemplate(slug: string) {
  const t = await db.pactTemplate.findUnique({ where: { slug } });
  return t && t.published && t.public ? t : null;
}

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const t = await publicTemplate(slug);
  if (!t) return { title: "Pacto digital" };
  return pageMeta(`/pacto/${t.slug}`, `Pacto digital: ${t.appName}`, `Crea gratis, sin cuenta, un pacto familiar para ${t.appName}: acuerdos claros que firman tú y tus hijos desde el celular. ${t.description}`.slice(0, 160));
}

/** Enlace público para crear un pacto de esta plantilla sin cuenta. */
export default async function PublicPactPage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const template = await publicTemplate(slug);
  if (!template) notFound();
  const user = await getCurrentUser();
  // Los suscriptores lo crean en su cuenta, con todas las plantillas.
  if (user && (await hasMemberAccess(user))) redirect(`/pactos/nuevo?plantilla=${template.slug}`);

  return (
    <div className="container section" style={{ maxWidth: 860 }}>
      <span className="badge badge-green">Gratis · sin crear cuenta</span>
      <h1 style={{ marginTop: 10 }}>Pacto para {template.appName}</h1>
      <p className="muted">
        {template.description ? `${template.description} ` : ""}
        Revisen juntos los acuerdos, ajústenlos a su familia y fírmenlos desde el celular. Al terminar te damos un enlace privado para
        volver a tu pacto y otro para que tu hijo o hija firme desde su propio dispositivo.
      </p>
      <div className="card">
        <PactForm
          action={createPublicPactAction}
          submitLabel="Crear pacto"
          publicForm={!user}
          initial={{
            templateId: template.id,
            appName: template.appName,
            childName: "",
            childAge: "",
            parentName: user?.name ?? "",
            clauses: Array.isArray(template.clauses) ? (template.clauses as string[]) : [],
            rewards: "",
            consequences: "",
            reviewDate: "",
          }}
        />
      </div>
      <p className="small muted center" style={{ marginTop: 16 }}>
        Con la suscripción de Tecnofamilias tienes pactos para Roblox, TikTok, WhatsApp y más, guardados en tu cuenta.{" "}
        <Link href="/planes">Conocer los planes</Link>
      </p>
    </div>
  );
}
