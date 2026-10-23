-- AlterTable
ALTER TABLE "Game" ADD COLUMN     "fullHeight" BOOLEAN NOT NULL DEFAULT false;

-- Segundo juego (se carga una sola vez; luego se administra en /admin/juegos).
INSERT INTO "Game" ("id", "slug", "title", "description", "ageLabel", "emoji", "color", "html", "fullHeight", "published", "order", "updatedAt")
VALUES ('game_aventura_tecnito', 'aventura-tecnito', 'La aventura de Tecnito: ¡Guardianes digitales!', 'Tecnito guía a los más pequeños por 5 islas: la llave secreta, quién me escribe, el semáforo digital, mis tesoros y cuido mi cuerpo. Con voz, estrellas y diploma de Guardián Digital.', '3 a 8 años · con un adulto', '🏝️', '#3DAEE3', $tfgame$<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>La aventura de Tecnito · Tecnofamilias</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fredoka:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
:root{
  --blue:#3DAEE3; --yellow:#FDBE2F; --red:#EF4A36; --navy:#283A60; --green:#36B37E;
  --bg:#EAF6FC; --surface:#FFFFFF; --text:#283A60; --muted:#55658A; --line:#CFE3F0;
  --soft-yellow:#FFF4D6; --soft-red:#FDE4E0; --soft-green:#DDF5EA; --soft-blue:#DDF1FB;
  --lvl:var(--blue);
  color-scheme:light;
  box-sizing:border-box;
  padding-top:env(safe-area-inset-top,0px);
  padding-bottom:env(safe-area-inset-bottom,0px);
}
@media (prefers-color-scheme:dark){
  :root:not([data-theme="light"]){
    --bg:#121a2e; --surface:#1d2945; --text:#F3F7FF; --muted:#B7C3DD; --line:#33426a;
    --soft-yellow:#3a3220; --soft-red:#3b2326; --soft-green:#1f3a31; --soft-blue:#1c3550;
    color-scheme:dark;
  }
}
*,*::before,*::after{box-sizing:inherit}
html,body{margin:0;min-height:100%}
body{
  background:var(--bg); color:var(--text);
  font-family:"Fredoka","Baloo 2","Nunito","Trebuchet MS",system-ui,sans-serif;
  font-size:18px; line-height:1.35; -webkit-tap-highlight-color:transparent;
  overflow-x:hidden;
}
button{font:inherit;color:inherit;cursor:pointer;border:0;background:none}
button:focus-visible,input:focus-visible{outline:4px solid var(--blue);outline-offset:3px}
.app{max-width:960px;margin:0 auto;padding:14px 16px 32px;min-height:100vh}
.screen[hidden]{display:none}

/* barra superior */
.top{display:flex;align-items:center;gap:10px;margin-bottom:14px}
.top .grow{flex:1}
.pill{
  display:inline-flex;align-items:center;gap:6px;padding:10px 16px;border-radius:999px;
  background:var(--surface);border:3px solid var(--line);font-weight:600;font-size:1rem;
}
.pill:active{transform:scale(.96)}
.icon-btn{width:52px;height:52px;border-radius:50%;background:var(--surface);border:3px solid var(--line);font-size:1.5rem;display:grid;place-items:center}
.icon-btn:active{transform:scale(.92)}

/* inicio */
.home{text-align:center;padding-top:4vh}
.home .mascot-big{width:min(210px,46vw);animation:bob 3s ease-in-out infinite}
.home h1{font-size:clamp(2.2rem,7vw,3.6rem);line-height:1.02;margin:14px 0 6px;font-weight:700;letter-spacing:-.5px}
.home h1 span{display:block;color:var(--blue)}
.home p.sub{font-size:1.3rem;color:var(--muted);margin:0 auto 28px;max-width:30ch}
.btn{
  display:inline-flex;align-items:center;justify-content:center;gap:10px;
  padding:18px 34px;border-radius:999px;font-weight:700;font-size:1.5rem;
  background:var(--yellow);color:var(--navy);
  box-shadow:0 6px 0 #d99a10;transition:transform .08s;
}
.btn:active{transform:translateY(5px);box-shadow:0 1px 0 #d99a10}
.btn.blue{background:var(--blue);color:#fff;box-shadow:0 6px 0 #2486b4}
.btn.blue:active{box-shadow:0 1px 0 #2486b4}
.btn.small{font-size:1.15rem;padding:14px 24px}
.home .ages{margin-top:26px;color:var(--muted);font-size:1rem}
.brand{margin:30px auto 0;display:block;width:150px;opacity:.95}
.dots-deco{display:flex;justify-content:center;gap:10px;margin-top:6px}
.dots-deco i{width:14px;height:14px;border-radius:50%;display:block}

/* mapa de islas */
.map-head{display:flex;align-items:center;gap:14px;margin:4px 0 18px}
.map-head img{width:72px;animation:bob 3s ease-in-out infinite}
.bubble{
  position:relative;background:var(--surface);border:3px solid var(--line);border-radius:26px;
  padding:14px 20px;font-size:1.3rem;font-weight:500;flex:1;
}
.bubble::before{
  content:"";position:absolute;left:-14px;top:50%;margin-top:-10px;
  border:10px solid transparent;border-right:14px solid var(--line);border-left:0;
}
.islands{display:grid;grid-template-columns:repeat(auto-fit,minmax(160px,1fr));gap:16px}
.isle{
  position:relative;background:var(--surface);border-radius:32px 32px 32px 32px;
  border:4px solid var(--c);padding:18px 12px 16px;text-align:center;
  box-shadow:0 7px 0 var(--c);transition:transform .1s;
}
.isle:nth-child(odd){transform:rotate(-1.2deg)}
.isle:nth-child(even){transform:rotate(1.2deg) translateY(10px)}
.isle:active{transform:scale(.96)}
.isle .num{position:absolute;top:-14px;left:-10px;width:40px;height:40px;border-radius:50%;background:var(--c);color:var(--navy);font-weight:700;display:grid;place-items:center;font-size:1.2rem}
.isle .em{font-size:3.6rem;display:block;line-height:1.1}
.isle .tt{display:block;font-weight:600;font-size:1.15rem;margin:6px 0 4px}
.isle .st{font-size:1.2rem;letter-spacing:2px}
.off{filter:grayscale(1);opacity:.3}
.cert-cta{text-align:center;margin-top:34px}

/* nivel */
.stage{display:grid;grid-template-columns:auto 1fr;gap:14px;align-items:center;margin-bottom:16px}
.stage img{width:84px}
.scene{
  width:150px;height:150px;margin:0 auto 18px;border-radius:50%;
  display:grid;place-items:center;font-size:5.2rem;
  background:var(--surface);border:6px solid var(--lvl);
}
.scene.pop{animation:pop .45s cubic-bezier(.3,1.6,.6,1)}
.progress{display:flex;gap:8px;align-items:center}
.progress i{width:16px;height:16px;border-radius:50%;background:var(--line);display:block}
.progress i.done{background:var(--green)}
.progress i.now{background:var(--lvl);transform:scale(1.3)}
.opts{display:grid;gap:16px;grid-template-columns:repeat(auto-fit,minmax(210px,1fr))}
.opts.single{grid-template-columns:1fr;justify-items:center}
.opt{
  background:var(--surface);border:4px solid var(--line);border-radius:28px;
  padding:18px 14px;min-height:150px;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:8px;
  box-shadow:0 6px 0 var(--line);transition:transform .08s;
}
.opt:active{transform:translateY(4px);box-shadow:0 2px 0 var(--line)}
.opt .oe{font-size:3.4rem;line-height:1}
.opt .ot{font-weight:600;font-size:1.25rem;text-align:center}
.opt.g{border-color:var(--green);box-shadow:0 6px 0 var(--green);background:var(--soft-green)}
.opt.y{border-color:var(--yellow);box-shadow:0 6px 0 var(--yellow);background:var(--soft-yellow)}
.opt.r{border-color:var(--red);box-shadow:0 6px 0 var(--red);background:var(--soft-red)}
.opt.secret{border-color:var(--navy);box-shadow:0 6px 0 var(--navy);background:var(--soft-blue)}
.opt.share{border-color:var(--yellow);box-shadow:0 6px 0 var(--yellow);background:var(--soft-yellow)}
.opt.right{border-color:var(--green)!important;animation:pop .4s}
.opt.wrong{animation:shake .45s}
.opt.used{opacity:.45}

/* retroalimentación */
.overlay{position:fixed;inset:0;background:rgba(20,30,55,.55);display:grid;place-items:center;padding:20px;z-index:20}
.overlay[hidden]{display:none}
.card{
  background:var(--surface);border-radius:34px;max-width:520px;width:100%;padding:28px 24px 26px;text-align:center;
  border:6px solid var(--blue);animation:pop .4s cubic-bezier(.3,1.6,.6,1);
}
.overlay.good .card{border-color:var(--green)}
.overlay.try .card{border-color:var(--yellow)}
.card .big{font-size:4.6rem;line-height:1}
.card h2{font-size:2.1rem;margin:8px 0 6px}
.card p{font-size:1.3rem;margin:0 0 22px;color:var(--text)}

/* fin de nivel */
.end{text-align:center;padding-top:3vh}
.end .em{font-size:5rem}
.end .stars{font-size:3.2rem;letter-spacing:6px;margin:6px 0 16px}
.rule{
  background:var(--soft-yellow);border:4px dashed var(--yellow);border-radius:28px;
  padding:18px 20px;max-width:560px;margin:0 auto 26px;font-size:1.4rem;font-weight:600;
}
.rule small{display:block;font-size:1rem;font-weight:500;color:var(--muted);margin-bottom:4px}

/* diploma */
.cert{
  background:var(--surface);border-radius:34px;padding:30px 24px;max-width:680px;margin:0 auto;text-align:center;
  border:8px solid var(--yellow);outline:4px solid var(--blue);outline-offset:-20px;
}
.cert img.logo{width:170px}
.cert h2{font-size:clamp(1.8rem,6vw,2.6rem);margin:10px 0 4px}
.cert .name{font-size:2rem;font-weight:700;color:var(--blue);min-height:2.6rem;border-bottom:3px dashed var(--line);max-width:420px;margin:8px auto 14px}
.cert ol{text-align:left;max-width:520px;margin:12px auto;padding-left:1.4rem;font-size:1.1rem}
.cert ol li{margin:6px 0}
.cert .date{color:var(--muted);font-size:.95rem}
.name-in{font:inherit;font-size:1.3rem;padding:12px 18px;border-radius:999px;border:3px solid var(--line);background:var(--surface);color:var(--text);width:min(360px,100%);text-align:center}
.cert-tools{display:flex;flex-wrap:wrap;gap:12px;justify-content:center;margin:18px 0}

/* panel adultos */
.adult{max-width:640px;text-align:left;max-height:86vh;overflow:auto;border-color:var(--navy)}
.adult h2{font-size:1.7rem;text-align:center}
.adult h3{font-size:1.2rem;margin:18px 0 6px;color:var(--blue)}
.adult p,.adult li{font-size:1.05rem;margin:0 0 8px}
.adult ul{padding-left:1.2rem;margin:0}

/* confeti */
.confetti{position:fixed;top:-20px;width:12px;height:18px;border-radius:3px;z-index:30;pointer-events:none;animation:fall linear forwards}

@keyframes bob{0%,100%{transform:translateY(0)}50%{transform:translateY(-8px)}}
@keyframes pop{0%{transform:scale(.6)}100%{transform:scale(1)}}
@keyframes shake{0%,100%{transform:translateX(0)}20%,60%{transform:translateX(-10px)}40%,80%{transform:translateX(10px)}}
@keyframes fall{to{transform:translateY(110vh) rotate(720deg)}}
@media (prefers-reduced-motion:reduce){*{animation:none!important;transition:none!important}}

@media (max-width:520px){
  .opt{min-height:118px;flex-direction:row;justify-content:flex-start;gap:14px;padding:14px 18px}
  .opt .ot{text-align:left}
  .scene{width:120px;height:120px;font-size:4rem}
  .stage img{width:64px}
  .bubble{font-size:1.15rem}
}
@media print{
  body{background:#fff}
  .app > *:not(#s-cert), .cert-tools, .top, .name-row{display:none!important}
  #s-cert{display:block!important}
  .cert{box-shadow:none}
}
</style>
</head>
<body>
<main class="app">

  <!-- INICIO -->
  <section class="screen home" id="s-home">
    <div class="top"><span class="grow"></span><button class="icon-btn" data-sound aria-label="Activar o quitar sonido">🔊</button></div>
    <img class="mascot-big" src="data:image/png;base64,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" alt="Tecnito, la mascota de Tecnofamilias">
    <h1>La aventura de Tecnito<span>¡Guardianes digitales!</span></h1>
    <p class="sub">Aprende a cuidarte en internet jugando con Tecnito.</p>
    <button class="btn" id="playBtn">▶ ¡Jugar!</button>
    <div class="ages">Para niños y niñas de 3 a 8 años · Juega con un adulto</div>
    <div style="margin-top:16px"><button class="pill" data-adults>👨‍👩‍👧 Guía para adultos</button></div>
    <img class="brand" src="data:image/png;base64,/9j/4AAQSkZJRgABAgAAAQABAAD/wAARCAEYAtgDACIAAREBAhEB/9sAQwAIBgYHBgUIBwcHCQkICgwUDQwLCwwZEhMPFB0aHx4dGhwcICQuJyAiLCMcHCg3KSwwMTQ0NB8nOT04MjwuMzQy/9sAQwEJCQkMCwwYDQ0YMiEcITIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIy/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMAAAERAhEAPwD3+iiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoorO1DXdO0vi5uVEn/ADzX5m/IdPxppNuyFKSirydkaNFcXdeP0BItLFmH96V8foP8az28eamT8sFoo/3WP/s1dCwddq/Kcksww0XZy/M9Eorz6Lx9fg/vbS2Yf7O5f6mtaz8d2ExC3UEtuT/EPnUflz+lEsJWiruIRx+Gk7KX6fmdXRUFreW17EJbWdJU9UOcfX0qeuZq2jOtNNXQUUUUDCiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigApk00dvC8srqkaDLMxwAKcSFUkkADkk9q808T+IX1a5NvAxFnGflx/y0P94/0rahQlWlyo58TiYYeHNL5It654znumaDTS0MHQy9Hf6eg/WuUJLEkkknkk0lFe9SoQpK0UfMV8TUryvN/5BRRRWpgFFFFAE9pe3NjOJrWZ4pB3U9fr613/AIf8Wxaky2t5tiujwrDhZP8AA+1ec0A4OR1rnr4eFZa79zqw2LqYd+7t2PbaK5bwl4iOoR/Ybt83MY+Rz/y0Uf1FdTXhVaUqUuWR9PRrQrQU4bBRRRWZqFFFFABRRRQAUUUUAFFFFABRRWZquq/YNscahpWGeegFZ1asKUHObskVCEpy5Y7mnRXKf29ff3k/75o/t6+/vJ/3zXmf23hO7+46vqNY6uiuU/t6+/vJ/wB80f29ff3k/wC+aP7bwnd/cH1GsdXRXKf29ff3k/75o/t6+/vJ/wB80f23hO7+4PqNY6uiuU/t6+/vJ/3zV/Tdcee4WC5VcucK6jHPvV084wtSSina/dEywdWKvY3KKKK9Q5QooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAOW8basbSwWxibEtwDvx1Cf/AF+n5153Wt4kvTfa/dSZyiN5afReP8T+NZNe/g6Sp0l3ep8tmFd1a7XRaBRRRXUcQUUUUAFFFFABRRRQBLbXEtpcx3ELbZI2DKfevXtNvo9S06C7j6SLkj0PcfnXjld14BvS0N1YsfuE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E+mOtfTHw+8PT+GvCFrY3eBdMWmmUHO1m7fgMD6104VQxYAZPU4pa0qVudWsTGFnczfEGl/234e1DTA4RrmBo1Y9AxHBP44r5W1PSb/Rr6Sy1C1kt50OCrjGfcHuPcV9d0hVWxkA45GR0pU6vIEocx5D8GfC19Yz3Wu3sDwRyw+RbrIMFwWDFsenyjHrzXr9FFTObm7jjHlVipqemWesadNYX8CzW0owyN/MehHrXg3i34T6vokslxpSSajp/UbBmWMejKOv1H5CvoSinCo4bBKKkfHLo0blHUqynBUjBBpK+uL/AEPSdUOb/TLO6PrNCrn8yKoR+CfC8Um9NA07d1+aBSPyNdCxEeqM/ZM+atE8Oav4iuRBpdjLcHOGcDCJ/vMeBXqh+Da2vgy8QSLc686h0YHCLg5KLn1GRk+3QZr1yGGK3iWKGNI414VEUAD6AU+s5V29ilTS3Pj+ezurW7a1nt5YrhW2mJ0IYH0x1r3z4ReGL3QNCurvUImgnv3VhC4wyooOMjsTuPH0r0MqpYMQMjocUtKdfmjawRp2dynqml2Ws6dNYahAs9tKMMjfzB7EeteF+KfhDrGlSyT6OrajZckKuPOQehX+L6j8hX0BRUQqShsVKKkfHtxbT2kzQ3MMkMq9UkUqw/A1FX1/d2Nnfx+XeWsFwn92aMOPyNZD+B/C0jbm0DTwf9mBVH5Ct1iF1Rm6TPlhVZ2CqCzE4AAyTXfeEvhVrGuzRz6lHJp2n5BZpBiWQeiqen1P617xYaFpGlnNhplnat/ehgVT+YGa0KUsR/Khqn3KmmabaaPp0NhYwrDbQrtRF/mfUnrmrdFFcrdzUKKKKACiiigAooooAKKKKACiiigAooooAKhubS2vYDBdW8U8TdUlQMp/A1NRQBwusfCTwtqm54LeXT5Tzutnwuf905GPpit/wn4f/wCEX8OwaSLn7QIWciTZtyGYt0yfWtuiqc5NWbEopO6CiiipGFFFFABRRRQAVleJNH/4SDw9eaUJ/I+0oE8zbu28g9MjPStWihOwHAaP8H/DOm7Xu0m1GUc5nfamfZVx+ua7ezsLPToBBZWsNtEOiQxhB+QqxRVSnKW7EopbBRRRUjCiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAP/2Q==" alt="Tecnofamilias">
  </section>

  <!-- MAPA -->
  <section class="screen" id="s-map" hidden>
    <div class="top">
      <button class="pill" id="homeBtn">🏠 Inicio</button>
      <span class="grow"></span>
      <button class="pill" data-adults>👨‍👩‍👧 Adultos</button>
      <button class="icon-btn" data-sound aria-label="Activar o quitar sonido">🔊</button>
    </div>
    <div class="map-head">
      <img src="data:image/png;base64,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" alt="">
      <div class="bubble" id="mapMsg">Elige una isla para jugar</div>
    </div>
    <div class="islands" id="islands"></div>
    <div class="cert-cta" id="certCta" hidden>
      <button class="btn blue" id="certBtn">🏅 ¡Recibir mi diploma!</button>
    </div>
  </section>

  <!-- NIVEL -->
  <section class="screen" id="s-level" hidden>
    <div class="top">
      <button class="pill" id="backMap">◀ Islas</button>
      <span class="grow"></span>
      <div class="progress" id="progress" aria-label="Progreso"></div>
      <span class="grow"></span>
      <button class="icon-btn" id="repeatBtn" aria-label="Escuchar otra vez">🗣️</button>
      <button class="icon-btn" data-sound aria-label="Activar o quitar sonido">🔊</button>
    </div>
    <div class="stage">
      <img src="data:image/png;base64,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" alt="Tecnito">
      <div class="bubble" id="bubble" aria-live="polite"></div>
    </div>
    <div class="scene" id="scene" aria-hidden="true"></div>
    <div class="opts" id="opts"></div>
  </section>

  <!-- FIN DE NIVEL -->
  <section class="screen end" id="s-end" hidden>
    <div class="em" id="endEmoji"></div>
    <h2 style="font-size:2.3rem;margin:4px 0">¡Isla superada!</h2>
    <div class="stars" id="endStars"></div>
    <div class="rule"><small>Regla de oro</small><span id="endRule"></span></div>
    <button class="btn" id="endBtn">🗺️ Volver a las islas</button>
  </section>

  <!-- DIPLOMA -->
  <section class="screen" id="s-cert" hidden>
    <div class="top"><button class="pill" id="certBack">◀ Islas</button><span class="grow"></span></div>
    <div class="cert">
      <img class="logo" src="data:image/png;base64,/9j/4AAQSkZJRgABAgAAAQABAAD/wAARCAEYAtgDACIAAREBAhEB/9sAQwAIBgYHBgUIBwcHCQkICgwUDQwLCwwZEhMPFB0aHx4dGhwcICQuJyAiLCMcHCg3KSwwMTQ0NB8nOT04MjwuMzQy/9sAQwEJCQkMCwwYDQ0YMiEcITIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIy/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMAAAERAhEAPwD3+iiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoorO1DXdO0vi5uVEn/ADzX5m/IdPxppNuyFKSirydkaNFcXdeP0BItLFmH96V8foP8az28eamT8sFoo/3WP/s1dCwddq/Kcksww0XZy/M9Eorz6Lx9fg/vbS2Yf7O5f6mtaz8d2ExC3UEtuT/EPnUflz+lEsJWiruIRx+Gk7KX6fmdXRUFreW17EJbWdJU9UOcfX0qeuZq2jOtNNXQUUUUDCiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigApk00dvC8srqkaDLMxwAKcSFUkkADkk9q808T+IX1a5NvAxFnGflx/y0P94/0rahQlWlyo58TiYYeHNL5It654znumaDTS0MHQy9Hf6eg/WuUJLEkkknkk0lFe9SoQpK0UfMV8TUryvN/5BRRRWpgFFFFAE9pe3NjOJrWZ4pB3U9fr613/AIf8Wxaky2t5tiujwrDhZP8AA+1ec0A4OR1rnr4eFZa79zqw2LqYd+7t2PbaK5bwl4iOoR/Ybt83MY+Rz/y0Uf1FdTXhVaUqUuWR9PRrQrQU4bBRRRWZqFFFFABRRRQAUUUUAFFFFABRRWZquq/YNscahpWGeegFZ1asKUHObskVCEpy5Y7mnRXKf29ff3k/75o/t6+/vJ/3zXmf23hO7+46vqNY6uiuU/t6+/vJ/wB80f29ff3k/wC+aP7bwnd/cH1GsdXRXKf29ff3k/75o/t6+/vJ/wB80f23hO7+4PqNY6uiuU/t6+/vJ/3zV/Tdcee4WC5VcucK6jHPvV084wtSSina/dEywdWKvY3KKKK9Q5QooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAOW8basbSwWxibEtwDvx1Cf/AF+n5153Wt4kvTfa/dSZyiN5afReP8T+NZNe/g6Sp0l3ep8tmFd1a7XRaBRRRXUcQUUUUAFFFFABRRRQBLbXEtpcx3ELbZI2DKfevXtNvo9S06C7j6SLkj0PcfnXjld14BvS0N1YsfuE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E+mOtfTHw+8PT+GvCFrY3eBdMWmmUHO1m7fgMD6104VQxYAZPU4pa0qVudWsTGFnczfEGl/234e1DTA4RrmBo1Y9AxHBP44r5W1PSb/Rr6Sy1C1kt50OCrjGfcHuPcV9d0hVWxkA45GR0pU6vIEocx5D8GfC19Yz3Wu3sDwRyw+RbrIMFwWDFsenyjHrzXr9FFTObm7jjHlVipqemWesadNYX8CzW0owyN/MehHrXg3i34T6vokslxpSSajp/UbBmWMejKOv1H5CvoSinCo4bBKKkfHLo0blHUqynBUjBBpK+uL/AEPSdUOb/TLO6PrNCrn8yKoR+CfC8Um9NA07d1+aBSPyNdCxEeqM/ZM+atE8Oav4iuRBpdjLcHOGcDCJ/vMeBXqh+Da2vgy8QSLc686h0YHCLg5KLn1GRk+3QZr1yGGK3iWKGNI414VEUAD6AU+s5V29ilTS3Pj+ezurW7a1nt5YrhW2mJ0IYH0x1r3z4ReGL3QNCurvUImgnv3VhC4wyooOMjsTuPH0r0MqpYMQMjocUtKdfmjawRp2dynqml2Ws6dNYahAs9tKMMjfzB7EeteF+KfhDrGlSyT6OrajZckKuPOQehX+L6j8hX0BRUQqShsVKKkfHtxbT2kzQ3MMkMq9UkUqw/A1FX1/d2Nnfx+XeWsFwn92aMOPyNZD+B/C0jbm0DTwf9mBVH5Ct1iF1Rm6TPlhVZ2CqCzE4AAyTXfeEvhVrGuzRz6lHJp2n5BZpBiWQeiqen1P617xYaFpGlnNhplnat/ehgVT+YGa0KUsR/Khqn3KmmabaaPp0NhYwrDbQrtRF/mfUnrmrdFFcrdzUKKKKACiiigAooooAKKKKACiiigAooooAKhubS2vYDBdW8U8TdUlQMp/A1NRQBwusfCTwtqm54LeXT5Tzutnwuf905GPpit/wn4f/wCEX8OwaSLn7QIWciTZtyGYt0yfWtuiqc5NWbEopO6CiiipGFFFFABRRRQAVleJNH/4SDw9eaUJ/I+0oE8zbu28g9MjPStWihOwHAaP8H/DOm7Xu0m1GUc5nfamfZVx+ua7ezsLPToBBZWsNtEOiQxhB+QqxRVSnKW7EopbBRRRUjCiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAP/2Q==" alt="Tecnofamilias">
      <h2>Diploma de Guardián Digital</h2>
      <div>Este diploma es para</div>
      <div class="name" id="certName"></div>
      <div>porque aprendió las 5 reglas de oro para cuidarse en internet:</div>
      <ol id="certRules"></ol>
      <div class="date" id="certDate"></div>
    </div>
    <div class="cert-tools">
      <div class="name-row" style="width:100%;text-align:center"><input class="name-in" id="nameIn" maxlength="30" placeholder="Escribe tu nombre" aria-label="Nombre para el diploma"></div>
      <button class="btn small" id="printBtn">🖨️ Imprimir diploma</button>
      <button class="btn small blue" id="againBtn">🔁 Jugar otra vez</button>
    </div>
  </section>
</main>

<!-- RETROALIMENTACIÓN -->
<div class="overlay" id="fb" hidden role="dialog" aria-modal="true" aria-labelledby="fbTitle">
  <div class="card">
    <div class="big" id="fbEmoji"></div>
    <h2 id="fbTitle"></h2>
    <p id="fbText"></p>
    <button class="btn" id="fbBtn"></button>
  </div>
</div>

<!-- GUÍA PARA ADULTOS -->
<div class="overlay" id="adults" hidden role="dialog" aria-modal="true" aria-labelledby="adTitle">
  <div class="card adult">
    <h2 id="adTitle">Guía para padres y docentes</h2>
    <p>“La aventura de Tecnito” es una introducción lúdica al cibercuidado. Cada isla trabaja una idea sencilla y termina con una regla de oro que el niño puede repetir.</p>
    <h3>Cómo usarlo</h3>
    <ul>
      <li><b>3 a 5 años:</b> jueguen juntos. El adulto toca la pantalla si hace falta y conversa después de cada respuesta. Las voces leen todo en voz alta.</li>
      <li><b>6 a 8 años:</b> pueden jugar con más autonomía, con un adulto cerca para conversar al final de cada isla.</li>
      <li>Sesiones cortas: una o dos islas por día (5 a 10 minutos).</li>
    </ul>
    <h3>Lo que aprende en cada isla</h3>
    <ul>
      <li>🔑 La contraseña es secreta y solo la saben los cuidadores.</li>
      <li>🕵️ Si alguien que no conozco me escribe, le cuento a un adulto. Ningún secreto con desconocidos.</li>
      <li>🚦 Semáforo digital: verde adelante, amarillo pregunto, rojo cierro y aviso.</li>
      <li>💎 Dirección, colegio, teléfono y fotos son datos privados.</li>
      <li>🌳 Pausas, comidas y sueño sin pantallas.</li>
    </ul>
    <h3>Preguntas para conversar</h3>
    <ul>
      <li>¿Qué harías si algo en la tablet te asusta?</li>
      <li>¿Quiénes son los adultos a los que les puedes contar cualquier cosa?</li>
      <li>¿Qué cosas tuyas son un tesoro secreto?</li>
    </ul>
    <p style="margin-top:14px">Lo más importante: que el niño sepa que <b>siempre puede contarte</b> lo que vio, sin miedo a regaños ni a que le quiten el dispositivo.</p>
    <div style="text-align:center;margin-top:16px"><button class="btn small blue" id="adClose">Entendido</button></div>
  </div>
</div>

<script>
/* ---------- CONTENIDO ---------- */
const SEM = [
  {k:'g', e:'🟢', t:'Verde: ¡adelante!', cls:'g'},
  {k:'y', e:'🟡', t:'Amarillo: pregunto a un adulto', cls:'y'},
  {k:'r', e:'🔴', t:'Rojo: ¡alto! Cierro y aviso', cls:'r'}
];
const BIN = [
  {k:'s', e:'🤫', t:'Es un tesoro secreto', cls:'secret'},
  {k:'c', e:'😊', t:'Lo puedo contar', cls:'share'}
];

const LEVELS = [
  { id:'llave', emoji:'🔑', title:'La llave secreta', color:'#FDBE2F',
    intro:'Tu contraseña es como la llave de tu casa. ¡Solo la saben tus papás o las personas que te cuidan!',
    rule:'Mi contraseña es secreta: solo la saben mis papás o cuidadores.',
    rounds:[
      {scene:'🔑', q:'¿A quién le puedes contar tu contraseña?', opts:[
        {e:'👩‍👦', t:'A mamá, papá o mi cuidador', ok:true, fb:'¡Exacto! Los adultos que te cuidan pueden saberla para protegerte.'},
        {e:'👾', t:'A alguien de un juego', ok:false, fb:'Mmm, no. Las personas de internet no deben saber tu contraseña.'},
        {e:'🧒', t:'A un amigo del parque', ok:false, fb:'Aunque sea tu amigo, la contraseña es secreta. Solo la saben tus papás.'}
      ]},
      {scene:'🔒', q:'¿Cuál candado es más fuerte?', opts:[
        {e:'🔓', t:'1 2 3', ok:false, fb:'“1 2 3” es muy fácil de adivinar. ¡Cualquiera abre ese candado!'},
        {e:'🔐', t:'Perro Arcoíris Cohete 7', ok:true, fb:'¡Sí! Las contraseñas largas y divertidas son candados súper fuertes.'}
      ]},
      {scene:'🎮', q:'En un juego alguien te dice: “Dame tu contraseña y te regalo monedas”. ¿Qué haces?', opts:[
        {e:'🙅', t:'Digo NO y le cuento a un adulto', ok:true, fb:'¡Muy bien! Es un truco. Nadie de verdad necesita tu contraseña.'},
        {e:'🎁', t:'Se la doy para tener monedas', ok:false, fb:'¡Cuidado! Es un truco para quitarte tu juego. Di NO y avisa a un adulto.'}
      ]}
    ]},
  { id:'desconocido', emoji:'🕵️', title:'¿Quién me escribe?', color:'#3DAEE3',
    intro:'En internet no siempre sabemos quién está del otro lado. ¡Vamos a descubrir qué hacer!',
    rule:'Si alguien que no conozco me escribe, le cuento a un adulto.',
    rounds:[
      {scene:'💬', q:'Alguien que no conoces te escribe en un juego: “¿Dónde vives?”. ¿Qué haces?', opts:[
        {e:'🗣️', t:'No respondo y le cuento a un adulto', ok:true, fb:'¡Perfecto! Si no lo conoces, no respondes y le cuentas a un adulto.'},
        {e:'🏠', t:'Le digo dónde vivo', ok:false, fb:'Dónde vives es un tesoro secreto. No se lo digas a nadie de internet.'}
      ]},
      {scene:'📱', q:'Tu abuelita te hace una videollamada. ¿Qué haces?', opts:[
        {e:'👵', t:'Contesto con mamá o papá cerca', ok:true, fb:'¡Qué bien! Hablar con la familia es lindo, con un adulto cerca.'},
        {e:'🙈', t:'Me asusto y escondo la tablet', ok:false, fb:'¡Tranquilo! Hablar con la familia está bien. Solo hazlo con un adulto cerca.'}
      ]},
      {scene:'🤐', q:'Alguien en internet te dice: “No le cuentes a tus papás que hablamos”. ¿Qué haces?', opts:[
        {e:'📢', t:'Se lo cuento a mis papás', ok:true, fb:'¡Muy valiente! Si alguien te pide esconder algo de tus papás, siempre se lo cuentas.'},
        {e:'🤫', t:'Lo guardo en secreto', ok:false, fb:'Los secretos que te hacen sentir raro no se guardan. Cuéntaselo a un adulto que te cuide.'}
      ]},
      {scene:'📸', q:'Alguien que no conoces te pide una foto tuya. ¿Qué haces?', opts:[
        {e:'✋', t:'Digo NO y aviso a un adulto', ok:true, fb:'¡Excelente! Tus fotos son tuyas. No se las mandas a nadie de internet.'},
        {e:'🤳', t:'Le mando una foto', ok:false, fb:'Nunca mandes fotos a personas que no conoces. Di NO y avisa a un adulto.'}
      ]}
    ]},
  { id:'semaforo', emoji:'🚦', title:'El semáforo digital', color:'#36B37E',
    intro:'En internet también hay un semáforo. Verde: ¡adelante! Amarillo: pregunto a un adulto. Rojo: ¡alto! Cierro y aviso.',
    rule:'Si algo me asusta o me hace sentir raro, cierro y le aviso a un adulto.',
    rounds:[
      {type:'sem', scene:'📺', q:'Ver dibujos animados con mamá.', ans:'g',
        ok:'¡Verde! Ver dibujos con un adulto es seguro y divertido.', no:'Esto es verde: ver dibujos con mamá está bien. ¡Adelante!'},
      {type:'sem', scene:'🛒', q:'El juego te pide comprar algo.', ans:'y',
        ok:'¡Amarillo! Antes de comprar, siempre le preguntas a un adulto.', no:'Esto es amarillo: para comprar, primero pregunta a un adulto.'},
      {type:'sem', scene:'😨', q:'Aparece una imagen que te asusta.', ans:'r',
        ok:'¡Rojo! Cierras y le cuentas a un adulto. ¡No es tu culpa!', no:'Esto es rojo: cierra la pantalla y cuéntale a un adulto. ¡No es tu culpa!'},
      {type:'sem', scene:'🎉', q:'Sale un mensaje: “¡Ganaste un premio! Toca aquí”.', ans:'r',
        ok:'¡Rojo! Esos premios son trampas. No toques nada y avisa.', no:'Esto es rojo: esos premios son trampas. No toques y avisa a un adulto.'},
      {type:'sem', scene:'⬇️', q:'Quieres bajar un juego nuevo.', ans:'y',
        ok:'¡Amarillo! Un adulto te ayuda a ver si el juego es seguro.', no:'Esto es amarillo: pide a un adulto que te ayude a bajar juegos.'}
    ]},
  { id:'tesoros', emoji:'💎', title:'Mis tesoros', color:'#EF4A36',
    intro:'Hay cosas tuyas que son un tesoro y se guardan en secreto. Otras sí las puedes contar. ¡Vamos a separarlas!',
    rule:'Dónde vivo, mi colegio, mi teléfono y mis fotos son un tesoro: no los cuento en internet.',
    rounds:[
      {type:'bin', scene:'🏠', q:'Dónde vivo.', ans:'s', ok:'¡Sí! Tu casa es un tesoro secreto.', no:'Dónde vives es secreto. Solo lo saben tu familia y amigos de verdad.'},
      {type:'bin', scene:'🎨', q:'Mi color favorito.', ans:'c', ok:'¡Claro! Tu color favorito lo puedes contar.', no:'¡Tu color favorito sí lo puedes contar! No es peligroso.'},
      {type:'bin', scene:'🏫', q:'El nombre de mi colegio.', ans:'s', ok:'¡Muy bien! El nombre de tu colegio es secreto en internet.', no:'El nombre de tu colegio es un tesoro. En internet no se cuenta.'},
      {type:'bin', scene:'🐶', q:'Mi animal favorito.', ans:'c', ok:'¡Sí! Tu animal favorito lo puedes contar.', no:'¡Tu animal favorito sí lo puedes contar!'},
      {type:'bin', scene:'📞', q:'Mi número de teléfono.', ans:'s', ok:'¡Exacto! El teléfono es un tesoro secreto.', no:'El número de teléfono es secreto. No lo des en internet.'},
      {type:'bin', scene:'📸', q:'Fotos mías.', ans:'s', ok:'¡Muy bien! Tus fotos solo se comparten con permiso de tus papás.', no:'Tus fotos son un tesoro. Solo se comparten con permiso de tus papás.'}
    ]},
  { id:'cuerpo', emoji:'🌳', title:'Cuido mi cuerpo', color:'#283A60',
    intro:'Las pantallas son divertidas, pero tu cuerpo también necesita jugar, comer y dormir.',
    rule:'Hago pausas: juego afuera, como sin pantallas y duermo sin tablet.',
    rounds:[
      {scene:'😵‍💫', q:'Te cansan los ojos de mirar la tablet. ¿Qué haces?', opts:[
        {e:'⚽', t:'Descanso y juego a otra cosa', ok:true, fb:'¡Genial! Tus ojos y tu cuerpo te lo agradecen.'},
        {e:'📱', t:'Sigo mirando la tablet', ok:false, fb:'Cuando los ojos se cansan, es hora de descansar y jugar a otra cosa.'}
      ]},
      {scene:'🍽️', q:'Es hora de comer en familia. ¿Qué haces?', opts:[
        {e:'👨‍👩‍👧', t:'Dejo la tablet y converso', ok:true, fb:'¡Muy bien! La comida es para disfrutar y conversar en familia.'},
        {e:'📺', t:'Como mirando videos', ok:false, fb:'En la mesa, mejor sin pantallas. ¡Así conversas con tu familia!'}
      ]},
      {scene:'🌙', q:'Es hora de dormir. ¿Dónde va la tablet?', opts:[
        {e:'🔌', t:'Fuera de mi cuarto, cargando', ok:true, fb:'¡Perfecto! Sin pantallas duermes mejor y sueñas bonito.'},
        {e:'🛏️', t:'Conmigo en la cama', ok:false, fb:'La tablet no deja dormir bien. Que duerma fuera de tu cuarto.'}
      ]}
    ]}
];

/* ---------- ESTADO ---------- */
const $ = s => document.querySelector(s);
const state = {stars:{}, sound:true, level:0, round:0, mistakes:0, lastSpoken:''};
try { const saved = JSON.parse(localStorage.getItem('tecnito-progreso') || '{}'); if (saved && typeof saved === 'object') state.stars = saved; } catch(e) {}
function save(){ try { localStorage.setItem('tecnito-progreso', JSON.stringify(state.stars)); } catch(e) {} }

/* ---------- VOZ ---------- */
let voices = [];
const hasTTS = 'speechSynthesis' in window;
function loadVoices(){ voices = speechSynthesis.getVoices(); }
if (hasTTS) { loadVoices(); speechSynthesis.onvoiceschanged = loadVoices; }
function pickVoice(){
  const pref = ['es-CO','es-MX','es-US','es-419','es-AR','es-ES'];
  for (const p of pref) { const v = voices.find(v => v.lang.replace('_','-') === p); if (v) return v; }
  return voices.find(v => v.lang.toLowerCase().startsWith('es'));
}
function clean(t){ return t.replace(/[\u{1F000}-\u{1FAFF}\u{2600}-\u{27BF}\u{2B00}-\u{2BFF}\uFE0F\u200D]/gu,'').replace(/[“”]/g,''); }
function speak(t){
  state.lastSpoken = t;
  if (!state.sound || !hasTTS) return;
  speechSynthesis.cancel();
  const u = new SpeechSynthesisUtterance(clean(t));
  const v = pickVoice(); if (v) u.voice = v;
  u.lang = v ? v.lang : 'es-CO'; u.rate = .9; u.pitch = 1.15;
  speechSynthesis.speak(u);
}

/* ---------- SONIDOS ---------- */
let actx;
function tone(freqs, dur, type){
  if (!state.sound) return;
  try {
    actx = actx || new (window.AudioContext || window.webkitAudioContext)();
    const t = actx.currentTime;
    freqs.forEach((f,i) => {
      const o = actx.createOscillator(), g = actx.createGain();
      o.type = type; o.frequency.value = f;
      g.gain.setValueAtTime(.0001, t+i*dur);
      g.gain.exponentialRampToValueAtTime(.2, t+i*dur+.02);
      g.gain.exponentialRampToValueAtTime(.0001, t+i*dur+dur);
      o.connect(g); g.connect(actx.destination);
      o.start(t+i*dur); o.stop(t+i*dur+dur+.05);
    });
  } catch(e) {}
}
const sfx = {
  ok: () => tone([523,659,784,1047], .1, 'triangle'),
  no: () => tone([392,311], .18, 'sine'),
  tap: () => tone([700], .05, 'triangle'),
  win: () => tone([523,659,784,659,784,1047], .12, 'triangle')
};

/* ---------- UTILIDADES ---------- */
const pick = a => a[Math.floor(Math.random()*a.length)];
function shuffle(a){ for (let i=a.length-1;i>0;i--){ const j=Math.floor(Math.random()*(i+1)); [a[i],a[j]]=[a[j],a[i]]; } return a; }
function show(id){
  document.querySelectorAll('.screen').forEach(s => s.hidden = s.id !== 's-'+id);
  window.scrollTo(0,0);
}
function starsHTML(n){ return '⭐'.repeat(n) + '<span class="off">⭐</span>'.repeat(3-n); }
function confetti(n){
  if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;
  const cols = ['#3DAEE3','#FDBE2F','#EF4A36','#36B37E','#283A60'];
  for (let i=0;i<n;i++){
    const d = document.createElement('div');
    d.className = 'confetti';
    d.style.left = Math.random()*100 + 'vw';
    d.style.background = pick(cols);
    d.style.animationDuration = (1.6 + Math.random()*1.6) + 's';
    d.style.animationDelay = (Math.random()*.4) + 's';
    document.body.appendChild(d);
    setTimeout(() => d.remove(), 3800);
  }
}
function updateSoundIcons(){ document.querySelectorAll('[data-sound]').forEach(b => b.textContent = state.sound ? '🔊' : '🔇'); }

/* ---------- MAPA ---------- */
function renderMap(){
  const g = $('#islands'); g.innerHTML = '';
  LEVELS.forEach((L,i) => {
    const s = state.stars[L.id] || 0;
    const b = document.createElement('button');
    b.className = 'isle';
    b.style.setProperty('--c', L.color);
    b.setAttribute('aria-label', 'Isla ' + (i+1) + ': ' + L.title + (s ? ', ' + s + ' estrellas' : ''));
    b.innerHTML = '<span class="num">'+(i+1)+'</span><span class="em">'+L.emoji+'</span><span class="tt">'+L.title+'</span><span class="st">'+starsHTML(s)+'</span>';
    b.onclick = () => { sfx.tap(); startLevel(i); };
    g.appendChild(b);
  });
  const done = LEVELS.filter(L => state.stars[L.id]).length;
  const all = done === LEVELS.length;
  $('#certCta').hidden = !all;
  const msg = all ? '¡Superaste todas las islas! Ya puedes recibir tu diploma.'
    : done === 0 ? '¡Hola! Soy Tecnito. Elige una isla para empezar.'
    : '¡Vas muy bien! Te faltan ' + (LEVELS.length - done) + ' islas.';
  $('#mapMsg').textContent = msg;
  speak(msg);
}

/* ---------- NIVEL ---------- */
function renderProgress(){
  const L = LEVELS[state.level], p = $('#progress'); p.innerHTML = '';
  L.rounds.forEach((_,i) => {
    const d = document.createElement('i');
    if (i < state.round) d.className = 'done'; else if (i === state.round) d.className = 'now';
    p.appendChild(d);
  });
}
function setScene(e){
  const s = $('#scene'); s.textContent = e;
  s.classList.remove('pop'); void s.offsetWidth; s.classList.add('pop');
}
function startLevel(i){
  state.level = i; state.round = -1; state.mistakes = 0;
  const L = LEVELS[i];
  document.documentElement.style.setProperty('--lvl', L.color);
  show('level');
  $('#progress').innerHTML = '';
  setScene(L.emoji);
  $('#bubble').textContent = L.intro;
  const box = $('#opts'); box.innerHTML = ''; box.className = 'opts single';
  const go = document.createElement('button');
  go.className = 'btn'; go.textContent = '¡Vamos! ▶';
  go.onclick = () => { sfx.tap(); state.round = 0; renderRound(); };
  box.appendChild(go);
  speak(L.intro);
}
function optsFor(r){
  if (r.type === 'sem') return SEM.map(o => ({...o, ok:o.k===r.ans, fb:o.k===r.ans ? r.ok : r.no}));
  if (r.type === 'bin') return BIN.map(o => ({...o, ok:o.k===r.ans, fb:o.k===r.ans ? r.ok : r.no}));
  return shuffle(r.opts.slice());
}
function renderRound(){
  const r = LEVELS[state.level].rounds[state.round];
  renderProgress();
  setScene(r.scene);
  const q = r.type === 'sem' ? r.q + ' ¿Qué color es?' : r.type === 'bin' ? r.q + ' ¿Es secreto o lo puedo contar?' : r.q;
  $('#bubble').textContent = q;
  const box = $('#opts'); box.innerHTML = '';
  box.className = 'opts';
  const os = optsFor(r);
  os.forEach(o => {
    const b = document.createElement('button');
    b.className = 'opt' + (o.cls ? ' ' + o.cls : '');
    b.innerHTML = '<span class="oe" aria-hidden="true">'+o.e+'</span><span class="ot">'+o.t+'</span>';
    b.onclick = () => answer(o, b);
    box.appendChild(b);
  });
  const spoken = (r.type === 'sem' || r.type === 'bin') ? q : q + ' ' + os.map(o => o.t).join('. ¿O ') + '?';
  speak(spoken.replace('?. ¿O','? ¿O'));
}
function answer(o, b){
  if (b.classList.contains('used')) return;
  if (o.ok){
    sfx.ok(); b.classList.add('right'); confetti(40);
    feedback(true, o.fb);
  } else {
    sfx.no(); state.mistakes++;
    b.classList.add('wrong','used');
    feedback(false, o.fb);
  }
}
function feedback(ok, txt){
  const ov = $('#fb');
  ov.className = 'overlay ' + (ok ? 'good' : 'try');
  $('#fbEmoji').textContent = ok ? pick(['🎉','🌟','🦸','👏','🥳']) : '🤔';
  $('#fbTitle').textContent = ok ? pick(['¡Muy bien!','¡Genial!','¡Súper!','¡Eso es!']) : '¡Casi!';
  $('#fbText').textContent = txt;
  $('#fbBtn').textContent = ok ? 'Siguiente ▶' : 'Intentar otra vez ↺';
  $('#fbBtn').onclick = () => {
    sfx.tap(); ov.hidden = true;
    if (ok) nextRound(); else speak($('#bubble').textContent);
  };
  ov.hidden = false;
  speak($('#fbTitle').textContent + ' ' + txt);
  setTimeout(() => $('#fbBtn').focus(), 50);
}
function nextRound(){
  const L = LEVELS[state.level];
  state.round++;
  if (state.round < L.rounds.length) renderRound(); else endLevel();
}
function endLevel(){
  const L = LEVELS[state.level], m = state.mistakes;
  const s = m === 0 ? 3 : m <= 2 ? 2 : 1;
  state.stars[L.id] = Math.max(state.stars[L.id] || 0, s); save();
  show('end');
  $('#endEmoji').textContent = L.emoji;
  $('#endStars').innerHTML = starsHTML(s);
  $('#endRule').textContent = L.rule;
  sfx.win(); confetti(90);
  speak('¡Isla superada! Ganaste ' + s + (s === 1 ? ' estrella' : ' estrellas') + '. Regla de oro: ' + L.rule);
}

/* ---------- DIPLOMA ---------- */
function renderCert(){
  const ol = $('#certRules'); ol.innerHTML = '';
  LEVELS.forEach(L => { const li = document.createElement('li'); li.textContent = L.emoji + ' ' + L.rule; ol.appendChild(li); });
  $('#certName').textContent = $('#nameIn').value.trim() || '\u00a0';
  $('#certDate').textContent = new Date().toLocaleDateString('es-CO', {day:'numeric', month:'long', year:'numeric'});
  show('cert'); sfx.win(); confetti(120);
  speak('¡Felicitaciones! Eres un Guardián Digital. Escribe tu nombre en el diploma.');
}

/* ---------- EVENTOS ---------- */
$('#playBtn').onclick = () => { sfx.tap(); show('map'); renderMap(); };
$('#homeBtn').onclick = () => { sfx.tap(); show('home'); };
$('#backMap').onclick = () => { sfx.tap(); show('map'); renderMap(); };
$('#endBtn').onclick = () => { sfx.tap(); show('map'); renderMap(); };
$('#certBtn').onclick = () => { sfx.tap(); renderCert(); };
$('#certBack').onclick = () => { sfx.tap(); show('map'); renderMap(); };
$('#repeatBtn').onclick = () => speak(state.lastSpoken || $('#bubble').textContent);
$('#nameIn').oninput = e => { $('#certName').textContent = e.target.value.trim() || '\u00a0'; };
$('#printBtn').onclick = () => window.print();
$('#againBtn').onclick = () => { state.stars = {}; save(); show('map'); renderMap(); };
document.querySelectorAll('[data-sound]').forEach(b => b.onclick = () => {
  state.sound = !state.sound; updateSoundIcons();
  if (!state.sound && hasTTS) speechSynthesis.cancel();
});
document.querySelectorAll('[data-adults]').forEach(b => b.onclick = () => { $('#adults').hidden = false; $('#adClose').focus(); });
$('#adClose').onclick = () => { $('#adults').hidden = true; };
document.addEventListener('keydown', e => { if (e.key === 'Escape') $('#adults').hidden = true; });
updateSoundIcons();
</script>
</body>
</html>
$tfgame$, true, true, 2, CURRENT_TIMESTAMP)
ON CONFLICT ("slug") DO NOTHING;
