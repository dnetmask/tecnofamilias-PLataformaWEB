import "server-only";

/**
 * Envío de correos transaccionales desde un buzón de Microsoft 365 con
 * Microsoft Graph (POST /users/{buzón}/sendMail), autenticado como aplicación
 * de Entra ID con el permiso de aplicación Mail.Send.
 *
 * Variables: MS_TENANT_ID, MS_CLIENT_ID, MS_CLIENT_SECRET y MS_SENDER (el buzón
 * que envía, p. ej. hola@tecnofamilias.com). Opcional: EMAIL_FROM_NAME (nombre
 * visible, por defecto "Tecnofamilias"). Sin configurar, en desarrollo el correo
 * se muestra en la consola y en producción se registra el error.
 */

let cachedToken: { value: string; expiresAt: number } | null = null;

function config() {
  const { MS_TENANT_ID: tenant, MS_CLIENT_ID: clientId, MS_CLIENT_SECRET: secret, MS_SENDER: sender } = process.env;
  return tenant && clientId && secret && sender ? { tenant, clientId, secret, sender } : null;
}

/** Token de aplicación (client credentials); se reutiliza hasta un minuto antes de vencer. */
async function graphToken(c: NonNullable<ReturnType<typeof config>>) {
  if (cachedToken && cachedToken.expiresAt > Date.now() + 60_000) return cachedToken.value;
  const res = await fetch(`https://login.microsoftonline.com/${encodeURIComponent(c.tenant)}/oauth2/v2.0/token`, {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      client_id: c.clientId,
      client_secret: c.secret,
      scope: "https://graph.microsoft.com/.default",
      grant_type: "client_credentials",
    }),
    signal: AbortSignal.timeout(8000),
  });
  if (!res.ok) throw new Error(`Microsoft Entra respondió ${res.status}: ${await res.text()}`);
  const data = (await res.json()) as { access_token: string; expires_in: number };
  cachedToken = { value: data.access_token, expiresAt: Date.now() + data.expires_in * 1000 };
  return data.access_token;
}

export async function sendEmail(msg: { to: string; subject: string; html: string; text: string }): Promise<boolean> {
  const c = config();
  if (!c) {
    if (process.env.NODE_ENV === "production") console.error("Correo no enviado: faltan MS_TENANT_ID, MS_CLIENT_ID, MS_CLIENT_SECRET o MS_SENDER");
    else console.log(`[correo de prueba] Para: ${msg.to}\nAsunto: ${msg.subject}\n${msg.text}`);
    return false;
  }
  try {
    const token = await graphToken(c);
    const res = await fetch(`https://graph.microsoft.com/v1.0/users/${encodeURIComponent(c.sender)}/sendMail`, {
      method: "POST",
      headers: { Authorization: `Bearer ${token}`, "Content-Type": "application/json" },
      body: JSON.stringify({
        message: {
          subject: msg.subject,
          body: { contentType: "HTML", content: msg.html },
          from: { emailAddress: { address: c.sender, name: process.env.EMAIL_FROM_NAME || "Tecnofamilias" } },
          toRecipients: [{ emailAddress: { address: msg.to } }],
        },
        // Los correos automáticos no se guardan en "Elementos enviados" del buzón.
        saveToSentItems: false,
      }),
      signal: AbortSignal.timeout(8000),
    });
    // Graph responde 202 Accepted cuando el correo queda en cola de envío.
    if (!res.ok) {
      if (res.status === 401) cachedToken = null;
      console.error(`Microsoft Graph respondió ${res.status}: ${await res.text()}`);
    }
    return res.ok;
  } catch (err) {
    console.error("No se pudo enviar el correo", err);
    return false;
  }
}
