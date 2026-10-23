import { CURRENCIES, type Currency } from "@/lib/currency";

export function CurrencyNote({ currency }: { currency: Currency }) {
  if (currency === "COP") return null;
  return (
    <p className="small muted" style={{ margin: 0 }}>
      Valores de referencia en {CURRENCIES[currency].name.toLowerCase()}. El cobro se realiza en pesos colombianos (COP) y tu banco hace la conversión.
    </p>
  );
}
