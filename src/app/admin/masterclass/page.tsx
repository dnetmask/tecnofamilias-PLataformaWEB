import Link from "next/link";
import { SeatsBar } from "@/components/SeatsBar";
import { SubmitButton } from "@/components/SubmitButton";
import { getMasterclass } from "@/lib/masterclass";
import { saveMasterclassAction } from "../actions";
import { Notice, type NoticeParams } from "../Notice";

export default async function AdminMasterclassPage({ searchParams }: { searchParams: NoticeParams }) {
  const { error, ok } = await searchParams;
  const mc = await getMasterclass();
  return (
    <>
      <div className="row between">
        <h1>Masterclass</h1>
        <Link href="/masterclass" className="btn btn-sm btn-light" target="_blank">Ver la landing</Link>
      </div>
      <Notice error={error} ok={ok} />
      <p className="small muted">
        Datos de la próxima masterclass que se muestran en la landing <strong>/masterclass</strong> y en el aviso de los inicios.
        El precio se edita en <Link href="/admin/servicios">Otros servicios</Link>
        {mc.service ? <> ({mc.service.name})</> : <> — <strong>no se encontró el servicio {mc.serviceSlug}</strong></>}.
        Las compras aparecen en <Link href="/admin/solicitudes">Solicitudes</Link>.
      </p>

      <div className="card">
        <SeatsBar pct={mc.seatsPct} />
        <p className="small muted" style={{ margin: "10px 0 0" }}>
          {mc.dateLabel} · {mc.time} ({mc.timezone}) · {mc.isPast ? "La fecha ya pasó: el aviso y la compra están ocultos." : mc.showOnHome ? "Visible en los inicios." : "Oculta en los inicios."}
        </p>
      </div>

      <form action={saveMasterclassAction} className="card form">
        <div className="grid grid-3" style={{ gap: 14 }}>
          <div className="field">
            <label htmlFor="mc-date">Fecha</label>
            <input id="mc-date" className="input" type="date" name="date" defaultValue={mc.date} required />
          </div>
          <div className="field">
            <label htmlFor="mc-time">Horario</label>
            <input id="mc-time" className="input" name="time" defaultValue={mc.time} required />
          </div>
          <div className="field">
            <label htmlFor="mc-tz">Zona horaria</label>
            <input id="mc-tz" className="input" name="timezone" defaultValue={mc.timezone} required />
          </div>
          <div className="field">
            <label htmlFor="mc-mod">Modalidad</label>
            <input id="mc-mod" className="input" name="modality" defaultValue={mc.modality} required />
          </div>
          <div className="field">
            <label htmlFor="mc-dur">Duración</label>
            <input id="mc-dur" className="input" name="duration" defaultValue={mc.duration} required />
          </div>
          <div className="field">
            <label htmlFor="mc-rec">Días de acceso a la grabación</label>
            <input id="mc-rec" className="input" type="number" min={0} max={365} name="recordingDays" defaultValue={mc.recordingDays} required />
          </div>
          <div className="field">
            <label htmlFor="mc-seats">Cupos ocupados (%)</label>
            <input id="mc-seats" className="input" type="number" min={0} max={100} name="seatsPct" defaultValue={mc.seatsPct} required />
            <span className="hint">Porcentaje que muestra la barra de cupos.</span>
          </div>
        </div>
        <label className="check"><input type="checkbox" name="showOnHome" defaultChecked={mc.showOnHome} /> Mostrar el aviso en los inicios</label>
        <div><SubmitButton className="btn btn-sm">Guardar</SubmitButton></div>
      </form>
    </>
  );
}
