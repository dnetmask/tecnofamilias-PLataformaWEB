"use client";

import { useRouter } from "next/navigation";
import { useTransition } from "react";
import { CURRENCIES, CURRENCY_CODES, CURRENCY_COOKIE, type Currency } from "@/lib/currency";

export function CurrencySwitcher({ current, dark = false }: { current: Currency; dark?: boolean }) {
  const router = useRouter();
  const [pending, start] = useTransition();
  return (
    <div className={`currency-switch${dark ? " dark" : ""}`} role="group" aria-label="Moneda" aria-busy={pending}>
      {CURRENCY_CODES.map((c) => (
        <button
          key={c}
          type="button"
          aria-pressed={c === current}
          title={CURRENCIES[c].name}
          onClick={() => {
            document.cookie = `${CURRENCY_COOKIE}=${c}; path=/; max-age=31536000; samesite=lax`;
            start(() => router.refresh());
          }}
        >
          <span aria-hidden>{CURRENCIES[c].flag}</span> {c}
        </button>
      ))}
    </div>
  );
}
