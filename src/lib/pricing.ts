import "server-only";
import { cookies, headers } from "next/headers";
import { cache } from "react";
import {
  chargeCop,
  CURRENCY_COOKIE,
  type Currency,
  currencyForCountry,
  DEFAULT_RATES,
  formatPrice,
  formatRange,
  isCurrency,
  type Rates,
} from "./currency";
import { db } from "./db";

export const RATES_KEY = "fx";

/** Configuración guardada en /admin/monedas. */
export type RatesSetting = { mode: "auto" | "manual"; manual: Rates };

export type RatesInfo = {
  rates: Rates;
  source: "auto" | "manual" | "default";
  /** Fecha de la tasa automática (si aplica). */
  asOf: Date | null;
};

// Tasas del día: ExchangeRate-API (acceso abierto, sin clave). Se cachean 6 horas.
const AUTO_URL = "https://open.er-api.com/v6/latest/USD";

async function fetchAutoRates(): Promise<{ rates: Rates; asOf: Date } | null> {
  try {
    const res = await fetch(AUTO_URL, { next: { revalidate: 21600 }, signal: AbortSignal.timeout(4000) });
    if (!res.ok) return null;
    const data = (await res.json()) as { result?: string; time_last_update_unix?: number; rates?: Record<string, number> };
    const r = data.rates;
    if (data.result !== "success" || !r || !(r.COP > 0 && r.MXN > 0 && r.PEN > 0)) return null;
    return { rates: { COP: r.COP, MXN: r.MXN, PEN: r.PEN }, asOf: new Date((data.time_last_update_unix ?? 0) * 1000) };
  } catch {
    return null;
  }
}

export async function getRatesSetting(): Promise<RatesSetting & { updatedAt: Date | null }> {
  const row = await db.setting.findUnique({ where: { key: RATES_KEY } });
  const v = (row?.value ?? {}) as Partial<RatesSetting>;
  const m = (v.manual ?? {}) as Partial<Rates>;
  const pick = (k: keyof Rates) => (typeof m[k] === "number" && m[k]! > 0 ? m[k]! : DEFAULT_RATES[k]);
  return {
    mode: v.mode === "manual" ? "manual" : "auto",
    manual: { COP: pick("COP"), MXN: pick("MXN"), PEN: pick("PEN") },
    updatedAt: row?.updatedAt ?? null,
  };
}

export const getRatesInfo = cache(async (): Promise<RatesInfo> => {
  const setting = await getRatesSetting();
  if (setting.mode === "auto") {
    const auto = await fetchAutoRates();
    if (auto) return { rates: auto.rates, source: "auto", asOf: auto.asOf };
  }
  return { rates: setting.manual, source: setting.updatedAt ? "manual" : "default", asOf: setting.updatedAt };
});

/** Moneda elegida por el visitante (cookie) o la de su país, y formateadores. */
export const getPricing = cache(async () => {
  const [jar, h, info] = await Promise.all([cookies(), headers(), getRatesInfo()]);
  const saved = jar.get(CURRENCY_COOKIE)?.value;
  const currency: Currency = isCurrency(saved) ? saved : currencyForCountry(h.get("x-vercel-ip-country"));
  const { rates } = info;
  return {
    currency,
    rates,
    info,
    price: (usd: number) => formatPrice(usd, currency, rates),
    range: (fromUsd: number, toUsd: number) => formatRange(fromUsd, toUsd, currency, rates),
    /** Lo que efectivamente cobra Mercado Pago hoy, en COP. */
    charge: (usd: number) => chargeCop(usd, rates),
  };
});
