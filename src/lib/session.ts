// Sesión firmada con JWT en cookie httpOnly. Este módulo no usa la base de
// datos para poder ejecutarse también en el middleware (runtime edge).
import { SignJWT, jwtVerify } from "jose";

export const SESSION_COOKIE = "tf_session";
export const SESSION_MAX_AGE = 60 * 60 * 24 * 30; // 30 días

export type SessionPayload = { sub: string; role: "USER" | "ADMIN"; /** Segundos desde 1970 en que se firmó. */ iat?: number };

function secret() {
  const value = process.env.AUTH_SECRET;
  if (!value || value.length < 32) {
    throw new Error("AUTH_SECRET debe tener al menos 32 caracteres");
  }
  return new TextEncoder().encode(value);
}

export async function signSession(payload: SessionPayload) {
  return new SignJWT({ role: payload.role })
    .setProtectedHeader({ alg: "HS256" })
    .setSubject(payload.sub)
    .setIssuedAt()
    .setExpirationTime(`${SESSION_MAX_AGE}s`)
    .sign(secret());
}

export async function verifySession(token: string | undefined): Promise<SessionPayload | null> {
  if (!token) return null;
  try {
    const { payload } = await jwtVerify(token, secret(), { algorithms: ["HS256"] });
    if (typeof payload.sub !== "string") return null;
    return { sub: payload.sub, role: payload.role === "ADMIN" ? "ADMIN" : "USER", iat: payload.iat };
  } catch {
    return null;
  }
}
