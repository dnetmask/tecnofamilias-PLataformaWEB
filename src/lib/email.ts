import "server-only";

/**
 * Envío de correos transaccionales con Resend (https://resend.com).
 * Requiere RESEND_API_KEY y EMAIL_FROM (p. ej. "Tecnofamilias <hola@tecnofamilias.com>",
 * con el dominio verificado en Resend). Sin configurar, en desarrollo el correo se
 * muestra en la consola y en producción se registra el error.
 */
export async function sendEmail(msg: { to: string; subject: string; html: string; text: string }): Promise<boolean> {
  const key = process.env.RESEND_API_KEY;
  const from = process.env.EMAIL_FROM;
  if (!key || !from) {
    if (process.env.NODE_ENV === "production") console.error("Correo no enviado: faltan RESEND_API_KEY o EMAIL_FROM");
    else console.log(`[correo de prueba] Para: ${msg.to}\nAsunto: ${msg.subject}\n${msg.text}`);
    return false;
  }
  try {
    const res = await fetch("https://api.resend.com/emails", {
      method: "POST",
      headers: { Authorization: `Bearer ${key}`, "Content-Type": "application/json" },
      body: JSON.stringify({ from, to: [msg.to], subject: msg.subject, html: msg.html, text: msg.text }),
      signal: AbortSignal.timeout(8000),
    });
    if (!res.ok) console.error(`Resend respondió ${res.status}: ${await res.text()}`);
    return res.ok;
  } catch (err) {
    console.error("No se pudo enviar el correo", err);
    return false;
  }
}
