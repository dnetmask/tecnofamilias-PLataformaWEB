import { CURRENCIES, type Currency } from "@/lib/currency";

/** Aclara que el precio base es en dólares y que el cobro se hace en COP. */
export function CurrencyNote({ currency }: { currency: Currency }) {
  return (
    <p className="small muted" style={{ margin: 0 }}>
      Precios base en dólares{currency !== "USD" ? `, convertidos a ${CURRENCIES[currency].name.toLowerCase()} con la tasa del día` : ""}.
      Mercado Pago cobra el equivalente en pesos colombianos (COP); si tu tarjeta es de otro país, tu banco hace la conversión final.
    </p>
  );
}
