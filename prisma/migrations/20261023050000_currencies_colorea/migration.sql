-- Rangos de precio numéricos para mostrarlos en varias monedas.
ALTER TABLE "Service" ADD COLUMN "priceFromCop" INTEGER;
ALTER TABLE "Service" ADD COLUMN "priceToCop" INTEGER;
UPDATE "Service" SET "priceFromCop" = 1000000,   "priceToCop" = 1000000   WHERE "slug" = 'asesoria-personalizada';
UPDATE "Service" SET "priceFromCop" = 3000000,   "priceToCop" = 5000000   WHERE "slug" = 'colegios-masterclass-institucional';
UPDATE "Service" SET "priceFromCop" = 12000000,  "priceToCop" = 20000000  WHERE "slug" = 'colegios-programa-anual';
UPDATE "Service" SET "priceFromCop" = 4000000,   "priceToCop" = 6000000   WHERE "slug" = 'empresas-sesion-empleados';
UPDATE "Service" SET "priceFromCop" = 20000000,  "priceToCop" = 25000000  WHERE "slug" = 'empresas-programa-bienestar';
UPDATE "Service" SET "priceFromCop" = 60000000,  "priceToCop" = 150000000 WHERE "slug" = 'alcaldias-programa-social';
UPDATE "Service" SET "priceFromCop" = 200000000, "priceToCop" = 500000000 WHERE "slug" = 'gobernaciones-programa-departamental';
-- Servicios creados desde el admin con otro slug: usar el precio en línea si existe.
UPDATE "Service" SET "priceFromCop" = COALESCE("priceCop", 0), "priceToCop" = COALESCE("priceCop", 0) WHERE "priceFromCop" IS NULL;
ALTER TABLE "Service" ALTER COLUMN "priceFromCop" SET NOT NULL;
ALTER TABLE "Service" ALTER COLUMN "priceToCop" SET NOT NULL;
ALTER TABLE "Service" DROP COLUMN "priceLabel";

-- Configuración editable (tasas de cambio).
CREATE TABLE "Setting" (
    "key" TEXT NOT NULL,
    "value" JSONB NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    CONSTRAINT "Setting_pkey" PRIMARY KEY ("key")
);

-- Solo queda el plan anual.
UPDATE "Plan" SET "active" = false WHERE "slug" = 'mensual';
UPDATE "Plan" SET "description" = 'Acceso completo durante 12 meses.' WHERE "slug" = 'anual' AND "description" = 'Dos meses gratis frente al plan mensual.';

-- Tercer juego.
INSERT INTO "Game" ("id", "slug", "title", "description", "ageLabel", "emoji", "color", "html", "fullHeight", "published", "order", "updatedAt")
VALUES ('game_colorea_tecnito', 'colorea-tecnito', 'Colorea con Tecnito', '20 dibujos de Tecnito para pintar tocando colores: pantallas con límite, contraseñas secretas, pedir ayuda, dormir sin tablet y más. Cada dibujo trae un mensaje de cuidado digital.', '3 a 8 años', '🖍️', '#EF4A36', $tfgame$<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>Colorea con Tecnito · Tecnofamilias</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@500;600;700;800&display=swap" rel="stylesheet">
<style>
:root{
  --blue:#3EAEE3; --navy:#283A61; --yellow:#FDBE2F; --red:#EF4A36;
  --bg:#EAF6FD; --bg-dot:#cfe9f8; --surface:#ffffff; --text:#283A61; --muted:#5b6b8c;
  --line:#d6e4f0; --paper:#ffffff; --chip:#f3f8fc;
  color-scheme: light;
  box-sizing:border-box;
  padding-top:env(safe-area-inset-top,0px); padding-bottom:env(safe-area-inset-bottom,0px);
}
@media (prefers-color-scheme: dark){
  :root:not([data-theme="light"]){
    --bg:#172340; --bg-dot:#22325a; --surface:#22304f; --text:#f2f6ff; --muted:#b6c3df;
    --line:#34466f; --paper:#ffffff; --chip:#2b3b60; color-scheme:dark;
  }
}
:root[data-theme="dark"]{
  --bg:#172340; --bg-dot:#22325a; --surface:#22304f; --text:#f2f6ff; --muted:#b6c3df;
  --line:#34466f; --paper:#ffffff; --chip:#2b3b60; color-scheme:dark;
}
html{scroll-padding-top:env(safe-area-inset-top,0px)}
*{box-sizing:border-box}
html,body{margin:0}
body{
  font-family:"Baloo 2","Nunito","Trebuchet MS",system-ui,sans-serif;
  background:var(--bg);
  background-image:radial-gradient(var(--bg-dot) 2px, transparent 2.5px);
  background-size:26px 26px;
  color:var(--text); min-height:100vh;
  -webkit-tap-highlight-color:transparent;
}
button{font-family:inherit;color:inherit;cursor:pointer}
button:focus-visible,.card:focus-visible{outline:4px solid var(--yellow);outline-offset:3px}
.wrap{max-width:1100px;margin:0 auto;padding:16px}

/* header */
header.top{display:flex;align-items:center;justify-content:space-between;gap:12px}
.logo{background:#fff;border-radius:18px;padding:6px 14px;display:flex;align-items:center;box-shadow:0 3px 0 var(--line)}
.logo img{height:38px;display:block}
.iconbtn{border:none;background:var(--surface);border-radius:16px;min-width:52px;height:52px;font-size:24px;box-shadow:0 4px 0 var(--line);display:inline-flex;align-items:center;justify-content:center;gap:6px;padding:0 14px;font-weight:700}
.iconbtn:active{transform:translateY(3px);box-shadow:0 1px 0 var(--line)}

/* hero */
.hero{display:grid;grid-template-columns:auto 1fr;gap:18px;align-items:center;margin:18px 0 8px}
.hero svg{width:150px;height:150px}
.hero h1{font-size:clamp(34px,6vw,58px);line-height:1;margin:0 0 8px;font-weight:800;letter-spacing:-.5px}
.hero h1 span{display:inline-block}
.hero p{margin:0;font-size:20px;color:var(--muted);max-width:34ch;line-height:1.3}
.progress{margin-top:12px;display:flex;align-items:center;gap:10px;font-weight:700;font-size:18px}
.bar{flex:0 1 260px;height:16px;background:var(--surface);border-radius:20px;overflow:hidden;box-shadow:inset 0 0 0 2px var(--line)}
.bar i{display:block;height:100%;width:0;background:repeating-linear-gradient(90deg,var(--blue) 0 25%,var(--yellow) 25% 50%,var(--red) 50% 75%,#6FD8B5 75% 100%);border-radius:20px;transition:width .5s}

/* gallery */
.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(160px,1fr));gap:16px;margin-top:20px;padding-bottom:30px}
.card{position:relative;border:none;background:var(--surface);border-radius:22px;padding:10px 10px 12px;text-align:left;box-shadow:0 5px 0 var(--line);display:flex;flex-direction:column;gap:6px}
.card:active{transform:translateY(4px);box-shadow:0 1px 0 var(--line)}
.card .thumb{background:var(--paper);border-radius:14px;aspect-ratio:1;overflow:hidden;box-shadow:inset 0 0 0 2px #e6eef5}
.card .thumb svg{width:100%;height:100%;display:block;pointer-events:none}
.card b{font-size:17px;line-height:1.1;font-weight:700}
.card .n{position:absolute;top:2px;left:2px;background:var(--navy);color:#fff;border-radius:12px;font-weight:800;font-size:15px;min-width:30px;height:30px;display:grid;place-items:center;border:3px solid var(--surface)}
.card .done{position:absolute;top:0;right:0;font-size:28px;filter:drop-shadow(0 2px 0 rgba(0,0,0,.15))}

/* color view */
#view{display:none}
body.coloring #home{display:none}
body.coloring #view{display:block}
.vtop{display:flex;align-items:center;gap:10px;flex-wrap:wrap}
.vtop h2{margin:0;font-size:clamp(22px,4vw,32px);flex:1;min-width:150px;line-height:1.05;font-weight:800}
.stage{display:grid;grid-template-columns:minmax(0,1fr) 300px;gap:18px;margin-top:14px;align-items:start}
.paper{background:var(--paper);border-radius:28px;padding:10px;box-shadow:0 6px 0 var(--line);position:relative}
.paper svg{width:100%;height:auto;display:block;touch-action:manipulation}
.side{display:flex;flex-direction:column;gap:14px}
.say{background:var(--surface);border-radius:22px;padding:14px 16px;display:grid;grid-template-columns:62px 1fr;gap:10px;align-items:center;box-shadow:0 5px 0 var(--line)}
.say svg{width:62px;height:62px}
.say p{margin:0;font-size:19px;line-height:1.2;font-weight:600}
.palette{background:var(--surface);border-radius:22px;padding:14px;box-shadow:0 5px 0 var(--line)}
.sw{display:grid;grid-template-columns:repeat(6,1fr);gap:10px}
.sw button{aspect-ratio:1;border-radius:50%;border:4px solid #fff;box-shadow:0 0 0 2px var(--line),0 3px 0 2px var(--line);padding:0;transition:transform .12s}
.sw button[aria-pressed="true"]{transform:scale(1.18);box-shadow:0 0 0 4px var(--navy),0 3px 0 4px var(--navy)}
:root[data-theme="dark"] .sw button[aria-pressed="true"]{box-shadow:0 0 0 4px var(--yellow)}
@media (prefers-color-scheme: dark){:root:not([data-theme="light"]) .sw button[aria-pressed="true"]{box-shadow:0 0 0 4px var(--yellow)}}
.tools{display:grid;grid-template-columns:repeat(3,1fr);gap:10px;margin-top:14px}
.tool{border:none;border-radius:16px;background:var(--chip);padding:8px 4px;font-weight:700;font-size:15px;display:flex;flex-direction:column;align-items:center;gap:2px;box-shadow:0 3px 0 var(--line)}
.tool span{font-size:26px;line-height:1}
.tool[aria-pressed="true"]{background:var(--yellow);color:#283A61}
.tool:active{transform:translateY(2px)}
.nav{display:flex;gap:10px}
.nav .iconbtn{flex:1}

/* celebration */
.party{position:fixed;inset:0;display:none;place-items:center;background:rgba(23,35,64,.45);z-index:20;padding:20px}
.party.show{display:grid}
.party .box{background:var(--surface);border-radius:30px;padding:22px 26px;text-align:center;max-width:360px;box-shadow:0 8px 0 var(--line);animation:pop .45s cubic-bezier(.2,1.6,.4,1)}
.party h3{font-size:40px;margin:0;font-weight:800;line-height:1}
.party p{font-size:19px;margin:6px 0 16px;color:var(--muted)}
.party svg{width:130px;height:130px}
.big{border:none;border-radius:18px;background:var(--blue);color:#fff;font-weight:800;font-size:20px;padding:12px 20px;box-shadow:0 5px 0 #2a86b3;width:100%}
.big.alt{background:var(--chip);color:var(--text);box-shadow:0 5px 0 var(--line);margin-top:10px}
@keyframes pop{from{transform:scale(.6);opacity:0}to{transform:scale(1);opacity:1}}
canvas#conf{position:fixed;inset:0;pointer-events:none;z-index:30;width:100%;height:100%}

/* svg drawing styles */
.r{fill:#fff;stroke:#2b2b3a;stroke-width:3;stroke-linejoin:round;cursor:pointer;vector-effect:non-scaling-stroke;transition:fill .15s}
.k{fill:none;stroke:#2b2b3a;stroke-width:3;stroke-linecap:round;stroke-linejoin:round;pointer-events:none;vector-effect:non-scaling-stroke}
.d{fill:#2b2b3a;pointer-events:none}
.w{fill:#fff;pointer-events:none}
.txt{font-family:"Baloo 2",sans-serif;font-weight:800;fill:#2b2b3a;pointer-events:none}
.thumb .r,.thumb .k{stroke-width:2}
.hint .r{animation:blink 1s ease-in-out 2}
@keyframes blink{50%{fill:#fff3c4}}

@media (max-width:820px){
  .stage{grid-template-columns:1fr}
  .side{flex-direction:column-reverse}
  .sw{grid-template-columns:repeat(9,1fr);gap:7px}
  .hero{grid-template-columns:1fr;text-align:center;justify-items:center}
  .hero p{margin:0 auto}
  .progress{justify-content:center}
}
@media (max-width:480px){
  .sw{grid-template-columns:repeat(6,1fr)}
  .grid{grid-template-columns:repeat(2,1fr);gap:12px}
  .hero svg{width:120px;height:120px}
}
@media (prefers-reduced-motion:reduce){*{animation:none!important;transition:none!important}}
</style>
</head>
<body>

<div class="wrap" id="home">
  <header class="top">
    <div class="logo"><img src="data:image/png;base64,/9j/4AAQSkZJRgABAgAAAQABAAD/wAARCAEYAtgDACIAAREBAhEB/9sAQwAIBgYHBgUIBwcHCQkICgwUDQwLCwwZEhMPFB0aHx4dGhwcICQuJyAiLCMcHCg3KSwwMTQ0NB8nOT04MjwuMzQy/9sAQwEJCQkMCwwYDQ0YMiEcITIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIy/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMAAAERAhEAPwD3+iiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoorO1DXdO0vi5uVEn/ADzX5m/IdPxppNuyFKSirydkaNFcXdeP0BItLFmH96V8foP8az28eamT8sFoo/3WP/s1dCwddq/Kcksww0XZy/M9Eorz6Lx9fg/vbS2Yf7O5f6mtaz8d2ExC3UEtuT/EPnUflz+lEsJWiruIRx+Gk7KX6fmdXRUFreW17EJbWdJU9UOcfX0qeuZq2jOtNNXQUUUUDCiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigApk00dvC8srqkaDLMxwAKcSFUkkADkk9q808T+IX1a5NvAxFnGflx/y0P94/0rahQlWlyo58TiYYeHNL5It654znumaDTS0MHQy9Hf6eg/WuUJLEkkknkk0lFe9SoQpK0UfMV8TUryvN/5BRRRWpgFFFFAE9pe3NjOJrWZ4pB3U9fr613/AIf8Wxaky2t5tiujwrDhZP8AA+1ec0A4OR1rnr4eFZa79zqw2LqYd+7t2PbaK5bwl4iOoR/Ybt83MY+Rz/y0Uf1FdTXhVaUqUuWR9PRrQrQU4bBRRRWZqFFFFABRRRQAUUUUAFFFFABRRWZquq/YNscahpWGeegFZ1asKUHObskVCEpy5Y7mnRXKf29ff3k/75o/t6+/vJ/3zXmf23hO7+46vqNY6uiuU/t6+/vJ/wB80f29ff3k/wC+aP7bwnd/cH1GsdXRXKf29ff3k/75o/t6+/vJ/wB80f23hO7+4PqNY6uiuU/t6+/vJ/3zV/Tdcee4WC5VcucK6jHPvV084wtSSina/dEywdWKvY3KKKK9Q5QooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAOW8basbSwWxibEtwDvx1Cf/AF+n5153Wt4kvTfa/dSZyiN5afReP8T+NZNe/g6Sp0l3ep8tmFd1a7XRaBRRRXUcQUUUUAFFFFABRRRQBLbXEtpcx3ELbZI2DKfevXtNvo9S06C7j6SLkj0PcfnXjld14BvS0N1YsfuE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E+mOtfTHw+8PT+GvCFrY3eBdMWmmUHO1m7fgMD6104VQxYAZPU4pa0qVudWsTGFnczfEGl/234e1DTA4RrmBo1Y9AxHBP44r5W1PSb/Rr6Sy1C1kt50OCrjGfcHuPcV9d0hVWxkA45GR0pU6vIEocx5D8GfC19Yz3Wu3sDwRyw+RbrIMFwWDFsenyjHrzXr9FFTObm7jjHlVipqemWesadNYX8CzW0owyN/MehHrXg3i34T6vokslxpSSajp/UbBmWMejKOv1H5CvoSinCo4bBKKkfHLo0blHUqynBUjBBpK+uL/AEPSdUOb/TLO6PrNCrn8yKoR+CfC8Um9NA07d1+aBSPyNdCxEeqM/ZM+atE8Oav4iuRBpdjLcHOGcDCJ/vMeBXqh+Da2vgy8QSLc686h0YHCLg5KLn1GRk+3QZr1yGGK3iWKGNI414VEUAD6AU+s5V29ilTS3Pj+ezurW7a1nt5YrhW2mJ0IYH0x1r3z4ReGL3QNCurvUImgnv3VhC4wyooOMjsTuPH0r0MqpYMQMjocUtKdfmjawRp2dynqml2Ws6dNYahAs9tKMMjfzB7EeteF+KfhDrGlSyT6OrajZckKuPOQehX+L6j8hX0BRUQqShsVKKkfHtxbT2kzQ3MMkMq9UkUqw/A1FX1/d2Nnfx+XeWsFwn92aMOPyNZD+B/C0jbm0DTwf9mBVH5Ct1iF1Rm6TPlhVZ2CqCzE4AAyTXfeEvhVrGuzRz6lHJp2n5BZpBiWQeiqen1P617xYaFpGlnNhplnat/ehgVT+YGa0KUsR/Khqn3KmmabaaPp0NhYwrDbQrtRF/mfUnrmrdFFcrdzUKKKKACiiigAooooAKKKKACiiigAooooAKhubS2vYDBdW8U8TdUlQMp/A1NRQBwusfCTwtqm54LeXT5Tzutnwuf905GPpit/wn4f/wCEX8OwaSLn7QIWciTZtyGYt0yfWtuiqc5NWbEopO6CiiipGFFFFABRRRQAVleJNH/4SDw9eaUJ/I+0oE8zbu28g9MjPStWihOwHAaP8H/DOm7Xu0m1GUc5nfamfZVx+ua7ezsLPToBBZWsNtEOiQxhB+QqxRVSnKW7EopbBRRRUjCiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAP/2Q==" alt="Tecnofamilias"></div>
    <button class="iconbtn" id="soundBtn" aria-label="Sonido">🔊</button>
  </header>
  <section class="hero">
    <svg viewBox="-90 -125 180 210" aria-hidden="true" id="heroTec"></svg>
    <div>
      <h1><span style="color:var(--blue)">Colorea</span> <span>con</span> <span style="color:var(--red)">Tecnito</span></h1>
      <p>Elige un dibujo, toca un color y luego toca el dibujo para pintarlo.</p>
      <div class="progress"><div class="bar"><i id="barFill"></i></div><span id="progTxt">0 de 20</span></div>
    </div>
  </section>
  <div class="grid" id="grid"></div>
</div>

<div class="wrap" id="view">
  <div class="vtop">
    <button class="iconbtn" id="backBtn" aria-label="Volver a los dibujos">🏠</button>
    <h2 id="vTitle"></h2>
    <div class="nav">
      <button class="iconbtn" id="prevBtn" aria-label="Dibujo anterior">◀</button>
      <button class="iconbtn" id="nextBtn" aria-label="Dibujo siguiente">▶</button>
    </div>
  </div>
  <div class="stage">
    <div class="paper"><svg id="art" viewBox="0 0 400 400" role="img"></svg></div>
    <div class="side">
      <div class="say"><svg viewBox="-90 -125 180 210" aria-hidden="true" id="sayTec"></svg><p id="vMsg"></p></div>
      <div class="palette">
        <div class="sw" id="swatches"></div>
        <div class="tools">
          <button class="tool" id="eraseBtn" aria-pressed="false"><span>🧽</span>Borrar</button>
          <button class="tool" id="undoBtn"><span>↩️</span>Deshacer</button>
          <button class="tool" id="resetBtn"><span>✨</span>Empezar</button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="party" id="party">
  <div class="box">
    <svg viewBox="-90 -135 180 220" aria-hidden="true" id="partyTec"></svg>
    <h3>¡Muy bien!</h3>
    <p id="partyMsg">Terminaste tu dibujo.</p>
    <button class="big" id="partyNext">Siguiente dibujo</button>
    <button class="big alt" id="partyStay">Seguir pintando</button>
  </div>
</div>
<canvas id="conf"></canvas>

<script>
/* ---------- helpers de dibujo ---------- */
const F=(t,a)=>`<${t} class="r" ${a}/>`;
const K=(d,w)=>`<path class="k" d="${d}"${w?` style="stroke-width:${w}"`:''}/>`;
const rect=(x,y,w,h,rx=0)=>F('rect',`x="${x}" y="${y}" width="${w}" height="${h}" rx="${rx}"`);
const circ=(cx,cy,r)=>F('circle',`cx="${cx}" cy="${cy}" r="${r}"`);
const ell=(cx,cy,rx,ry)=>F('ellipse',`cx="${cx}" cy="${cy}" rx="${rx}" ry="${ry}"`);
const P=(d,extra='')=>F('path',`d="${d}" ${extra}`);
const T=(x,y,s,txt)=>`<text class="txt" x="${x}" y="${y}" font-size="${s}" text-anchor="middle">${txt}</text>`;
const G=(x,y,s,inner)=>`<g transform="translate(${x} ${y}) scale(${s})">${inner}</g>`;

function star(cx,cy,r){let p=[];for(let i=0;i<10;i++){const a=-Math.PI/2+i*Math.PI/5,rr=i%2?r*.45:r;p.push((cx+rr*Math.cos(a)).toFixed(1)+','+(cy+rr*Math.sin(a)).toFixed(1))}return P('M'+p.join('L')+'Z')}
const heart=(x,y,s)=>G(x,y,s,P('M0,14 C-30,-4 -16,-28 0,-12 C16,-28 30,-4 0,14 Z'));
const cloud=(x,y,s)=>G(x,y,s,P('M-42,16 Q-58,14 -54,-2 Q-52,-16 -34,-14 Q-32,-34 -10,-32 Q4,-46 22,-32 Q42,-34 44,-14 Q60,-12 58,4 Q56,16 42,16 Z'));
function sun(cx,cy,r){let s='';for(let i=0;i<8;i++){const a=i*Math.PI/4,x1=cx+(r+8)*Math.cos(a),y1=cy+(r+8)*Math.sin(a),x2=cx+(r+22)*Math.cos(a),y2=cy+(r+22)*Math.sin(a);s+=K(`M${x1.toFixed(1)},${y1.toFixed(1)} L${x2.toFixed(1)},${y2.toFixed(1)}`,4)}return s+circ(cx,cy,r)+K(`M${cx-9},${cy-4} l0,2 M${cx+9},${cy-4} l0,2`,4)+K(`M${cx-9},${cy+7} Q${cx},${cy+15} ${cx+9},${cy+7}`)}
function flower(x,y,s=1,stem=30){let p='';for(let i=0;i<5;i++){const a=-Math.PI/2+i*2*Math.PI/5;p+=circ((Math.cos(a)*11).toFixed(1),(Math.sin(a)*11).toFixed(1),9)}return K(`M${x},${y} L${x},${y+stem*s}`)+G(x,y+stem*s*.55,s,P('M0,0 Q14,-12 22,-4 Q12,6 0,0Z'))+G(x,y,s,p+circ(0,0,7))}
const ground=y=>P(`M0,${y} Q100,${y-18} 200,${y} T400,${y} L400,400 L0,400Z`);
const grass=(x,y)=>K(`M${x},${y} l-4,-10 M${x+6},${y} l0,-13 M${x+12},${y} l4,-10`);
function tablet(x,y,w,h){return rect(x,y,w,h,14)+rect(x+10,y+12,w-20,h-34,4)+circ(x+w/2,y+h-11,5)}
function rainbow(cx,cy,r,n,bw){let s='';for(let i=0;i<n;i++){const R=r-i*bw,r2=R-bw;s+=P(`M${cx-R},${cy} A${R},${R} 0 0 1 ${cx+R},${cy} L${cx+r2},${cy} A${r2},${r2} 0 0 0 ${cx-r2},${cy}Z`)}return s}
const tree=(x,y)=>rect(x-11,y-70,22,70,4)+G(x,y-95,1,P('M-46,20 Q-62,0 -44,-16 Q-48,-44 -18,-46 Q0,-66 22,-48 Q50,-50 46,-20 Q64,-2 46,20 Q30,34 0,28 Q-28,36 -46,20Z'))+circ(x-18,y-100,6)+circ(x+16,y-82,6)+circ(x+10,y-118,6);
const note=(x,y)=>K(`M${x+8},${y} L${x+8},${y-34} L${x+26},${y-40} L${x+26},${y-8}`)+ell(x,y,10,8)+ell(x+18,y-6,10,8);
const bird=(x,y)=>K(`M${x-12},${y} Q${x-6},${y-8} ${x},${y} Q${x+6},${y-8} ${x+12},${y}`);
const drop=(x,y,s=1)=>G(x,y,s,P('M0,-16 Q12,0 10,6 Q8,16 0,16 Q-8,16 -10,6 Q-12,0 0,-16Z'));

/* ---------- Tecnito ---------- */
function tec(x,y,s=1,o={}){
  let L=o.L||[-68,8], R=o.R||[68,8];
  if(o.wave) R=[64,-70];
  if(o.up){L=[-58,-104];R=[58,-104]}
  let g='';
  if(o.cape) g+=P('M-40,8 Q-80,70 -66,96 L66,96 Q80,70 40,8 Z');
  if(!o.headOnly){
    g+=P('M-50,78 L-50,36 Q-50,0 0,0 Q50,0 50,36 L50,78 L24,70 L24,40 Q24,24 0,24 Q-24,24 -24,40 L-24,70 Z');
  }
  g+=K('M0,-78 L0,-94')+circ(0,-101,8);
  g+=circ(0,-40,38);
  if(o.sleep){g+=K('M-21,-44 Q-13,-37 -5,-44')+K('M5,-44 Q13,-37 21,-44')}
  else{g+=`<ellipse class="d" cx="-13" cy="-45" rx="5.5" ry="7.5"/><ellipse class="d" cx="13" cy="-45" rx="5.5" ry="7.5"/><circle class="w" cx="-11" cy="-48" r="2.2"/><circle class="w" cx="15" cy="-48" r="2.2"/>`}
  g+=o.wow?K('M-7,-24 Q0,-16 7,-24 Q0,-28 -7,-24'):K('M-12,-27 Q0,-15 12,-27');
  g+=circ(-26,-31,6)+circ(26,-31,6);
  if(o.shield) g+=P('M0,30 L22,36 Q22,62 0,74 Q-22,62 -22,36 Z')+star(0,52,9);
  if(!o.headOnly){
    if(o.wave) g+=K('M84,-86 q6,-4 4,-12 M86,-62 q8,0 10,-6');
    g+=circ(L[0],L[1],15)+circ(R[0],R[1],15);
  }
  return G(x,y,s,g);
}

/* ---------- 20 plantillas ---------- */
const TPL=[
 {t:'¡Hola, soy Tecnito!', m:'¡Hola! Soy Tecnito y te acompaño a usar la tecnología de forma segura.',
  d:()=>sun(70,70,30)+cloud(300,70,1)+cloud(200,40,.6)+ground(330)+grass(40,345)+grass(330,350)+tec(200,220,1.15,{wave:1})+star(60,190,16)+star(345,180,12)+flower(80,290,1,40)+flower(320,290,.9,40)},
 {t:'Un ratito de pantalla', m:'Uso la pantalla solo un ratito y con un adulto cerca. ¡El reloj me ayuda!',
  d:()=>ground(345)+circ(320,85,50)+circ(320,85,40)+K('M320,85 L320,58 M320,85 L340,95')+`<circle class="d" cx="320" cy="85" r="4"/>`+K('M320,48 l0,6 M357,85 l-6,0 M320,122 l0,-6 M283,85 l6,0')+rect(300,30,40,10,4)+tec(140,245,.95,{R:[214,240]})+tablet(206,175,110,150)+star(70,90,14)},
 {t:'Pido permiso', m:'Antes de usar la tablet o el celular, le pido permiso a mi familia.',
  d:()=>P('M230,40 L370,40 Q385,40 385,55 L385,130 Q385,145 370,145 L280,145 L250,175 L258,145 L230,145 Q215,145 215,130 L215,55 Q215,40 230,40Z')+T(300,122,80,'?')+rect(250,280,140,18,6)+rect(262,298,14,70)+rect(364,298,14,70)+tablet(282,215,80,65)+tec(120,240,1,{wave:1})+ground(368)},
 {t:'Mi contraseña es secreta', m:'Mis contraseñas son secretas: solo las conoce mi familia.',
  d:()=>P('M240,170 L240,120 Q240,70 290,70 Q340,70 340,120 L340,170 L318,170 L318,122 Q318,94 290,94 Q262,94 262,122 L262,170Z')+rect(220,165,140,125,22)+circ(290,215,15)+P('M282,222 L298,222 L302,260 L278,260Z')+rect(40,320,320,46,22)+circ(85,343,9)+circ(130,343,9)+circ(175,343,9)+circ(220,343,9)+circ(265,343,9)+circ(310,343,9)+tec(110,190,.9,{R:[16,-70]})+star(370,60,12)},
 {t:'Descanso mis ojos', m:'Cada ratito dejo la pantalla, miro lejos y descanso mis ojos.',
  d:()=>sun(330,70,28)+bird(110,60)+bird(150,80)+ground(320)+tree(330,330)+tec(170,225,1,{sleep:1})+flower(60,300,1,30)+flower(250,310,.8,28)+grass(100,360)+grass(270,375)},
 {t:'¡A jugar afuera!', m:'Correr, saltar y jugar afuera también es súper divertido.',
  d:()=>cloud(90,60,.8)+P('M300,30 L345,80 L300,140 L255,80Z')+K('M300,30 L300,140 M255,80 L345,80')+K('M300,140 Q290,170 305,195 Q320,220 300,250')+P('M292,170 l14,-6 l-2,14Z')+P('M298,215 l14,-6 l-2,14Z')+ground(330)+tec(150,230,1,{R:[218,180]})+circ(300,320,34)+P('M270,305 Q300,330 330,305')+K('M300,286 L300,354')+grass(40,350)+grass(360,360)},
 {t:'Hora de dormir', m:'En la noche las pantallas también descansan. ¡Yo duermo feliz!',
  d:()=>P('M80,40 A44,44 0 1 0 128,110 A36,36 0 1 1 80,40Z')+star(190,50,12)+star(250,90,9)+star(160,110,8)+rect(40,190,20,170,6)+rect(60,250,260,40,10)+tec(130,236,.85,{sleep:1,headOnly:1})+P('M150,232 L320,232 Q330,232 330,250 L330,290 L150,290 Z')+rect(60,290,260,20)+rect(60,310,14,50)+rect(306,310,14,50)+rect(330,280,60,80,6)+rect(345,250,30,30,6)+T(195,190,36,'z')+T(222,165,28,'z')+T(244,145,20,'z')},
 {t:'Comer sin pantallas', m:'A la hora de comer guardo las pantallas y converso con mi familia.',
  d:()=>tec(200,200,1)+rect(40,260,320,24,8)+rect(60,284,16,90)+rect(324,284,16,90)+ell(200,248,70,14)+ell(200,246,48,8)+circ(110,236,16)+K('M110,220 q2,-8 8,-10')+P('M120,212 q10,-6 14,2 q-8,6 -14,-2Z')+P('M270,250 L300,214 Q306,214 304,222 Z')+rect(310,212,30,46,6)+P('M340,222 q14,0 14,12 q0,12 -14,12')},
 {t:'Le cuento a un adulto', m:'Si algo en internet me asusta o incomoda, se lo cuento a un adulto de confianza.',
  d:()=>ground(350)+tec(260,215,1.3,{L:[-60,-10]})+tec(115,265,.8,{R:[70,-20]})+heart(185,85,2.2)+P('M40,50 L130,50 Q142,50 142,62 L142,100 Q142,112 130,112 L80,112 L62,132 L66,112 L40,112 Q28,112 28,100 L28,62 Q28,50 40,50Z')+T(85,96,34,'¡Ayuda!')},
 {t:'No hablo con extraños', m:'Si un desconocido me escribe, no respondo y aviso a mi familia.',
  d:()=>tablet(220,70,150,210)+circ(295,140,36)+T(295,158,48,'?')+rect(248,195,94,20,10)+rect(248,222,70,20,10)+tec(110,230,1,{R:[118,40]})+P('M178,190 L232,204 Q232,262 178,290 Q124,262 124,204 Z')+P('M158,242 l14,14 l26,-30',' style="fill:none"')+ground(360)},
 {t:'Soy amable en línea', m:'En internet digo cosas bonitas, igual que en la vida real.',
  d:()=>tec(200,230,1.05,{wave:1})+heart(70,90,2)+heart(330,110,1.5)+heart(110,200,1.1)+P('M250,30 L360,30 Q372,30 372,42 L372,72 Q372,84 360,84 L280,84 L262,100 L266,84 L250,84 Q238,84 238,72 L238,42 Q238,30 250,30Z')+T(305,68,28,'¡Gracias!')+star(60,300,14)+star(340,300,14)+ground(360)},
 {t:'La pantalla, a buena distancia', m:'Pongo la pantalla lejos de mis ojos: ¡a la distancia de mi brazo!',
  d:()=>rect(200,250,190,18,6)+rect(214,268,14,100)+rect(362,268,14,100)+tablet(270,140,100,110)+P('M300,250 L340,250 L330,238 L310,238Z')+tec(100,240,1)+K('M150,140 L250,140',3)+K('M150,140 l12,-8 M150,140 l12,8 M250,140 l-12,-8 M250,140 l-12,8')+T(200,122,24,'¡Lejitos!')+ground(368)},
 {t:'Me siento derechito', m:'Me siento derechito, con la espalda recta y los pies en el piso.',
  d:()=>rect(40,110,20,230,6)+tec(120,215,.95)+rect(40,290,160,20,6)+rect(48,310,14,60)+rect(178,310,14,60)+rect(230,250,160,18,6)+rect(244,268,14,102)+rect(362,268,14,102)+P('M260,250 L350,250 L340,180 L270,180Z')+rect(276,188,58,52,4)+ground(370)},
 {t:'Leo un cuento', m:'Los libros también me llevan a mundos increíbles.',
  d:()=>tec(200,170,1,{L:[-60,110],R:[60,110]})+P('M200,236 Q140,214 70,226 L70,350 Q140,338 200,360Z')+P('M200,236 Q260,214 330,226 L330,350 Q260,338 200,360Z')+K('M95,262 Q140,254 180,266 M95,290 Q140,282 180,294 M220,266 Q260,254 305,262 M220,294 Q260,282 305,290')+star(60,70,16)+star(340,70,16)+star(110,130,9)+P('M300,140 Q320,110 340,140 Q320,150 300,140Z')},
 {t:'Familia conectada', m:'En familia aprendemos juntos a usar la tecnología.',
  d:()=>P('M60,150 L200,50 L340,150Z')+rect(80,150,240,180)+rect(180,240,44,90,6)+rect(104,180,50,46,4)+rect(246,180,50,46,4)+K('M129,180 L129,226 M104,203 L154,203 M271,180 L271,226 M246,203 L296,203')+tec(70,300,.62)+tec(330,290,.72)+tec(200,320,.45,{wave:1})+ground(372)},
 {t:'Súper Tecnito', m:'¡Con buenos hábitos digitales soy un superhéroe!',
  d:()=>rect(20,200,60,170)+rect(300,180,80,190)+rect(90,250,40,120)+rect(34,220,14,14)+rect(54,220,14,14)+rect(34,250,14,14)+rect(54,250,14,14)+rect(316,200,18,18)+rect(346,200,18,18)+rect(316,232,18,18)+rect(346,232,18,18)+tec(200,200,1.15,{cape:1,shield:1,up:1})+star(70,80,15)+star(330,70,18)+star(110,150,9)+ground(370)},
 {t:'Tomo agua', m:'Cuando juego hago pausas para tomar agua y comer algo rico.',
  d:()=>sun(70,70,26)+tec(150,230,1,{R:[218,222]})+P('M230,150 L320,150 L308,330 L242,330Z')+P('M235,200 L315,200 L308,330 L242,330Z')+drop(340,110,1)+drop(370,160,.7)+circ(350,320,22)+P('M350,298 q4,-12 14,-14')+ground(352)},
 {t:'¡A estirarse!', m:'Después de un ratito de pantalla, me estiro y me muevo.',
  d:()=>sun(340,60,26)+tec(200,250,1.05,{up:1,wow:1})+note(70,120)+note(300,190)+star(80,230,13)+star(330,280,11)+K('M120,105 q-12,-14 0,-28 M280,105 q12,-14 0,-28')+ground(350)+grass(60,370)+grass(320,372)},
 {t:'Creo con mis manos', m:'Desconectarme un rato me ayuda a crear cosas con mis manos.',
  d:()=>rainbow(200,170,150,4,16)+K('M260,160 L240,360 M330,160 L350,360 M295,170 L295,360',6)+rect(240,140,110,120,4)+circ(270,180,12)+P('M260,240 L290,205 L315,240Z')+tec(110,250,1,{R:[180,230]})+P('M150,350 Q170,310 220,320 Q250,330 230,355 Q210,375 170,372 Q140,370 150,350Z')+circ(175,340,7)+circ(200,334,7)+circ(222,344,7)},
 {t:'¡Misión cumplida!', m:'¡Lo lograste! Ya sabes cuidarte en el mundo digital.',
  d:()=>rainbow(200,250,190,3,18)+tec(200,240,1.05,{up:1,wow:1})+circ(200,288,18)+star(200,288,11)+star(50,60,16)+star(350,60,16)+star(80,170,10)+star(320,170,10)+P('M30,330 L370,330 L350,355 L370,380 L30,380 L50,355Z')+T(200,366,26,'¡Experto digital!')}
];

/* ---------- estado ---------- */
const KEY='tecnito-colorea-v1';
let S={fills:{},done:{},sound:true};
try{const raw=localStorage.getItem(KEY);if(raw)S=Object.assign(S,JSON.parse(raw))}catch(e){}
const save=()=>{try{localStorage.setItem(KEY,JSON.stringify(S))}catch(e){}};

const COLORS=['#3EAEE3','#283A61','#FDBE2F','#EF4A36','#FF8FC7','#A77BEB','#D7C2FF','#6FD8B5','#4CB963','#2E8B57','#A9E2FF','#FF9A3C','#FFE07A','#FFD3B0','#E8B48A','#A0663C','#B8BEC9','#3a3a48'];
let color=COLORS[0], erasing=false, cur=0, undo=[];

/* ---------- sonido ---------- */
let ac=null;
function blip(f=520,len=.09){
  if(!S.sound) return;
  try{ac=ac||new (window.AudioContext||window.webkitAudioContext)();
    const o=ac.createOscillator(),g=ac.createGain();o.type='sine';o.frequency.setValueAtTime(f,ac.currentTime);
    o.frequency.exponentialRampToValueAtTime(f*1.8,ac.currentTime+len);g.gain.setValueAtTime(.15,ac.currentTime);
    g.gain.exponentialRampToValueAtTime(.001,ac.currentTime+len+.05);o.connect(g).connect(ac.destination);o.start();o.stop(ac.currentTime+len+.06)}catch(e){}
}
function tune(){[523,659,784,1046].forEach((f,i)=>setTimeout(()=>blip(f,.12),i*120))}

/* ---------- render ---------- */
function paint(svgEl,idx){
  const fills=S.fills[idx]||[];
  svgEl.querySelectorAll('.r').forEach((el,i)=>{if(fills[i])el.style.fill=fills[i]});
}
function buildGrid(){
  const g=document.getElementById('grid');g.innerHTML='';
  TPL.forEach((t,i)=>{
    const b=document.createElement('button');b.className='card';b.setAttribute('aria-label',`Dibujo ${i+1}: ${t.t}`);
    b.innerHTML=`<span class="n">${i+1}</span>${S.done[i]?'<span class="done">⭐</span>':''}<div class="thumb"><svg viewBox="0 0 400 400">${t.d()}</svg></div><b>${t.t}</b>`;
    paint(b.querySelector('svg'),i);
    b.onclick=()=>{blip(440);open(i)};
    g.appendChild(b);
  });
  const n=Object.keys(S.done).filter(k=>S.done[k]).length;
  document.getElementById('barFill').style.width=(n/TPL.length*100)+'%';
  document.getElementById('progTxt').textContent=`${n} de ${TPL.length} ⭐`;
}
function open(i){
  cur=i;undo=[];
  const t=TPL[i],art=document.getElementById('art');
  art.innerHTML=t.d();art.setAttribute('aria-label',t.t);
  paint(art,i);
  document.getElementById('vTitle').textContent=`${i+1}. ${t.t}`;
  document.getElementById('vMsg').textContent=t.m;
  document.body.classList.add('coloring');
  window.scrollTo(0,0);
  if(!(S.fills[i]||[]).some(Boolean)){art.classList.add('hint');setTimeout(()=>art.classList.remove('hint'),2100)}
}
function home(){document.body.classList.remove('coloring');buildGrid();window.scrollTo(0,0)}

document.getElementById('art').addEventListener('click',e=>{
  const el=e.target.closest('.r');if(!el)return;document.getElementById('art').classList.remove('hint');
  const art=document.getElementById('art'),all=[...art.querySelectorAll('.r')],i=all.indexOf(el);
  const arr=S.fills[cur]||(S.fills[cur]=[]);
  const nv=erasing?null:color;
  if((arr[i]||null)===nv)return;
  undo.push([i,arr[i]||null]);
  arr[i]=nv;el.style.fill=nv||'#fff';
  blip(erasing?300:380+Math.random()*300);
  save();checkDone(all.length);
});
function checkDone(total){
  const arr=S.fills[cur]||[];let c=0;for(let i=0;i<total;i++)if(arr[i])c++;
  if(c===total&&!S.done[cur]){S.done[cur]=true;save();celebrate()}
}

/* paleta */
const sw=document.getElementById('swatches');
COLORS.forEach((c,i)=>{const b=document.createElement('button');b.style.background=c;b.setAttribute('aria-label','Color '+(i+1));b.setAttribute('aria-pressed',i===0);
  b.onclick=()=>{color=c;erasing=false;document.getElementById('eraseBtn').setAttribute('aria-pressed','false');sw.querySelectorAll('button').forEach(x=>x.setAttribute('aria-pressed',x===b));blip(660,.06)};sw.appendChild(b)});
document.getElementById('eraseBtn').onclick=function(){erasing=!erasing;this.setAttribute('aria-pressed',erasing);if(erasing)sw.querySelectorAll('button').forEach(x=>x.setAttribute('aria-pressed','false'));else sw.querySelector(`button`).click()};
document.getElementById('undoBtn').onclick=()=>{const u=undo.pop();if(!u)return;const arr=S.fills[cur];arr[u[0]]=u[1];
  document.getElementById('art').querySelectorAll('.r')[u[0]].style.fill=u[1]||'#fff';save();blip(300)};
document.getElementById('resetBtn').onclick=()=>{if(!confirm('¿Borrar todos los colores de este dibujo?'))return;S.fills[cur]=[];S.done[cur]=false;save();open(cur)};
document.getElementById('backBtn').onclick=home;
document.getElementById('prevBtn').onclick=()=>open((cur+TPL.length-1)%TPL.length);
document.getElementById('nextBtn').onclick=()=>open((cur+1)%TPL.length);
const sb=document.getElementById('soundBtn');
const setSnd=()=>{sb.textContent=S.sound?'🔊':'🔇';sb.setAttribute('aria-label',S.sound?'Silenciar sonido':'Activar sonido')};
sb.onclick=()=>{S.sound=!S.sound;save();setSnd();blip()};setSnd();

/* celebración */
const party=document.getElementById('party');
function celebrate(){
  const allDone=TPL.every((_,i)=>S.done[i]);
  document.getElementById('partyMsg').textContent=allDone?'¡Pintaste los 20 dibujos! Eres un experto digital.':'Ganaste una estrella ⭐ por este dibujo.';
  party.classList.add('show');tune();confetti();
}
document.getElementById('partyNext').onclick=()=>{party.classList.remove('show');open((cur+1)%TPL.length)};
document.getElementById('partyStay').onclick=()=>party.classList.remove('show');
function confetti(){
  if(matchMedia('(prefers-reduced-motion: reduce)').matches)return;
  const cv=document.getElementById('conf'),cx=cv.getContext('2d');cv.width=innerWidth;cv.height=innerHeight;
  const ps=Array.from({length:120},()=>({x:Math.random()*cv.width,y:-20-Math.random()*cv.height*.5,vx:(Math.random()-.5)*3,vy:2+Math.random()*4,r:5+Math.random()*6,c:['#3EAEE3','#FDBE2F','#EF4A36','#6FD8B5','#FF8FC7'][Math.floor(Math.random()*5)],a:Math.random()*6}));
  let f=0;(function step(){cx.clearRect(0,0,cv.width,cv.height);ps.forEach(p=>{p.x+=p.vx;p.y+=p.vy;p.a+=.1;cx.fillStyle=p.c;cx.beginPath();cx.ellipse(p.x,p.y,p.r,p.r*.6,p.a,0,7);cx.fill()});
    if(++f<180)requestAnimationFrame(step);else cx.clearRect(0,0,cv.width,cv.height)})();
}

/* Tecnito a color para la portada */
function colorTec(id,o){const el=document.getElementById(id);el.innerHTML=tec(0,0,1,o);
  const c=['#283A61','#FDBE2F','#3EAEE3','#FF8FC7','#FF8FC7','#FDBE2F','#EF4A36'];
  el.querySelectorAll('.r').forEach((r,i)=>{r.style.fill=c[i]||'#3EAEE3';r.style.cursor='default'})}
colorTec('heroTec',{wave:1});colorTec('sayTec',{});colorTec('partyTec',{up:1,wow:1});
buildGrid();
</script>
</body>
</html>
$tfgame$, true, true, 3, CURRENT_TIMESTAMP)
ON CONFLICT ("slug") DO NOTHING;
