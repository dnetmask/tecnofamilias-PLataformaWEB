export const CURRENCIES = {
  COP: { name: "Pesos colombianos", flag: "🇨🇴", country: "CO" },
  USD: { name: "Dólares estadounidenses", flag: "🇺🇸", country: "" },
  MXN: { name: "Pesos mexicanos", flag: "🇲🇽", country: "MX" },
  PEN: { name: "Soles peruanos", flag: "🇵🇪", country: "PE" },
} as const;

export type Currency = keyof typeof CURRENCIES;
export const CURRENCY_CODES = Object.keys(CURRENCIES) as Currency[];
export const CURRENCY_COOKIE = "tf_currency";

/** Pesos colombianos por unidad de cada moneda. Se editan en /admin/monedas. */
export type Rates = Record<Exclude<Currency, "COP">, number>;
export const DEFAULT_RATES: Rates = { USD: 4000, MXN: 215, PEN: 1100 };

export function isCurrency(value: unknown): value is Currency {
  return typeof value === "string" && value in CURRENCIES;
}

/** Moneda por defecto según el país del visitante (cabecera de Vercel). */
export function currencyForCountry(country: string | null | undefined): Currency {
  if (!country) return "COP";
  const match = CURRENCY_CODES.find((c) => CURRENCIES[c].country === country.toUpperCase());
  return match ?? "USD";
}

function convert(cop: number, currency: Currency, rates: Rates) {
  return currency === "COP" ? cop : cop / rates[currency];
}

/** Redondeo "bonito" para precios fijos: 49,7 → 50; 4.651 → 4.650. */
function niceRound(x: number) {
  const step = x < 100 ? 1 : x < 1000 ? 5 : x < 10000 ? 10 : x < 100000 ? 100 : 1000;
  return Math.max(step === 1 ? 1 : step, Math.round(x / step) * step);
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

function millions(cop: number) {
  const m = cop / 1_000_000;
  return new Intl.NumberFormat("es-CO", { maximumFractionDigits: 1 }).format(m);
}

/** Precio fijo convertido, p. ej. "USD 50" o "COP 200.000". */
export function formatPrice(cop: number, currency: Currency, rates: Rates) {
  if (currency === "COP") return money(cop, "COP");
  return money(niceRound(convert(cop, currency, rates)), currency);
}

/** Rango de referencia, p. ej. "COP 3–5 M" o "USD 750–1.300". */
export function formatRange(fromCop: number, toCop: number, currency: Currency, rates: Rates) {
  if (fromCop === toCop) return formatPrice(fromCop, currency, rates);
  if (currency === "COP") {
    if (fromCop >= 1_000_000) return `COP ${millions(fromCop)}–${millions(toCop)} M`;
    return `${money(fromCop, "COP")}–${new Intl.NumberFormat("es-CO").format(toCop)}`;
  }
  const a = roundSig(convert(fromCop, currency, rates));
  const b = roundSig(convert(toCop, currency, rates));
  return `${money(a, currency)}–${new Intl.NumberFormat("es-CO").format(b)}`;
}
