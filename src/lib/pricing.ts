import "server-only";
import { cookies, headers } from "next/headers";
import { cache } from "react";
import {
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

export async function getRates(): Promise<Rates> {
  const row = await db.setting.findUnique({ where: { key: RATES_KEY } });
  const v = (row?.value ?? {}) as Partial<Rates>;
  const pick = (k: keyof Rates) => (typeof v[k] === "number" && v[k]! > 0 ? v[k]! : DEFAULT_RATES[k]);
  return { USD: pick("USD"), MXN: pick("MXN"), PEN: pick("PEN") };
}

/** Moneda elegida por el visitante (cookie) o la de su país, y formateadores. */
export const getPricing = cache(async () => {
  const [jar, h, rates] = await Promise.all([cookies(), headers(), getRates()]);
  const saved = jar.get(CURRENCY_COOKIE)?.value;
  const currency: Currency = isCurrency(saved) ? saved : currencyForCountry(h.get("x-vercel-ip-country"));
  return {
    currency,
    rates,
    price: (cop: number) => formatPrice(cop, currency, rates),
    range: (fromCop: number, toCop: number) => formatRange(fromCop, toCop, currency, rates),
    /** Precio en COP (lo que se cobra) para mostrar como referencia. */
    cop: (cop: number) => formatPrice(cop, "COP", rates),
  };
});
