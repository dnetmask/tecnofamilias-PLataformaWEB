import Script from "next/script";

/** Etiqueta de Google (GA4). Solo se carga si NEXT_PUBLIC_GA_ID está configurado (p. ej. G-XXXXXXXXXX). */
export const GA_ID = process.env.NEXT_PUBLIC_GA_ID;

export function GoogleTag() {
  if (!GA_ID) return null;
  return (
    <>
      <Script src={`https://www.googletagmanager.com/gtag/js?id=${GA_ID}`} strategy="afterInteractive" />
      <Script id="google-tag" strategy="afterInteractive">
        {`window.dataLayer=window.dataLayer||[];function gtag(){dataLayer.push(arguments);}gtag('js',new Date());gtag('config','${GA_ID}');`}
      </Script>
    </>
  );
}
