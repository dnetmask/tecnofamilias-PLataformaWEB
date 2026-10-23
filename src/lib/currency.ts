export const CURRENCIES = {
  USD: { name: "Dólares estadounidenses", flag: "🇺🇸", country: "" },
  COP: { name: "Pesos colombianos", flag: "🇨🇴", country: "CO" },
  MXN: { name: "Pesos mexicanos", flag: "🇲🇽", country: "MX" },
  PEN: { name: "Soles peruanos", flag: "🇵🇪", country: "PE" },
} as const;

export type Currency = keyof typeof CURRENCIES;
export const CURRENCY_CODES = Object.keys(CURRENCIES) as Currency[];
export const CURRENCY_COOKIE = "tf_currency";

/** Unidades de cada moneda por 1 USD (los precios base están en dólares). */
export type Rates = Record<Exclude<Currency, "USD">, number>;
export const DEFAULT_RATES: Rates = { COP: 4000, MXN: 18.5, PEN: 3.75 };

/** Moneda en la que cobra Mercado Pago (cuenta de Colombia). */
export const CHARGE_CURRENCY = "COP" as const;

export function isCurrency(value: unknown): value is Currency {
  return typeof value === "string" && value in CURRENCIES;
}

/** Moneda por defecto según el país del visitante (cabecera de Vercel). */
export function currencyForCountry(country: string | null | undefined): Currency {
  if (!country) return "USD";
  const match = CURRENCY_CODES.find((c) => CURRENCIES[c].country === country.toUpperCase());
  return match ?? "USD";
}

function convert(usd: number, currency: Currency, rates: Rates) {
  return currency === "USD" ? usd : usd * rates[currency];
}

/** Redondeo "bonito" para mostrar precios fijos convertidos. */
function niceRound(x: number) {
  const step = x < 100 ? 1 : x < 1000 ? 5 : x < 10000 ? 10 : x < 100000 ? 100 : 1000;
  return Math.max(1, Math.round(x / step) * step);
}

/** Dos cifras significativas, para rangos de referencia. */
function roundSig(x: number) {
  if (x <= 0) return 0;
  const p = Math.pow(10, Math.floor(Math.log10(x)) - 1);
  return Math.round(x / p) * p;
}

function money(amount: number, currency: Currency) {
  return new Intl.NumberFormat("es-CO", {
    style: "currency",
    currency,
    currencyDisplay: "code",
    maximumFractionDigits: 0,
  }).format(amount);
}

const num = (n: number, max = 0) => new Intl.NumberFormat("es-CO", { maximumFractionDigits: max }).format(n);

/** Precio fijo en la moneda elegida, p. ej. "USD 60" o "MXN 1.110". */
export function formatPrice(usd: number, currency: Currency, rates: Rates) {
  if (currency === "USD") return money(usd, "USD");
  return money(niceRound(convert(usd, currency, rates)), currency);
}

/** Rango de referencia, p. ej. "USD 750–1.250" o "COP 3–5 M". */
export function formatRange(fromUsd: number, toUsd: number, currency: Currency, rates: Rates) {
  if (fromUsd === toUsd) return formatPrice(fromUsd, currency, rates);
  if (currency === "USD") return `${money(fromUsd, "USD")}–${num(toUsd)}`;
  const a = convert(fromUsd, currency, rates);
  const b = convert(toUsd, currency, rates);
  if (currency === "COP" && a >= 1_000_000) return `COP ${num(roundSig(a) / 1e6, 1)}–${num(roundSig(b) / 1e6, 1)} M`;
  return `${money(roundSig(a), currency)}–${num(roundSig(b))}`;
}

/** Monto exacto a cobrar en COP para un precio en dólares (redondeado a 100). */
export function chargeCop(usd: number, rates: Rates) {
  return Math.max(100, Math.round((usd * rates.COP) / 100) * 100);
}
