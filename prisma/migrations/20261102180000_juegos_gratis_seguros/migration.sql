-- Sección oculta "Juegos gratis y seguros" (/juegos-gratis-seguros): juegos gratis fuera del SEO.
ALTER TABLE "Game" ADD COLUMN "unlisted" BOOLEAN NOT NULL DEFAULT false;

INSERT INTO "Game" ("id", "slug", "title", "description", "ageLabel", "emoji", "color", "html", "fullHeight", "free", "unlisted", "published", "order", "updatedAt")
VALUES ('game_arena_splash', 'arena-splash', $TF$Arena Splash · Duelo de colores$TF$, $TF$Duelo de pintura contra bots en 9 arenas: burbujas, rayos de luz y chorros de color. Los bots no se lastiman, se manchan y salen teletransportados. Sin sangre.$TF$, $TF$Desde 9 años$TF$, $TF$🎨$TF$, '#3DAEE4', $TF$<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>Arena Splash · Duelo de colores</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fredoka:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
:root{
  --bg:#f3efff; --spot1:rgba(255,61,139,.16); --spot2:rgba(23,195,255,.16); --spot3:rgba(255,207,51,.22);
  --surface:#ffffff; --surface-2:#f1ecff; --surface-3:#e2daf8;
  --text:#2a1a5e; --muted:#62568f; --line:rgba(42,26,94,.14);
  --pink:#ff3d8b; --blue:#17a8e6; --yellow:#ffcf33; --green:#38b54a; --purple:#7a4dff;
  --on-accent:#ffffff; --on-yellow:#3a2a00;
  --star:#f2a900; --star-off:#cfc6ea;
  --shadow:0 6px 0 rgba(42,26,94,.18); --shadow-sm:0 3px 0 rgba(42,26,94,.16);
  --hud-bg:rgba(24,16,56,.58); --hud-text:#ffffff; --hud-muted:rgba(255,255,255,.78);
  --scrim:rgba(18,12,44,.62);
  color-scheme:light;
  box-sizing:border-box;
  padding-top:env(safe-area-inset-top,0px);
  padding-bottom:env(safe-area-inset-bottom,0px);
}
@media (prefers-color-scheme: dark){
  :root:not([data-theme="light"]){
    --bg:#140f2c; --spot1:rgba(255,61,139,.12); --spot2:rgba(23,195,255,.10); --spot3:rgba(255,207,51,.08);
    --surface:#231c49; --surface-2:#2c2459; --surface-3:#3a3170;
    --text:#f5f2ff; --muted:#bdb4e6; --line:rgba(255,255,255,.14);
    --star:#ffcf33; --star-off:#4f4686;
    --shadow:0 6px 0 rgba(0,0,0,.45); --shadow-sm:0 3px 0 rgba(0,0,0,.4);
    color-scheme:dark;
  }
}
:root[data-theme="dark"]{
  --bg:#140f2c; --spot1:rgba(255,61,139,.12); --spot2:rgba(23,195,255,.10); --spot3:rgba(255,207,51,.08);
  --surface:#231c49; --surface-2:#2c2459; --surface-3:#3a3170;
  --text:#f5f2ff; --muted:#bdb4e6; --line:rgba(255,255,255,.14);
  --star:#ffcf33; --star-off:#4f4686;
  --shadow:0 6px 0 rgba(0,0,0,.45); --shadow-sm:0 3px 0 rgba(0,0,0,.4);
  color-scheme:dark;
}
*,*::before,*::after{box-sizing:inherit}
html{height:100%;scroll-padding-top:env(safe-area-inset-top,0px);-webkit-text-size-adjust:100%}
body{margin:0;min-height:100%;background-color:var(--bg);
  background-image:radial-gradient(circle at 8% 12%,var(--spot1) 0 120px,transparent 121px),
    radial-gradient(circle at 92% 18%,var(--spot2) 0 90px,transparent 91px),
    radial-gradient(circle at 85% 88%,var(--spot3) 0 140px,transparent 141px),
    radial-gradient(circle at 12% 80%,var(--spot2) 0 60px,transparent 61px);
  background-attachment:fixed;
  color:var(--text);font-family:'Fredoka','Trebuchet MS','Segoe UI',system-ui,sans-serif;
  -webkit-tap-highlight-color:transparent;overflow-x:hidden}
body.ingame{overflow:hidden}
button{font-family:inherit;cursor:pointer}
button:focus-visible{outline:3px solid var(--blue);outline-offset:3px}
h2{margin:0;font-size:clamp(24px,4.4vw,34px);font-weight:700}
html,body{height:100%}
body{overflow:hidden}
#app{height:100%}
.screen{display:none;flex-direction:column;height:100%;max-width:1200px;margin:0 auto;padding:12px calc(env(safe-area-inset-right,0px) + 16px) 12px calc(env(safe-area-inset-left,0px) + 16px);overflow:auto}
.screen.active{display:flex}
.bar{display:flex;align-items:center;gap:12px;margin-bottom:16px}
.grow{flex:1}
.icon-btn{width:48px;height:48px;flex:none;border-radius:16px;border:0;background:var(--surface);color:var(--text);box-shadow:var(--shadow-sm);font-size:22px;font-weight:700}
.icon-btn:active{transform:translateY(2px);box-shadow:none}
.lead{color:var(--muted);font-size:17px;max-width:70ch;margin:0 0 18px;line-height:1.45}
.lead.small{font-size:15px;margin-top:-4px}

/* Logo: el elemento memorable */
.logo{font-weight:700;line-height:.9;font-size:clamp(44px,10vw,84px);letter-spacing:-1px;position:relative;display:inline-block}
.logo .l1{color:var(--surface);-webkit-text-stroke:0;text-shadow:3px 3px 0 var(--pink),6px 6px 0 var(--purple),-2px -2px 0 var(--purple),2px -2px 0 var(--purple),-2px 2px 0 var(--purple)}
.logo .l2{color:var(--yellow);text-shadow:3px 3px 0 var(--blue),6px 6px 0 var(--purple),-2px -2px 0 var(--purple),2px -2px 0 var(--purple),-2px 2px 0 var(--purple)}
.logo small{display:block;font-size:clamp(15px,2.6vw,20px);font-weight:500;color:var(--muted);letter-spacing:0;margin-top:12px;text-shadow:none}
.drip{position:absolute;width:12px;border-radius:0 0 8px 8px;background:var(--pink)}

.btn{border:0;border-radius:20px;padding:14px 22px;font-size:19px;font-weight:600;background:var(--surface);color:var(--text);box-shadow:var(--shadow);transition:transform .08s,box-shadow .08s}
.btn:active{transform:translateY(4px);box-shadow:var(--shadow-sm)}
.btn.big{font-size:24px;padding:18px 26px;width:100%;text-align:left}
.btn.primary{background:var(--pink);color:var(--on-accent)}
.btn.blue{background:var(--blue);color:var(--on-accent)}
.btn.yellow{background:var(--yellow);color:var(--on-yellow)}
.btn:disabled{opacity:.45;cursor:not-allowed}

.hero{display:grid;grid-template-columns:1.35fr 1fr;gap:20px;margin-top:22px}
@media (max-width:600px){.hero{grid-template-columns:1fr}}
.card{background:var(--surface);border-radius:26px;box-shadow:var(--shadow);padding:20px}
.pc{display:flex;gap:18px;align-items:center}
.badge{width:96px;height:96px;flex:none;border-radius:50%;background:conic-gradient(var(--pink),var(--yellow),var(--blue),var(--purple),var(--pink));display:grid;place-items:center}
.badge span{width:78px;height:78px;border-radius:50%;background:var(--surface);color:var(--text);display:grid;place-items:center;font-weight:700;font-size:34px}
.badge.pulse{animation:pulse .5s ease}
@keyframes pulse{50%{transform:scale(1.18)}}
.pinfo{flex:1;min-width:0}
.kicker{color:var(--muted);font-size:15px}
.rank{font-size:26px;font-weight:700;margin:2px 0 8px}
.xpbar{height:18px;border-radius:99px;background:var(--surface-3);overflow:hidden}
.xpbar i{display:block;height:100%;width:0;background:linear-gradient(90deg,var(--blue),var(--purple),var(--pink));border-radius:99px}
.xptxt{font-size:14px;color:var(--muted);margin-top:6px}
.chips{display:grid;grid-template-columns:repeat(4,1fr);gap:10px;margin-top:18px}
@media (max-width:520px){.chips{grid-template-columns:repeat(2,1fr)}}
.chip{background:var(--surface-2);border-radius:16px;padding:10px 12px}
.chip b{display:block;font-size:22px}
.chip span{font-size:13px;color:var(--muted)}
.next{margin-top:14px;font-size:15px;color:var(--muted)}
.menu-btns{display:flex;flex-direction:column;gap:14px;justify-content:center}
.foot{color:var(--muted);font-size:14px;margin-top:28px}

.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(250px,1fr));gap:18px}
.arena{background:var(--surface);border-radius:24px;box-shadow:var(--shadow);overflow:hidden}
.arena .ban{height:140px;position:relative;overflow:hidden}
.arena .ban svg{position:absolute;inset:0;width:100%;height:100%;display:block}
.arena .em{font-size:58px;filter:drop-shadow(0 4px 0 rgba(0,0,0,.18))}
.arena .num{position:absolute;top:10px;left:10px;background:var(--hud-bg);color:var(--hud-text);font-weight:700;border-radius:12px;padding:2px 10px;font-size:15px}
.arena .lockic{position:absolute;top:8px;right:10px;font-size:24px}
.arena.locked .ban{filter:grayscale(.85) brightness(.8)}
.arena .body{padding:12px 14px 14px}
.arena h3{margin:0 0 2px;font-size:21px}
.arena p{margin:0 0 12px;color:var(--muted);font-size:14px;min-height:2.6em;line-height:1.3}
.lockmsg{font-size:13px;color:var(--muted);margin-top:10px}
.lvls{display:grid;grid-template-columns:repeat(3,1fr);gap:8px}
.lvl{border:0;border-radius:16px;padding:8px 4px 6px;background:var(--surface-2);color:var(--text);box-shadow:var(--shadow-sm);font-weight:600;font-size:15px;display:flex;flex-direction:column;align-items:center;gap:1px}
.lvl small{font-weight:500;font-size:12px;color:var(--muted)}
.lvl:disabled{opacity:.5;cursor:not-allowed}
.lvl:not(:disabled):active{transform:translateY(2px);box-shadow:none}
.st{font-size:15px;letter-spacing:1px;color:var(--star)}
.st em{font-style:normal;color:var(--star-off)}

.match-sum{background:var(--surface);border-radius:20px;box-shadow:var(--shadow-sm);padding:12px 16px;margin-bottom:16px;font-size:17px;display:none}
.match-sum.show{display:block}
.slots{display:flex;gap:12px;flex-wrap:wrap;margin-bottom:14px}
.slot{flex:1;min-width:220px;border:4px solid transparent;border-radius:20px;background:var(--surface);color:var(--text);box-shadow:var(--shadow-sm);padding:10px 14px;text-align:left;display:flex;flex-direction:column}
.slot .sk{font-size:13px;color:var(--muted)}
.slot .sv{font-size:20px;font-weight:600}
#slot0.active{border-color:var(--pink)}
#slot1.active{border-color:var(--blue)}
.wgrid{grid-template-columns:repeat(auto-fill,minmax(270px,1fr));gap:10px}
.weapon{border:3px solid transparent;background:var(--surface);border-radius:18px;padding:10px 12px;text-align:left;color:var(--text);box-shadow:var(--shadow-sm);display:grid;grid-template-columns:40px 1fr;gap:4px 10px;position:relative}
.weapon.s0{border-color:var(--pink)}
.weapon.s1{border-color:var(--blue)}
.weapon .em{font-size:30px;line-height:1;align-self:center}
.weapon .wt{min-width:0;padding-right:78px}
.weapon .stats{grid-column:1/-1;display:grid;grid-template-columns:repeat(3,1fr);gap:8px}
.weapon h4{margin:0;font-size:16px}
.weapon p{margin:2px 0 0;font-size:12.5px;color:var(--muted);line-height:1.25}
.weapon .tag{position:absolute;top:8px;right:8px;font-size:11px;font-weight:600;border-radius:10px;padding:2px 8px;color:var(--on-accent)}
.weapon .tag.t0{background:var(--pink)} .weapon .tag.t1{background:var(--blue)}
.weapon.locked{opacity:.55}
.weapon.locked .tag{background:var(--surface-3);color:var(--text)}
.stat{display:grid;grid-template-columns:auto 1fr;align-items:center;gap:5px;font-size:11px;color:var(--muted)}
.stat b{height:7px;border-radius:9px;background:var(--surface-3);overflow:hidden;display:block}
.stat b i{display:block;height:100%;background:var(--green);border-radius:9px}
.ldbar{position:sticky;top:env(safe-area-inset-top,0px);z-index:10;background:var(--bg);padding:10px 0;margin-top:-10px;flex-wrap:wrap}
.ldbar .btn{font-size:18px;padding:12px 18px}
body::before{content:"";position:fixed;inset:0 0 auto;height:env(safe-area-inset-top,0px);z-index:10;background:var(--bg)}

.res{max-width:620px;margin:10px auto;text-align:center}
.rtitle{font-size:clamp(40px,9vw,64px);font-weight:700;line-height:1}
.rtitle.win{color:var(--pink)} .rtitle.lose{color:var(--blue)}
.rsub{color:var(--muted);margin:8px 0 6px;font-size:17px}
.rstars{font-size:44px;letter-spacing:6px;color:var(--star);min-height:52px}
.rstars em{font-style:normal;color:var(--star-off)}
.rlines{text-align:left;margin:12px 0;border-radius:18px;background:var(--surface-2);padding:6px 16px}
.rl{display:flex;justify-content:space-between;padding:8px 0;border-bottom:2px dashed var(--line);font-size:17px}
.rl:last-child{border-bottom:0}
.rl b{color:var(--green)}
.rtotal{font-size:22px;font-weight:700;margin:8px 0 16px}
.res .pc{text-align:left;margin:6px 0 10px}
.unl{display:flex;flex-direction:column;gap:8px;margin:12px 0}
.unl div{background:var(--surface-2);border-radius:16px;padding:10px 14px;font-weight:600;text-align:left}
.rbtns{display:grid;grid-template-columns:1fr 1fr;gap:12px;margin-top:16px}
.rbtns .btn{font-size:18px}
.rbtns .wide{grid-column:1/-1}

/* Juego */
#game{position:fixed;inset:0;display:none;background:#000;z-index:100;touch-action:none;user-select:none;-webkit-user-select:none;overflow:hidden}
#game.active{display:block}
#cv{position:absolute;inset:0;width:100%;height:100%;display:block}
#hud{position:absolute;inset:0;pointer-events:none;color:var(--hud-text);
  padding:calc(env(safe-area-inset-top,0px) + 10px) calc(env(safe-area-inset-right,0px) + 12px) calc(env(safe-area-inset-bottom,0px) + 12px) calc(env(safe-area-inset-left,0px) + 12px)}
.hud-top{display:flex;gap:8px;justify-content:center;align-items:center;flex-wrap:wrap}
.pill{background:var(--hud-bg);color:var(--hud-text);border-radius:999px;padding:6px 14px;font-weight:600;font-size:16px}
#hPause{pointer-events:auto;z-index:3;position:absolute;top:calc(env(safe-area-inset-top,0px) + 8px);right:calc(env(safe-area-inset-right,0px) + 10px);width:44px;height:44px;border-radius:14px;border:0;background:var(--hud-bg);color:var(--hud-text);font-size:18px}
#cross{position:absolute;left:50%;top:50%;width:28px;height:28px;transform:translate(-50%,-50%)}
#cross::before,#cross::after{content:"";position:absolute;background:var(--hud-text);box-shadow:0 0 0 1.5px rgba(0,0,0,.45);border-radius:2px}
#cross::before{left:13px;top:2px;width:2px;height:24px}
#cross::after{top:13px;left:2px;height:2px;width:24px}
#cross.aim::before,#cross.aim::after{background:var(--yellow)}
#hitm{position:absolute;left:50%;top:50%;width:40px;height:40px;transform:translate(-50%,-50%) rotate(45deg);opacity:0}
#hitm::before,#hitm::after{content:"";position:absolute;background:var(--hud-text)}
#hitm::before{left:19px;top:0;width:3px;height:40px;clip-path:polygon(0 0,100% 0,100% 30%,0 30%,0 70%,100% 70%,100% 100%,0 100%)}
#hitm::after{top:19px;left:0;height:3px;width:40px;clip-path:polygon(0 0,30% 0,30% 100%,0 100%,0 0,70% 0,100% 0,100% 100%,70% 100%)}
#hitm.show{animation:hm .22s ease-out}
#hitm.head::before,#hitm.head::after{background:var(--yellow)}
@keyframes hm{0%{opacity:1;transform:translate(-50%,-50%) rotate(45deg) scale(1.3)}100%{opacity:0;transform:translate(-50%,-50%) rotate(45deg) scale(1)}}
#banner{position:absolute;left:50%;top:30%;transform:translate(-50%,-50%);text-align:center;font-size:clamp(34px,8vw,68px);font-weight:700;line-height:1;opacity:0;white-space:nowrap;text-shadow:0 4px 0 rgba(0,0,0,.35)}
#banner small{display:block;font-size:clamp(16px,3vw,24px);font-weight:500;margin-top:8px}
#banner.show{animation:ban 2s ease forwards}
@keyframes ban{0%{opacity:0;transform:translate(-50%,-50%) scale(.6)}12%{opacity:1;transform:translate(-50%,-50%) scale(1.06)}20%{transform:translate(-50%,-50%) scale(1)}80%{opacity:1}100%{opacity:0}}
#count{position:absolute;left:50%;top:50%;transform:translate(-50%,-50%);font-size:clamp(70px,16vw,140px);font-weight:700;opacity:0;text-shadow:0 6px 0 rgba(0,0,0,.35);color:var(--yellow)}
#count.show{animation:cnt .9s ease forwards}
@keyframes cnt{0%{opacity:0;transform:translate(-50%,-50%) scale(1.8)}25%{opacity:1;transform:translate(-50%,-50%) scale(1)}100%{opacity:0;transform:translate(-50%,-50%) scale(.8)}}
#feed{position:absolute;top:calc(env(safe-area-inset-top,0px) + 62px);right:calc(env(safe-area-inset-right,0px) + 12px);display:flex;flex-direction:column;gap:6px;align-items:flex-end}
.fi{background:var(--hud-bg);color:var(--hud-text);border-radius:12px;padding:6px 12px;font-size:15px;display:flex;gap:10px;animation:fi 2.6s ease forwards}
.fi b{color:var(--yellow)}
@keyframes fi{0%{opacity:0;transform:translateX(20px)}8%{opacity:1;transform:none}80%{opacity:1}100%{opacity:0}}
.hud-bottom{position:absolute;left:calc(env(safe-area-inset-left,0px) + 12px);right:calc(env(safe-area-inset-right,0px) + 12px);bottom:calc(env(safe-area-inset-bottom,0px) + 12px);display:flex;justify-content:space-between;align-items:flex-end;gap:10px}
.shield{display:flex;align-items:center;gap:8px;background:var(--hud-bg);padding:8px 12px;border-radius:16px;width:min(260px,44vw)}
.shield .bar{flex:1;height:14px;background:rgba(255,255,255,.22);border-radius:99px;overflow:hidden}
.shield .bar i{display:block;height:100%;width:100%;background:linear-gradient(90deg,#4ade80,#22d3ee);border-radius:99px}
.shield.low .bar i{background:linear-gradient(90deg,#ffb020,#ff7a45);animation:lowp .6s infinite alternate}
@keyframes lowp{to{opacity:.55}}
.weap{background:var(--hud-bg);padding:8px 14px;border-radius:16px;text-align:right;min-width:170px}
#hWName{font-size:15px;color:var(--hud-muted)}
#hAmmo{font-size:26px;font-weight:700}
.slotsH{display:flex;gap:8px;justify-content:flex-end;font-size:14px}
.slotsH span{opacity:.5}.slotsH span.on{opacity:1;font-weight:600}
#splats{position:absolute;inset:0;pointer-events:none;overflow:hidden}
.splat{position:absolute;width:300px;height:300px;margin:-150px 0 0 -150px;border-radius:50%;animation:spl 1.3s ease-out forwards}
@keyframes spl{0%{opacity:.95;transform:scale(.4)}15%{opacity:.9;transform:scale(1)}100%{opacity:0;transform:scale(1.05) translateY(30px)}}
#scope{position:absolute;inset:0;display:none;pointer-events:none;background:radial-gradient(circle at center,transparent 0 30%,rgba(0,0,0,.8) 31%)}
#game.zoom #scope{display:block}
#game.ads #scope{display:block;background:radial-gradient(circle at center,transparent 0 50%,rgba(0,0,0,.4) 80%)}
#game.ads #cross{transform:translate(-50%,-50%) scale(.6)}
#hint{position:absolute;left:50%;bottom:calc(env(safe-area-inset-bottom,0px) + 96px);transform:translateX(-50%);background:var(--hud-bg);color:var(--hud-text);border-radius:14px;padding:8px 14px;font-size:14px;text-align:center;max-width:92vw;opacity:0;transition:opacity .4s}
#hint.show{opacity:1}

#touch{position:absolute;inset:0;display:none;z-index:1}
#game.touch #touch{display:block}
#game.touch .hud-bottom{bottom:auto;top:calc(env(safe-area-inset-top,0px) + 58px);align-items:flex-start}
#game.touch #feed{top:calc(env(safe-area-inset-top,0px) + 130px)}
#game.touch .weap{padding:6px 10px;min-width:0}
#game.touch #hAmmo{font-size:20px}
#joyBase{position:absolute;width:124px;height:124px;border-radius:50%;background:rgba(255,255,255,.14);border:3px solid rgba(255,255,255,.4);display:none;transform:translate(-50%,-50%)}
#joyKnob{position:absolute;left:50%;top:50%;width:56px;height:56px;margin:-28px 0 0 -28px;border-radius:50%;background:rgba(255,255,255,.6)}
.joyhint{position:absolute;left:calc(env(safe-area-inset-left,0px) + 28px);bottom:calc(env(safe-area-inset-bottom,0px) + 30px);color:var(--hud-muted);font-size:13px;background:var(--hud-bg);border-radius:12px;padding:6px 10px}
.tbtn{position:absolute;border-radius:50%;border:3px solid rgba(255,255,255,.45);background:rgba(255,255,255,.18);color:var(--hud-text);font-weight:700;display:grid;place-items:center;touch-action:none}
.tbtn.on{background:rgba(255,255,255,.4)}
#tFire{width:96px;height:96px;right:calc(env(safe-area-inset-right,0px) + 22px);bottom:calc(env(safe-area-inset-bottom,0px) + 26px);background:rgba(255,61,139,.62);font-size:34px}
#tJump{width:66px;height:66px;right:calc(env(safe-area-inset-right,0px) + 132px);bottom:calc(env(safe-area-inset-bottom,0px) + 22px);font-size:24px}
#tSwap{width:58px;height:58px;right:calc(env(safe-area-inset-right,0px) + 34px);bottom:calc(env(safe-area-inset-bottom,0px) + 136px);font-size:22px}
#tZoom{width:56px;height:56px;right:calc(env(safe-area-inset-right,0px) + 104px);bottom:calc(env(safe-area-inset-bottom,0px) + 176px);font-size:22px}
#tReload{width:52px;height:52px;right:calc(env(safe-area-inset-right,0px) + 124px);bottom:calc(env(safe-area-inset-bottom,0px) + 104px);font-size:20px}

.overlay{position:absolute;inset:0;display:none;place-items:center;background:var(--scrim);z-index:5;padding:20px}
.overlay.show{display:grid}
.panel{background:var(--surface);color:var(--text);border-radius:26px;padding:22px;max-width:440px;width:100%;box-shadow:var(--shadow);text-align:center;max-height:100%;overflow:auto}
.panel h3{margin:0 0 12px;font-size:30px}
.panel .btn{width:100%;margin-top:10px}
.row{display:flex;align-items:center;justify-content:space-between;gap:12px;margin:14px 0 4px;font-size:16px;text-align:left}
.row input[type=range]{flex:1;accent-color:var(--pink)}
.modal{position:fixed;inset:0;display:none;place-items:center;background:var(--scrim);z-index:200;padding:calc(env(safe-area-inset-top,0px) + 16px) 16px calc(env(safe-area-inset-bottom,0px) + 16px)}
.modal.show{display:grid}
.modal .panel{max-width:560px;text-align:left}
.modal h4{margin:16px 0 6px;font-size:19px}
.modal ul{margin:0;padding-left:20px;line-height:1.5;color:var(--muted)}
.modal li b{color:var(--text)}
#toast{position:fixed;left:50%;bottom:calc(env(safe-area-inset-bottom,0px) + 24px);transform:translateX(-50%) translateY(120px);background:var(--text);color:var(--bg);border-radius:16px;padding:12px 18px;font-weight:600;z-index:300;transition:transform .3s;max-width:90vw;text-align:center}
#toast.show{transform:translateX(-50%) translateY(0)}

/* Una sola pantalla, sin bajar */
#arenaGrid{flex:1;min-height:0;display:grid;grid-auto-flow:column;grid-template-rows:minmax(0,1fr);grid-auto-columns:minmax(270px,320px);overflow-x:auto;overflow-y:hidden;scroll-snap-type:x mandatory;padding:4px 4px 14px;gap:16px}
#arenaGrid .arena{scroll-snap-align:start;display:flex;flex-direction:column;min-height:0}
.arena .ban{height:auto;flex:1;min-height:70px;max-height:150px}
.arena .body{flex:none}
.wgrid{flex:1;min-height:0;display:grid;grid-auto-flow:column;grid-template-rows:repeat(2,auto);grid-template-columns:none;grid-auto-columns:minmax(300px,340px);align-content:start;overflow-x:auto;overflow-y:hidden;scroll-snap-type:x mandatory;padding:4px 4px 14px}
.weapon{scroll-snap-align:start}
.lvl span:first-child{white-space:nowrap}
.weapon h4{white-space:nowrap;overflow:hidden;text-overflow:ellipsis;padding-right:78px}
.weapon.locked h4{padding-right:58px}
.weapon .wt{padding-right:0}
.weapon{overflow:hidden}
.weapon p{display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;overflow:hidden}
.ldbar{position:static;margin-top:0;padding:0}
.swipe{font-size:13px;color:var(--muted);margin:0 0 6px}
.res{display:grid;grid-template-columns:1fr 1fr;gap:22px;align-items:start;text-align:left;max-width:980px;width:100%;margin:auto}
.rcol{min-width:0;display:flex;flex-direction:column}
.res .rstars{min-height:0}
.unl{max-height:30vh;overflow:auto}
.rbtns{margin-top:auto;padding-top:10px}
@media (min-height:760px){.wgrid{grid-template-rows:repeat(3,auto)}}
@media (max-width:600px){.res{grid-template-columns:1fr}.screen{overflow:auto}}
@media (max-height:540px){
 .bar{margin-bottom:8px}
 .logo{font-size:34px}.logo br{display:none}.logo small{display:none}
 .hero{margin-top:4px;gap:12px}.card{padding:12px 14px;border-radius:20px}
 .badge{width:62px;height:62px}.badge span{width:50px;height:50px;font-size:22px}
 .rank{font-size:19px;margin:0 0 6px}.xpbar{height:13px}.xptxt{font-size:12px}
 .chips{margin-top:10px;gap:8px}.chip{padding:6px 10px}.chip b{font-size:17px}.chip span{font-size:11px}
 .next{margin-top:8px;font-size:13px}.menu-btns{gap:10px}.btn.big{font-size:19px;padding:11px 18px}
 .foot{display:none}
 h2{font-size:22px}.icon-btn{width:40px;height:40px;font-size:18px;border-radius:12px}
 .lead{display:none}
 .arena h3{font-size:17px}.arena p{display:none}.arena .body{padding:8px 10px 10px}.lvl{padding:5px 4px 4px;font-size:13px}.lvl small{font-size:11px}.lockmsg{margin-top:6px;font-size:12px}
 .match-sum{padding:6px 12px;font-size:14px;margin-bottom:8px}
 .slots{margin-bottom:8px;gap:8px}.slot{padding:4px 10px;min-width:160px;border-width:3px}.slot .sv{font-size:15px}.slot .sk{font-size:11px}
 .wgrid{grid-template-rows:repeat(2,minmax(0,1fr));gap:8px;grid-auto-columns:300px}.weapon .tag{font-size:10px;padding:1px 6px}.weapon h4{padding-right:66px}.weapon.locked h4{padding-right:50px}.weapon{padding:7px 10px;gap:2px 8px}.weapon p{-webkit-line-clamp:1}.swipe{margin-bottom:4px;font-size:12px}.weapon .em{font-size:24px}.weapon h4{font-size:14px}.weapon p{font-size:11.5px}
 .res{gap:14px}.rtitle{font-size:34px}.rsub{font-size:13px;margin:4px 0 2px}.rstars{font-size:24px;letter-spacing:3px}
 .rlines{margin:6px 0;padding:2px 12px}.rl{padding:4px 0;font-size:13.5px}.rtotal{font-size:17px;margin:4px 0 0}
 .res .pc{margin:0 0 6px}.unl{gap:5px;margin:6px 0}.unl div{padding:6px 10px;font-size:13px}
 .rbtns{gap:8px;padding-top:6px}.rbtns .btn{font-size:14px;padding:9px 12px;border-radius:14px}
}
#rotate{position:fixed;inset:0;z-index:600;display:none;place-items:center;background:var(--bg);color:var(--text);text-align:center;padding:24px}
.rot-in{display:flex;flex-direction:column;align-items:center;gap:10px;max-width:300px}
.rot-in b{font-size:26px}.rot-in span{color:var(--muted);font-size:16px}
.rot-in .phone{font-size:72px;animation:rot 2s ease-in-out infinite}
@keyframes rot{0%,25%{transform:rotate(0)}55%,100%{transform:rotate(-90deg)}}
@media (orientation: portrait) and (pointer: coarse){#rotate{display:grid}}
@media (prefers-reduced-motion: reduce){#banner.show,#count.show,.fi,.badge.pulse{animation-duration:.01s}}
</style>
</head>
<body>
<main id="app">

<section id="s-menu" class="screen active">
  <div class="bar">
    <div class="logo" aria-label="Arena Splash"><span class="l1">Arena</span> <br><span class="l2">Splash</span><small>Duelo de colores contra bots</small></div>
    <div class="grow"></div>
    <button class="icon-btn" id="btnMute" aria-label="Activar o silenciar el sonido">🔊</button>
  </div>
  <div class="hero">
    <div class="card">
      <div class="pc">
        <div class="badge" id="mBadge"><span id="mLevel">1</span></div>
        <div class="pinfo">
          <div class="kicker">Tu nivel de jugador</div>
          <div class="rank" id="mRank">Novato</div>
          <div class="xpbar"><i id="mXp"></i></div>
          <div class="xptxt" id="mXpTxt"></div>
        </div>
      </div>
      <div class="chips">
        <div class="chip"><b id="mPts">0</b><span>puntos totales</span></div>
        <div class="chip"><b id="mStars">0/27</b><span>estrellas</span></div>
        <div class="chip"><b id="mElims">0</b><span>bots fuera</span></div>
        <div class="chip"><b id="mWins">0</b><span>victorias</span></div>
      </div>
      <div class="next" id="mNext"></div>
    </div>
    <div class="menu-btns">
      <button class="btn big primary" id="btnPlay">▶ Jugar</button>
      <button class="btn big blue" id="btnWeapons">🎨 Mis armas</button>
      <button class="btn big" id="btnHow">❓ Cómo jugar</button>
    </div>
  </div>
  <p class="foot">Pintura, burbujas y rayos de luz: los bots no se lastiman, se manchan y salen teletransportados de la arena. Sin sangre. Para jugadores de 9 años en adelante.</p>
</section>

<section id="s-arenas" class="screen">
  <div class="bar"><button class="icon-btn" data-go="menu" aria-label="Volver al menú">←</button><h2>Elige arena y nivel</h2></div>
  <p class="swipe">Desliza hacia los lados para ver las 9 arenas ➜</p>
  <p class="lead">Gana el nivel 1 de una arena para abrir la siguiente. Cada nivel trae más oleadas y bots más rápidos; en el nivel 3 te espera un Mega Bot.</p>
  <div class="grid" id="arenaGrid"></div>
</section>

<section id="s-loadout" class="screen">
  <div class="bar ldbar"><button class="icon-btn" id="ldBack" aria-label="Volver">←</button><h2>Elige tus armas</h2><div class="grow"></div><button class="btn primary" id="ldGo">¡A la arena! ▶</button></div>
  <div class="match-sum" id="ldSum"></div>
  <div class="slots">
    <button class="slot" id="slot0"><span class="sk">Principal (tecla 1)</span><span class="sv"></span></button>
    <button class="slot" id="slot1"><span class="sk">Secundaria (tecla 2)</span><span class="sv"></span></button>
  </div>
  <p class="swipe">Toca una casilla y luego el arma. Desliza hacia los lados para ver todas ➜</p>
  <div class="grid wgrid" id="wGrid"></div>
</section>

<section id="s-results" class="screen">
  <div class="card res"><div class="rcol">
    <div class="rtitle" id="rTitle">¡Victoria!</div>
    <div class="rsub" id="rSub"></div>
    <div class="rstars" id="rStars"></div>
    <div class="rlines" id="rLines"></div>
    <div class="rtotal">Ganaste <span id="rTotal">0</span> puntos</div>
    </div><div class="rcol">
    <div class="pc">
      <div class="badge" id="rBadge"><span id="rLevel">1</span></div>
      <div class="pinfo">
        <div class="rank" id="rRank">Novato</div>
        <div class="xpbar"><i id="rXp"></i></div>
        <div class="xptxt" id="rXpTxt"></div>
      </div>
    </div>
    <div class="unl" id="rUnl"></div>
    <div class="rbtns">
      <button class="btn primary wide" id="rNext">Siguiente nivel ▶</button>
      <button class="btn" id="rRetry">↻ Repetir</button>
      <button class="btn" id="rArenas">🗺️ Arenas</button>
      <button class="btn wide" id="rMenu">Menú principal</button>
    </div>
  </div></div>
</section>
</main>

<div id="game">
  <canvas id="cv"></canvas>
  <div id="scope"></div>
  <div id="splats"></div>
  <div id="hud">
    <div class="hud-top"><span class="pill" id="hScore">0 pts</span><span class="pill" id="hWave">Oleada 1/1</span><span class="pill" id="hBots">🤖 0</span></div>
    <div id="cross"></div><div id="hitm"></div>
    <div id="feed"></div>
    <div id="banner"></div>
    <div id="count"></div>
    <div class="hud-bottom">
      <div class="shield" id="hShieldBox"><span aria-hidden="true">🛡️</span><div class="bar"><i id="hShield"></i></div></div>
      <div class="weap"><div id="hWName"></div><div id="hAmmo"></div><div class="slotsH" id="hSlots"></div></div>
    </div>
    <div id="hint"></div>
  </div>
  <button id="hPause" aria-label="Pausa">⏸</button>
  <div id="touch">
    <div class="joyhint">Arrastra aquí para moverte</div>
    <div id="joyBase"><div id="joyKnob"></div></div>
    <button class="tbtn" id="tFire" aria-label="Disparar">🎯</button>
    <button class="tbtn" id="tJump" aria-label="Saltar">⤒</button>
    <button class="tbtn" id="tSwap" aria-label="Cambiar arma">⇄</button>
    <button class="tbtn" id="tReload" aria-label="Recargar">↻</button>
    <button class="tbtn" id="tZoom" aria-label="Usar la mira">🔍</button>
  </div>
  <div id="pause" class="overlay">
    <div class="panel">
      <h3>Pausa</h3>
      <div class="row"><label for="sens">Sensibilidad</label><input type="range" id="sens" min="0.3" max="2.5" step="0.1"></div>
      <div class="row" id="afRow"><span>Disparo automático al apuntar</span><button class="btn" id="afBtn" style="padding:8px 14px;font-size:16px">Sí</button></div>
      <button class="btn primary" id="pResume">▶ Continuar</button>
      <button class="btn" id="pMute">🔊 Sonido</button>
      <button class="btn" id="pQuit">Salir de la partida</button>
    </div>
  </div>
</div>

<div id="howto" class="modal">
  <div class="panel">
    <h3>Cómo jugar</h3>
    <p style="color:var(--muted);margin:0">Entra a una arena, mancha a todos los bots con pintura, láser o burbujas y gana puntos. Cuando un bot queda lleno de pintura, sale teletransportado entre confeti.</p>
    <h4>En computador</h4>
    <ul>
      <li><b>W A S D</b> o flechas arriba/abajo para moverte, <b>Shift</b> para correr</li>
      <li><b>Mouse</b> para apuntar y <b>clic</b> para disparar</li>
      <li><b>Espacio</b> para saltar sobre cajas y plataformas</li>
      <li><b>1</b>, <b>2</b>, <b>Q</b> o la rueda del mouse para cambiar de arma; <b>R</b> para recargar</li>
      <li>Mantén el <b>clic derecho</b> para usar la mira en las armas con 🔍; la Ballesta de Ventosas tiene mira telescópica</li>
      <li>Sube por las <b>rampas</b> a las torres para disparar desde lo alto</li>
      <li><b>Esc</b> o <b>P</b> para pausar</li>
    </ul>
    <h4>En celular o tablet</h4>
    <ul>
      <li>Arrastra en la mitad izquierda para moverte y en la derecha para mirar</li>
      <li>El botón 🎯 dispara; también disparas solo cuando apuntas a un bot</li>
      <li>El botón 🔍 activa o quita la mira</li>
    </ul>
    <h4>Puntos y niveles</h4>
    <ul>
      <li>Cada bot fuera da puntos; terminar el nivel, tener buena puntería y no mancharte dan bonos</li>
      <li>Hay <b>100 niveles</b> de jugador y 10 armas para desbloquear</li>
      <li>Consigue hasta 3 estrellas por nivel: gana, recibe poca pintura y apunta bien</li>
    </ul>
    <button class="btn primary" id="howClose">¡Entendido!</button>
    <button class="btn" id="btnReset">Borrar mi progreso</button>
  </div>
</div>
<div id="toast" role="status"></div>
<div id="rotate" role="alert"><div class="rot-in"><div class="phone" aria-hidden="true">📱</div><b>Gira tu celular</b><span>Arena Splash se juega en horizontal</span><button class="btn primary" id="rotBtn">Pantalla completa</button></div></div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
<script>
(function(){
'use strict';
const $=s=>document.querySelector(s);
const fmt=n=>Math.round(n).toLocaleString('es-CO');
const hex=n=>n.toString(16).padStart(6,'0');
const clamp=(v,a,b)=>v<a?a:(v>b?b:v);
const pick=a=>a[Math.floor(Math.random()*a.length)];
const isTouch=window.matchMedia?matchMedia('(pointer: coarse)').matches:('ontouchstart' in window);

/* ---------- Guardado ---------- */
const SAVE_KEY='arenaSplash.v1';
const defSave=()=>({xp:0,stars:{},loadout:['paint','laser'],muted:false,sens:1,elims:0,matches:0,wins:0,autoFire:true});
let save=defSave();
try{const raw=localStorage.getItem(SAVE_KEY);if(raw)save=Object.assign(defSave(),JSON.parse(raw));}catch(e){}
function persist(){try{localStorage.setItem(SAVE_KEY,JSON.stringify(save));}catch(e){}}

/* ---------- Niveles ---------- */
const MAX_LEVEL=100;
const xpFor=n=>n<=1?0:Math.round(30*Math.pow(n-1,1.65));
function levelOf(xp){let l=1;while(l<MAX_LEVEL&&xp>=xpFor(l+1))l++;return l;}
function levelProgress(xp){const l=levelOf(xp);if(l>=MAX_LEVEL)return{l,cur:1,have:0,span:0};const a=xpFor(l),b=xpFor(l+1);return{l,cur:(xp-a)/(b-a),have:xp-a,span:b-a};}
const RANKS=[[1,'Novato'],[5,'Aprendiz de pintura'],[12,'Explorador'],[20,'Tirador de colores'],[30,'Experto'],[42,'As de la arena'],[55,'Campeón'],[70,'Maestro del splash'],[85,'Leyenda'],[100,'Leyenda suprema']];
function rankOf(l){let r=RANKS[0][1];for(const[m,n]of RANKS)if(l>=m)r=n;return r;}

/* ---------- Datos ---------- */
const RAINBOW=[0xff5252,0xffab40,0xffeb3b,0x69f0ae,0x40c4ff,0x7c4dff,0xff4081];
const WEAPONS=[
 {id:'paint',name:'Pistola de Paintball',emoji:'🎨',unlock:1,type:'proj',dmg:24,rate:4,mag:12,reload:1.3,speed:62,spread:0.012,pellets:1,size:0.11,color:'rainbow',zoom:50,body:0x7a4dff,desc:'Bolitas de pintura de todos los colores. Precisa y confiable.'},
 {id:'laser',name:'Rayo Láser',emoji:'🔦',unlock:1,type:'beam',dmg:9,rate:10,mag:30,reload:1.6,spread:0.008,pellets:1,color:0x34e7ff,zoom:50,body:0x1e88e5,desc:'Rayo de luz instantáneo que dispara muy rápido.'},
 {id:'confetti',name:'Cañón de Confeti',emoji:'🎉',unlock:4,type:'proj',dmg:10,rate:1.4,mag:4,reload:1.8,speed:55,spread:0.085,pellets:7,size:0.07,color:'rainbow',body:0xff9800,desc:'Lanza una nube de confeti. Es el mejor de cerca.'},
 {id:'bubble',name:'Lanzaburbujas',emoji:'🫧',unlock:8,type:'proj',dmg:32,rate:2.2,mag:8,reload:1.5,speed:20,spread:0.02,pellets:1,size:0.32,color:0xa5f3ff,splash:2.4,body:0x26c6da,desc:'Burbujas lentas que revientan y salpican alrededor.'},
 {id:'suction',name:'Ballesta de Ventosas',emoji:'🎯',unlock:14,type:'beam',dmg:80,rate:0.9,mag:5,reload:2,spread:0,pellets:1,color:0xfff176,zoom:26,scope:true,body:0x8d6e63,desc:'Ventosas de largo alcance con mira telescópica.'},
 {id:'balloon',name:'Globos de Agua',emoji:'🎈',unlock:22,type:'arc',dmg:48,rate:1.2,mag:6,reload:2,speed:24,spread:0.01,pellets:1,size:0.22,color:0x4fc3f7,splash:3.4,gravity:16,body:0x29b6f6,desc:'Caen en arco y empapan una zona grande.'},
 {id:'freeze',name:'Rayo Congelante',emoji:'❄️',unlock:32,type:'beam',dmg:7,rate:12,mag:40,reload:1.7,spread:0.01,pellets:1,color:0xb3e5fc,slow:1.6,zoom:55,body:0x81d4fa,desc:'Rayo helado que vuelve lentos a los bots.'},
 {id:'hose',name:'Hidrolanzadora',emoji:'💦',unlock:45,type:'proj',dmg:7,rate:14,mag:60,reload:1.8,speed:46,spread:0.03,pellets:1,size:0.08,color:0x40c4ff,body:0x0288d1,desc:'Chorro de agua continuo que lo moja todo.'},
 {id:'rainbow',name:'Cañón Arcoíris',emoji:'🌈',unlock:60,type:'proj',dmg:42,rate:2.8,mag:10,reload:1.6,speed:72,spread:0.006,pellets:1,size:0.16,color:'rainbow',pierce:true,zoom:40,body:0xec407a,desc:'Disparo arcoíris que atraviesa a varios bots.'},
 {id:'stars',name:'Lanzaestrellas',emoji:'⭐',unlock:80,type:'proj',dmg:26,rate:2.4,mag:9,reload:1.6,speed:34,spread:0.07,pellets:3,size:0.15,color:0xffd54f,homing:true,body:0xffb300,desc:'Tres estrellas que persiguen a los bots solas.'}
];
const W=id=>WEAPONS.find(w=>w.id===id)||WEAPONS[0];
const ARENAS=[
 {name:'Patio de Juegos',emoji:'🛝',desc:'Torres de colores, toboganes y columpios.',sky:0x9fdcff,fog:0xc8ecff,ground:0x7ccf6a,wall:0xffffff,cover:0xff8a65,theme:'park'},
 {name:'Bosque Mágico',emoji:'🍄',desc:'Árboles altos y hongos gigantes para esconderse.',sky:0xbfe8d0,fog:0xcdeedb,ground:0x4f9d55,wall:0x8d6e63,cover:0xa1887f,theme:'forest'},
 {name:'Playa Tropical',emoji:'🏝️',desc:'Palmeras, sombrillas y castillos de arena.',sky:0x8fd3ff,fog:0xbfe6ff,ground:0xf3d99b,wall:0xffffff,cover:0x4dd0e1,theme:'beach'},
 {name:'Ciudad Neón',emoji:'🌃',desc:'Edificios brillantes en plena noche.',sky:0x1b1340,fog:0x241a52,ground:0x2e2b4a,wall:0x3d3566,cover:0x5c4bb0,theme:'city',night:true},
 {name:'Polo Norte',emoji:'⛄',desc:'Bloques de hielo, iglús y muñecos de nieve.',sky:0xdff3ff,fog:0xeaf7ff,ground:0xf4fbff,wall:0xb3e5fc,cover:0x90caf9,theme:'snow'},
 {name:'Isla Volcán',emoji:'🌋',desc:'Rocas enormes y charcos de gelatina naranja.',sky:0xffb38a,fog:0xffc9a6,ground:0x6d5a52,wall:0x4e342e,cover:0x8d6e63,theme:'volcano'},
 {name:'Estación Espacial',emoji:'🚀',desc:'Poca gravedad: ¡los saltos son enormes!',sky:0x0b0d2a,fog:0x11143a,ground:0x8a93a8,wall:0x5c6680,cover:0xb0bec5,theme:'space',night:true,grav:0.45},
 {name:'Templo Antiguo',emoji:'🏛️',desc:'Columnas, ruinas y una pirámide para escalar.',sky:0xf6e2b8,fog:0xf8e9c8,ground:0xd2b07a,wall:0xb08d57,cover:0xc8a96e,theme:'temple'},
 {name:'Castillo de Caramelo',emoji:'🍭',desc:'Chupetes, bastones de dulce y chocolate.',sky:0xffd6ec,fog:0xffe3f2,ground:0xffb3d9,wall:0xffffff,cover:0x8d5a3b,theme:'candy'}
];
const LVL_NAMES=['Fácil','Medio','Difícil'];
const BOT_COLORS=[0xff6b6b,0xffa53d,0xffd93d,0x5ddc6b,0x3dc5ff,0x8b6dff,0xff6ddf,0x2ee6c5];
const BOT_NAMES=['Chispa','Tornillo','Pixel','Burbuja','Turbo','Zumbi','Bip-Bop','Rayito','Tuerca','Gizmo','Cometa','Dínamo','Nano','Voltio','Kiwi','Mango','Robi','Tito'];

function isUnlocked(a,l){if(a===0&&l===0)return true;if(l>0)return(save.stars[a+'-'+(l-1)]||0)>0;return(save.stars[(a-1)+'-0']||0)>0;}
function starsTotal(){return Object.values(save.stars).reduce((s,v)=>s+v,0);}
// Verifica que el equipo guardado sea válido
(function(){const lvl=levelOf(save.xp);save.loadout=save.loadout.map((id,i)=>{const w=WEAPONS.find(x=>x.id===id);return w&&w.unlock<=lvl?id:(i===0?'paint':'laser');});if(save.loadout[0]===save.loadout[1])save.loadout=['paint','laser'];})();

/* ---------- Sonido ---------- */
const Sound=(()=>{
 let ctx=null,master=null,nb=null;
 function c(){if(save.muted)return null;if(!ctx){try{ctx=new(window.AudioContext||window.webkitAudioContext)();master=ctx.createGain();master.gain.value=0.5;master.connect(ctx.destination);}catch(e){return null;}}if(ctx.state==='suspended')ctx.resume();return ctx;}
 function tone(f,dur,type,vol,f2,delay){const a=c();if(!a)return;const t=a.currentTime+(delay||0);const o=a.createOscillator(),g=a.createGain();o.type=type||'square';o.frequency.setValueAtTime(f,t);if(f2)o.frequency.exponentialRampToValueAtTime(Math.max(20,f2),t+dur);g.gain.setValueAtTime(vol||0.1,t);g.gain.exponentialRampToValueAtTime(0.0001,t+dur);o.connect(g);g.connect(master);o.start(t);o.stop(t+dur+0.02);}
 function noise(dur,vol,freq,delay){const a=c();if(!a)return;if(!nb){nb=a.createBuffer(1,a.sampleRate*0.5,a.sampleRate);const d=nb.getChannelData(0);for(let i=0;i<d.length;i++)d[i]=Math.random()*2-1;}const t=a.currentTime+(delay||0);const s=a.createBufferSource();s.buffer=nb;const f=a.createBiquadFilter();f.type='bandpass';f.frequency.value=freq||1200;f.Q.value=0.8;const g=a.createGain();g.gain.setValueAtTime(vol||0.2,t);g.gain.exponentialRampToValueAtTime(0.0001,t+dur);s.connect(f);f.connect(g);g.connect(master);s.start(t);s.stop(t+dur+0.02);}
 return{
  shoot(id){switch(id){case'laser':tone(1400,0.08,'sawtooth',0.035,500);break;case'freeze':tone(2200,0.06,'triangle',0.03,1600);break;case'suction':tone(300,0.15,'square',0.06,120);noise(0.08,0.1,800);break;case'bubble':tone(500,0.12,'sine',0.09,900);break;case'balloon':tone(260,0.18,'sine',0.09,420);break;case'confetti':noise(0.18,0.25,1800);tone(180,0.1,'square',0.05,90);break;case'hose':noise(0.05,0.07,2500);break;case'stars':tone(900,0.12,'triangle',0.05,1600);tone(1200,0.1,'triangle',0.03,1800,0.04);break;case'rainbow':tone(600,0.16,'sawtooth',0.04,1500);break;default:noise(0.07,0.18,1500);tone(220,0.07,'square',0.04,110);}},
  botShoot(v){noise(0.06,0.06*v,1000);},
  hit(){tone(1600,0.05,'square',0.045,2200);},
  head(){tone(1800,0.06,'square',0.05,2600);tone(2400,0.08,'square',0.04,3000,0.04);},
  pop(){tone(500,0.08,'square',0.07,1200);tone(800,0.12,'triangle',0.06,1800,0.05);noise(0.15,0.15,3000,0.02);},
  splat(){noise(0.1,0.12,600);},
  hurt(){noise(0.15,0.22,500);tone(200,0.12,'sine',0.06,120);},
  click(){tone(700,0.04,'square',0.035,900);},
  go(){tone(523,0.12,'square',0.06);tone(784,0.22,'square',0.06,null,0.1);},
  tick(){tone(440,0.09,'square',0.05);},
  win(){[523,659,784,1046].forEach((f,i)=>tone(f,0.18,'square',0.06,null,i*0.12));},
  lose(){[392,330,262].forEach((f,i)=>tone(f,0.22,'triangle',0.07,null,i*0.16));},
  level(){[659,784,988,1318].forEach((f,i)=>tone(f,0.14,'triangle',0.07,null,i*0.08));},
  reload(){tone(300,0.05,'square',0.03,500);tone(500,0.05,'square',0.03,700,0.12);},
  wave(){tone(392,0.12,'triangle',0.06);tone(523,0.18,'triangle',0.06,null,0.12);},
  jump(){tone(300,0.1,'sine',0.04,600);}
 };
})();

/* ---------- Interfaz ---------- */
let sel={arena:0,level:0};
function show(name){document.querySelectorAll('.screen').forEach(s=>s.classList.remove('active'));const sc=$('#s-'+name);sc.classList.add('active');sc.scrollTop=0;sc.querySelectorAll('.grid').forEach(g=>g.scrollLeft=0);if(name==='menu')renderMenu();if(name==='arenas')renderArenas();}
let toastT=0;
function toast(msg){const t=$('#toast');t.textContent=msg;t.classList.add('show');clearTimeout(toastT);toastT=setTimeout(()=>t.classList.remove('show'),2600);}
function renderMenu(){
 const pr=levelProgress(save.xp);
 $('#mLevel').textContent=pr.l;$('#mRank').textContent=rankOf(pr.l);
 $('#mXp').style.width=(pr.cur*100)+'%';
 $('#mXpTxt').textContent=pr.l>=MAX_LEVEL?'¡Llegaste al nivel máximo!':`${fmt(pr.have)} de ${fmt(pr.span)} puntos para el nivel ${pr.l+1}`;
 $('#mPts').textContent=fmt(save.xp);$('#mStars').textContent=starsTotal()+'/27';
 $('#mElims').textContent=fmt(save.elims);$('#mWins').textContent=fmt(save.wins);
 const nw=WEAPONS.find(w=>w.unlock>pr.l);
 $('#mNext').textContent=nw?`Próxima arma: ${nw.emoji} ${nw.name}, en el nivel ${nw.unlock}.`:'Ya tienes todas las armas desbloqueadas.';
 $('#btnMute').textContent=save.muted?'🔇':'🔊';
}

function arenaArt(i){
 let sd=i*977+13;const r=()=>{sd=(sd*9301+49297)%233280;return sd/233280;};const id='aa'+i;
 const sky=(a,b)=>`<defs><linearGradient id="${id}" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="${a}"/><stop offset="1" stop-color="${b}"/></linearGradient></defs><rect width="320" height="140" fill="url(#${id})"/>`;
 const stars=(n,h,c)=>{let o='';for(let k=0;k<n;k++)o+=`<circle cx="${(r()*320).toFixed(1)}" cy="${(r()*h).toFixed(1)}" r="${(0.6+r()*1.3).toFixed(1)}" fill="${c||'#fff'}" opacity="${(0.5+r()*0.5).toFixed(2)}"/>`;return o;};
 const cloud=(x,y,sc,c)=>`<g fill="${c||'#fff'}" opacity=".95" transform="translate(${x} ${y}) scale(${sc})"><ellipse rx="22" ry="10"/><ellipse cx="15" cy="-7" rx="14" ry="11"/><ellipse cx="-13" cy="-4" rx="11" ry="8"/></g>`;
 const tri=(x,y,w,h,c)=>`<polygon points="${x-w/2},${y} ${x},${y-h} ${x+w/2},${y}" fill="${c}"/>`;
 let s='';
 switch(i){
 case 0:{let rays='';for(let k=0;k<8;k++){const a=k*Math.PI/4;rays+=`<line x1="${270+Math.cos(a)*24}" y1="${32+Math.sin(a)*24}" x2="${270+Math.cos(a)*32}" y2="${32+Math.sin(a)*32}"/>`;}
  s=sky('#5cc2ff','#c8ecff')+`<circle cx="270" cy="32" r="18" fill="#ffd93d"/><g stroke="#ffd93d" stroke-width="3" stroke-linecap="round">${rays}</g>`+cloud(70,28,1)+cloud(175,20,0.75)
  +`<ellipse cx="70" cy="150" rx="170" ry="56" fill="#8bd97a"/><ellipse cx="270" cy="158" rx="150" ry="52" fill="#6fc35e"/>`
  +`<rect x="36" y="74" width="40" height="26" rx="4" fill="#ff6b6b"/><rect x="42" y="52" width="28" height="22" rx="4" fill="#ffd93d"/><rect x="47" y="34" width="18" height="18" rx="4" fill="#4fc3f7"/><rect x="88" y="84" width="22" height="18" rx="4" fill="#8b6dff"/>`
  +`<rect x="196" y="58" width="26" height="46" rx="3" fill="#4fc3f7"/><path d="M222 58 Q250 66 266 104 L280 104 Q262 60 222 50Z" fill="#ffd93d"/><g stroke="#ff6b6b" stroke-width="3"><line x1="200" y1="66" x2="218" y2="66"/><line x1="200" y1="78" x2="218" y2="78"/><line x1="200" y1="90" x2="218" y2="90"/></g>`
  +`<circle cx="140" cy="104" r="12" fill="#ff9f43"/><circle cx="162" cy="110" r="8" fill="#5ddc6b"/><path d="M128 100 q12 -8 24 0" stroke="#fff" stroke-width="2" fill="none" opacity=".6"/>`;break;}
 case 1:{s=sky('#8fd9b5','#e3f7ea')+`<circle cx="60" cy="32" r="20" fill="#fff6c2"/>`;
  for(let k=0;k<13;k++)s+=tri(k*26+8,104,30,40+r()*26,'#5aa864');
  s+=`<rect y="100" width="320" height="40" fill="#4f9d55"/>`+tri(28,128,54,92,'#2e7d32')+tri(28,96,40,60,'#3d8f41')+tri(296,128,58,96,'#2e7d32')+tri(296,94,42,60,'#3d8f41');
  s+=`<rect x="144" y="96" width="14" height="22" rx="5" fill="#fff3e0"/><path d="M122 100 Q151 58 180 100Z" fill="#ff5252"/><circle cx="140" cy="88" r="4" fill="#fff"/><circle cx="156" cy="80" r="5" fill="#fff"/><circle cx="168" cy="92" r="3.5" fill="#fff"/>`;
  s+=`<rect x="213" y="104" width="10" height="16" rx="4" fill="#fff3e0"/><path d="M200 107 Q218 82 236 107Z" fill="#ab47bc"/><circle cx="214" cy="98" r="3" fill="#fff"/><circle cx="224" cy="101" r="2.5" fill="#fff"/>`;
  s+=stars(10,95,'#fff59d');break;}
 case 2:{let wv='';for(let y=84;y<104;y+=7){let d=`M0 ${y}`;for(let x=0;x<320;x+=20)d+=` q5 -3 10 0 t10 0`;wv+=`<path d="${d}" stroke="#b3e5fc" stroke-width="1.5" fill="none" opacity=".8"/>`;}
  s=sky('#4cbcff','#bfe9ff')+`<circle cx="255" cy="34" r="20" fill="#ffe066"/>`+cloud(90,30,0.9)+cloud(190,18,0.6)+`<rect y="76" width="320" height="34" fill="#29b6f6"/>`+wv+`<path d="M0 102 Q160 88 320 102 V140 H0Z" fill="#f3d99b"/>`;
  s+=`<path d="M64 128 Q56 94 74 58" stroke="#8d6e63" stroke-width="8" fill="none" stroke-linecap="round"/>`;
  for(let k=0;k<6;k++)s+=`<ellipse cx="74" cy="58" rx="26" ry="7" fill="${k%2?'#2e9d4a':'#43b05c'}" transform="rotate(${k*60-10} 74 58) translate(20 0)"/>`;
  s+=`<circle cx="70" cy="62" r="4" fill="#5d4037"/><circle cx="78" cy="63" r="4" fill="#5d4037"/>`;
  s+=`<line x1="196" y1="96" x2="196" y2="124" stroke="#fff" stroke-width="3"/><path d="M166 98 Q196 66 226 98Z" fill="#ff5252"/><path d="M186 98 Q196 70 206 98Z" fill="#fff"/>`;
  s+=`<rect x="250" y="104" width="44" height="18" fill="#e6c27a"/><rect x="250" y="92" width="12" height="14" fill="#e6c27a"/><rect x="282" y="92" width="12" height="14" fill="#e6c27a"/><polygon points="256,86 256,78 266,82" fill="#ff5252"/><rect x="268" y="112" width="8" height="10" fill="#c9a463"/>`;break;}
 case 3:{s=sky('#0f0a30','#3a2370')+stars(45,80)+`<circle cx="268" cy="28" r="14" fill="#fff4c4"/><circle cx="275" cy="23" r="12" fill="#150e3c"/>`;
  let x=-4;while(x<320){const w=18+r()*16,h=50+r()*40;s+=`<rect x="${x}" y="${120-h}" width="${w}" height="${h}" fill="#2a2155"/>`;x+=w+2;}
  x=4;const wc=['#ffe082','#80deea','#f48fb1','#b39ddb'];
  while(x<320){const w=26+r()*22,h=30+r()*55;s+=`<rect x="${x}" y="${122-h}" width="${w}" height="${h}" fill="#1c1838"/>`;
   for(let yy=122-h+6;yy<116;yy+=10)for(let xx=x+4;xx<x+w-6;xx+=8)if(r()<0.6)s+=`<rect x="${xx.toFixed(1)}" y="${yy.toFixed(1)}" width="4" height="5" fill="${wc[Math.floor(r()*4)]}"/>`;
   s+=`<rect x="${x}" y="${122-h}" width="${w}" height="2" fill="${['#ff4fd8','#34e7ff','#ffe14d'][Math.floor(r()*3)]}"/>`;x+=w+6;}
  s+=`<rect y="122" width="320" height="18" fill="#2e2b4a"/><rect y="121" width="320" height="2" fill="#ff4fd8"/>`;break;}
 case 4:{s=sky('#a9dcff','#f2faff')+tri(80,100,180,72,'#cfe8f7')+tri(80,48,46,20,'#fff')+tri(240,100,200,86,'#b9dcf2')+tri(240,34,50,20,'#fff')+`<rect y="98" width="320" height="42" fill="#f4fbff"/>`;
  s+=`<path d="M30 116 A32 32 0 0 1 94 116Z" fill="#fff" stroke="#b3e5fc" stroke-width="2"/><path d="M52 116 A10 10 0 0 1 72 116Z" fill="#455a64"/><path d="M38 104 H86 M44 94 H80" stroke="#b3e5fc" stroke-width="1.5"/>`;
  s+=`<circle cx="236" cy="112" r="14" fill="#fff" stroke="#cfe8f7"/><circle cx="236" cy="90" r="10" fill="#fff" stroke="#cfe8f7"/><circle cx="236" cy="74" r="7" fill="#fff" stroke="#cfe8f7"/><polygon points="236,74 248,76 236,78" fill="#ff8f00"/><rect x="229" y="62" width="14" height="6" fill="#263238"/><rect x="226" y="82" width="20" height="4" fill="#e53935"/>`;
  s+=tri(150,112,22,34,'#2e7d32')+tri(150,90,14,12,'#fff')+tri(290,114,24,38,'#2e7d32')+tri(290,88,16,12,'#fff')+stars(30,96,'#ffffff');break;}
 case 5:{s=sky('#ff7a4d','#ffd3a8')+`<circle cx="60" cy="30" r="15" fill="#ffe0b2" opacity=".8"/>`;
  s+=`<circle cx="160" cy="26" r="12" fill="#9e9e9e" opacity=".6"/><circle cx="174" cy="14" r="15" fill="#9e9e9e" opacity=".5"/><circle cx="192" cy="6" r="17" fill="#9e9e9e" opacity=".4"/>`;
  s+=`<path d="M80 112 L148 40 L180 40 L250 112Z" fill="#5d4037"/><path d="M164 40 L180 40 L250 112 L214 112Z" fill="#4e342e"/><ellipse cx="164" cy="40" rx="16" ry="4" fill="#ff7043"/><path d="M158 42 Q150 74 132 112 L146 112 Q160 76 168 42Z" fill="#ffab40"/>`;
  s+=`<rect y="108" width="320" height="32" fill="#6d5a52"/><polygon points="20,124 34,104 52,110 58,126" fill="#4e342e"/><polygon points="270,126 284,100 304,108 312,126" fill="#5d4037"/><ellipse cx="110" cy="126" rx="22" ry="5" fill="#ff7043"/><ellipse cx="110" cy="126" rx="11" ry="2.5" fill="#ffca28"/><ellipse cx="220" cy="130" rx="18" ry="4" fill="#ff7043"/>`;break;}
 case 6:{s=sky('#05061c','#1b1f4f')+stars(70,120)+`<circle cx="250" cy="44" r="24" fill="#7e57c2"/><path d="M226 44 Q250 60 274 44" fill="#673ab7"/><ellipse cx="250" cy="46" rx="40" ry="8" fill="none" stroke="#d1c4e9" stroke-width="3" transform="rotate(-14 250 46)"/><circle cx="70" cy="26" r="9" fill="#cfd8dc"/>`;
  s+=`<path d="M0 112 Q80 102 160 112 T320 108 V140 H0Z" fill="#8a93a8"/><ellipse cx="120" cy="124" rx="12" ry="3" fill="#6f7891"/><ellipse cx="270" cy="128" rx="16" ry="4" fill="#6f7891"/>`;
  s+=`<path d="M30 114 A30 30 0 0 1 90 114Z" fill="#80deea" opacity=".6"/><rect x="28" y="112" width="64" height="6" fill="#78909c"/>`;
  s+=`<rect x="172" y="58" width="20" height="46" rx="8" fill="#eceff1"/><polygon points="172,62 182,40 192,62" fill="#ff4f8b"/><circle cx="182" cy="74" r="5" fill="#40c4ff" stroke="#90a4ae" stroke-width="2"/><polygon points="172,92 162,108 172,104" fill="#ff4f8b"/><polygon points="192,92 202,108 192,104" fill="#ff4f8b"/><polygon points="176,104 182,124 188,104" fill="#ffab40"/>`;break;}
 case 7:{s=sky('#ffcf6e','#fff1d0')+`<circle cx="70" cy="34" r="20" fill="#fff8e1"/>`+tri(240,110,180,82,'#d7b679')+`<polygon points="240,28 330,110 240,110" fill="#c9a463"/>`;
  s+=`<rect y="108" width="320" height="32" fill="#d2b07a"/><rect x="24" y="100" width="130" height="10" fill="#b08d57"/><polygon points="20,58 89,36 158,58" fill="#c9a463"/><rect x="22" y="56" width="134" height="7" fill="#b08d57"/>`;
  for(let k=0;k<5;k++){const cx=34+k*27;s+=`<rect x="${cx}" y="63" width="12" height="37" fill="#e8d3a2"/><rect x="${cx-3}" y="62" width="18" height="4" fill="#d7c08a"/>`;}
  s+=`<rect x="190" y="88" width="14" height="22" fill="#e8d3a2"/><rect x="212" y="106" width="24" height="9" rx="4" fill="#e8d3a2" transform="rotate(8 224 110)"/><circle cx="240" cy="22" r="4" fill="#ffd54f"/>`;break;}
 case 8:{s=sky('#ff8fca','#ffe3f2')+cloud(60,26,0.9,'#fff0f7')+cloud(260,20,0.7,'#fff0f7')+`<path d="M0 108 Q160 96 320 108 V140 H0Z" fill="#ffb3d9"/>`;
  s+=`<rect x="120" y="58" width="80" height="54" fill="#f8bbd0"/><rect x="108" y="44" width="22" height="68" fill="#f48fb1"/><rect x="190" y="44" width="22" height="68" fill="#f48fb1"/><polygon points="104,46 119,18 134,46" fill="#ba68c8"/><polygon points="186,46 201,18 216,46" fill="#ba68c8"/><path d="M150 112 V92 A10 10 0 0 1 170 92 V112Z" fill="#8d5a3b"/><rect x="120" y="54" width="80" height="6" fill="#fff"/>`;
  s+=`<line x1="50" y1="80" x2="50" y2="122" stroke="#fff" stroke-width="3"/><circle cx="50" cy="72" r="16" fill="#7c4dff"/><path d="M50 72 m-10 0 a10 10 0 1 1 10 10 a6 6 0 1 1 -6 -6" stroke="#fff" stroke-width="2.5" fill="none"/>`;
  s+=`<line x1="270" y1="84" x2="270" y2="124" stroke="#fff" stroke-width="3"/><circle cx="270" cy="76" r="13" fill="#00e5ff"/><path d="M270 76 m-8 0 a8 8 0 1 1 8 8" stroke="#fff" stroke-width="2.5" fill="none"/>`;
  s+=`<path d="M232 124 V92 A8 8 0 0 1 248 92" stroke="#e53935" stroke-width="6" fill="none" stroke-linecap="round"/><path d="M232 124 V92 A8 8 0 0 1 248 92" stroke="#fff" stroke-width="6" fill="none" stroke-dasharray="4 5"/>`;
  s+=`<path d="M84 126 A10 10 0 0 1 104 126Z" fill="#76ff03"/><path d="M98 128 A9 9 0 0 1 116 128Z" fill="#ffea00"/>`;break;}
 }
 return `<svg viewBox="0 0 320 140" preserveAspectRatio="xMidYMid slice" aria-hidden="true">${s}</svg>`;
}
function renderArenas(){
 const g=$('#arenaGrid');g.innerHTML='';
 ARENAS.forEach((A,ai)=>{
  const un=isUnlocked(ai,0);
  const card=document.createElement('div');card.className='arena'+(un?'':' locked');
  card.innerHTML=`<div class="ban">${arenaArt(ai)}<span class="num">${ai+1}</span>${un?'':'<span class="lockic">🔒</span>'}</div><div class="body"><h3>${A.emoji} ${A.name}</h3><p>${A.desc}</p><div class="lvls"></div>${un?'':`<div class="lockmsg">Gana el nivel 1 de ${ARENAS[ai-1].name} para abrirla.</div>`}</div>`;
  const lv=card.querySelector('.lvls');
  for(let l=0;l<3;l++){
   const b=document.createElement('button');b.className='lvl';const ok=isUnlocked(ai,l);b.disabled=!ok;
   const s=save.stars[ai+'-'+l]||0;
   b.innerHTML=`<span>Nivel ${l+1}</span><small>${LVL_NAMES[l]}</small><span class="st">${ok?`${'★'.repeat(s)}<em>${'★'.repeat(3-s)}</em>`:'🔒'}</span>`;
   b.setAttribute('aria-label',`${A.name}, nivel ${l+1}, ${LVL_NAMES[l]}${ok?'':', bloqueado'}`);
   b.onclick=()=>{Sound.click();sel={arena:ai,level:l};openLoadout(true);};
   lv.appendChild(b);
  }
  g.appendChild(card);
 });
}
let loadMode=false,activeSlot=0;
function openLoadout(forMatch){loadMode=forMatch;activeSlot=0;renderLoadout();show('loadout');}
function renderLoadout(){
 const lvl=levelOf(save.xp);
 [0,1].forEach(i=>{const w=W(save.loadout[i]);const el=$('#slot'+i);el.classList.toggle('active',activeSlot===i);el.querySelector('.sv').textContent=w.emoji+' '+w.name;});
 const sum=$('#ldSum');
 if(loadMode){const A=ARENAS[sel.arena];sum.textContent=`${A.emoji} ${A.name}: nivel ${sel.level+1} (${LVL_NAMES[sel.level]}), ${sel.level+1} ${sel.level?'oleadas':'oleada'}${sel.level===2?' y un Mega Bot':''}`;sum.classList.add('show');$('#ldGo').textContent='¡A la arena! ▶';}
 else{sum.classList.remove('show');$('#ldGo').textContent='Guardar armas ✓';}
 const g=$('#wGrid');g.innerHTML='';
 WEAPONS.forEach(w=>{
  const locked=w.unlock>lvl;const si=save.loadout.indexOf(w.id);
  const b=document.createElement('button');b.className='weapon'+(locked?' locked':'')+(si>=0?' s'+si:'');
  const dmg=Math.min(1,(w.dmg*w.pellets*(w.splash?1.3:1))/85),rate=Math.min(1,w.rate/14),rng=w.type==='beam'?1:(w.type==='arc'?0.45:Math.min(1,w.speed/72));
  b.innerHTML=`${locked?`<span class="tag">🔒 Nv. ${w.unlock}</span>`:(si>=0?`<span class="tag t${si}" title="${si===0?'Principal':'Secundaria'}">${si===0?'Principal':'Secundaria'}</span>`:'')}<span class="em">${w.emoji}</span><div class="wt"><h4>${w.name}${w.zoom?' 🔍':''}</h4><p>${w.desc}</p></div>
  <div class="stats"><div class="stat"><span>Fuerza</span><b><i style="width:${Math.round(dmg*100)}%"></i></b></div>
  <div class="stat"><span>Rapidez</span><b><i style="width:${Math.round(rate*100)}%"></i></b></div>
  <div class="stat"><span>Alcance</span><b><i style="width:${Math.round(rng*100)}%"></i></b></div></div>`;
  b.onclick=()=>{
   if(locked){toast(`${w.emoji} ${w.name} se desbloquea en el nivel ${w.unlock}.`);return;}
   Sound.click();const other=1-activeSlot;
   if(save.loadout[other]===w.id)save.loadout[other]=save.loadout[activeSlot];
   save.loadout[activeSlot]=w.id;activeSlot=other;persist();renderLoadout();
  };
  g.appendChild(b);
 });
}
$('#slot0').onclick=()=>{activeSlot=0;renderLoadout();};
$('#slot1').onclick=()=>{activeSlot=1;renderLoadout();};
$('#ldBack').onclick=()=>show(loadMode?'arenas':'menu');
$('#ldGo').onclick=()=>{if(loadMode)startMatch(sel.arena,sel.level);else{toast('Armas guardadas.');show('menu');}};
$('#btnPlay').onclick=()=>{tryLandscape();Sound.click();show('arenas');};
$('#btnWeapons').onclick=()=>{Sound.click();openLoadout(false);};
$('#btnHow').onclick=()=>{$('#howto').classList.add('show');};
$('#howClose').onclick=()=>$('#howto').classList.remove('show');
$('#howto').addEventListener('click',e=>{if(e.target.id==='howto')$('#howto').classList.remove('show');});
let resetArm=false;
$('#btnReset').onclick=()=>{if(!resetArm){resetArm=true;$('#btnReset').textContent='Toca otra vez para borrar todo';setTimeout(()=>{resetArm=false;$('#btnReset').textContent='Borrar mi progreso';},3500);return;}save=defSave();persist();resetArm=false;$('#btnReset').textContent='Borrar mi progreso';$('#howto').classList.remove('show');toast('Progreso borrado. ¡A empezar de nuevo!');show('menu');};
function toggleMute(){save.muted=!save.muted;persist();$('#btnMute').textContent=save.muted?'🔇':'🔊';$('#pMute').textContent=save.muted?'🔇 Sonido apagado':'🔊 Sonido encendido';}
$('#btnMute').onclick=toggleMute;
document.querySelectorAll('[data-go]').forEach(b=>b.onclick=()=>show(b.dataset.go));

/* ---------- Motor 3D ---------- */
const V3=THREE.Vector3;const UP=new V3(0,1,0);const H=32;
const canvas=$('#cv'),gameEl=$('#game');
let renderer=null,scene=null,camera=null,vmScene=null,vmRoot=null,vm=null,vmTip=null;
let G=null,locked=false,noLockMode=false,lockWorked=false;
const mouse={x:0,y:0};
let matCache={};const GEO={};
function M(color,opt){const k='L'+color+(opt?JSON.stringify(opt):'');let m=matCache[k];if(!m){m=new THREE.MeshLambertMaterial(Object.assign({color},opt||{}));matCache[k]=m;}return m;}
function MB(color,opt){const k='B'+color+(opt?JSON.stringify(opt):'');let m=matCache[k];if(!m){m=new THREE.MeshBasicMaterial(Object.assign({color},opt||{}));matCache[k]=m;}return m;}
function shade(color,f){const c=new THREE.Color(color);c.r=Math.min(1,c.r*f);c.g=Math.min(1,c.g*f);c.b=Math.min(1,c.b*f);return c.getHex();}
function sharedGeos(){if(GEO.box)return;GEO.box=new THREE.BoxGeometry(1,1,1);GEO.sphere=new THREE.SphereGeometry(1,12,9);GEO.oct=new THREE.OctahedronGeometry(1,0);GEO.circle=new THREE.CircleGeometry(1,16);GEO.cyl=new THREE.CylinderGeometry(1,1,1,8);GEO.ring=new THREE.RingGeometry(0.85,1,28);for(const k in GEO)GEO[k].userData.shared=true;}
function initRenderer(){
 if(renderer)return true;
 try{renderer=new THREE.WebGLRenderer({canvas,antialias:!isTouch,powerPreference:'high-performance'});}catch(e){toast('Este navegador no puede mostrar gráficos 3D (WebGL).');return false;}
 renderer.setPixelRatio(Math.min(window.devicePixelRatio||1,isTouch?1.5:1.75));
 camera=new THREE.PerspectiveCamera(75,1,0.05,420);camera.rotation.order='YXZ';
 vmScene=new THREE.Scene();vmRoot=new THREE.Group();vmScene.add(vmRoot);
 vmScene.add(new THREE.HemisphereLight(0xffffff,0x666688,1.0));const dl=new THREE.DirectionalLight(0xffffff,0.6);dl.position.set(1,2,1);vmScene.add(dl);
 sharedGeos();
 window.addEventListener('resize',onResize);onResize();
 requestAnimationFrame(loop);
 return true;
}
function onResize(){if(!renderer)return;const w=window.innerWidth,h=window.innerHeight;renderer.setSize(w,h,false);camera.aspect=w/h;camera.updateProjectionMatrix();}
function disposeScene(){
 if(!scene)return;
 scene.traverse(o=>{if(o.geometry&&!o.geometry.userData.shared)o.geometry.dispose();if(o.material){const ms=Array.isArray(o.material)?o.material:[o.material];ms.forEach(m=>{if(m.map)m.map.dispose();m.dispose();});}});
 for(const k in matCache)matCache[k].dispose();matCache={};scene=null;
}
function mulberry(a){return function(){a|=0;a=a+0x6D2B79F5|0;let t=Math.imul(a^a>>>15,1|a);t=t+Math.imul(t^t>>>7,61|t)^t;return((t^t>>>14)>>>0)/4294967296;};}

/* Construcción del mundo */
function addCol(x,y,z,w,h,d){G.boxes.push({minX:x-w/2,maxX:x+w/2,minY:y,maxY:y+h,minZ:z-d/2,maxZ:z+d/2});}
function addMesh(geo,mat,x,y,z){const m=new THREE.Mesh(geo,mat);m.position.set(x,y,z);scene.add(m);return m;}
function rampH(q,x,z){return clamp((x-q.x0)*q.dx+(z-q.z0)*q.dz,0,q.L)*q.k;}
function addRamp(x0,z0,dx,dz,L,w,h,mat){
 const sh=new THREE.Shape();sh.moveTo(0,0);sh.lineTo(L,0);sh.lineTo(L,h);sh.lineTo(0,0);
 const geo=new THREE.ExtrudeGeometry(sh,{depth:w,bevelEnabled:false});geo.translate(0,0,-w/2);
 const m=addMesh(geo,mat,x0,0,z0);m.rotation.y=Math.atan2(-dz,dx);
 const k=h/L,cx=x0+dx*L/2,cz=z0+dz*L/2,hx=Math.abs(dx)*L/2+Math.abs(dz)*w/2,hz=Math.abs(dz)*L/2+Math.abs(dx)*w/2;
 G.ramps.push({ramp:true,x0,z0,dx,dz,L,w,h,k,minX:cx-hx,maxX:cx+hx,minZ:cz-hz,maxZ:cz+hz,n:new V3(-k*dx,1,-k*dz).normalize()});
}
function addBox(x,y,z,w,h,d,mat,collide){const m=addMesh(GEO.box,mat,x,y+h/2,z);m.scale.set(w,h,d);if(collide!==false)addCol(x,y,z,w,h,d);return m;}
function makeGroundTex(A){
 const c=document.createElement('canvas');c.width=c.height=128;const x=c.getContext('2d');
 const base=new THREE.Color(A.ground);x.fillStyle='#'+base.getHexString();x.fillRect(0,0,128,128);
 if(A.theme==='space'||A.theme==='city'){x.strokeStyle=A.theme==='city'?'rgba(150,120,255,.5)':'rgba(255,255,255,.3)';x.lineWidth=3;x.strokeRect(1.5,1.5,125,125);x.lineWidth=1;x.beginPath();x.moveTo(64,0);x.lineTo(64,128);x.moveTo(0,64);x.lineTo(128,64);x.stroke();}
 else{x.fillStyle='#'+new THREE.Color(shade(A.ground,0.93)).getHexString();x.fillRect(0,0,64,64);x.fillRect(64,64,64,64);
  for(let i=0;i<140;i++){x.fillStyle=Math.random()<0.5?'rgba(0,0,0,.06)':'rgba(255,255,255,.1)';x.fillRect(Math.random()*128,Math.random()*128,2,2);}}
 const t=new THREE.CanvasTexture(c);t.wrapS=t.wrapT=THREE.RepeatWrapping;t.repeat.set(40,40);t.anisotropy=Math.min(8,renderer.capabilities.getMaxAnisotropy());return t;
}
function clouds(rng,n){const m=MB(0xffffff,{fog:false});for(let i=0;i<n;i++){const a=rng()*Math.PI*2,r=80+rng()*70,y=32+rng()*25;const cx=Math.cos(a)*r,cz=Math.sin(a)*r;for(let k=0;k<4;k++){const s=addMesh(GEO.sphere,m,cx+(k-1.5)*5+rng()*2,y+rng()*2,cz+rng()*3);s.scale.set(5+rng()*3,3+rng()*1.5,4+rng()*2);}}}
function starsSky(rng,n){const pos=new Float32Array(n*3);for(let i=0;i<n;i++){const th=rng()*Math.PI*2,ph=Math.acos(rng()*0.95);const r=200;pos[i*3]=Math.sin(ph)*Math.cos(th)*r;pos[i*3+1]=Math.cos(ph)*r*0.8+8;pos[i*3+2]=Math.sin(ph)*Math.sin(th)*r;}const g=new THREE.BufferGeometry();g.setAttribute('position',new THREE.BufferAttribute(pos,3));scene.add(new THREE.Points(g,new THREE.PointsMaterial({color:0xffffff,size:2,sizeAttenuation:false,fog:false})));}
function tree(x,z,s,col,noCol){addMesh(new THREE.CylinderGeometry(0.25*s,0.35*s,2.2*s,7),M(0x6d4c41),x,1.1*s,z);addMesh(new THREE.ConeGeometry(1.6*s,2.6*s,8),M(col),x,2.9*s,z);addMesh(new THREE.ConeGeometry(1.15*s,2*s,8),M(shade(col,1.18)),x,4.2*s,z);if(!noCol)addCol(x,0,z,0.8*s,5*s,0.8*s);}
function windowCanvas(rng){const c=document.createElement('canvas');c.width=c.height=64;const x=c.getContext('2d');x.fillStyle='#1c1838';x.fillRect(0,0,64,64);const cols=['#ffe082','#80deea','#f48fb1','#b39ddb'];for(let i=0;i<2;i++)for(let j=0;j<2;j++){x.fillStyle=rng()<0.7?cols[Math.floor(rng()*4)]:'#2c2752';x.fillRect(i*32+8,j*32+8,16,18);}return c;}
const THEMES={
 park(rng,spot){
  const pal=[0xff6b6b,0xffd93d,0x4fc3f7,0x8b6dff,0x5ddc6b,0xff9f43];
  for(let i=0;i<7;i++){const s=spot(1.6);if(!s)break;let y=0;const n=2+Math.floor(rng()*2);for(let k=0;k<n;k++){const sz=2-k*0.4;addBox(s.x,y,s.z,sz,1.3,sz,M(pal[(i+k)%6]),false);y+=1.3;}addCol(s.x,0,s.z,2,y,2);}
  for(let i=0;i<5;i++){const s=spot(1.3);if(!s)break;const r=0.9+rng()*0.5;const m=addMesh(GEO.sphere,M(pal[Math.floor(rng()*6)]),s.x,r,s.z);m.scale.setScalar(r);addCol(s.x,0,s.z,r*1.5,r*2,r*1.5);}
  for(let i=0;i<3;i++){const s=spot(3);if(!s)break;addBox(s.x,0,s.z,2,2.4,2,M(0x4fc3f7));const sl=addMesh(GEO.box,M(0xffd93d),s.x,1.2,s.z+2.4);sl.scale.set(1.4,0.15,3.6);sl.rotation.x=0.6;}
  for(let i=0;i<2;i++){const s=spot(2.5);if(!s)break;const c=M(0xff6b6b);[-1.8,1.8].forEach(dx=>{const p=addMesh(GEO.cyl,c,s.x+dx,1.5,s.z);p.scale.set(0.1,3,0.1);addCol(s.x+dx,0,s.z,0.3,3,0.3);});const t=addMesh(GEO.cyl,c,s.x,3,s.z);t.scale.set(0.1,3.8,0.1);t.rotation.z=Math.PI/2;[-0.7,0.7].forEach(dx=>{const st=addMesh(GEO.box,M(0x8b6dff),s.x+dx,0.9,s.z);st.scale.set(0.6,0.08,0.3);});}
  clouds(rng,10);
 },
 forest(rng,spot){
  for(let i=0;i<14;i++){const s=spot(1.2);if(!s)break;tree(s.x,s.z,0.9+rng()*0.5,rng()<0.5?0x2e7d32:0x43a047);}
  const mc=[0xff5252,0xab47bc,0xffa726];
  for(let i=0;i<5;i++){const s=spot(1.4);if(!s)break;const sc=0.8+rng()*0.6;addMesh(new THREE.CylinderGeometry(0.3*sc,0.4*sc,1.4*sc,10),M(0xfff3e0),s.x,0.7*sc,s.z);addMesh(new THREE.SphereGeometry(1.1*sc,16,10,0,Math.PI*2,0,Math.PI/2),M(mc[i%3]),s.x,1.3*sc,s.z);for(let k=0;k<6;k++){const a=k/6*Math.PI*2;const d=addMesh(GEO.sphere,M(0xffffff),s.x+Math.cos(a)*0.65*sc,1.3*sc+0.89*sc,s.z+Math.sin(a)*0.65*sc);d.scale.setScalar(0.16*sc);}addCol(s.x,0,s.z,1.2*sc,2.2*sc,1.2*sc);}
  for(let i=0;i<3;i++){const s=spot(2);if(!s)break;const lg=addMesh(GEO.cyl,M(0x795548),s.x,0.45,s.z);lg.scale.set(0.45,3.2,0.45);lg.rotation.z=Math.PI/2;addCol(s.x,0,s.z,3.2,0.9,0.9);}
  for(let i=0;i<42;i++){const a=i/42*Math.PI*2,r=H+4+rng()*12;tree(Math.cos(a)*r,Math.sin(a)*r,1.3+rng()*0.9,0x2e7d32,true);}
 },
 beach(rng,spot){
  for(let i=0;i<8;i++){const s=spot(1.2);if(!s)break;const sc=1+rng()*0.4,lean=(rng()-0.5)*0.6;for(let k=0;k<5;k++)addMesh(new THREE.CylinderGeometry(0.22*sc,0.28*sc,0.9*sc,7),M(0x8d6e63),s.x+lean*k*0.25*sc,0.45*sc+k*0.85*sc,s.z);const tx=s.x+lean*1.25*sc,ty=4.4*sc;for(let k=0;k<6;k++){const a=k/6*Math.PI*2;const lf=addMesh(GEO.box,M(0x2e9d4a),tx+Math.cos(a)*1.0*sc,ty-0.25*sc,s.z+Math.sin(a)*1.0*sc);lf.scale.set(2.4*sc,0.08,0.55*sc);lf.rotation.order='YXZ';lf.rotation.set(0,-a,-0.35);}for(let k=0;k<3;k++){const co=addMesh(GEO.sphere,M(0x5d4037),tx+(k-1)*0.25,ty-0.4*sc,s.z+0.15);co.scale.setScalar(0.17*sc);}addCol(s.x,0,s.z,0.6*sc,4.4*sc,0.6*sc);}
  const uc=[0xff5252,0xffd740,0x40c4ff,0x69f0ae,0xff80ab];
  for(let i=0;i<5;i++){const s=spot(1.5);if(!s)break;const p=addMesh(GEO.cyl,M(0xffffff),s.x,1.3,s.z);p.scale.set(0.06,2.6,0.06);addMesh(new THREE.ConeGeometry(1.6,0.7,10),M(uc[i%5]),s.x,2.7,s.z);addCol(s.x,0,s.z,0.4,2.6,0.4);const tw=addMesh(GEO.box,M(uc[(i+2)%5]),s.x+1.3,0.02,s.z);tw.scale.set(1,0.03,1.8);}
  for(let i=0;i<4;i++){const s=spot(1.8);if(!s)break;const sand=M(0xe6c27a);addBox(s.x,0,s.z,2.2,1,2.2,sand,false);[[-1,-1],[1,-1],[-1,1],[1,1]].forEach(([a,b])=>{const t=addMesh(GEO.cyl,sand,s.x+a*1,0.8,s.z+b*1);t.scale.set(0.38,1.6,0.38);const f=addMesh(new THREE.ConeGeometry(0.42,0.5,8),M(0xd4a95f),s.x+a,1.85,s.z+b);});addCol(s.x,0,s.z,2.5,1.6,2.5);}
  const sea=M(0x29b6f6);[[0,-H-40,200,78],[0,H+40,200,78],[-H-40,0,78,200],[H+40,0,78,200]].forEach(([x,z,w,d])=>{const p=addMesh(new THREE.PlaneGeometry(w,d),sea,x,0.03,z);p.rotation.x=-Math.PI/2;});
  clouds(rng,9);
 },
 city(rng,spot){
  const cvs=[windowCanvas(rng),windowCanvas(rng),windowCanvas(rng)];const neon=[0xff4fd8,0x34e7ff,0xffe14d,0x8bff6d];
  function building(x,z,w,h,d,noCol){const t=new THREE.CanvasTexture(cvs[Math.floor(rng()*3)]);t.wrapS=t.wrapT=THREE.RepeatWrapping;t.repeat.set(Math.max(1,Math.round(w/1.5)),Math.max(1,Math.round(h/1.5)));const mat=new THREE.MeshLambertMaterial({map:t,emissive:0xffffff,emissiveMap:t,emissiveIntensity:0.85});const m=addMesh(GEO.box,mat,x,h/2,z);m.scale.set(w,h,d);const top=addMesh(GEO.box,MB(neon[Math.floor(rng()*4)]),x,h,z);top.scale.set(w+0.1,0.15,d+0.1);if(!noCol)addCol(x,0,z,w,h,d);}
  for(let i=0;i<9;i++){const s=spot(2.6);if(!s)break;building(s.x,s.z,3+rng()*2.2,5+rng()*8,3+rng()*2.2);}
  for(let i=0;i<6;i++){const s=spot(0.6);if(!s)break;const p=addMesh(GEO.cyl,M(0x555577),s.x,1.8,s.z);p.scale.set(0.08,3.6,0.08);const l=addMesh(GEO.sphere,MB(neon[i%4]),s.x,3.7,s.z);l.scale.setScalar(0.25);addCol(s.x,0,s.z,0.3,3.6,0.3);}
  for(let i=0;i<34;i++){const a=i/34*Math.PI*2,r=H+8+rng()*14;building(Math.cos(a)*r,Math.sin(a)*r,5+rng()*5,10+rng()*22,5+rng()*5,true);}
  starsSky(rng,500);
 },
 snow(rng,spot){
  const ice=M(0xb3e5fc,{transparent:true,opacity:0.85});
  for(let i=0;i<7;i++){const s=spot(1.6);if(!s)break;const w=1.6+rng()*1.6,h=1.2+rng()*1.4;addBox(s.x,0,s.z,w,h,1.6,ice);}
  for(let i=0;i<5;i++){const s=spot(1);if(!s)break;const wht=M(0xffffff);[[0.7,0.7],[0.5,1.75],[0.36,2.5]].forEach(([r,y])=>{const b=addMesh(GEO.sphere,wht,s.x,y,s.z);b.scale.setScalar(r);});const n=addMesh(new THREE.ConeGeometry(0.08,0.4,8),M(0xff8f00),s.x,2.5,s.z+0.45);n.rotation.x=Math.PI/2;const hat=addMesh(GEO.cyl,M(0x263238),s.x,2.95,s.z);hat.scale.set(0.3,0.35,0.3);const sc=addMesh(GEO.cyl,M(0xe53935),s.x,2.12,s.z);sc.scale.set(0.42,0.12,0.42);addCol(s.x,0,s.z,1.3,2.8,1.3);}
  for(let i=0;i<8;i++){const s=spot(1.2);if(!s)break;tree(s.x,s.z,0.9+rng()*0.4,0x2e7d32);addMesh(new THREE.ConeGeometry(0.7,0.8,8),M(0xffffff),s.x,5,s.z);}
  for(let i=0;i<2;i++){const s=spot(2.6);if(!s)break;addMesh(new THREE.SphereGeometry(2.2,16,10,0,Math.PI*2,0,Math.PI/2),M(0xf5fbff),s.x,0,s.z);addCol(s.x,0,s.z,3.2,2,3.2);}
  for(let i=0;i<36;i++){const a=i/36*Math.PI*2,r=H+5+rng()*12;tree(Math.cos(a)*r,Math.sin(a)*r,1.4+rng()*0.8,0x1b5e20,true);}
  const n=700,pos=new Float32Array(n*3);for(let i=0;i<n;i++){pos[i*3]=(rng()*2-1)*H;pos[i*3+1]=rng()*24;pos[i*3+2]=(rng()*2-1)*H;}const g=new THREE.BufferGeometry();g.setAttribute('position',new THREE.BufferAttribute(pos,3));const pts=new THREE.Points(g,new THREE.PointsMaterial({color:0xffffff,size:0.14}));scene.add(pts);G.snow=pts;
 },
 volcano(rng,spot){
  const rc=[0x5d4037,0x6d4c41,0x4e342e];
  for(let i=0;i<12;i++){const s=spot(1.6);if(!s)break;const sx=1+rng()*0.9,sy=0.8+rng()*1.2,sz=1+rng()*0.9;const r=addMesh(new THREE.DodecahedronGeometry(1,0),M(rc[i%3]),s.x,sy*0.75,s.z);r.scale.set(sx,sy,sz);r.rotation.y=rng()*6;addCol(s.x,0,s.z,sx*1.5,sy*1.6,sz*1.5);}
  for(let i=0;i<5;i++){const s=spot(2);if(!s)break;const r=1.4+rng()*1.2;const a=addMesh(GEO.circle,MB(0xff7043),s.x,0.03,s.z);a.rotation.x=-Math.PI/2;a.scale.setScalar(r);const b=addMesh(GEO.circle,MB(0xffca28),s.x,0.04,s.z);b.rotation.x=-Math.PI/2;b.scale.setScalar(r*0.55);}
  addMesh(new THREE.CylinderGeometry(7,38,34,24),M(0x5d4037),0,17,-H-50);const top=addMesh(new THREE.CylinderGeometry(7,7,0.6,24),MB(0xff7043),0,34.1,-H-50);
  for(let i=0;i<5;i++){const p=addMesh(GEO.sphere,MB(0x9e9e9e,{transparent:true,opacity:0.6}),(rng()-0.5)*6,38+i*4,-H-50);p.scale.setScalar(3+i);}
  for(let i=0;i<10;i++){const a=Math.PI*0.15+i/10*Math.PI*1.7,r=H+28;const h=12+rng()*14;addMesh(new THREE.ConeGeometry(14,h,8),M(0x795548),Math.sin(a)*r,h/2,Math.cos(a)*r);}
 },
 space(rng,spot){
  for(let i=0;i<8;i++){const s=spot(1.4);if(!s)break;addBox(s.x,0,s.z,1.8,1.8,1.8,M(0xb0bec5));const st=addMesh(GEO.box,MB(0x34e7ff),s.x,0.9,s.z);st.scale.set(1.84,0.12,1.84);if(rng()<0.4){addBox(s.x,1.8,s.z,1.4,1.4,1.4,M(0x90a4ae));}}
  for(let i=0;i<3;i++){const s=spot(2.6);if(!s)break;addMesh(new THREE.SphereGeometry(2.2,18,10,0,Math.PI*2,0,Math.PI/2),M(0x80deea,{transparent:true,opacity:0.5}),s.x,0,s.z);const base=addMesh(GEO.cyl,M(0x78909c),s.x,0.15,s.z);base.scale.set(2.35,0.3,2.35);addCol(s.x,0,s.z,3.4,2.1,3.4);}
  for(let i=0;i<3;i++){const s=spot(1);if(!s)break;const p=addMesh(GEO.cyl,M(0xcfd8dc),s.x,2,s.z);p.scale.set(0.12,4,0.12);const d=addMesh(new THREE.ConeGeometry(1,0.6,16,1,true),M(0xeceff1,{side:THREE.DoubleSide}),s.x,4.2,s.z);d.rotation.x=Math.PI*0.8;const l=addMesh(GEO.sphere,MB(0xff4f8b),s.x,4.6,s.z);l.scale.setScalar(0.15);addCol(s.x,0,s.z,0.4,4,0.4);}
  const pl=addMesh(GEO.sphere,MB(0x7e57c2,{fog:false}),70,60,-150);pl.scale.setScalar(28);const ring=addMesh(GEO.ring,MB(0xd1c4e9,{fog:false,side:THREE.DoubleSide}),70,60,-150);ring.scale.setScalar(46);ring.rotation.x=1.2;
  const mo=addMesh(GEO.sphere,MB(0xeeeeee,{fog:false}),-90,80,-120);mo.scale.setScalar(9);
  starsSky(rng,900);
 },
 temple(rng,spot){
  const st=M(0xd7c08a),st2=M(0xbfa46a);
  for(let i=0;i<10;i++){const s=spot(1);if(!s)break;const h=4+rng()*2;const p=addMesh(GEO.cyl,st,s.x,h/2,s.z);p.scale.set(0.55,h,0.55);addBox(s.x,h,s.z,1.5,0.4,1.5,st2,false);addBox(s.x,0,s.z,1.5,0.3,1.5,st2,false);addCol(s.x,0,s.z,1.2,h+0.4,1.2);}
  for(let i=0;i<4;i++){const s=spot(1.6);if(!s)break;const h=1.2+rng()*1.3;const p=addMesh(GEO.cyl,st,s.x,h/2,s.z);p.scale.set(0.55,h,0.55);const f=addMesh(GEO.cyl,st,s.x+1.4,0.5,s.z);f.scale.set(0.5,2,0.5);f.rotation.z=Math.PI/2;addCol(s.x,0,s.z,1.2,h,1.2);addCol(s.x+1.4,0,s.z,2,1,1);}
  for(let i=0;i<5;i++){const s=spot(1.4);if(!s)break;addBox(s.x,0,s.z,2,1.2,1.4,st2);addBox(s.x,1.2,s.z,2,0.08,1.4,M(0x7cb342),false);}
  const s=spot(4.2);if(s){addBox(s.x,0,s.z,6,1,6,st2);addBox(s.x,1,s.z,4.2,1,4.2,st);addBox(s.x,2,s.z,2.4,1,2.4,st2);const gb=addMesh(GEO.sphere,M(0xffd54f,{emissive:0x553300}),s.x,3.5,s.z);gb.scale.setScalar(0.5);}
  for(let i=0;i<6;i++){const a=Math.PI*0.2+i/6*Math.PI*1.6,r=H+30;addMesh(new THREE.ConeGeometry(16,18,4),M(0xd7b679),Math.sin(a)*r,9,Math.cos(a)*r);}
  clouds(rng,6);
 },
 candy(rng,spot){
  const pal=[0xff4081,0x7c4dff,0x00e5ff,0xffea00,0x76ff03,0xff9100];
  for(let i=0;i<7;i++){const s=spot(1.4);if(!s)break;const st=addMesh(GEO.cyl,M(0xffffff),s.x,1.6,s.z);st.scale.set(0.1,3.2,0.1);const disc=addMesh(new THREE.CylinderGeometry(1.1,1.1,0.25,24),M(pal[i%6]),s.x,3.6,s.z);disc.rotation.x=Math.PI/2;disc.rotation.z=rng()*3;const sw=addMesh(new THREE.TorusGeometry(0.6,0.1,8,24),M(0xffffff),s.x,3.6,s.z+0.13);addCol(s.x,0,s.z,0.4,3.2,0.4);}
  for(let i=0;i<5;i++){const s=spot(0.8);if(!s)break;for(let k=0;k<9;k++){const c=addMesh(GEO.cyl,M(k%2?0xffffff:0xe53935),s.x,0.18+k*0.36,s.z);c.scale.set(0.2,0.36,0.2);}const hk=addMesh(new THREE.TorusGeometry(0.4,0.2,8,16,Math.PI),M(0xe53935),s.x+0.4,3.24,s.z);addCol(s.x,0,s.z,0.5,3.3,0.5);}
  for(let i=0;i<6;i++){const s=spot(1.2);if(!s)break;addMesh(new THREE.CylinderGeometry(0.5,1,1.2,14),M(pal[(i+2)%6]),s.x,0.6,s.z);addCol(s.x,0,s.z,1.6,1.2,1.6);}
  for(let i=0;i<4;i++){const s=spot(1.8);if(!s)break;addBox(s.x,0,s.z,3,1.1,1.6,M(0x6d4c41));for(let k=0;k<3;k++){addBox(s.x-1+k,1.1,s.z,0.85,0.12,1.4,M(0x8d6e63),false);}}
  for(let i=0;i<3;i++){const s=spot(1.6);if(!s)break;const d=addMesh(new THREE.TorusGeometry(1,0.45,10,24),M(0xffcc80),s.x,0.45,s.z);d.rotation.x=Math.PI/2;const ic=addMesh(new THREE.TorusGeometry(1,0.3,8,24,Math.PI*2),M(0xf06292),s.x,0.62,s.z);ic.rotation.x=Math.PI/2;ic.scale.set(1,1,0.6);addCol(s.x,0,s.z,2.6,0.9,2.6);}
  for(let i=0;i<8;i++){const a=i/8*Math.PI*2,r=H+18;const x=Math.sin(a)*r,z=Math.cos(a)*r;const t=addMesh(GEO.cyl,M(0xf8bbd0),x,10,z);t.scale.set(4,20,4);addMesh(new THREE.ConeGeometry(5,8,12),M(0xba68c8),x,24,z);}
  clouds(rng,8);
 }
};
function buildWorld(A,seed){
 scene=new THREE.Scene();scene.background=new THREE.Color(A.sky);scene.fog=new THREE.Fog(A.fog,30,120);
 scene.add(new THREE.HemisphereLight(A.night?0xb0a6ff:0xffffff,A.ground,A.night?0.75:0.85));
 const sun=new THREE.DirectionalLight(A.night?0xc9c0ff:0xfff4e0,A.night?0.5:0.75);sun.position.set(25,50,15);scene.add(sun);
 const ground=addMesh(new THREE.PlaneGeometry(200,200),new THREE.MeshLambertMaterial({map:makeGroundTex(A)}),0,0,0);ground.rotation.x=-Math.PI/2;
 const wm=M(A.wall),wh=3.2;
 addBox(0,0,-H-0.5,2*H+2,wh,1,wm);addBox(0,0,H+0.5,2*H+2,wh,1,wm);addBox(-H-0.5,0,0,1,wh,2*H,wm);addBox(H+0.5,0,0,1,wh,2*H,wm);
 const tm=M(A.cover);addBox(0,wh,-H-0.5,2*H+2,0.25,1.2,tm,false);addBox(0,wh,H+0.5,2*H+2,0.25,1.2,tm,false);addBox(-H-0.5,wh,0,1.2,0.25,2*H,tm,false);addBox(H+0.5,wh,0,1.2,0.25,2*H,tm,false);
 const rng=mulberry(seed);const placed=[];
 function spot(r){for(let k=0;k<70;k++){const x=(rng()*2-1)*(H-3-r),z=(rng()*2-1)*(H-3-r);if(Math.hypot(x,z-(H-6))<7+r)continue;let ok=true;for(const p of placed){if(Math.hypot(p.x-x,p.z-z)<p.r+r+2.2){ok=false;break;}}if(ok){placed.push({x,z,r});return{x,z};}}return null;}
 const cm=M(A.cover),cm2=M(shade(A.cover,0.82)),rm=M(shade(A.cover,1.15));
 function tower(x,z,h){
  const L=h*2.3,pref=Math.abs(x)>Math.abs(z)?[[-Math.sign(x),0],[0,-(Math.sign(z)||1)],[0,Math.sign(z)||1],[Math.sign(x),0]]:[[0,-(Math.sign(z)||1)],[-(Math.sign(x)||1),0],[Math.sign(x)||1,0],[0,Math.sign(z)||1]];
  let dx=pref[0][0],dz=pref[0][1];
  for(const[ax,az]of pref){const ex=x+ax*(2.2+L),ez=z+az*(2.2+L);if(Math.abs(ex)>H-2||Math.abs(ez)>H-2)continue;
   const cx=x+ax*(2.2+L/2),cz=z+az*(2.2+L/2),hx=Math.abs(ax)*L/2+Math.abs(az)*1.2+1.2,hz=Math.abs(az)*L/2+Math.abs(ax)*1.2+1.2;
   if(G.boxes.concat(G.ramps).some(b=>b.maxX>cx-hx&&b.minX<cx+hx&&b.maxZ>cz-hz&&b.minZ<cz+hz))continue;dx=ax;dz=az;break;}
  placed.push({x:x+dx*(2.2+L/2),z:z+dz*(2.2+L/2),r:L/2+0.5});
  addBox(x,0,z,4.4,h,4.4,cm2);addBox(x,h,z,4.5,0.12,4.5,cm,false);
  [[1,0],[-1,0],[0,1],[0,-1]].forEach(([ax,az])=>{if(ax===dx&&az===dz)return;addBox(x+ax*2.1,h,z+az*2.1,az?4.4:0.22,0.75,ax?4.4:0.22,cm);});
  addRamp(x+dx*(2.2+L),z+dz*(2.2+L),-dx,-dz,L,2.4,h,rm);
 }
 for(let i=0;i<3;i++){const s=spot(6);if(!s)continue;tower(s.x,s.z,i===0?3.2:2.2+rng()*1);}
 for(let i=0;i<6;i++){const s=spot(3);if(!s)continue;const along=rng()<0.5,len=3.5+rng()*3;addBox(s.x,0,s.z,along?len:0.9,1.4,along?0.9:len,cm);}
 for(let i=0;i<5;i++){const s=spot(1.5);if(!s)continue;addBox(s.x,0,s.z,1.6,1.6,1.6,cm2);if(rng()<0.45)addBox(s.x,1.6,s.z,1.4,1.4,1.4,cm);}
 THEMES[A.theme](rng,spot);
}

/* Bots */
function part(geo,mat,x,y,z,sx,sy,sz){const m=new THREE.Mesh(geo,mat);m.position.set(x,y,z);m.scale.set(sx,sy,sz);return m;}
function makeBot(color,boss){
 const g=new THREE.Group();const body=new THREE.MeshLambertMaterial({color});
 const dark=M(0x2b2d42),light=M(0xf4f4f8),eye=MB(boss?0xff4fd8:0x5ff8ff),B=GEO.box,S=GEO.sphere,C=GEO.cyl;
 g.add(part(B,dark,-0.2,0.25,0,0.28,0.5,0.32),part(B,dark,0.2,0.25,0,0.28,0.5,0.32));
 g.add(part(B,body,0,0.95,0,0.9,0.9,0.6),part(B,light,0,0.95,0.305,0.5,0.4,0.02));
 g.add(part(B,body,0,1.75,0,0.75,0.6,0.62),part(B,dark,0,1.78,0.315,0.6,0.28,0.02));
 g.add(part(B,eye,-0.13,1.79,0.33,0.12,0.1,0.02),part(B,eye,0.13,1.79,0.33,0.12,0.1,0.02));
 g.add(part(C,dark,0,2.2,0,0.03,0.3,0.03),part(S,eye,0,2.38,0,0.08,0.08,0.08));
 g.add(part(B,body,-0.6,1.0,0,0.22,0.6,0.25),part(B,body,0.6,1.0,0,0.22,0.6,0.25));
 g.add(part(B,dark,0.6,0.78,0.25,0.16,0.16,0.45),part(S,MB(0xffffff),0.6,0.78,0.5,0.07,0.07,0.07));
 if(boss){const gold=M(0xffd54f,{emissive:0x332200});g.add(part(C,gold,0,2.12,0,0.42,0.18,0.42));for(let k=0;k<5;k++){const a=k/5*Math.PI*2;g.add(part(B,gold,Math.cos(a)*0.32,2.32,Math.sin(a)*0.32,0.1,0.22,0.1));}}
 return{g,body};
}
function diffParams(){const d=G.diff;return{count:Math.min(7,3+Math.floor(d/5)),hp:50+d*5,speed:3+d*0.085,dmg:5+d*0.22,fireCd:Math.max(0.9,1.8-d*0.035),spread:Math.max(0.04,0.12-d*0.003),pspeed:24+d*0.5,lead:Math.min(0.7,d*0.03)};}
function boxAtXZ(x,z,r){for(const b of G.boxes.concat(G.ramps)){if(x+r>b.minX&&x-r<b.maxX&&z+r>b.minZ&&z-r<b.maxZ)return true;}return false;}
function spawnBot(boss){
 const P=diffParams(),s=boss?1.6:1;let pos=null;
 for(let k=0;k<60;k++){const x=(Math.random()*2-1)*(H-3),z=(Math.random()*2-1)*(H-3);if(Math.hypot(x-G.player.pos.x,z-G.player.pos.z)<18)continue;if(boxAtXZ(x,z,0.9*s))continue;pos=new V3(x,0,z);break;}
 if(!pos)pos=new V3(0,0,-H+5);
 const color=boss?0xffc400:pick(BOT_COLORS);
 const bot=makeBot(color,boss);bot.g.position.copy(pos);bot.g.scale.setScalar(0.01);scene.add(bot.g);
 const bg=new THREE.Mesh(new THREE.PlaneGeometry(1.1*s,0.16),new THREE.MeshBasicMaterial({color:0x1b1b2f,transparent:true,opacity:0.75}));
 const fm=new THREE.MeshBasicMaterial({color:0x5ddc6b});const fill=new THREE.Mesh(new THREE.PlaneGeometry(1.04*s,0.1),fm);fill.position.z=0.01;
 const bar=new THREE.Group();bar.add(bg,fill);bar.visible=false;scene.add(bar);
 G.bots.push({g:bot.g,body:bot.body,bar,fill,fm,barW:1.04*s,pos,scale:s,boss,color,name:boss?'Mega Bot':pick(BOT_NAMES),
  hp:P.hp*(boss?5:1),maxHp:P.hp*(boss?5:1),speed:P.speed*(boss?0.8:1),dmg:P.dmg*(boss?1.4:1),fireCd:P.fireCd*(boss?0.9:1),spread:P.spread,pspeed:P.pspeed,lead:P.lead,
  pref:8+Math.random()*6,cd:1+Math.random()*1.2,strafe:Math.random()<0.5?1:-1,strafeT:1,los:false,losT:0,stuckT:0.6,lastX:pos.x,lastZ:pos.z,wT:0,wdx:0,wdz:0,
  slowT:0,flash:0,alive:true,dying:0,spawnT:0.6,splats:0,phase:Math.random()*6});
 ringFx(pos,color);burst(new V3(pos.x,1,pos.z),[color,0xffffff],14,4,0.1,0.8,4);
 if(boss)feed('¡Llegó el Mega Bot!','👑');
}
function ringFx(pos,color){const m=new THREE.Mesh(GEO.ring,new THREE.MeshBasicMaterial({color,transparent:true,side:THREE.DoubleSide}));m.rotation.x=-Math.PI/2;m.position.set(pos.x,0.06,pos.z);scene.add(m);G.fx.push({m,life:0.6,max:0.6,ring:true});}
function removeBot(b,i){scene.remove(b.g);b.body.dispose();scene.remove(b.bar);b.bar.children.forEach(c=>{c.geometry.dispose();c.material.dispose();});G.bots.splice(i,1);}

/* Colisiones */
function pushOut(pos,r,minX,maxX,minZ,maxZ){
 const cx=clamp(pos.x,minX,maxX),cz=clamp(pos.z,minZ,maxZ);const dx=pos.x-cx,dz=pos.z-cz,d2=dx*dx+dz*dz;
 if(d2>=r*r)return;
 if(d2>1e-9){const d=Math.sqrt(d2),p=(r-d)/d;pos.x+=dx*p;pos.z+=dz*p;}
 else{const l=pos.x-minX,rr=maxX-pos.x,n=pos.z-minZ,f=maxZ-pos.z,m=Math.min(l,rr,n,f);if(m===l)pos.x=minX-r;else if(m===rr)pos.x=maxX+r;else if(m===n)pos.z=minZ-r;else pos.z=maxZ+r;}
}
function collideXZ(pos,r,feet,height,step,solidAll){
 for(const b of G.boxes){if(!solidAll&&feet>=b.maxY-step)continue;if(feet+height<=b.minY)continue;pushOut(pos,r,b.minX,b.maxX,b.minZ,b.maxZ);}
 for(const q of G.ramps){const top=rampH(q,clamp(pos.x,q.minX,q.maxX),clamp(pos.z,q.minZ,q.maxZ));if(!solidAll&&feet>=top-0.45)continue;pushOut(pos,r,q.minX,q.maxX,q.minZ,q.maxZ);}
}
function groundHeight(x,z,r,feet,step){let h=0;for(const b of G.boxes){if(x+r>b.minX&&x-r<b.maxX&&z+r>b.minZ&&z-r<b.maxZ&&feet>=b.maxY-step-0.001)h=Math.max(h,b.maxY);}
 for(const q of G.ramps){if(x>=q.minX&&x<=q.maxX&&z>=q.minZ&&z<=q.maxZ){const t=rampH(q,x,z);if(feet>=t-0.5)h=Math.max(h,t);}}return h;}
function rayWorld(o,d,maxT){let best=maxT,n=null;
 for(const b of G.boxes){const r=rayAABB(o,d,b);if(r&&r.t<best){best=r.t;n=r.n;}}
 for(const q of G.ramps){const den=d.y-q.k*(d.x*q.dx+d.z*q.dz);if(Math.abs(den)<1e-6)continue;const f=o.y-q.k*((o.x-q.x0)*q.dx+(o.z-q.z0)*q.dz);const t=-f/den;if(t<=0||t>=best)continue;
  const px=o.x+d.x*t,pz=o.z+d.z*t,sv=(px-q.x0)*q.dx+(pz-q.z0)*q.dz,c=Math.abs((px-q.x0)*(-q.dz)+(pz-q.z0)*q.dx);if(sv<0||sv>q.L||c>q.w/2)continue;best=t;n=q.n.clone();}
 return n?{t:best,n}:null;}
function rayAABB(o,d,b){
 let tmin=-Infinity,tmax=Infinity,ax=null,sg=0;
 for(const a of['x','y','z']){const mn=b['min'+a.toUpperCase()],mx=b['max'+a.toUpperCase()];
  if(Math.abs(d[a])<1e-9){if(o[a]<mn||o[a]>mx)return null;}
  else{let t1=(mn-o[a])/d[a],t2=(mx-o[a])/d[a],s=-1;if(t1>t2){const t=t1;t1=t2;t2=t;s=1;}if(t1>tmin){tmin=t1;ax=a;sg=s;}if(t2<tmax)tmax=t2;if(tmin>tmax)return null;}}
 if(tmax<0)return null;const n=new V3();if(ax)n[ax]=sg;else n.y=1;return{t:Math.max(0,tmin),n};
}
function raySphere(o,d,c,r){const ox=o.x-c.x,oy=o.y-c.y,oz=o.z-c.z;const b=ox*d.x+oy*d.y+oz*d.z;const cc=ox*ox+oy*oy+oz*oz-r*r;const disc=b*b-cc;if(disc<0)return-1;const sq=Math.sqrt(disc);let t=-b-sq;if(t<0)t=-b+sq;return t>0?t:-1;}
function los(a,b){const d=b.clone().sub(a);const len=d.length();d.divideScalar(len);return !rayWorld(a,d,len);}
function boxAt(pt,r){for(const b of G.boxes){if(pt.x>b.minX-r&&pt.x<b.maxX+r&&pt.y>b.minY-r&&pt.y<b.maxY+r&&pt.z>b.minZ-r&&pt.z<b.maxZ+r)return b;}return null;}
function solidAt(pt,r){const b=boxAt(pt,r);if(b)return b;for(const q of G.ramps){if(pt.x>q.minX&&pt.x<q.maxX&&pt.z>q.minZ&&pt.z<q.maxZ&&pt.y<rampH(q,pt.x,pt.z)+r)return q;}return null;}
function hitBot(b,pt,r){const s=b.scale,dx=pt.x-b.pos.x,dz=pt.z-b.pos.z,h2=dx*dx+dz*dz,hy=pt.y-1.75*s,by=pt.y-0.95*s;
 if(h2+hy*hy<(0.45*s+r)*(0.45*s+r))return 2;if(h2+by*by<(0.62*s+r)*(0.62*s+r))return 1;if(pt.y<0.6*s&&h2<(0.35*s+r)*(0.35*s+r))return 1;return 0;}
function hitPlayer(pt,r){const P=G.player.pos;const dx=pt.x-P.x,dz=pt.z-P.z,rr=0.45+r;if(dx*dx+dz*dz>rr*rr)return false;return pt.y>P.y-0.05&&pt.y<P.y+1.85;}

/* Efectos */
function decal(pt,n,color,size){
 const m=new THREE.Mesh(GEO.circle,MB(color,{polygonOffset:true,polygonOffsetFactor:-1,polygonOffsetUnits:-4,transparent:true,opacity:0.95,depthWrite:false}));
 m.scale.setScalar(size);m.position.copy(pt).addScaledVector(n,0.015+Math.random()*0.012);m.lookAt(m.position.clone().add(n));m.rotateZ(Math.random()*6.28);scene.add(m);G.decals.push(m);
 if(G.decals.length>170)scene.remove(G.decals.shift());
}
function splatDecal(pt,n,color,size){decal(pt,n,color,size);const t1=Math.abs(n.y)>0.9?new V3(1,0,0):new V3().crossVectors(n,UP).normalize();const t2=new V3().crossVectors(n,t1);for(let i=0;i<3;i++){const a=Math.random()*6.28,d=size*(1+Math.random()*0.7);decal(pt.clone().addScaledVector(t1,Math.cos(a)*d).addScaledVector(t2,Math.sin(a)*d),n,color,size*(0.2+Math.random()*0.25));}}
function burst(pos,colors,n,speed,size,life,grav){
 if(G.parts.length>450)return;const cols=Array.isArray(colors)?colors:[colors];
 for(let i=0;i<n;i++){const m=new THREE.Mesh(GEO.box,MB(cols[i%cols.length]));m.position.copy(pos);const s=size*(0.6+Math.random()*0.8);m.scale.setScalar(s);scene.add(m);
  const v=new V3(Math.random()*2-1,Math.random()*1.2+0.2,Math.random()*2-1).normalize().multiplyScalar(speed*(0.4+Math.random()*0.8));
  G.parts.push({m,v,life:life*(0.6+Math.random()*0.5),max:life,s,grav:grav==null?14:grav,sx:Math.random()*10,sy:Math.random()*10});}
}
function beam(a,b,color,r){const len=a.distanceTo(b);if(len<0.01)return;const mat=new THREE.MeshBasicMaterial({color,transparent:true,opacity:0.9});const m=new THREE.Mesh(GEO.cyl,mat);m.position.copy(a).add(b).multiplyScalar(0.5);m.scale.set(r,len,r);m.quaternion.setFromUnitVectors(UP,b.clone().sub(a).normalize());scene.add(m);G.fx.push({m,life:0.09,max:0.09});}
function splatOnBot(b,pt,color){
 if(b.splats>=14)return;b.splats++;
 const l=b.g.worldToLocal(pt.clone());const head=l.y>1.42;
 const c=head?new V3(0,1.75,0):new V3(0,0.95,0),h=head?new V3(0.375,0.3,0.31):new V3(0.45,0.45,0.3);
 const r=new V3((l.x-c.x)/h.x,(l.y-c.y)/h.y,(l.z-c.z)/h.z);
 let ax='x';if(Math.abs(r.y)>Math.abs(r[ax]))ax='y';if(Math.abs(r.z)>Math.abs(r[ax]))ax='z';
 const sg=r[ax]>=0?1:-1;const p=new V3(clamp(l.x,c.x-h.x*0.9,c.x+h.x*0.9),clamp(l.y,c.y-h.y*0.9,c.y+h.y*0.9),clamp(l.z,c.z-h.z*0.9,c.z+h.z*0.9));p[ax]=c[ax]+sg*(h[ax]+0.012);
 const m=new THREE.Mesh(GEO.circle,MB(color));m.position.copy(p);m.scale.setScalar(0.12+Math.random()*0.1);
 if(ax==='z')m.rotation.y=sg>0?0:Math.PI;else if(ax==='x')m.rotation.y=sg*Math.PI/2;else m.rotation.x=-sg*Math.PI/2;
 b.g.add(m);
}

/* Combate */
function spreadDir(dir,s){if(!s)return dir.clone();const right=new V3().crossVectors(dir,UP).normalize();const up=new V3().crossVectors(right,dir).normalize();const a=Math.random()*Math.PI*2,r=Math.sqrt(Math.random())*s;return dir.clone().addScaledVector(right,Math.cos(a)*r).addScaledVector(up,Math.sin(a)*r).normalize();}
function spawnProj(o){const geo=o.kind==='star'?GEO.oct:GEO.sphere;const mat=o.kind==='bubble'?MB(o.color,{transparent:true,opacity:0.55}):MB(o.color);const m=new THREE.Mesh(geo,mat);m.scale.setScalar(o.size);m.position.copy(o.pos);scene.add(m);o.mesh=m;if(o.pierce)o.hitSet=new Set();G.projs.push(o);}
function fire(){
 const w=G.weapons[G.cur],d=w.d;
 if(w.reloadT>0||w.cd>0)return;
 if(w.ammo<=0){startReload(w);return;}
 w.ammo--;w.cd=1/d.rate;
 const o=camera.position.clone(),dir=new V3();camera.getWorldDirection(dir);
 const tip=new V3();vmTip.getWorldPosition(tip);
 for(let i=0;i<d.pellets;i++){
  G.stats.shots++;const sd=spreadDir(dir,d.spread*(G.zoomOn?0.3:1));const color=d.color==='rainbow'?pick(RAINBOW):d.color;
  if(d.type==='beam')hitscan(o,sd,d,color,tip);
  else{const start=o.clone().addScaledVector(sd,0.45);start.y-=0.08;const vel=sd.clone().multiplyScalar(d.speed);if(d.type==='arc')vel.y+=4;
   spawnProj({pos:start,vel,owner:'player',dmg:d.dmg,color,size:d.size,gravity:d.gravity||0,splash:d.splash||0,pierce:!!d.pierce,homing:!!d.homing,life:d.type==='arc'?4:2.6,kind:d.id==='stars'?'star':(d.id==='bubble'?'bubble':''),w:d});}
 }
 G.kick=Math.min(1,G.kick+(d.dmg*d.pellets>60?0.9:0.35));
 Sound.shoot(d.id);
 if(w.ammo<=0)startReload(w);
}
function startReload(w){if(w.reloadT>0||w.ammo===w.d.mag)return;w.reloadT=w.d.reload;Sound.reload();}
function hitscan(o,dir,d,color,tip){
 let best=160,kind=null,bot=null,head=false,n=null;
 if(dir.y<-1e-4){const t=-o.y/dir.y;if(t<best){best=t;kind='w';n=new V3(0,1,0);}}
 {const rw=rayWorld(o,dir,best);if(rw){best=rw.t;kind='w';n=rw.n;}}
 for(const b of G.bots){if(!b.alive||b.spawnT>0)continue;const s=b.scale;
  const th=raySphere(o,dir,new V3(b.pos.x,1.75*s,b.pos.z),0.45*s);if(th>0&&th<best){best=th;kind='b';bot=b;head=true;}
  const tb=raySphere(o,dir,new V3(b.pos.x,0.95*s,b.pos.z),0.62*s);if(tb>0&&tb<best){best=tb;kind='b';bot=b;head=false;}}
 const pt=o.clone().addScaledVector(dir,best);
 if(kind==='b'){G.stats.hits++;damageBot(bot,d.dmg,pt,color,head,d);burst(pt,color,5,3,0.07,0.4);}
 else if(kind==='w'){decal(pt,n,color,d.id==='suction'?0.22:0.12);burst(pt,color,3,2,0.06,0.35);}
 beam(tip,pt,color,d.id==='suction'?0.04:0.025);
}
function damageBot(b,dmg,pt,color,head,w){
 if(!b.alive||b.spawnT>0)return false;
 b.hp-=dmg*(head?1.5:1);b.flash=0.08;if(w.slow)b.slowT=w.slow;
 splatOnBot(b,pt,color);hitMarker(head);if(head){G.stats.heads++;Sound.head();}else Sound.hit();
 if(b.hp<=0)eliminate(b,head);return true;
}
function eliminate(b,head){
 b.alive=false;b.dying=0;b.bar.visible=false;G.stats.elims++;
 const base=10+G.ai*3+G.li*4,pts=b.boss?base*5:base;G.stats.elimPts+=pts;G.stats.points+=pts;if(b.boss)G.stats.boss=true;
 feed(`${head?'🎯 ':''}${b.name} salió de la arena`,'+'+pts);Sound.pop();
 const c=new V3(b.pos.x,1.1*b.scale,b.pos.z);burst(c,RAINBOW.concat([b.color]),b.boss?80:36,7,0.12,1.4);ringFx(b.pos,0xffffff);
}
function splashAt(pt,p){let any=false;for(const b of G.bots){if(!b.alive||b.spawnT>0)continue;const c=new V3(b.pos.x,0.95*b.scale,b.pos.z);const dist=c.distanceTo(pt);if(dist<p.splash+0.5*b.scale){const f=1-0.5*clamp(dist/p.splash,0,1);const near=c.clone().addScaledVector(pt.clone().sub(c).normalize(),0.5);damageBot(b,p.dmg*f,near,p.color,false,p.w);any=true;}}
 burst(pt,[p.color,0xffffff],22,6,0.1,0.7);Sound.splat();return any;}
function damagePlayer(dmg,color){
 if(G.ended)return;const P=G.player;P.shield-=dmg;P.lastHit=G.time;G.stats.dmgTaken+=dmg;G.shake=Math.min(1,G.shake+0.5);
 screenSplat(color);Sound.hurt();
 if(P.shield<=0){P.shield=0;endMatch(false);}
}
function botShoot(b){
 const from=b.g.localToWorld(new V3(0.6,0.78,0.6));const target=new V3(G.player.pos.x,G.player.pos.y+1.2,G.player.pos.z);
 const dist=from.distanceTo(target);target.addScaledVector(G.player.vel,dist/b.pspeed*b.lead);
 const dir=target.sub(from).normalize();const n=b.boss?3:1;
 for(let i=0;i<n;i++){const sd=spreadDir(dir,b.spread);if(n>1)sd.applyAxisAngle(UP,(i-1)*0.12);spawnProj({pos:from.clone(),vel:sd.multiplyScalar(b.pspeed),owner:'bot',dmg:b.dmg,color:b.color,size:0.13,life:3});}
 Sound.botShoot(Math.max(0.15,1-dist/45));
}
function impactNormal(pt,prev){
 if(pt.y<=0.03){pt.y=0.0;return new V3(0,1,0);}
 const b=solidAt(pt,0.05);if(!b)return new V3(0,1,0);if(b.ramp){pt.y=rampH(b,pt.x,pt.z);return b.n.clone();}
 let best=-1,ax='y',sg=1;
 for(const a of['x','y','z']){const mn=b['min'+a.toUpperCase()],mx=b['max'+a.toUpperCase()];if(prev[a]<mn&&mn-prev[a]>best){best=mn-prev[a];ax=a;sg=-1;}if(prev[a]>mx&&prev[a]-mx>best){best=prev[a]-mx;ax=a;sg=1;}}
 pt[ax]=sg>0?b['max'+ax.toUpperCase()]:b['min'+ax.toUpperCase()];const n=new V3();n[ax]=sg;return n;
}
function updateProjs(dt){
 for(let i=G.projs.length-1;i>=0;i--){
  const p=G.projs[i];p.life-=dt;
  if(p.homing){let tgt=null,bd=30;for(const b of G.bots){if(!b.alive||b.spawnT>0)continue;const d=b.pos.distanceTo(p.pos);if(d<bd){bd=d;tgt=b;}}if(tgt){const sp=p.vel.length();const des=new V3(tgt.pos.x,0.95*tgt.scale,tgt.pos.z).sub(p.pos).normalize().multiplyScalar(sp);p.vel.lerp(des,Math.min(1,3.2*dt)).setLength(sp);}p.mesh.rotation.y+=dt*8;}
  if(p.gravity)p.vel.y-=p.gravity*dt;
  if(p.kind==='bubble')p.mesh.scale.setScalar(p.size*(1+Math.sin(G.time*14+i)*0.08));
  const start=p.pos.clone(),end=p.pos.clone().addScaledVector(p.vel,dt);const steps=Math.max(1,Math.ceil(start.distanceTo(end)/0.35));let done=false,prev=start.clone();
  for(let s=1;s<=steps&&!done;s++){
   const pt=start.clone().lerp(end,s/steps);
   if(pt.y<=0.02||solidAt(pt,p.size*0.4)){
    const n=impactNormal(pt,prev);
    if(p.owner==='player'){if(p.splash){if(splashAt(pt,p))G.stats.hits++;splatDecal(pt,n,p.color,0.9);}else{splatDecal(pt,n,p.color,0.22+p.size);burst(pt,p.color,4,2.5,0.06,0.35);}}
    else{splatDecal(pt,n,p.color,0.25);}
    done=true;break;
   }
   if(p.owner==='player'){
    for(const b of G.bots){if(!b.alive||b.spawnT>0)continue;const h=hitBot(b,pt,p.size);if(!h)continue;
     if(p.pierce){if(p.hitSet.has(b))continue;p.hitSet.add(b);if(p.hitSet.size===1)G.stats.hits++;damageBot(b,p.dmg,pt,p.color,h===2,p.w);burst(pt,p.color,6,3,0.07,0.4);continue;}
     G.stats.hits++;if(p.splash)splashAt(pt,p);else{damageBot(b,p.dmg,pt,p.color,h===2,p.w);burst(pt,p.color,6,3,0.07,0.4);}
     done=true;break;}
   }else if(hitPlayer(pt,p.size)){damagePlayer(p.dmg,p.color);done=true;break;}
   prev=pt;
  }
  if(done||p.life<=0||Math.abs(end.x)>H+6||Math.abs(end.z)>H+6||end.y>60){scene.remove(p.mesh);G.projs.splice(i,1);}
  else{p.pos.copy(end);p.mesh.position.copy(end);}
 }
}
function updateParts(dt){
 for(let i=G.parts.length-1;i>=0;i--){const p=G.parts[i];p.life-=dt;if(p.life<=0){scene.remove(p.m);G.parts.splice(i,1);continue;}
  p.v.y-=p.grav*(G.A.grav||1)*dt;p.m.position.addScaledVector(p.v,dt);if(p.m.position.y<0.05){p.m.position.y=0.05;p.v.y*=-0.3;p.v.x*=0.7;p.v.z*=0.7;}
  p.m.rotation.x+=p.sx*dt;p.m.rotation.y+=p.sy*dt;p.m.scale.setScalar(p.s*Math.min(1,p.life/(p.max*0.35)));}
}
function updateFx(dt){
 for(let i=G.fx.length-1;i>=0;i--){const f=G.fx[i];f.life-=dt;if(f.life<=0){scene.remove(f.m);f.m.material.dispose();G.fx.splice(i,1);continue;}
  const k=f.life/f.max;f.m.material.opacity=k*0.9;if(f.ring)f.m.scale.setScalar(0.4+(1-k)*2.2);}
 if(G.snow){const a=G.snow.geometry.attributes.position.array;for(let i=1;i<a.length;i+=3){a[i]-=dt*(1.5+(i%7)*0.15);if(a[i]<0)a[i]=24;}G.snow.geometry.attributes.position.needsUpdate=true;}
}
function updateBot(b,dt,i){
 if(b.spawnT>0){b.spawnT-=dt;b.g.scale.setScalar(b.scale*clamp(1-b.spawnT/0.6,0.01,1));if(b.spawnT<=0){b.g.scale.setScalar(b.scale);b.bar.visible=true;}return;}
 if(!b.alive){b.dying+=dt;const k=1-b.dying/0.45;b.g.scale.setScalar(b.scale*Math.max(0.01,k));b.g.rotation.y+=dt*18;b.g.position.y+=dt*3;if(b.dying>=0.45)removeBot(b,i);return;}
 const P=G.player;const dx=P.pos.x-b.pos.x,dz=P.pos.z-b.pos.z,dist=Math.hypot(dx,dz)||0.001;
 b.losT-=dt;if(b.losT<=0){b.losT=0.25;b.los=los(new V3(b.pos.x,1.7*b.scale,b.pos.z),new V3(P.pos.x,P.pos.y+1.5,P.pos.z));}
 const slow=b.slowT>0?0.45:1;if(b.slowT>0)b.slowT-=dt;
 let mx=0,mz=0;
 if(b.wT>0){b.wT-=dt;mx=b.wdx;mz=b.wdz;}
 else if(!b.los){mx=dx/dist;mz=dz/dist;}
 else{const nx=dx/dist,nz=dz/dist;if(dist>b.pref+3){mx=nx;mz=nz;}else if(dist<b.pref-3){mx=-nx;mz=-nz;}
  b.strafeT-=dt;if(b.strafeT<=0){b.strafe=Math.random()<0.5?1:-1;b.strafeT=1+Math.random()*1.5;}mx+=-nz*b.strafe*0.8;mz+=nx*b.strafe*0.8;}
 const ml=Math.hypot(mx,mz);const moving=ml>0.01&&G.countdown<=0;
 if(moving){const sp=b.speed*slow;b.pos.x+=mx/ml*sp*dt;b.pos.z+=mz/ml*sp*dt;}
 for(const o of G.bots){if(o===b||!o.alive)continue;const ox=b.pos.x-o.pos.x,oz=b.pos.z-o.pos.z,od=Math.hypot(ox,oz),mn=0.6*(b.scale+o.scale);if(od>0.001&&od<mn){b.pos.x+=ox/od*(mn-od)*0.5;b.pos.z+=oz/od*(mn-od)*0.5;}}
 collideXZ(b.pos,0.5*b.scale,0,2*b.scale,0,true);b.pos.x=clamp(b.pos.x,-H+0.8,H-0.8);b.pos.z=clamp(b.pos.z,-H+0.8,H-0.8);
 b.stuckT-=dt;if(b.stuckT<=0){b.stuckT=0.6;if(moving&&b.wT<=0&&Math.hypot(b.pos.x-b.lastX,b.pos.z-b.lastZ)<0.35){const a=Math.random()*Math.PI*2;b.wdx=Math.cos(a);b.wdz=Math.sin(a);b.wT=0.9;}b.lastX=b.pos.x;b.lastZ=b.pos.z;}
 b.g.rotation.y=Math.atan2(dx,dz);
 const bob=moving?Math.abs(Math.sin(G.time*9+b.phase))*0.08:0;b.g.position.set(b.pos.x,bob,b.pos.z);
 if(b.flash>0)b.flash-=dt;b.body.emissive.setHex(b.flash>0?0x777777:(b.slowT>0?0x2a5577:0));
 b.cd-=dt*slow;if(b.cd<=0&&b.los&&dist<46&&!G.ended&&G.countdown<=0){botShoot(b);b.cd=b.fireCd*(0.8+Math.random()*0.5);}
 const r=Math.max(0,b.hp/b.maxHp);b.fill.scale.x=Math.max(0.001,r);b.fill.position.x=-(1-r)*b.barW/2;b.fm.color.setHex(r>0.6?0x5ddc6b:(r>0.3?0xffd93d:0xff8a3d));
 b.bar.position.set(b.pos.x,2.6*b.scale+bob,b.pos.z);b.bar.quaternion.copy(camera.quaternion);
}

/* Arma en primera persona */
function buildViewmodel(){
 if(vm){vmRoot.remove(vm);vm.traverse(o=>{if(o.material)o.material.dispose();if(o.geometry&&!o.geometry.userData.shared)o.geometry.dispose();});}
 const d=G.weapons[G.cur].d;vm=new THREE.Group();
 const bodyM=new THREE.MeshLambertMaterial({color:d.body}),darkM=new THREE.MeshLambertMaterial({color:0x2b2d42}),acc=new THREE.MeshBasicMaterial({color:d.color==='rainbow'?0xff4081:d.color});
 const B=GEO.box,S=GEO.sphere,C=GEO.cyl;
 vm.add(part(B,bodyM,0,0,0,0.13,0.15,0.5));const grip=part(B,darkM,0,-0.15,0.12,0.1,0.2,0.12);grip.rotation.x=0.3;vm.add(grip);
 const br=part(C,darkM,0,0.02,-0.36,0.035,0.3,0.035);br.rotation.x=Math.PI/2;vm.add(br);vm.add(part(S,acc,0,0.02,-0.52,0.05,0.05,0.05));
 if(['paint','hose','balloon','bubble'].includes(d.id)){vm.add(part(S,new THREE.MeshBasicMaterial({color:d.color==='rainbow'?0xffeb3b:d.color,transparent:true,opacity:0.8}),0,0.15,-0.02,0.09,0.09,0.09));}
 if(d.id==='laser'||d.id==='freeze'){vm.add(part(B,acc,0.068,0.02,-0.05,0.01,0.04,0.4),part(B,acc,-0.068,0.02,-0.05,0.01,0.04,0.4));}
 if(d.id==='confetti'){const cn=new THREE.Mesh(new THREE.ConeGeometry(0.09,0.22,10,1,true),new THREE.MeshLambertMaterial({color:0xffeb3b,side:THREE.DoubleSide}));cn.rotation.x=-Math.PI/2;cn.position.set(0,0.02,-0.48);vm.add(cn);}
 if(d.id==='suction'){vm.add(part(B,darkM,0,0.04,-0.32,0.55,0.03,0.05));vm.add(part(S,new THREE.MeshLambertMaterial({color:0xff7043}),0,0.04,-0.6,0.06,0.06,0.03));}
 if(d.id==='stars'||d.id==='rainbow'){RAINBOW.slice(0,3).forEach((c,k)=>{const r=new THREE.Mesh(new THREE.TorusGeometry(0.06,0.012,6,16),new THREE.MeshBasicMaterial({color:c}));r.position.set(0,0.02,-0.25-k*0.08);vm.add(r);});}
 if(d.zoom&&!d.scope){vm.add(part(B,darkM,0,0.105,0.16,0.04,0.05,0.025),part(B,acc,0,0.1,-0.42,0.018,0.04,0.018));}
 if(d.scope){const sc=part(C,darkM,0,0.13,-0.05,0.045,0.34,0.045);sc.rotation.x=Math.PI/2;vm.add(sc);}
 vmTip=new THREE.Object3D();vmTip.position.set(0,0.02,-0.58);vm.add(vmTip);
 vm.position.set(0.28,-0.27,-0.55);vmRoot.add(vm);
}
function switchW(i){if(!G||i===G.cur||!G.weapons[i])return;G.cur=i;G.swapT=0.22;buildViewmodel();Sound.click();updateHUD();}

/* HUD */
function updateHUD(){
 $('#hScore').textContent=fmt(G.stats.points)+' pts';
 $('#hWave').textContent=`Oleada ${Math.max(1,G.wave)}/${G.waves}`;
 $('#hBots').textContent='🤖 '+(G.bots.filter(b=>b.alive).length+G.spawnQ.length);
 $('#hShield').style.width=G.player.shield+'%';$('#hShieldBox').classList.toggle('low',G.player.shield<30);
 const w=G.weapons[G.cur];$('#hWName').textContent=w.d.emoji+' '+w.d.name;
 $('#hAmmo').textContent=w.reloadT>0?'Recargando…':`${w.ammo} / ${w.d.mag}`;
 $('#tZoom').style.display=w.d.zoom?'grid':'none';$('#tZoom').classList.toggle('on',!!G.input.zoom);
 $('#hSlots').innerHTML=G.weapons.map((x,i)=>`<span class="${i===G.cur?'on':''}">${i+1} ${x.d.emoji}</span>`).join('');
}
function hitMarker(head){const h=$('#hitm');h.classList.remove('show','head');void h.offsetWidth;h.classList.add('show');if(head)h.classList.add('head');}
function feed(text,pts){const el=document.createElement('div');el.className='fi';el.innerHTML=`<span></span><b></b>`;el.firstChild.textContent=text;el.lastChild.textContent=pts;const f=$('#feed');f.prepend(el);while(f.children.length>5)f.lastChild.remove();setTimeout(()=>el.remove(),2700);}
function banner(text,sub){const b=$('#banner');b.innerHTML='';b.append(text);if(sub){const s=document.createElement('small');s.textContent=sub;b.append(s);}b.classList.remove('show');void b.offsetWidth;b.classList.add('show');}
function bigCount(t){const c=$('#count');c.textContent=t;c.classList.remove('show');void c.offsetWidth;c.classList.add('show');}
function screenSplat(color){const box=$('#splats');if(box.children.length>6)box.firstChild.remove();const el=document.createElement('div');el.className='splat';const a=Math.random()*Math.PI*2;el.style.left=(50+Math.cos(a)*38)+'%';el.style.top=(50+Math.sin(a)*36)+'%';const c='#'+hex(color);el.style.background=`radial-gradient(circle at 50% 50%,${c} 0 34%,transparent 35%),radial-gradient(circle at 78% 30%,${c} 0 9%,transparent 10%),radial-gradient(circle at 22% 72%,${c} 0 7%,transparent 8%),radial-gradient(circle at 70% 80%,${c} 0 6%,transparent 7%)`;box.append(el);setTimeout(()=>el.remove(),1350);}
let hintT=0;function hint(text,ms){const h=$('#hint');h.textContent=text;h.classList.add('show');clearTimeout(hintT);hintT=setTimeout(()=>h.classList.remove('show'),ms||5000);}

/* Partida */
function startMatch(ai,li){
 if(!initRenderer())return;
 tryLandscape();Sound.click();disposeScene();
 const A=ARENAS[ai];
 G={ai,li,A,active:true,paused:false,ended:false,done:false,endT:0,time:0,countdown:4,lastCount:5,
  boxes:[],ramps:[],bots:[],projs:[],parts:[],fx:[],decals:[],spawnQ:[],snow:null,
  grav:20*(A.grav||1),wave:0,waves:li+1,waveDelay:-1,diff:ai*3+li,
  input:{fire:false,zoom:false,jump:false,jx:0,jy:0},keys:{},
  player:{pos:new V3(0,0,H-6),vel:new V3(),yaw:0,pitch:0,onGround:true,shield:100,lastHit:-99},
  weapons:save.loadout.map(id=>{const d=W(id);return{d,ammo:d.mag,cd:0,reloadT:0};}),cur:0,
  stats:{shots:0,hits:0,elims:0,dmgTaken:0,points:0,elimPts:0,heads:0,boss:false},
  kick:0,shake:0,bobT:0,ads:0,swapT:0,hudT:0,aimT:0,aimOn:false,zoomOn:false};
 buildWorld(A,1000+ai*97+li*13);buildViewmodel();
 camera.fov=75;camera.updateProjectionMatrix();
 document.body.classList.add('ingame');gameEl.classList.add('active');gameEl.classList.toggle('touch',isTouch);
 $('#pause').classList.remove('show');$('#feed').innerHTML='';$('#splats').innerHTML='';
 $('#afRow').style.display=isTouch?'flex':'none';
 onResize();updateHUD();
 banner(`${A.emoji} ${A.name}`,`Nivel ${li+1}: ${LVL_NAMES[li]}`);
 if(!isTouch)requestLock();
 if(save.matches<3)hint(isTouch?'Izquierda: moverte. Derecha: mirar. 🎯 dispara.':'WASD para moverte, mouse para apuntar, clic para disparar, Espacio para saltar, Q para cambiar de arma',7000);
}
function startWave(){
 G.wave++;const P=diffParams();const n=P.count;const boss=G.wave===G.waves&&G.li===2;
 if(G.wave>1){banner(`Oleada ${G.wave} de ${G.waves}`,'¡Vienen más bots!');Sound.wave();}
 for(let i=0;i<n;i++)G.spawnQ.push({t:0.3+i*0.45,boss:false});
 if(boss)G.spawnQ.push({t:0.9+n*0.45,boss:true});
}
function endMatch(win){
 if(G.ended)return;G.ended=true;G.won=win;G.endT=win?1.8:1.6;G.input.fire=false;
 if(win){banner('¡Victoria!','Todos los bots salieron de la arena');Sound.win();burst(new V3(G.player.pos.x,2.5,G.player.pos.z-3),RAINBOW,60,8,0.12,1.6);}
 else{banner('¡Te llenaron de pintura!','Tu escudo se acabó, inténtalo otra vez');Sound.lose();}
}
function finish(){
 G.active=false;if(document.pointerLockElement)document.exitPointerLock();
 gameEl.classList.remove('active','zoom');document.body.classList.remove('ingame');$('#pause').classList.remove('show');
 showResults();
}
function quitMatch(){if(!G)return;G.active=false;if(document.pointerLockElement)document.exitPointerLock();gameEl.classList.remove('active','zoom');document.body.classList.remove('ingame');$('#pause').classList.remove('show');show('arenas');}
function setPause(p){if(!G||!G.active||G.ended)return;G.paused=p;$('#pause').classList.toggle('show',p);if(p){G.input.fire=false;G.input.zoom=false;G.keys={};}$('#sens').value=save.sens;$('#pMute').textContent=save.muted?'🔇 Sonido apagado':'🔊 Sonido encendido';$('#afBtn').textContent=save.autoFire?'Sí':'No';}

function updatePlayer(dt){
 const P=G.player,k=G.keys,I=G.input;
 let f=((k.KeyW||k.ArrowUp)?1:0)-((k.KeyS||k.ArrowDown)?1:0)-I.jy,s=(k.KeyD?1:0)-(k.KeyA?1:0)+I.jx;
 const turn=(k.ArrowLeft?1:0)-(k.ArrowRight?1:0);P.yaw+=turn*2.4*dt*save.sens;
 if(noLockMode&&!isTouch&&!G.paused){const ex=mouse.x/window.innerWidth;if(ex<0.06)P.yaw+=2.2*dt*save.sens;else if(ex>0.94)P.yaw-=2.2*dt*save.sens;}
 const len=Math.hypot(f,s);if(len>1){f/=len;s/=len;}
 const sp=G.zoomOn?4:((k.ShiftLeft||k.ShiftRight)?9.5:7);
 const fx=-Math.sin(P.yaw),fz=-Math.cos(P.yaw),rx=Math.cos(P.yaw),rz=-Math.sin(P.yaw);
 const tx=(fx*f+rx*s)*sp,tz=(fz*f+rz*s)*sp,a=Math.min(1,(P.onGround?14:5)*dt);
 P.vel.x+=(tx-P.vel.x)*a;P.vel.z+=(tz-P.vel.z)*a;
 if((k.Space||I.jump)&&P.onGround){P.vel.y=7.6;P.onGround=false;I.jump=false;Sound.jump();}
 const wasGround=P.onGround;P.vel.y-=G.grav*dt;
 P.pos.x+=P.vel.x*dt;P.pos.z+=P.vel.z*dt;
 collideXZ(P.pos,0.45,P.pos.y,1.75,0.4,false);
 P.pos.x=clamp(P.pos.x,-H+0.6,H-0.6);P.pos.z=clamp(P.pos.z,-H+0.6,H-0.6);
 const prevY=P.pos.y;P.pos.y+=P.vel.y*dt;
 const gh=groundHeight(P.pos.x,P.pos.z,0.32,prevY,0.4);
 if(P.pos.y<=gh){P.pos.y=gh;if(P.vel.y<0)P.vel.y=0;P.onGround=true;}
 else if(wasGround&&P.vel.y<=0&&P.pos.y-gh<0.35){P.pos.y=gh;P.vel.y=0;P.onGround=true;}
 else P.onGround=P.pos.y-gh<0.05;
}
function setCamera(dt){
 const P=G.player,hs=Math.hypot(P.vel.x,P.vel.z);if(P.onGround&&hs>1)G.bobT+=dt*hs*1.5;
 const bob=Math.sin(G.bobT)*0.045*(P.onGround?Math.min(1,hs/7):0);
 G.kick=Math.max(0,G.kick-dt*5);G.shake=Math.max(0,G.shake-dt*3);G.swapT=Math.max(0,G.swapT-dt);
 const sx=(Math.random()-0.5)*G.shake*0.15,sy=(Math.random()-0.5)*G.shake*0.15;
 camera.position.set(P.pos.x+sx,P.pos.y+1.6+bob+sy,P.pos.z);camera.rotation.set(P.pitch+G.kick*0.025,P.yaw,0);
 camera.updateMatrixWorld();vmRoot.position.copy(camera.position);vmRoot.quaternion.copy(camera.quaternion);
 const cw=G.weapons[G.cur].d;G.ads+=((G.zoomOn?1:0)-G.ads)*Math.min(1,dt*14);const ad=G.ads,bw=1-ad*0.8;
 vm.position.set(0.28*(1-ad)+Math.cos(G.bobT*0.5)*0.012*bw,-0.27+ad*0.13-Math.abs(Math.sin(G.bobT*0.5))*0.012*bw-G.swapT*1.2,-0.55+ad*0.12+G.kick*0.09);vm.rotation.x=G.kick*0.12;vm.visible=!(G.zoomOn&&cw.scope);
}
function botUnderCrosshair(){const o=camera.position,d=new V3();camera.getWorldDirection(d);let bt=70;for(const b of G.bots){if(!b.alive||b.spawnT>0)continue;const s=b.scale;const t1=raySphere(o,d,new V3(b.pos.x,0.95*s,b.pos.z),0.75*s),t2=raySphere(o,d,new V3(b.pos.x,1.75*s,b.pos.z),0.5*s);[t1,t2].forEach(t=>{if(t>0&&t<bt)bt=t;});}if(bt>=70)return false;return !rayWorld(o,d,bt);}
function update(dt){
 G.time+=dt;
 if(G.countdown>0){const n=Math.ceil(G.countdown);if(n!==G.lastCount&&n<=3){G.lastCount=n;bigCount(n);Sound.tick();}G.countdown-=dt;if(G.countdown<=0){bigCount('¡Ya!');Sound.go();startWave();}}
 updatePlayer(dt);
 for(const w of G.weapons){if(w.cd>0)w.cd-=dt;if(w.reloadT>0){w.reloadT-=dt;if(w.reloadT<=0){w.reloadT=0;w.ammo=w.d.mag;}}}
 const cw=G.weapons[G.cur].d;G.zoomOn=!!(G.input.zoom&&cw.zoom&&!G.ended);gameEl.classList.toggle('zoom',G.zoomOn&&!!cw.scope);gameEl.classList.toggle('ads',G.zoomOn&&!cw.scope);
 const tf=G.zoomOn?cw.zoom:75;if(Math.abs(camera.fov-tf)>0.05){camera.fov+=(tf-camera.fov)*Math.min(1,dt*12);camera.updateProjectionMatrix();}
 setCamera(dt);
 let want=G.input.fire;
 if(isTouch&&save.autoFire&&G.countdown<=0&&!G.ended){G.aimT-=dt;if(G.aimT<=0){G.aimT=0.08;G.aimOn=botUnderCrosshair();$('#cross').classList.toggle('aim',G.aimOn);}if(G.aimOn)want=true;}
 if(want&&G.countdown<=0&&!G.ended)fire();
 for(let i=G.spawnQ.length-1;i>=0;i--){const q=G.spawnQ[i];q.t-=dt;if(q.t<=0){G.spawnQ.splice(i,1);spawnBot(q.boss);}}
 for(let i=G.bots.length-1;i>=0;i--)updateBot(G.bots[i],dt,i);
 updateProjs(dt);updateParts(dt);updateFx(dt);
 const P=G.player;if(!G.ended&&G.time-P.lastHit>3.5&&P.shield<100)P.shield=Math.min(100,P.shield+16*dt);
 if(!G.ended&&G.wave>0&&G.spawnQ.length===0&&!G.bots.some(b=>b.alive)){
  if(G.wave<G.waves){if(G.waveDelay<0)G.waveDelay=2.2;else{G.waveDelay-=dt;if(G.waveDelay<=0){G.waveDelay=-1;startWave();}}}
  else endMatch(true);
 }
 if(G.ended){G.endT-=dt;if(G.endT<=0&&!G.done){G.done=true;finish();return;}}
 G.hudT-=dt;if(G.hudT<=0){G.hudT=0.1;updateHUD();}
}
let lastT=performance.now();
function loop(now){
 requestAnimationFrame(loop);const dt=Math.min(0.05,(now-lastT)/1000);lastT=now;
 if(!G||!G.active||!scene)return;
 if(!G.paused)update(dt);
 if(!G.active)return;
 renderer.autoClear=false;renderer.clear();renderer.render(scene,camera);renderer.clearDepth();if(vm&&vm.visible)renderer.render(vmScene,camera);
}

/* Resultados */
function showResults(){
 const st=G.stats,win=G.won,acc=st.shots?st.hits/st.shots:0,lines=[];
 lines.push([`Bots fuera de la arena: ${st.elims}`,st.elimPts]);
 let stars=0;
 if(win){
  const comp=60+G.ai*25+G.li*30,accB=Math.round(acc*80);lines.push(['Nivel completado',comp]);lines.push([`Puntería del ${Math.round(acc*100)}%`,accB]);
  if(st.dmgTaken===0)lines.push(['¡Sin una sola mancha!',100]);else if(st.dmgTaken<50)lines.push(['Casi sin manchas',40]);
  stars=1+(st.dmgTaken<60?1:0)+(acc>=0.35?1:0);
 }
 const total=lines.reduce((s,l)=>s+l[1],0);
 const key=G.ai+'-'+G.li,before=save.xp,lvlB=levelOf(before);
 const unlockedBefore=ARENAS.map((_,a)=>[0,1,2].map(l=>isUnlocked(a,l)));
 if(win&&stars>(save.stars[key]||0))save.stars[key]=stars;
 save.xp=before+total;save.matches++;save.elims+=st.elims;if(win)save.wins++;persist();
 const lvlA=levelOf(save.xp);
 $('#rTitle').textContent=win?'¡Victoria!':'¡Casi lo logras!';$('#rTitle').className='rtitle '+(win?'win':'lose');
 $('#rSub').textContent=`${G.A.emoji} ${G.A.name}, nivel ${G.li+1} (${LVL_NAMES[G.li]})`+(win?'':'. Te quedas con los puntos de los bots que sacaste.');
 $('#rStars').innerHTML=win?`${'★'.repeat(stars)}<em>${'★'.repeat(3-stars)}</em>`:'';
 $('#rLines').innerHTML='';lines.forEach(([t,v])=>{const d=document.createElement('div');d.className='rl';d.innerHTML='<span></span><b></b>';d.firstChild.textContent=t;d.lastChild.textContent='+'+fmt(v);$('#rLines').append(d);});
 $('#rTotal').textContent=fmt(total);
 const un=$('#rUnl');un.innerHTML='';const add=t=>{const d=document.createElement('div');d.textContent=t;un.append(d);};
 if(lvlA>lvlB)add(`⬆️ ¡Subiste al nivel ${lvlA}! Ahora eres ${rankOf(lvlA)}.`);
 WEAPONS.filter(w=>w.unlock>lvlB&&w.unlock<=lvlA).forEach(w=>add(`${w.emoji} Nueva arma: ${w.name}`));
 ARENAS.forEach((A,a)=>[0,1,2].forEach(l=>{if(!unlockedBefore[a][l]&&isUnlocked(a,l))add(l===0?`${A.emoji} Nueva arena: ${A.name}`:`🔓 Abriste el nivel ${l+1} de ${A.name}`);}));
 let next=null;if(win){if(G.li<2)next=[G.ai,G.li+1];else if(G.ai<8)next=[G.ai+1,0];}
 const nb=$('#rNext');if(next&&isUnlocked(next[0],next[1])){nb.style.display='';nb.textContent=next[1]===0?`Siguiente arena: ${ARENAS[next[0]].emoji} ${ARENAS[next[0]].name} ▶`:`Siguiente: nivel ${next[1]+1} ▶`;nb.onclick=()=>{sel={arena:next[0],level:next[1]};startMatch(next[0],next[1]);};}else nb.style.display='none';
 const ai=G.ai,li=G.li;$('#rRetry').onclick=()=>startMatch(ai,li);
 show('results');animateXp(before,save.xp);
}
function animateXp(from,to){
 const start=performance.now(),dur=Math.min(2200,600+(to-from)*3);let lastL=levelOf(from);
 function paint(v){const pr=levelProgress(v);$('#rLevel').textContent=pr.l;$('#rRank').textContent=rankOf(pr.l);$('#rXp').style.width=(pr.cur*100)+'%';$('#rXpTxt').textContent=pr.l>=MAX_LEVEL?'¡Nivel máximo!':`${fmt(pr.have)} de ${fmt(pr.span)} puntos para el nivel ${pr.l+1}`;return pr.l;}
 paint(from);
 function step(now){const t=Math.min(1,(now-start)/dur),e=1-Math.pow(1-t,3);const l=paint(from+(to-from)*e);if(l>lastL){lastL=l;Sound.level();const b=$('#rBadge');b.classList.remove('pulse');void b.offsetWidth;b.classList.add('pulse');}if(t<1)requestAnimationFrame(step);}
 requestAnimationFrame(step);
}
$('#rArenas').onclick=()=>show('arenas');$('#rMenu').onclick=()=>show('menu');

/* Controles */
function requestLock(){
 if(isTouch||noLockMode)return;
 try{const r=canvas.requestPointerLock();if(r&&r.catch)r.catch(()=>lockFailed());}catch(e){lockFailed();}
}
function lockFailed(){
 if(lockWorked){setPause(true);toast('Espera un segundo y toca Continuar otra vez.');return;}
 if(!noLockMode){noLockMode=true;hint('Mueve el mouse para apuntar; acércalo a los bordes o usa las flechas para girar del todo. Abre el juego en su propia página para un control más cómodo.',8000);}
}
document.addEventListener('pointerlockerror',lockFailed);
document.addEventListener('pointerlockchange',()=>{locked=document.pointerLockElement===canvas;if(locked)lockWorked=true;if(!locked&&G&&G.active&&!G.ended&&!noLockMode&&!isTouch)setPause(true);});
canvas.addEventListener('mousedown',e=>{if(!G||!G.active||G.paused||isTouch)return;if(!locked&&!noLockMode){requestLock();return;}if(e.button===0)G.input.fire=true;if(e.button===2)G.input.zoom=true;});
window.addEventListener('mouseup',e=>{if(!G)return;if(e.button===0)G.input.fire=false;if(e.button===2)G.input.zoom=false;});
canvas.addEventListener('contextmenu',e=>e.preventDefault());
window.addEventListener('mousemove',e=>{mouse.x=e.clientX;mouse.y=e.clientY;if(!G||!G.active||G.paused||isTouch)return;if(locked||noLockMode){const s=0.0022*save.sens*(G.zoomOn?camera.fov/75:1);G.player.yaw-=e.movementX*s;G.player.pitch=clamp(G.player.pitch-e.movementY*s,-1.45,1.45);}});
window.addEventListener('wheel',e=>{if(G&&G.active&&!G.paused)switchW(1-G.cur);},{passive:true});
window.addEventListener('keydown',e=>{
 if(!G||!G.active)return;
 if(['Space','ArrowUp','ArrowDown','ArrowLeft','ArrowRight'].includes(e.code))e.preventDefault();
 if(e.code==='KeyP'||(e.code==='Escape'&&(noLockMode||!locked))){setPause(!G.paused);return;}
 if(G.paused)return;
 G.keys[e.code]=true;
 if(e.code==='Digit1')switchW(0);else if(e.code==='Digit2')switchW(1);else if(e.code==='KeyQ')switchW(1-G.cur);else if(e.code==='KeyR')startReload(G.weapons[G.cur]);
});
window.addEventListener('keyup',e=>{if(G)G.keys[e.code]=false;});
document.addEventListener('visibilitychange',()=>{if(document.hidden&&G&&G.active)setPause(true);});
$('#hPause').addEventListener('click',e=>{e.stopPropagation();if(document.pointerLockElement)document.exitPointerLock();setPause(true);});
$('#pResume').onclick=()=>{setPause(false);requestLock();};
$('#pQuit').onclick=()=>quitMatch();
$('#pMute').onclick=()=>toggleMute();
$('#sens').oninput=e=>{save.sens=parseFloat(e.target.value);persist();};
$('#afBtn').onclick=()=>{save.autoFire=!save.autoFire;persist();$('#afBtn').textContent=save.autoFire?'Sí':'No';};

/* Orientación horizontal */
function tryLandscape(){
 if(!isTouch)return;
 try{const el=document.documentElement;const p=(!document.fullscreenElement&&el.requestFullscreen)?el.requestFullscreen({navigationUI:'hide'}):Promise.resolve();
  p.then(()=>{if(screen.orientation&&screen.orientation.lock)return screen.orientation.lock('landscape');}).catch(()=>{});}catch(e){}
}
const portraitMQ=window.matchMedia?matchMedia('(orientation: portrait) and (pointer: coarse)'):null;
function onOrient(){if(portraitMQ&&portraitMQ.matches&&G&&G.active&&!G.ended&&!G.paused)setPause(true);}
if(portraitMQ){if(portraitMQ.addEventListener)portraitMQ.addEventListener('change',onOrient);else if(portraitMQ.addListener)portraitMQ.addListener(onOrient);}
$('#rotBtn').onclick=()=>tryLandscape();
document.addEventListener('touchend',function once(){tryLandscape();document.removeEventListener('touchend',once);},{passive:true});

/* Táctil */
const T={joy:null,ox:0,oy:0,look:null,lx:0,ly:0,fire:null,fx:0,fy:0};
const tl=$('#touch'),joyB=$('#joyBase'),joyK=$('#joyKnob');
function lookDelta(dx,dy){const s=0.0055*save.sens*(G&&G.zoomOn?camera.fov/75:1);G.player.yaw-=dx*s;G.player.pitch=clamp(G.player.pitch-dy*s,-1.45,1.45);}
tl.addEventListener('touchstart',e=>{if(!G||G.paused)return;e.preventDefault();for(const t of e.changedTouches){if(t.clientX<window.innerWidth*0.45&&T.joy===null){T.joy=t.identifier;T.ox=t.clientX;T.oy=t.clientY;joyB.style.display='block';joyB.style.left=t.clientX+'px';joyB.style.top=t.clientY+'px';joyK.style.transform='';}else if(T.look===null){T.look=t.identifier;T.lx=t.clientX;T.ly=t.clientY;}}},{passive:false});
tl.addEventListener('touchmove',e=>{if(!G)return;e.preventDefault();for(const t of e.changedTouches){
 if(t.identifier===T.joy){let dx=t.clientX-T.ox,dy=t.clientY-T.oy;const d=Math.hypot(dx,dy),m=52;if(d>m){dx=dx/d*m;dy=dy/d*m;}joyK.style.transform=`translate(${dx}px,${dy}px)`;G.input.jx=dx/m;G.input.jy=dy/m;}
 else if(t.identifier===T.look){lookDelta(t.clientX-T.lx,t.clientY-T.ly);T.lx=t.clientX;T.ly=t.clientY;}
 else if(t.identifier===T.fire){lookDelta(t.clientX-T.fx,t.clientY-T.fy);T.fx=t.clientX;T.fy=t.clientY;}}},{passive:false});
function tEnd(e){for(const t of e.changedTouches){if(t.identifier===T.joy){T.joy=null;joyB.style.display='none';if(G){G.input.jx=0;G.input.jy=0;}}if(t.identifier===T.look)T.look=null;if(t.identifier===T.fire){T.fire=null;if(G)G.input.fire=false;$('#tFire').classList.remove('on');}}}
tl.addEventListener('touchend',tEnd);tl.addEventListener('touchcancel',tEnd);
function tbtn(id,fn){const b=$(id);b.addEventListener('touchstart',e=>{e.preventDefault();e.stopPropagation();if(!G||G.paused)return;fn(e.changedTouches[0]);},{passive:false});}
tbtn('#tFire',t=>{T.fire=t.identifier;T.fx=t.clientX;T.fy=t.clientY;G.input.fire=true;$('#tFire').classList.add('on');});
tbtn('#tJump',()=>{G.input.jump=true;});
tbtn('#tSwap',()=>switchW(1-G.cur));
tbtn('#tReload',()=>startReload(G.weapons[G.cur]));
tbtn('#tZoom',()=>{G.input.zoom=!G.input.zoom;updateHUD();});

renderMenu();
})();
</script>
</body>
</html>
$TF$, true, true, true, true, 1, CURRENT_TIMESTAMP)
ON CONFLICT ("slug") DO NOTHING;

INSERT INTO "Game" ("id", "slug", "title", "description", "ageLabel", "emoji", "color", "html", "fullHeight", "free", "unlisted", "published", "order", "updatedAt")
VALUES ('game_golazo_latino', 'golazo-latino', $TF$Golazo Latino · Pase a pase hasta el gol$TF$, $TF$Arma tu jugador y tu equipo y juega de Medellín a Río: desliza desde el balón para pasar o rematar y gana monedas, estrellas y accesorios.$TF$, $TF$$TF$, $TF$⚽$TF$, '#1F8A5B', $TF$<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>Golazo · Ruta Latina</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bungee&family=Fredoka:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
:root{
  --bg:#e7ebf6; --spot1:rgba(255,90,31,.10); --spot2:rgba(0,148,255,.10); --spot3:rgba(43,212,106,.12);
  --surface:#ffffff; --surface-2:#edf0f9; --surface-3:#d6dcee;
  --text:#0e1430; --muted:#4b5579; --line:rgba(14,20,48,.14);
  --pink:#ec4a10; --blue:#0a7cff; --yellow:#ffc400; --green:#1fbf5c; --neon:#3dff8f;
  --on-accent:#ffffff; --on-yellow:#2b2100;
  --star:#f0a500; --star-off:#c9cfe3;
  --shadow:0 6px 0 rgba(14,20,48,.2); --shadow-sm:0 3px 0 rgba(14,20,48,.18);
  --hud-bg:rgba(8,12,30,.62); --hud-text:#ffffff; --hud-muted:rgba(255,255,255,.78);
  --scrim:rgba(6,10,26,.72);
  color-scheme:light;
  box-sizing:border-box;
  padding-top:env(safe-area-inset-top,0px);
  padding-bottom:env(safe-area-inset-bottom,0px);
}
@media (prefers-color-scheme: dark){
  :root:not([data-theme="light"]){
    --bg:#0a0f22; --spot1:rgba(255,90,31,.10); --spot2:rgba(0,148,255,.10); --spot3:rgba(43,212,106,.08);
    --surface:#141b38; --surface-2:#1b2449; --surface-3:#28335f;
    --text:#eef2ff; --muted:#9ba7d4; --line:rgba(255,255,255,.12);
    --pink:#ff5a1f; --blue:#1a8cff; --green:#2bd46a;
    --star:#ffc400; --star-off:#36406e;
    --shadow:0 6px 0 rgba(0,0,0,.5); --shadow-sm:0 3px 0 rgba(0,0,0,.45);
    color-scheme:dark;
  }
}
:root[data-theme="dark"]{
    --bg:#0a0f22; --spot1:rgba(255,90,31,.10); --spot2:rgba(0,148,255,.10); --spot3:rgba(43,212,106,.08);
    --surface:#141b38; --surface-2:#1b2449; --surface-3:#28335f;
    --text:#eef2ff; --muted:#9ba7d4; --line:rgba(255,255,255,.12);
    --pink:#ff5a1f; --blue:#1a8cff; --green:#2bd46a;
    --star:#ffc400; --star-off:#36406e;
    --shadow:0 6px 0 rgba(0,0,0,.5); --shadow-sm:0 3px 0 rgba(0,0,0,.45);
    color-scheme:dark;
}
*,*::before,*::after{box-sizing:inherit}
html{height:100%;scroll-padding-top:env(safe-area-inset-top,0px);-webkit-text-size-adjust:100%}
html,body{height:100%}
body{margin:0;background-color:var(--bg);
  background-image:linear-gradient(118deg,var(--spot1) 0 16%,transparent 16% 100%),linear-gradient(118deg,transparent 0 84%,var(--spot2) 84% 100%),linear-gradient(118deg,transparent 0 17.5%,var(--spot3) 17.5% 19%,transparent 19% 100%);
  background-attachment:fixed;color:var(--text);
  font-family:'Fredoka','Trebuchet MS','Segoe UI',system-ui,sans-serif;
  -webkit-tap-highlight-color:transparent;overflow:hidden}
button,input{font-family:inherit}
button{cursor:pointer}
button:focus-visible,input:focus-visible{outline:3px solid var(--blue);outline-offset:3px}
#app{height:100%}
.screen{display:none;flex-direction:column;height:100%;max-width:1200px;margin:0 auto;
  padding:12px calc(env(safe-area-inset-right,0px) + 16px) 12px calc(env(safe-area-inset-left,0px) + 16px);overflow:auto}
.screen.active{display:flex}
h2{margin:0;font-family:'Bungee','Impact','Arial Black',sans-serif;font-weight:400;letter-spacing:.5px;font-size:clamp(20px,3.6vw,30px)}
.bar{display:flex;align-items:center;gap:12px;margin-bottom:12px;flex:none}
.grow{flex:1;min-width:0}
.icon-btn{width:48px;height:48px;flex:none;border-radius:16px;border:0;background:var(--surface);color:var(--text);box-shadow:var(--shadow-sm);font-size:22px;font-weight:700}
.icon-btn:active{transform:translateY(2px);box-shadow:none}
.coins{background:var(--surface);border-radius:16px;box-shadow:var(--shadow-sm);padding:8px 14px;font-weight:700;font-size:18px;white-space:nowrap}
.btn{border:0;border-radius:18px;padding:13px 20px;font-size:18px;font-weight:600;background:var(--surface);color:var(--text);box-shadow:var(--shadow);transition:transform .08s,box-shadow .08s}
.btn:active{transform:translateY(4px);box-shadow:var(--shadow-sm)}
.btn.big{font-size:22px;padding:16px 22px;width:100%;text-align:left}
.btn.primary{background:var(--pink);color:var(--on-accent)}
.btn.blue{background:var(--blue);color:var(--on-accent)}
.btn.yellow{background:var(--yellow);color:var(--on-yellow)}
.btn.green{background:var(--green);color:#06210f}
.btn:disabled{opacity:.45;cursor:not-allowed}

/* Logo */
.logo span{display:inline-block}
.logo{font-family:'Bungee','Impact','Arial Black',sans-serif;font-weight:400;line-height:.95;font-size:clamp(38px,8vw,74px);letter-spacing:-1px;display:inline-block}
.logo .l1{color:#ffffff;text-shadow:3px 3px 0 var(--pink),6px 6px 0 #0e1430,-2px -2px 0 #0e1430,2px -2px 0 #0e1430,-2px 2px 0 #0e1430}
.logo .l2{color:var(--neon);text-shadow:3px 3px 0 var(--blue),6px 6px 0 #0e1430,-2px -2px 0 #0e1430,2px -2px 0 #0e1430,-2px 2px 0 #0e1430}
.logo small{display:block;font-family:'Fredoka','Trebuchet MS',sans-serif;font-size:clamp(14px,2.2vw,18px);font-weight:500;color:var(--muted);letter-spacing:0;margin-top:10px;text-shadow:none}

/* Menú */
.hero{display:grid;grid-template-columns:minmax(0,1.35fr) minmax(0,1fr);gap:18px;margin-top:16px;flex:1;min-height:0;align-items:center}
@media (max-width:640px){.hero{grid-template-columns:minmax(0,1fr);flex:none}}
.card{background:var(--surface);border-radius:24px;box-shadow:var(--shadow);padding:18px}
.pc{display:flex;gap:16px;align-items:center}
.ava{width:104px;height:104px;flex:none;border-radius:50%;background:conic-gradient(var(--pink),var(--yellow),var(--neon),var(--blue),var(--pink));display:grid;place-items:center}
.ava svg{width:90px;height:90px;border-radius:50%;background:var(--surface-2)}
.ava.pulse{animation:pulse .5s ease}
@keyframes pulse{50%{transform:scale(1.15)}}
.pinfo{flex:1;min-width:0}
.kicker{color:var(--muted);font-size:15px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.rank{font-size:24px;font-weight:700;margin:2px 0 8px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.xpbar{height:16px;border-radius:99px;background:var(--surface-3);overflow:hidden}
.xpbar i{display:block;height:100%;width:0;background:linear-gradient(90deg,var(--blue),var(--neon));border-radius:99px;transition:width .6s}
.xptxt{font-size:13px;color:var(--muted);margin-top:5px}
.chips{display:grid;grid-template-columns:repeat(4,1fr);gap:10px;margin-top:14px}
@media (max-width:520px){.chips{grid-template-columns:repeat(2,1fr)}}
.chip{background:var(--surface-2);border-radius:14px;padding:8px 10px}
.chip b{display:block;font-size:20px}
.chip span{font-size:12.5px;color:var(--muted)}
.next{margin-top:12px;font-size:14px;color:var(--muted)}
.menu-btns{display:flex;flex-direction:column;gap:12px;justify-content:center}
.foot{color:var(--muted);font-size:13px;margin-top:10px;flex:none}

/* Crear jugador y equipo */
.create{display:grid;grid-template-columns:minmax(0,1fr) minmax(0,1.2fr);gap:16px;flex:1;min-height:0}
@media (max-width:640px){.create{grid-template-columns:minmax(0,1fr);flex:none}.preview{height:260px}}
.preview{display:flex;flex-direction:column;align-items:center;justify-content:center;gap:8px;min-height:0;overflow:hidden}
#cPrev{flex:1;min-height:0;width:100%;display:flex;justify-content:center}
#cPrev svg{height:100%;width:auto;max-width:100%;display:block}
.preview .tname{font-family:'Bungee','Impact',sans-serif;font-size:22px;text-align:center}
.form{display:flex;flex-direction:column;gap:10px;min-height:0;overflow:auto;padding:2px}
.row{display:flex;flex-direction:column;gap:5px}
.row label{font-size:14px;font-weight:600;color:var(--muted)}
.row input[type=text],.row input[type=number]{border:3px solid var(--line);border-radius:14px;padding:9px 12px;font-size:18px;background:var(--surface);color:var(--text);width:100%}
.two{display:grid;grid-template-columns:1fr 110px;gap:10px}
.sw{display:flex;flex-wrap:wrap;gap:8px}
.sw button{width:40px;height:40px;border-radius:12px;border:3px solid transparent;box-shadow:var(--shadow-sm);font-size:20px;background:var(--surface-2);color:var(--text);padding:0}
.sw button.on{border-color:var(--text);transform:scale(1.08)}
.hint{font-size:13px;color:var(--muted)}

/* Estadios 3x3 */
#stGrid{flex:1;min-height:0;display:grid;grid-template-columns:repeat(3,minmax(0,1fr));grid-template-rows:repeat(3,minmax(0,1fr));gap:12px;overflow:hidden;padding:2px 2px 8px}
.st-card{background:var(--surface);border-radius:20px;box-shadow:var(--shadow);overflow:hidden;display:grid;grid-template-rows:minmax(0,1fr) auto;min-height:0;min-width:0}
.st-card .ban{position:relative;overflow:hidden;min-height:0}
.st-card .ban svg{position:absolute;inset:0;width:100%;height:100%;display:block}
.st-card .num{position:absolute;top:8px;left:8px;background:var(--hud-bg);color:var(--hud-text);font-weight:700;border-radius:10px;padding:1px 9px;font-size:14px}
.st-card .lockic{position:absolute;top:6px;right:8px;font-size:22px}
.st-card.locked .ban{filter:grayscale(.85) brightness(.8)}
.st-card .body{padding:8px 12px 10px;min-width:0}
.st-card h3{margin:0 0 6px;font-size:18px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.st-card h3 small{font-weight:500;color:var(--muted);font-size:13px}
.lvls{display:grid;grid-template-columns:repeat(3,1fr);gap:6px}
.lvl{border:0;border-radius:14px;padding:6px 2px 4px;background:var(--surface-2);color:var(--text);box-shadow:var(--shadow-sm);font-weight:600;font-size:14px;display:flex;flex-direction:column;align-items:center;gap:0}
.lvl:disabled{opacity:.5;cursor:not-allowed}
.lvl:not(:disabled):active{transform:translateY(2px);box-shadow:none}
.stars{font-size:14px;letter-spacing:1px;color:var(--star)}
.stars em{font-style:normal;color:var(--star-off)}

/* Habilidades y tienda */
.skgrid{flex:1;min-height:0;display:grid;grid-template-columns:repeat(2,minmax(0,1fr));grid-template-rows:repeat(2,minmax(0,1fr));gap:12px;overflow:hidden;padding:2px 2px 8px}
.sk{background:var(--surface);border-radius:20px;box-shadow:var(--shadow);padding:14px 16px;display:flex;flex-direction:column;gap:6px;min-height:0;min-width:0}
.sk h3{margin:0;font-size:20px;display:flex;gap:8px;align-items:center}
.sk h3 span.lv{margin-left:auto;font-size:15px;color:var(--muted);font-weight:600}
.sk p{margin:0;color:var(--muted);font-size:14px;line-height:1.3}
.pips{display:grid;grid-template-columns:repeat(10,1fr);gap:4px;margin-top:auto}
.pips i{height:12px;border-radius:4px;background:var(--surface-3)}
.pips i.on{background:linear-gradient(90deg,var(--blue),var(--neon))}
.pips i.bonus{background:var(--yellow)}
.sk .btn{padding:9px 14px;font-size:16px;border-radius:14px}
.shopgrid{flex:1;min-height:0;display:grid;grid-template-columns:repeat(5,minmax(0,1fr));grid-template-rows:repeat(2,minmax(0,1fr));gap:10px;overflow:hidden;padding:2px 2px 8px}
.item{border:3px solid transparent;background:var(--surface);border-radius:18px;box-shadow:var(--shadow-sm);padding:10px;display:flex;flex-direction:column;gap:4px;min-height:0;min-width:0;text-align:left;color:var(--text)}
.item.eq{border-color:var(--green)}
.item .ic{font-size:32px;line-height:1}
.item h4{margin:0;font-size:15px;line-height:1.15}
.item p{margin:0;font-size:12.5px;color:var(--muted);line-height:1.25}
.item .bon{font-size:13px;font-weight:600;color:var(--blue)}
.item .act{margin-top:auto;font-size:14px;font-weight:700}
.item.locked{opacity:.6}
.tabs{display:flex;gap:8px}
.tab{border:0;border-radius:14px;padding:9px 14px;font-weight:600;font-size:16px;background:var(--surface);color:var(--text);box-shadow:var(--shadow-sm)}
.tab.on{background:var(--blue);color:#fff}

/* Juego */
#s-game{padding:0;max-width:none;position:relative;background:#0a0f22}
#gl{position:absolute;inset:0;width:100%;height:100%;display:block}
#draw{position:absolute;inset:0;width:100%;height:100%;display:block;z-index:1;touch-action:none}
.hud{position:absolute;z-index:2;pointer-events:none;color:var(--hud-text)}
#hudTL{top:calc(env(safe-area-inset-top,0px) + 10px);left:calc(env(safe-area-inset-left,0px) + 10px);display:flex;flex-direction:column;gap:6px;align-items:flex-start}
.score{display:flex;align-items:stretch;border-radius:12px;overflow:hidden;box-shadow:0 3px 0 rgba(0,0,0,.35);font-family:'Bungee','Impact',sans-serif}
.score .min{background:#b98a4b;color:#fff;padding:6px 10px;font-size:20px;display:grid;place-items:center}
.score .tm{display:flex;align-items:center;background:#f4e7c8;padding:3px;gap:3px}
.score .tm div{width:44px;height:40px;border-radius:7px;display:grid;place-items:center;font-size:24px;color:#fff;text-shadow:0 2px 0 rgba(0,0,0,.4)}
.score .dash{color:#6b4a1f;font-size:18px;padding:0 2px}
.pill{background:var(--hud-bg);border-radius:12px;padding:4px 10px;font-size:14px;font-weight:600;white-space:nowrap}
#hudTR{top:calc(env(safe-area-inset-top,0px) + 10px);right:calc(env(safe-area-inset-right,0px) + 10px);pointer-events:auto;z-index:3}
#pauseBtn{width:52px;height:52px;border-radius:50%;border:4px solid #fff;background:#1c2f6b;color:#fff;font-size:20px;font-weight:700;box-shadow:0 3px 0 rgba(0,0,0,.35)}
#hint{left:50%;bottom:calc(env(safe-area-inset-bottom,0px) + 16px);transform:translateX(-50%);background:var(--hud-bg);border-radius:16px;padding:8px 16px;font-size:16px;font-weight:600;text-align:center;max-width:92vw}
#banner{left:50%;top:38%;transform:translate(-50%,-50%) scale(.6);opacity:0;font-family:'Bungee','Impact',sans-serif;font-size:clamp(34px,9vw,76px);text-align:center;white-space:nowrap;text-shadow:3px 3px 0 var(--pink),6px 6px 0 #0e1430;transition:opacity .2s,transform .25s}
#banner.show{opacity:1;transform:translate(-50%,-50%) scale(1)}
#banner small{display:block;font-family:'Fredoka',sans-serif;font-size:clamp(16px,3.6vw,24px);text-shadow:0 2px 0 #0e1430}
#toast{left:50%;top:calc(env(safe-area-inset-top,0px) + 70px);transform:translateX(-50%) translateY(-10px);opacity:0;background:#c8102e;border-radius:14px;padding:8px 14px;font-weight:700;font-size:16px;transition:opacity .25s,transform .25s;white-space:nowrap}
#toast.show{opacity:1;transform:translateX(-50%) translateY(0)}
#hand{left:0;top:0;font-size:42px;opacity:0;filter:drop-shadow(0 3px 2px rgba(0,0,0,.4))}
#hand.on{animation:hand 1.8s ease-in-out infinite}
@keyframes hand{0%{opacity:0;transform:translate(var(--hx0),var(--hy0))}15%{opacity:1;transform:translate(var(--hx0),var(--hy0))}70%{opacity:1;transform:translate(var(--hx1),var(--hy1))}100%{opacity:0;transform:translate(var(--hx1),var(--hy1))}}
#windPill.off{display:none}

/* Pausa y resultados */
.modal{position:fixed;inset:0;z-index:50;background:var(--scrim);display:none;place-items:center;padding:16px}
.modal.show{display:grid}
.modal .card{max-width:380px;width:100%;display:flex;flex-direction:column;gap:12px;text-align:center}
.res{flex:1;min-height:0;display:grid;grid-template-columns:minmax(0,1fr) minmax(0,1fr);gap:18px;align-items:center}
@media (max-width:640px){.res{grid-template-columns:minmax(0,1fr);flex:none}}
.rtitle{font-family:'Bungee','Impact',sans-serif;font-size:clamp(30px,6vw,52px);line-height:1}
.rsub{color:var(--muted);font-size:16px;margin:6px 0}
.rscore{font-family:'Bungee','Impact',sans-serif;font-size:clamp(26px,5vw,40px);margin:6px 0}
.rstars{font-size:34px;letter-spacing:4px;color:var(--star)}
.rstars em{font-style:normal;color:var(--star-off)}
.rlines{background:var(--surface);border-radius:18px;box-shadow:var(--shadow-sm);padding:6px 14px;margin:8px 0}
.rl{display:flex;justify-content:space-between;padding:5px 0;border-bottom:1px dashed var(--line);font-size:15px}
.rl:last-child{border-bottom:0}
.rtotal{font-weight:700;font-size:19px}
.unl{display:flex;flex-direction:column;gap:6px;margin:8px 0}
.unl div{background:var(--surface);border-radius:12px;padding:7px 12px;font-size:14px;font-weight:600;box-shadow:var(--shadow-sm)}
.rbtns{display:flex;gap:10px;flex-wrap:wrap}
.rbtns .btn{flex:1}

/* Pantallas bajas (celular horizontal) */
@media (max-height:540px){
  .screen{padding-top:8px;padding-bottom:8px}
  .logo{font-size:34px}.logo small{margin-top:4px;font-size:13px}
  .hero{margin-top:8px;gap:12px}
  .card{padding:12px;border-radius:18px}
  .ava{width:72px;height:72px}.ava svg{width:62px;height:62px}
  .rank{font-size:19px;margin:0 0 4px}
  .chips{margin-top:8px;gap:6px}.chip{padding:5px 8px}.chip b{font-size:16px}.chip span{font-size:11px}
  .next,.foot{display:none}
  .btn.big{font-size:17px;padding:10px 16px;border-radius:14px}
  .menu-btns{gap:8px}
  .bar{margin-bottom:6px}.icon-btn{width:40px;height:40px;border-radius:12px;font-size:18px}
  h2{font-size:20px}
  .st-card{grid-template-rows:none;grid-template-columns:36% minmax(0,1fr)}
  .st-card .body{padding:5px 8px;display:flex;flex-direction:column;justify-content:center}
  .st-card h3{font-size:14px;margin-bottom:3px}.st-card h3 small{display:none}
  .lvl{font-size:12px;padding:3px 1px 2px;border-radius:10px}.stars{font-size:11px}
  #stGrid{gap:8px}
  .sk{padding:8px 12px;gap:3px}.sk h3{font-size:16px}.sk p{font-size:12px;display:-webkit-box;-webkit-line-clamp:1;-webkit-box-orient:vertical;overflow:hidden}
  .sk .btn{padding:6px 10px;font-size:14px}
  .item{padding:6px;gap:2px}.item .ic{font-size:22px}.item h4{font-size:12.5px}.item p{display:none}.item .bon,.item .act{font-size:12px}
  .rtitle{font-size:30px}.rstars{font-size:24px}.rl{padding:3px 0;font-size:13px}.rlines{padding:2px 12px;margin:4px 0}
  .unl div{padding:5px 10px;font-size:12.5px}.rbtns .btn{font-size:14px;padding:9px 12px}
  .rscore{font-size:24px;margin:2px 0}
  #hint{bottom:auto;top:calc(env(safe-area-inset-top,0px) + 10px);max-width:52vw;font-size:14px;padding:6px 12px}
  .score .min{font-size:16px;padding:4px 8px}.score .tm div{width:34px;height:30px;font-size:18px}
  .preview .tname{font-size:16px}
  .row input[type=text],.row input[type=number]{padding:5px 10px;font-size:15px}
  .sw button{width:32px;height:32px;font-size:16px;border-radius:10px}
  .form{gap:6px 12px;display:grid;grid-template-columns:1fr 1fr;align-content:start;overflow:hidden}.row label{font-size:12.5px}
  .form .hint{display:none}.create{grid-template-columns:minmax(0,.7fr) minmax(0,1.6fr);gap:10px}
  .sw{gap:5px}.sw button{width:28px;height:28px;font-size:14px;border-radius:8px}
}
@media (max-width:600px){
  #stGrid,.skgrid,.shopgrid{overflow:auto;flex:none}
  #stGrid{grid-template-columns:1fr;grid-template-rows:none}
  #stGrid .st-card{grid-template-rows:110px auto}
  .skgrid{grid-template-columns:1fr;grid-template-rows:none}
  .shopgrid{grid-template-columns:repeat(2,minmax(0,1fr));grid-template-rows:none}
}
</style>
</head>
<body>
<div id="app">

<!-- Menú -->
<section class="screen active" id="s-menu">
  <div class="bar"><div class="grow"><div class="logo"><span class="l1">GOLAZO</span> <span class="l2">LATINO</span><small>Pase a pase hasta el gol, de Medellín a Río</small></div></div>
    <button class="icon-btn" id="muteBtn" aria-label="Sonido">🔊</button></div>
  <div class="hero">
    <div class="card">
      <div class="pc"><div class="ava" id="mAva"></div>
        <div class="pinfo"><div class="kicker" id="mTeam"></div><div class="rank" id="mName"></div>
          <div class="xpbar"><i id="mXp"></i></div><div class="xptxt" id="mXpT"></div></div></div>
      <div class="chips">
        <div class="chip"><b id="mCoins">0</b><span>🪙 Monedas</span></div>
        <div class="chip"><b id="mStars">0</b><span>⭐ Estrellas</span></div>
        <div class="chip"><b id="mGoals">0</b><span>⚽ Goles</span></div>
        <div class="chip"><b id="mWins">0</b><span>🏆 Victorias</span></div>
      </div>
      <div class="next" id="mNext"></div>
    </div>
    <div class="menu-btns">
      <button class="btn big primary" id="bPlay">⚽ Jugar</button>
      <button class="btn big blue" id="bSkills">💪 Habilidades</button>
      <button class="btn big yellow" id="bShop">👟 Accesorios</button>
      <button class="btn big" id="bEdit">✏️ Mi jugador y equipo</button>
    </div>
  </div>
  <div class="foot">Desliza desde el balón para pasar o rematar. Falla lo menos posible: cada error le da una contra al rival.</div>
</section>

<!-- Crear / editar -->
<section class="screen" id="s-create">
  <div class="bar"><button class="icon-btn" id="cBack" aria-label="Volver">←</button><h2 class="grow" id="cTitle">Crea tu jugador</h2><button class="btn primary" id="cSave">Guardar ✓</button></div>
  <div class="create">
    <div class="card preview"><div id="cPrev"></div><div class="tname" id="cTeamPrev"></div></div>
    <div class="card form">
      <div class="two">
        <div class="row"><label for="fNick">Apodo del jugador</label><input type="text" id="fNick" maxlength="14" autocomplete="off"></div>
        <div class="row"><label for="fNum">Dorsal</label><input type="number" id="fNum" min="1" max="99"></div>
      </div>
      <div class="hint">Usa un apodo, no tu nombre real.</div>
      <div class="row"><label>Tono de piel</label><div class="sw" id="fSkin"></div></div>
      <div class="row"><label>Color de pelo</label><div class="sw" id="fHair"></div></div>
      <div class="row"><label for="fTeam">Nombre del equipo</label><input type="text" id="fTeam" maxlength="18" autocomplete="off"></div>
      <div class="row"><label>Escudo</label><div class="sw" id="fCrest"></div></div>
      <div class="row"><label>Camiseta</label><div class="sw" id="fShirt"></div></div>
      <div class="row"><label>Pantaloneta</label><div class="sw" id="fShorts"></div></div>
    </div>
  </div>
</section>

<!-- Estadios -->
<section class="screen" id="s-stadiums">
  <div class="bar"><button class="icon-btn" data-back="menu" aria-label="Volver">←</button><h2 class="grow">Elige estadio y nivel</h2><div class="coins" id="stStars">⭐ 0/27</div></div>
  <div id="stGrid"></div>
</section>

<!-- Habilidades -->
<section class="screen" id="s-skills">
  <div class="bar"><button class="icon-btn" data-back="menu" aria-label="Volver">←</button><h2 class="grow">Habilidades</h2><div class="coins" id="skCoins">🪙 0</div></div>
  <div class="skgrid" id="skGrid"></div>
</section>

<!-- Tienda -->
<section class="screen" id="s-shop">
  <div class="bar"><button class="icon-btn" data-back="menu" aria-label="Volver">←</button><h2 class="grow">Accesorios</h2><div class="coins" id="shCoins">🪙 0</div></div>
  <div class="shopgrid" id="shGrid"></div>
</section>

<!-- Partido -->
<section class="screen" id="s-game">
  <canvas id="gl"></canvas>
  <canvas id="draw"></canvas>
  <div class="hud" id="hudTL">
    <div class="score"><div class="min" id="hMin">0'</div><div class="tm"><div id="hMy">0</div><span class="dash">–</span><div id="hRv">0</div></div></div>
    <div class="pill" id="hChance">Jugada 1/5</div>
    <div class="pill" id="hFails">✖ Fallos: 0</div>
    <div class="pill" id="windPill">💨 Viento →</div>
  </div>
  <div class="hud" id="hudTR"><button id="pauseBtn" aria-label="Pausa">❚❚</button></div>
  <div class="hud" id="hint">Desliza desde el balón hacia un compañero</div>
  <div class="hud" id="banner"></div>
  <div class="hud" id="toast"></div>
  <div class="hud" id="hand">👆</div>
</section>

<!-- Resultados -->
<section class="screen" id="s-results">
  <div class="res">
    <div>
      <div class="rtitle" id="rTitle">¡Victoria!</div>
      <div class="rscore" id="rScore">2 – 1</div>
      <div class="rsub" id="rSub"></div>
      <div class="rstars" id="rStars"></div>
      <div class="rlines" id="rLines"></div>
    </div>
    <div>
      <div class="card"><div class="pc"><div class="ava" id="rAva"></div><div class="pinfo"><div class="kicker">Nivel de jugador</div><div class="rank" id="rLvl"></div><div class="xpbar"><i id="rXp"></i></div><div class="xptxt" id="rXpT"></div></div></div></div>
      <div class="unl" id="rUnl"></div>
      <div class="rbtns"><button class="btn" id="rMenu">🏠 Menú</button><button class="btn blue" id="rRetry">🔁 Repetir</button><button class="btn primary" id="rNext">Siguiente ▶</button></div>
    </div>
  </div>
</section>
</div>

<div class="modal" id="pause"><div class="card"><h2>Pausa</h2>
  <button class="btn primary" id="pCont">▶ Continuar</button>
  <button class="btn" id="pMute">🔊 Sonido</button>
  <button class="btn" id="pQuit">🏳️ Salir del partido</button></div></div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
<script>
(function(){
'use strict';
const $=s=>document.querySelector(s);
const isTouch=window.matchMedia?matchMedia('(pointer: coarse)').matches:('ontouchstart' in window);
const MAX_LEVEL=100, SAVE_KEY='golazo-latino-v1';
const rand=(a,b)=>a+Math.random()*(b-a);
const clamp=(v,a,b)=>Math.max(a,Math.min(b,v));
const lerp=(a,b,t)=>a+(b-a)*t;

/* ---------- Datos ---------- */
const SKIN=['#f6d3b3','#e3b48c','#c68a5e','#9a6038','#6b3f22'];
const HAIR=['#1d1410','#5a3519','#b8732d','#e8c15a','#c23b2a'];
const SHIRT=['#ffd400','#e3262f','#1a73e8','#12a150','#ffffff','#111827','#7c3aed','#ff7a00'];
const SHORTS=['#1a3fa8','#ffffff','#111827','#e3262f','#12a150','#ffd400'];
const CRESTS=['⚡','🦅','🐆','🔥','⭐','🐺','🦁','🌋','🌊','☀️'];

const STADIUMS=[
 {city:'Medellín',flag:'co',name:'Estadio La Primavera',rival:'Silleteros FC',rc:['#0f8a43','#ffffff','#0f8a43'],desc:'Clima perfecto y la hinchada a favor.',sky:0x8fd0ff,night:false,alt:1,wind:0,fog:0},
 {city:'Bogotá',flag:'co',name:'Coliseo de la Sabana',rival:'Cóndores de la Sabana',rc:['#1a3fa8','#ffffff','#1a3fa8'],desc:'2.600 m de altura: el balón vuela más rápido.',sky:0xa9c3da,night:false,alt:1.08,wind:0.3,fog:0},
 {city:'Lima',flag:'pe',name:'Estadio del Pacífico',rival:'Garúa FC',rc:['#d91f26','#ffffff','#d91f26'],desc:'Garúa y neblina sobre la cancha.',sky:0xc4cbd1,night:false,alt:1,wind:0.4,fog:0.011},
 {city:'Quito',flag:'ec',name:'Estadio Mitad del Mundo',rival:'Volcanes de Quito',rc:['#ffd400','#1a3fa8','#e3262f'],desc:'2.850 m y viento de montaña.',sky:0x9cc6ef,night:false,alt:1.12,wind:0.6,fog:0},
 {city:'Ciudad de México',flag:'mx',name:'Estadio del Valle',rival:'Águilas del Valle',rc:['#0f7a43','#ffffff','#c8102e'],desc:'Noche bajo los reflectores.',sky:0x0b1236,night:true,alt:1.1,wind:0.3,fog:0},
 {city:'Santiago',flag:'cl',name:'Estadio Cordillera',rival:'Andes Unidos',rc:['#d52b1e','#0039a6','#ffffff'],desc:'Viento que baja de la cordillera.',sky:0x86b9ec,night:false,alt:1,wind:1.0,fog:0},
 {city:'Montevideo',flag:'uy',name:'Estadio Rambla',rival:'Gaviotas del Plata',rc:['#7fb8ff','#111827','#111827'],desc:'Brisa fuerte del río: compensa la curva.',sky:0x9fc4e6,night:false,alt:1,wind:1.3,fog:0.006},
 {city:'Buenos Aires',flag:'ar',name:'Estadio del Obelisco',rival:'Tango FC',rc:['#74acdf','#ffffff','#111827'],desc:'Noche de clásico y tribuna que no para.',sky:0x0a1030,night:true,alt:1,wind:0.6,fog:0},
 {city:'Río de Janeiro',flag:'br',name:'Estadio Pan de Azúcar',rival:'Samba Real',rc:['#ffd400','#1a5bd6','#ffffff'],desc:'La gran final: la defensa más dura del continente.',sky:0x6fc3ff,night:false,alt:1,wind:0.8,fog:0},
];
const LVL_NAMES=['Amistoso','Liga','Final'];
const STATS=[
 {id:'pase',name:'Pase',emoji:'🎯',desc:'Aros de recepción más grandes y balón más rápido.'},
 {id:'remate',name:'Remate',emoji:'💥',desc:'Disparos más precisos y potentes: el arquero llega menos.'},
 {id:'efecto',name:'Efecto',emoji:'🌀',desc:'Más curva para esquivar defensas y barreras.'},
 {id:'vision',name:'Visión',emoji:'👁️',desc:'Lees la jugada: avisos de destino, riesgo y viento.'},
];
const VISION_TXT=['','Aros bajo tus compañeros','','Destino del pase en verde','','Zonas de riesgo de los defensas','','','Marca de caída con viento','',''];
const ACC=[
 {id:'g0',slot:'guayos',emoji:'👟',name:'Guayos de barrio',price:0,unlock:1,bonus:{},color:'#111827',desc:'Los de siempre.'},
 {id:'g1',slot:'guayos',emoji:'👟',name:'Guayos veloces',price:180,unlock:3,bonus:{pase:1},color:'#1a73e8',desc:'Llegas antes al balón.'},
 {id:'g2',slot:'guayos',emoji:'🔥',name:'Guayos de fuego',price:420,unlock:7,bonus:{remate:1},color:'#ff5a1f',desc:'Remates con más potencia.'},
 {id:'g3',slot:'guayos',emoji:'🥇',name:'Guayos dorados',price:1200,unlock:16,bonus:{remate:2,efecto:1},color:'#ffc400',desc:'Para la final en Río.'},
 {id:'b0',slot:'balon',emoji:'⚽',name:'Balón clásico',price:0,unlock:1,bonus:{},color:'#ffffff',desc:'Blanco y negro.'},
 {id:'b1',slot:'balon',emoji:'🌀',name:'Balón espiral',price:260,unlock:4,bonus:{efecto:1},color:'#7c3aed',desc:'Gira más en el aire.'},
 {id:'b2',slot:'balon',emoji:'🌟',name:'Balón estelar',price:900,unlock:12,bonus:{efecto:1,vision:1},color:'#ffd400',desc:'Brilla en la noche.'},
 {id:'x1',slot:'extra',emoji:'🎗️',name:'Cinta de capitán',price:350,unlock:5,bonus:{pase:1,vision:1},color:'#ffd400',desc:'El equipo te sigue.'},
 {id:'x2',slot:'extra',emoji:'🧤',name:'Muñequeras pro',price:550,unlock:9,bonus:{vision:2},color:'#12a150',desc:'Concentración total.'},
 {id:'x3',slot:'extra',emoji:'🦸',name:'Capa de crack',price:1500,unlock:20,bonus:{pase:1,remate:1,efecto:1,vision:1},color:'#e3262f',desc:'Solo para leyendas.'},
];
const RANKS=['Promesa','Juvenil','Titular','Goleador','Crack','Estrella','Ídolo','Leyenda','Leyenda latina','Rey de la cancha'];

/* ---------- Guardado ---------- */
const defSave=()=>({v:1,created:false,player:{nick:'Crack',num:10,skin:1,hair:0},team:{name:'Rayos FC',crest:0,shirt:0,shorts:0},
  xp:0,coins:0,stats:{pase:1,remate:1,efecto:1,vision:1},owned:['g0','b0'],equip:{guayos:'g0',balon:'b0',extra:null},
  stars:{},goals:0,passes:0,wins:0,matches:0,muted:false,tutorial:true});
let save=defSave();
try{const raw=localStorage.getItem(SAVE_KEY);if(raw){const o=JSON.parse(raw);save=Object.assign(defSave(),o);save.stats=Object.assign(defSave().stats,o.stats||{});save.equip=Object.assign(defSave().equip,o.equip||{});}}catch(e){}
function persist(){try{localStorage.setItem(SAVE_KEY,JSON.stringify(save));}catch(e){}}

/* ---------- Progreso ---------- */
const xpFor=n=>n<=1?0:Math.round(30*Math.pow(n-1,1.65));
function levelOf(xp){let l=1;while(l<MAX_LEVEL&&xp>=xpFor(l+1))l++;return l;}
function levelProgress(xp){const l=levelOf(xp);if(l>=MAX_LEVEL)return{l,cur:1,have:0,span:0};const a=xpFor(l),b=xpFor(l+1);return{l,cur:(xp-a)/(b-a),have:xp-a,span:b-a};}
const rankOf=l=>RANKS[Math.min(RANKS.length-1,Math.floor((l-1)/10))];
function isUnlocked(a,l){if(a===0&&l===0)return true;if(l>0)return(save.stars[a+'-'+(l-1)]||0)>0;return(save.stars[(a-1)+'-0']||0)>0;}
function starsTotal(){return Object.values(save.stars).reduce((s,v)=>s+v,0);}
function bonusOf(stat){let b=0;for(const k in save.equip){const it=ACC.find(x=>x.id===save.equip[k]);if(it&&it.bonus[stat])b+=it.bonus[stat];}return b;}
function eff(stat){return save.stats[stat]+bonusOf(stat);}
function statCap(){return Math.min(10,3+Math.floor(levelOf(save.xp)/3));}
const upCost=lv=>Math.round(40*Math.pow(lv,1.6));
function accById(id){return ACC.find(x=>x.id===id);}

/* ---------- Sonido ---------- */
const Sound=(()=>{
 let ctx=null,master=null,nb=null;
 function c(){if(save.muted)return null;if(!ctx){try{ctx=new(window.AudioContext||window.webkitAudioContext)();master=ctx.createGain();master.gain.value=0.5;master.connect(ctx.destination);}catch(e){return null;}}if(ctx.state==='suspended')ctx.resume();return ctx;}
 function tone(f,dur,type,vol,f2,delay){const a=c();if(!a)return;const t=a.currentTime+(delay||0);const o=a.createOscillator(),g=a.createGain();o.type=type||'square';o.frequency.setValueAtTime(f,t);if(f2)o.frequency.exponentialRampToValueAtTime(Math.max(20,f2),t+dur);g.gain.setValueAtTime(vol||0.1,t);g.gain.exponentialRampToValueAtTime(0.0001,t+dur);o.connect(g);g.connect(master);o.start(t);o.stop(t+dur+0.02);}
 function noise(dur,vol,freq,delay,q){const a=c();if(!a)return;if(!nb){nb=a.createBuffer(1,a.sampleRate*2,a.sampleRate);const d=nb.getChannelData(0);for(let i=0;i<d.length;i++)d[i]=Math.random()*2-1;}const t=a.currentTime+(delay||0);const s=a.createBufferSource();s.buffer=nb;s.loop=true;const f=a.createBiquadFilter();f.type='bandpass';f.frequency.value=freq||1200;f.Q.value=q||0.8;const g=a.createGain();g.gain.setValueAtTime(0.0001,t);g.gain.exponentialRampToValueAtTime(vol||0.2,t+Math.min(0.08,dur/3));g.gain.exponentialRampToValueAtTime(0.0001,t+dur);s.connect(f);f.connect(g);g.connect(master);s.start(t);s.stop(t+dur+0.05);}
 return{
  kick(p){noise(0.08,0.35*(p||1),400,0,1.5);tone(120,0.08,'sine',0.12,60);},
  whistle(n){for(let i=0;i<(n||1);i++){tone(2600,0.22,'sine',0.06,2500,i*0.3);tone(2750,0.22,'triangle',0.03,2700,i*0.3);}},
  longWhistle(){tone(2600,0.9,'sine',0.06,2550);tone(2750,0.9,'triangle',0.03,2700);},
  cheer(){noise(2.2,0.22,900,0,0.5);noise(1.6,0.12,2200,0.15,0.6);},
  groan(){noise(1.0,0.14,500,0,0.6);tone(220,0.5,'sine',0.04,150);},
  goal(){this.cheer();[523,659,784,1046,1318].forEach((f,i)=>tone(f,0.2,'square',0.05,null,i*0.1));},
  click(){tone(700,0.04,'square',0.035,900);},
  coin(){tone(988,0.06,'square',0.04);tone(1318,0.12,'square',0.04,null,0.06);},
  win(){[523,659,784,1046].forEach((f,i)=>tone(f,0.18,'square',0.06,null,i*0.12));},
  lose(){[392,330,262].forEach((f,i)=>tone(f,0.22,'triangle',0.07,null,i*0.16));},
  level(){[659,784,988,1318].forEach((f,i)=>tone(f,0.14,'triangle',0.07,null,i*0.08));},
  alert(){tone(330,0.15,'square',0.05);tone(262,0.25,'square',0.05,null,0.15);},
  catch_(){noise(0.12,0.2,700);},
  pop(){noise(0.35,0.22,500,0,0.7);tone(90,0.25,'sine',0.08,40);noise(0.6,0.06,3000,0.08,0.5);}
 };
})();

/* ---------- SVG: avatar y estadios ---------- */
function shade(hex,k){const n=parseInt(hex.slice(1),16);let r=n>>16,g=(n>>8)&255,b=n&255;r=clamp(Math.round(r*k),0,255);g=clamp(Math.round(g*k),0,255);b=clamp(Math.round(b*k),0,255);return'#'+((1<<24)|(r<<16)|(g<<8)|b).toString(16).slice(1);}
function contrast(hex){const n=parseInt(hex.slice(1),16);const r=n>>16,g=(n>>8)&255,b=n&255;return(r*299+g*587+b*114)/1000>150?'#0e1430':'#ffffff';}
function avatarSVG(full){
  const p=save.player,t=save.team,sk=SKIN[p.skin],hr=HAIR[p.hair],sh=SHIRT[t.shirt],so=SHORTS[t.shorts],nc=contrast(sh);
  const boot=(accById(save.equip.guayos)||ACC[0]).color;
  if(!full){
    return `<svg viewBox="0 0 100 100" aria-hidden="true"><rect width="100" height="100" fill="none"/>
    <path d="M14 104 Q16 70 50 66 Q84 70 86 104Z" fill="${sh}" stroke="${shade(sh,.75)}" stroke-width="2"/>
    <text x="50" y="96" text-anchor="middle" font-family="Bungee,Impact,sans-serif" font-size="20" fill="${nc}">${p.num}</text>
    <rect x="42" y="56" width="16" height="14" rx="5" fill="${shade(sk,.9)}"/>
    <circle cx="50" cy="42" r="19" fill="${sk}"/>
    <path d="M31 40 Q32 20 50 20 Q68 20 69 40 Q62 30 50 31 Q38 30 31 40Z" fill="${hr}"/>
    <circle cx="43" cy="44" r="2.4" fill="#1b1b1b"/><circle cx="57" cy="44" r="2.4" fill="#1b1b1b"/>
    <path d="M43 51 Q50 56 57 51" stroke="#5a2b1a" stroke-width="2.2" fill="none" stroke-linecap="round"/></svg>`;
  }
  const ex=save.equip.extra?accById(save.equip.extra):null;
  return `<svg viewBox="0 0 200 300" aria-hidden="true">
  <ellipse cx="100" cy="290" rx="60" ry="8" fill="rgba(0,0,0,.18)"/>
  ${ex&&ex.id==='x3'?`<path d="M62 92 Q40 200 54 250 L146 250 Q160 200 138 92Z" fill="${ex.color}" opacity=".85"/>`:''}
  <rect x="74" y="200" width="20" height="70" rx="6" fill="${sh}"/><rect x="106" y="200" width="20" height="70" rx="6" fill="${sh}"/>
  <rect x="76" y="186" width="16" height="30" fill="${sk}"/><rect x="108" y="186" width="16" height="30" fill="${sk}"/>
  <rect x="70" y="268" width="28" height="14" rx="6" fill="${boot}"/><rect x="102" y="268" width="28" height="14" rx="6" fill="${boot}"/>
  <path d="M66 160 L134 160 L138 200 L62 200Z" fill="${so}" stroke="${shade(so,.75)}" stroke-width="2"/>
  <path d="M60 92 Q100 80 140 92 L138 166 L62 166Z" fill="${sh}" stroke="${shade(sh,.75)}" stroke-width="2"/>
  <path d="M60 92 L40 140 L52 146 L68 112Z" fill="${sh}"/><path d="M140 92 L160 140 L148 146 L132 112Z" fill="${sh}"/>
  <circle cx="46" cy="146" r="8" fill="${sk}"/><circle cx="154" cy="146" r="8" fill="${sk}"/>
  ${ex&&ex.id==='x2'?`<rect x="38" y="134" width="16" height="7" rx="3" fill="${ex.color}"/><rect x="146" y="134" width="16" height="7" rx="3" fill="${ex.color}"/>`:''}
  ${ex&&ex.id==='x1'?`<rect x="40" y="118" width="22" height="9" rx="3" fill="${ex.color}" transform="rotate(-62 51 122)"/>`:''}
  <text x="100" y="146" text-anchor="middle" font-family="Bungee,Impact,sans-serif" font-size="36" fill="${nc}">${p.num}</text>
  <text x="120" y="112" text-anchor="middle" font-size="16">${CRESTS[t.crest]}</text>
  <rect x="91" y="72" width="18" height="16" rx="5" fill="${shade(sk,.9)}"/>
  <circle cx="100" cy="54" r="26" fill="${sk}"/>
  <path d="M74 52 Q75 24 100 24 Q125 24 126 52 Q116 38 100 39 Q84 38 74 52Z" fill="${hr}"/>
  <circle cx="91" cy="57" r="3" fill="#1b1b1b"/><circle cx="109" cy="57" r="3" fill="#1b1b1b"/>
  <path d="M90 66 Q100 73 110 66" stroke="#5a2b1a" stroke-width="3" fill="none" stroke-linecap="round"/></svg>`;
}
function stadiumArt(i){
  const id='g'+i+Math.floor(Math.random()*1e6);
  const S=STADIUMS[i];
  const sky=(a,b)=>`<defs><linearGradient id="${id}" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="${a}"/><stop offset="1" stop-color="${b}"/></linearGradient></defs><rect width="320" height="140" fill="url(#${id})"/>`;
  let s='';
  switch(i){
   case 0:s=sky('#5bb8ff','#d8f1ff')+`<path d="M0 86 Q60 40 120 70 Q180 30 240 66 Q290 44 320 60 L320 140 L0 140Z" fill="#3e9c55"/><path d="M0 96 Q80 66 160 88 Q240 64 320 84 L320 140 L0 140Z" fill="#2f8445"/><line x1="40" y1="40" x2="260" y2="20" stroke="#4b5579" stroke-width="2"/><rect x="120" y="26" width="16" height="12" rx="3" fill="#ffc400"/><rect x="200" y="20" width="16" height="12" rx="3" fill="#ec4a10"/>`+flowers();break;
   case 1:s=sky('#93b4d4','#e3ebf2')+`<path d="M0 90 L60 40 L110 80 L170 30 L230 76 L280 48 L320 70 L320 140 L0 140Z" fill="#5a7d5e"/><rect x="164" y="22" width="12" height="10" fill="#fff"/><rect x="40" y="76" width="18" height="22" fill="#b5532f"/><rect x="62" y="70" width="14" height="28" fill="#c9673f"/><rect x="250" y="72" width="22" height="26" fill="#b5532f"/>`;break;
   case 2:s=sky('#b8c2ca','#e6e9ec')+`<rect x="0" y="80" width="320" height="60" fill="#5d8aa6"/><path d="M0 70 L80 66 L110 90 L0 96Z" fill="#c8b79a"/><path d="M200 74 L320 70 L320 100 L230 98Z" fill="#c8b79a"/>`+rain();break;
   case 3:s=sky('#6fb0ec','#d6ecff')+`<path d="M110 100 L180 26 L250 100Z" fill="#7a8a9a"/><path d="M162 46 L180 26 L198 46 L188 42 L180 50 L172 42Z" fill="#fff"/><path d="M0 100 L60 62 L120 100Z" fill="#6c7b6a"/><line x1="0" y1="104" x2="320" y2="104" stroke="#ffd400" stroke-width="3" stroke-dasharray="10 6"/>`;break;
   case 4:s=sky('#0b1236','#2a1f5a')+stars()+`<path d="M110 100 L140 60 L180 60 L210 100Z" fill="#2e3a6b"/><rect x="134" y="52" width="52" height="8" fill="#3d4a80"/><rect x="40" y="20" width="6" height="80" fill="#5a6390"/><rect x="30" y="16" width="26" height="10" fill="#fff6c2"/><rect x="274" y="20" width="6" height="80" fill="#5a6390"/><rect x="264" y="16" width="26" height="10" fill="#fff6c2"/>`;break;
   case 5:s=sky('#6aa8e8','#d3e8ff')+`<path d="M0 96 L50 40 L90 70 L150 22 L210 72 L260 34 L320 80 L320 140 L0 140Z" fill="#8494a8"/><path d="M130 40 L150 22 L170 40 L160 38 L150 46 L140 38Z" fill="#fff"/><path d="M242 50 L260 34 L278 52 L268 48 L260 54Z" fill="#fff"/><rect x="200" y="60" width="8" height="40" fill="#3d4a6b"/>`;break;
   case 6:s=sky('#8fbbe4','#e3f0fb')+`<rect x="0" y="84" width="320" height="56" fill="#7a96a8"/><rect x="250" y="36" width="12" height="52" fill="#fff"/><rect x="248" y="30" width="16" height="10" fill="#e3262f"/><path d="M0 84 Q40 76 80 84 Q120 92 160 84" stroke="#fff" stroke-width="2" fill="none"/>`+wind();break;
   case 7:s=sky('#0a1030','#232c62')+stars()+`<path d="M156 100 L160 18 L164 100Z" fill="#e8e8f0"/><rect x="0" y="70" width="320" height="30" fill="#1b2350"/><rect x="20" y="58" width="30" height="42" fill="#232d5e"/><rect x="250" y="54" width="40" height="46" fill="#232d5e"/>`;break;
   case 8:s=sky('#3fb0ff','#c9ecff')+`<rect x="0" y="92" width="320" height="48" fill="#1e88c8"/><path d="M180 96 Q196 30 222 34 Q240 40 250 96Z" fill="#3b7d45"/><path d="M240 96 Q262 60 284 64 Q300 70 306 96Z" fill="#4b8d55"/><path d="M40 92 Q70 50 100 92Z" fill="#3b7d45"/><circle cx="60" cy="30" r="14" fill="#ffe066"/>`;break;
  }
  // tribuna y cancha
  s+=`<path d="M40 140 Q160 92 280 140Z" fill="${S.rc[0]}" opacity=".9"/><path d="M70 140 Q160 108 250 140Z" fill="#2c9a4a"/><path d="M100 140 Q160 118 220 140Z" fill="#37b257"/><line x1="160" y1="118" x2="160" y2="140" stroke="#fff" stroke-width="1.5"/>`;
  s+=flagSVG(S.flag,276,98);
  return `<svg viewBox="0 0 320 140" preserveAspectRatio="xMidYMid slice" aria-hidden="true">${s}</svg>`;
  function stars(){let r='';for(let k=0;k<28;k++)r+=`<circle cx="${(k*73)%320}" cy="${(k*37)%70}" r="${k%3?0.9:1.6}" fill="#fff" opacity=".8"/>`;return r;}
  function rain(){let r='';for(let k=0;k<40;k++)r+=`<line x1="${(k*29)%320}" y1="${(k*17)%90}" x2="${(k*29)%320-3}" y2="${(k*17)%90+8}" stroke="#fff" stroke-width="1" opacity=".55"/>`;return r;}
  function wind(){return`<path d="M20 30 Q60 22 100 30 Q120 34 110 42" stroke="#fff" stroke-width="3" fill="none" opacity=".8"/><path d="M60 52 Q110 44 150 52" stroke="#fff" stroke-width="3" fill="none" opacity=".7"/>`;}
  function flowers(){let r='';for(let k=0;k<12;k++)r+=`<circle cx="${20+k*25}" cy="${110+(k%3)*6}" r="3.5" fill="${['#ffd400','#ff5a8a','#fff','#ff7a00'][k%4]}"/>`;return r;}
}
function flagSVG(f,x,y){
  const w=36,h=24;let s=`<g transform="translate(${x} ${y})"><rect x="-2" y="-2" width="2" height="40" fill="#555"/>`;
  switch(f){
   case'co':s+=`<rect width="${w}" height="12" fill="#ffd400"/><rect y="12" width="${w}" height="6" fill="#1a3fa8"/><rect y="18" width="${w}" height="6" fill="#d52b1e"/>`;break;
   case'ec':s+=`<rect width="${w}" height="12" fill="#ffd400"/><rect y="12" width="${w}" height="6" fill="#1a3fa8"/><rect y="18" width="${w}" height="6" fill="#d52b1e"/><circle cx="18" cy="12" r="3" fill="#7a5a2a"/>`;break;
   case'pe':s+=`<rect width="12" height="${h}" fill="#d91f26"/><rect x="12" width="12" height="${h}" fill="#fff"/><rect x="24" width="12" height="${h}" fill="#d91f26"/>`;break;
   case'mx':s+=`<rect width="12" height="${h}" fill="#0f7a43"/><rect x="12" width="12" height="${h}" fill="#fff"/><rect x="24" width="12" height="${h}" fill="#c8102e"/><circle cx="18" cy="12" r="3" fill="#8a5a2a"/>`;break;
   case'cl':s+=`<rect width="${w}" height="12" fill="#fff"/><rect y="12" width="${w}" height="12" fill="#d52b1e"/><rect width="12" height="12" fill="#0039a6"/><circle cx="6" cy="6" r="2.2" fill="#fff"/>`;break;
   case'uy':s+=`<rect width="${w}" height="${h}" fill="#fff"/>`+[3,9,15,21].map(v=>`<rect x="12" y="${v-0.6}" width="24" height="2.6" fill="#0038a8"/>`).join('')+`<circle cx="6" cy="6" r="3.4" fill="#fcd116"/>`;break;
   case'ar':s+=`<rect width="${w}" height="8" fill="#74acdf"/><rect y="8" width="${w}" height="8" fill="#fff"/><rect y="16" width="${w}" height="8" fill="#74acdf"/><circle cx="18" cy="12" r="2.6" fill="#f6b40e"/>`;break;
   case'br':s+=`<rect width="${w}" height="${h}" fill="#009c3b"/><path d="M18 2 L34 12 L18 22 L2 12Z" fill="#ffdf00"/><circle cx="18" cy="12" r="5.4" fill="#002776"/>`;break;
  }
  return s+'</g>';
}

/* ---------- Interfaz ---------- */
let sel={a:0,l:0};
function show(name){document.querySelectorAll('.screen').forEach(s=>s.classList.remove('active'));const sc=$('#s-'+name);sc.classList.add('active');sc.scrollTop=0;
  if(name==='menu')renderMenu();if(name==='stadiums')renderStadiums();if(name==='skills')renderSkills();if(name==='shop')renderShop();}
document.querySelectorAll('[data-back]').forEach(b=>b.addEventListener('click',()=>{Sound.click();show(b.dataset.back);}));
function setMuteIcons(){const ic=save.muted?'🔇':'🔊';$('#muteBtn').textContent=ic;$('#pMute').textContent=ic+' Sonido';}
$('#muteBtn').onclick=()=>{save.muted=!save.muted;persist();setMuteIcons();Sound.click();};
$('#pMute').onclick=()=>{save.muted=!save.muted;persist();setMuteIcons();};
function renderMenu(){
  const pr=levelProgress(save.xp);
  $('#mAva').innerHTML=avatarSVG(false);
  $('#mTeam').textContent=CRESTS[save.team.crest]+' '+save.team.name;
  $('#mName').textContent=save.player.nick+' #'+save.player.num+' · Nv '+pr.l;
  $('#mXp').style.width=(pr.cur*100)+'%';
  $('#mXpT').textContent=pr.l>=MAX_LEVEL?'¡Nivel máximo!':rankOf(pr.l)+' · '+pr.have+'/'+pr.span+' XP al nivel '+(pr.l+1);
  $('#mCoins').textContent=save.coins;$('#mStars').textContent=starsTotal()+'/27';$('#mGoals').textContent=save.goals;$('#mWins').textContent=save.wins;
  const nx=ACC.filter(a=>a.unlock>pr.l).sort((a,b)=>a.unlock-b.unlock)[0];
  $('#mNext').textContent=nx?('Próximo accesorio: '+nx.emoji+' '+nx.name+' en el nivel '+nx.unlock):'Tienes todos los accesorios disponibles.';
  setMuteIcons();
}
$('#bPlay').onclick=()=>{Sound.click();show('stadiums');};
$('#bSkills').onclick=()=>{Sound.click();show('skills');};
$('#bShop').onclick=()=>{Sound.click();show('shop');};
$('#bEdit').onclick=()=>{Sound.click();openCreate(false);};

/* Crear jugador */
let draft=null;
function openCreate(first){
  draft=JSON.parse(JSON.stringify({player:save.player,team:save.team}));
  $('#cTitle').textContent=first?'Crea tu jugador y equipo':'Mi jugador y equipo';
  $('#cBack').style.visibility=first?'hidden':'visible';
  $('#fNick').value=draft.player.nick;$('#fNum').value=draft.player.num;$('#fTeam').value=draft.team.name;
  const sw=(el,arr,key,obj,isEmoji)=>{const box=$(el);box.innerHTML='';arr.forEach((c,i)=>{const b=document.createElement('button');b.type='button';
    if(isEmoji)b.textContent=c;else b.style.background=c;b.setAttribute('aria-label',key+' '+(i+1));
    if(draft[obj][key]===i)b.classList.add('on');b.onclick=()=>{draft[obj][key]=i;Sound.click();box.querySelectorAll('button').forEach(x=>x.classList.remove('on'));b.classList.add('on');updPrev();};box.appendChild(b);});};
  sw('#fSkin',SKIN,'skin','player');sw('#fHair',HAIR,'hair','player');sw('#fCrest',CRESTS,'crest','team',true);sw('#fShirt',SHIRT,'shirt','team');sw('#fShorts',SHORTS,'shorts','team');
  updPrev();show('create');
}
function readForm(){draft.player.nick=($('#fNick').value.trim()||'Crack').slice(0,14);draft.player.num=clamp(parseInt($('#fNum').value,10)||10,1,99);draft.team.name=($('#fTeam').value.trim()||'Rayos FC').slice(0,18);}
function updPrev(){readForm();const bak={p:save.player,t:save.team};save.player=draft.player;save.team=draft.team;$('#cPrev').innerHTML=avatarSVG(true);save.player=bak.p;save.team=bak.t;$('#cTeamPrev').textContent=CRESTS[draft.team.crest]+' '+draft.team.name;}
['#fNick','#fNum','#fTeam'].forEach(s=>$(s).addEventListener('input',updPrev));
$('#cSave').onclick=()=>{readForm();save.player=draft.player;save.team=draft.team;save.created=true;persist();Sound.coin();show('menu');};
$('#cBack').onclick=()=>{Sound.click();show('menu');};

/* Estadios */
function renderStadiums(){
  const g=$('#stGrid');g.innerHTML='';
  STADIUMS.forEach((S,a)=>{
    const unlocked=isUnlocked(a,0);
    const c=document.createElement('div');c.className='st-card'+(unlocked?'':' locked');c.title=S.name+' · '+S.desc;
    let lv='';for(let l=0;l<3;l++){const st=save.stars[a+'-'+l]||0;const ok=isUnlocked(a,l);
      lv+=`<button class="lvl" data-a="${a}" data-l="${l}" ${ok?'':'disabled'} aria-label="${S.city} ${LVL_NAMES[l]}">${ok?LVL_NAMES[l]:'🔒'}<span class="stars">${'★'.repeat(st)}<em>${'★'.repeat(3-st)}</em></span></button>`;}
    c.innerHTML=`<div class="ban">${stadiumArt(a)}<span class="num">${a+1}</span>${unlocked?'':'<span class="lockic">🔒</span>'}</div><div class="body"><h3>${S.city} <small>· ${S.rival}</small></h3><div class="lvls">${lv}</div></div>`;
    g.appendChild(c);
  });
  g.querySelectorAll('.lvl').forEach(b=>b.onclick=()=>{Sound.click();startMatch(+b.dataset.a,+b.dataset.l);});
  $('#stStars').textContent='⭐ '+starsTotal()+'/27';
}

/* Habilidades */
function renderSkills(){
  $('#skCoins').textContent='🪙 '+save.coins;
  const g=$('#skGrid');g.innerHTML='';const cap=statCap();
  STATS.forEach(st=>{
    const lv=save.stats[st.id],bon=bonusOf(st.id),cost=upCost(lv);
    const d=document.createElement('div');d.className='sk';
    let pips='';for(let i=0;i<10;i++)pips+=`<i class="${i<lv?'on':(i<lv+bon?'bonus':'')}"></i>`;
    let extra=st.id==='vision'?(' Ahora: '+(visionList(eff('vision'))||'—')+'.'):'';
    const maxed=lv>=10,capped=lv>=cap;
    d.innerHTML=`<h3>${st.emoji} ${st.name}<span class="lv">Nv ${lv}${bon?' +'+bon:''}</span></h3><p>${st.desc}${extra}</p><div class="pips">${pips}</div>
      <button class="btn ${maxed||capped||save.coins<cost?'':'primary'}" ${maxed||capped||save.coins<cost?'disabled':''}>${maxed?'Máximo':capped?'Sube a nivel '+((lv-2)*3)+' de jugador':'Mejorar · 🪙 '+cost}</button>`;
    d.querySelector('button').onclick=()=>{if(save.coins<cost||maxed||capped)return;save.coins-=cost;save.stats[st.id]++;persist();Sound.coin();renderSkills();};
    g.appendChild(d);
  });
}
function visionList(v){const out=[];if(v>=1)out.push('aros');if(v>=3)out.push('destino');if(v>=5)out.push('riesgo');if(v>=8)out.push('viento');return out.join(', ');}

/* Tienda */
function renderShop(){
  $('#shCoins').textContent='🪙 '+save.coins;const lvl=levelOf(save.xp);
  const g=$('#shGrid');g.innerHTML='';
  ACC.forEach(it=>{
    const own=save.owned.includes(it.id),eq=save.equip[it.slot]===it.id,locked=lvl<it.unlock;
    const b=document.createElement('button');b.type='button';b.className='item'+(eq?' eq':'')+(locked?' locked':'');
    const bon=Object.keys(it.bonus).map(k=>'+'+it.bonus[k]+' '+STATS.find(s=>s.id===k).name).join(' · ')||'Estilo';
    const act=locked?'🔒 Nivel '+it.unlock:eq?(it.slot==='extra'?'✓ Puesto (quitar)':'✓ Puesto'):own?'Ponerme':'🪙 '+it.price;
    b.innerHTML=`<div class="ic">${it.emoji}</div><h4>${it.name}</h4><p>${it.desc}</p><div class="bon">${bon}</div><div class="act">${act}</div>`;
    b.onclick=()=>{
      if(locked){Sound.alert();return;}
      if(own){if(eq&&it.slot==='extra')save.equip.extra=null;else save.equip[it.slot]=it.id;persist();Sound.click();renderShop();return;}
      if(save.coins<it.price){Sound.alert();b.querySelector('.act').textContent='Te faltan 🪙 '+(it.price-save.coins);return;}
      save.coins-=it.price;save.owned.push(it.id);save.equip[it.slot]=it.id;persist();Sound.coin();renderShop();
    };
    g.appendChild(b);
  });
}

/* ---------- Mundo 3D ---------- */
const canvas=$('#gl'),dcv=$('#draw'),dctx=dcv.getContext('2d');
let renderer=null,scene=null,camera=null;
const GEO={};const MAT={};
function mat(c){const k=typeof c==='number'?c:c;if(!MAT[k])MAT[k]=new THREE.MeshLambertMaterial({color:c});return MAT[k];}
function initGL(){
  if(renderer)return;
  renderer=new THREE.WebGLRenderer({canvas,antialias:!isTouch,powerPreference:'high-performance'});
  renderer.setPixelRatio(Math.min(window.devicePixelRatio||1,isTouch?1.5:1.75));
  camera=new THREE.PerspectiveCamera(50,1,0.1,400);
  GEO.box=new THREE.BoxGeometry(1,1,1);
  GEO.sph=new THREE.SphereGeometry(1,14,10);
  GEO.cyl=new THREE.CylinderGeometry(1,1,1,10);
  GEO.disc=new THREE.CircleGeometry(1,24);
  GEO.ring=new THREE.RingGeometry(0.86,1,40);
}
function canvasTex(w,h,draw){const c=document.createElement('canvas');c.width=w;c.height=h;const x=c.getContext('2d');draw(x,w,h);const t=new THREE.CanvasTexture(c);t.anisotropy=renderer?Math.min(8,renderer.capabilities.getMaxAnisotropy()):1;return t;}
const PX=12.8; // px por metro en la textura de la cancha
function fieldTexture(night){
  // cubre x -40..40 y z -8..113
  return canvasTex(1024,1550,(x,w,h)=>{
    const M=v=>v*PX;const X=v=>M(v+40),Z=v=>M(v+8);
    for(let i=0;i<24;i++){x.fillStyle=i%2?(night?'#22662f':'#2f8a37'):(night?'#287036':'#3a9a40');x.fillRect(0,Z(-8)+i*M(5.25),w,M(5.25)+1);}
    for(let i=0;i<14000;i++){x.fillStyle=Math.random()<0.5?'rgba(0,0,0,.07)':'rgba(255,255,255,.05)';x.fillRect(Math.random()*w,Math.random()*h,2,2+Math.random()*2);}
    const vg=x.createRadialGradient(w/2,Z(52),M(10),w/2,Z(52),M(75));vg.addColorStop(0,'rgba(255,255,255,0)');vg.addColorStop(1,'rgba(0,0,0,.18)');x.fillStyle=vg;x.fillRect(0,0,w,h);
    x.strokeStyle='rgba(255,255,255,.92)';x.lineWidth=2.4;
    x.strokeRect(X(-34),Z(0),M(68),M(105));
    x.beginPath();x.moveTo(X(-34),Z(52.5));x.lineTo(X(34),Z(52.5));x.stroke();
    x.beginPath();x.arc(X(0),Z(52.5),M(9.15),0,Math.PI*2);x.stroke();
    [[0,1],[105,-1]].forEach(([z0,s])=>{
      x.strokeRect(X(-20.16),s>0?Z(z0):Z(z0-16.5),M(40.32),M(16.5));
      x.strokeRect(X(-9.16),s>0?Z(z0):Z(z0-5.5),M(18.32),M(5.5));
      x.fillStyle='#fff';x.beginPath();x.arc(X(0),Z(z0+s*11),3,0,7);x.fill();
      const a0=Math.acos(5.5/9.15);x.beginPath();
      if(s>0)x.arc(X(0),Z(z0+11),M(9.15),Math.PI/2-a0,Math.PI/2+a0);else x.arc(X(0),Z(z0-11),M(9.15),-Math.PI/2-a0,-Math.PI/2+a0);x.stroke();
    });
    for(const[cx,cz]of[[-34,0],[34,0],[-34,105],[34,105]]){x.beginPath();x.arc(X(cx),Z(cz),M(1),0,7);x.stroke();}
  });
}
function crowdTexture(cols,night){
  return canvasTex(512,256,(x,w,h)=>{
    x.fillStyle=night?'#141a33':'#3a4258';x.fillRect(0,0,w,h);
    for(let r=0;r<16;r++)for(let c=0;c<52;c++){
      const px=c*10+(r%2)*5+Math.random()*2,py=r*16+4;
      const col=Math.random()<0.6?cols[(Math.random()*cols.length)|0]:['#e7e7ef','#2a2f45','#c94b4b','#4b7fc9'][(Math.random()*4)|0];
      x.fillStyle=col;x.fillRect(px-3,py+5,7,8);x.fillStyle=['#f1c9a5','#c68a5e','#8b5a3c'][(Math.random()*3)|0];x.beginPath();x.arc(px+0.5,py+3,2.6,0,7);x.fill();
    }
  });
}
function boardTexture(S,shirt){
  return canvasTex(1024,64,(x,w,h)=>{
    const cols=['#1a3fa8','#c2185b','#12a150','#ff7a00'];
    for(let i=0;i<4;i++){x.fillStyle=cols[i];x.fillRect(i*256,0,256,h);x.fillStyle='rgba(255,255,255,.12)';x.beginPath();x.moveTo(i*256+150,0);x.lineTo(i*256+256,0);x.lineTo(i*256+200,h);x.lineTo(i*256+100,h);x.fill();
      x.fillStyle='#fff';x.font='bold 30px Bungee, Impact, sans-serif';x.textAlign='center';x.textBaseline='middle';x.fillText(i%2?'GOLAZO LATINO':S.city.toUpperCase(),i*256+128,h/2+2);}
  });
}
function flagTexture(f){
  return canvasTex(96,64,(x,w,h)=>{
    const H=(c,a,b)=>{x.fillStyle=c;x.fillRect(0,a*h,w,(b-a)*h);},V=(c,a,b)=>{x.fillStyle=c;x.fillRect(a*w,0,(b-a)*w,h);};
    switch(f){
      case'co':case'ec':H('#ffd400',0,.5);H('#1a3fa8',.5,.75);H('#d52b1e',.75,1);break;
      case'pe':V('#d91f26',0,1/3);V('#fff',1/3,2/3);V('#d91f26',2/3,1);break;
      case'mx':V('#0f7a43',0,1/3);V('#fff',1/3,2/3);V('#c8102e',2/3,1);break;
      case'cl':H('#fff',0,.5);H('#d52b1e',.5,1);x.fillStyle='#0039a6';x.fillRect(0,0,w/3,h/2);break;
      case'uy':H('#fff',0,1);for(let i=1;i<9;i+=2)H('#0038a8',i/9,(i+1)/9);x.fillStyle='#fff';x.fillRect(0,0,w*.4,h*5/9);x.fillStyle='#fcd116';x.beginPath();x.arc(w*.2,h*.27,9,0,7);x.fill();break;
      case'ar':H('#74acdf',0,1/3);H('#fff',1/3,2/3);H('#74acdf',2/3,1);x.fillStyle='#f6b40e';x.beginPath();x.arc(w/2,h/2,6,0,7);x.fill();break;
      case'br':H('#009c3b',0,1);x.fillStyle='#ffdf00';x.beginPath();x.moveTo(w/2,5);x.lineTo(w-6,h/2);x.lineTo(w/2,h-5);x.lineTo(6,h/2);x.fill();x.fillStyle='#002776';x.beginPath();x.arc(w/2,h/2,12,0,7);x.fill();break;
    }
  });
}
const NUMTEX={};
function numberTex(n,shirt){const k=n+shirt;if(NUMTEX[k])return NUMTEX[k];NUMTEX[k]=canvasTex(64,64,(x,w,h)=>{x.fillStyle=shirt;x.fillRect(0,0,w,h);x.fillStyle=contrast(shirt);x.font='44px Bungee, Impact, sans-serif';x.textAlign='center';x.textBaseline='middle';x.fillText(String(n),w/2,h/2+3);});return NUMTEX[k];}
function ballTexture(col){
  return canvasTex(128,64,(x,w,h)=>{x.fillStyle=col==='#ffffff'?'#ffffff':col;x.fillRect(0,0,w,h);x.fillStyle=col==='#ffffff'?'#1b1b1b':'#ffffff';
    for(let i=0;i<6;i++){const cx=i*22+8,cy=i%2?20:44;x.beginPath();for(let k=0;k<5;k++){const a=k*Math.PI*2/5;x.lineTo(cx+Math.cos(a)*8,cy+Math.sin(a)*8);}x.fill();}});
}

function makePlayer(kit,skin,hair,num,isKeeper){
  const g=new THREE.Group();
  const body=new THREE.Group();g.add(body);
  const add=(geo,m,sx,sy,sz,x,y,z,parent)=>{const o=new THREE.Mesh(geo,m);o.scale.set(sx,sy,sz);o.position.set(x,y,z);(parent||body).add(o);return o;};
  const legs=[];
  for(const s of[-1,1]){const leg=new THREE.Group();leg.position.set(s*0.11,0.82,0);body.add(leg);
    add(GEO.box,mat(skin),0.15,0.38,0.15,0,-0.2,0,leg);add(GEO.box,mat(kit[2]),0.16,0.4,0.16,0,-0.56,0,leg);add(GEO.box,mat(kit[3]||'#111827'),0.17,0.09,0.28,0,-0.78,-0.05,leg);legs.push(leg);}
  add(GEO.box,mat(kit[1]),0.44,0.28,0.27,0,0.9,0);
  add(GEO.box,mat(kit[0]),0.48,0.56,0.28,0,1.3,0);
  const arms=[];
  for(const s of[-1,1]){const arm=new THREE.Group();arm.position.set(s*0.31,1.54,0);body.add(arm);add(GEO.box,mat(kit[0]),0.13,0.28,0.14,0,-0.14,0,arm);add(GEO.box,mat(isKeeper?kit[0]:skin),0.11,0.3,0.12,0,-0.42,0,arm);arms.push(arm);}
  add(GEO.box,mat(skin),0.12,0.1,0.12,0,1.63,0);
  add(GEO.sph,mat(skin),0.15,0.17,0.15,0,1.8,0);
  add(GEO.sph,mat(hair),0.155,0.11,0.155,0,1.88,0.01);
  add(GEO.box,mat('#1b1b1b'),0.035,0.04,0.02,-0.055,1.82,-0.145);add(GEO.box,mat('#1b1b1b'),0.035,0.04,0.02,0.055,1.82,-0.145);
  add(GEO.box,mat('#7a2e1e'),0.07,0.02,0.02,0,1.74,-0.14);
  if(num!=null){const pl=new THREE.Mesh(new THREE.PlaneGeometry(0.34,0.34),new THREE.MeshBasicMaterial({map:numberTex(num,kit[0])}));pl.position.set(0,1.33,0.142);body.add(pl);}
  const sh=new THREE.Mesh(GEO.disc,new THREE.MeshBasicMaterial({color:0x000000,transparent:true,opacity:0.28,depthWrite:false}));sh.rotation.x=-Math.PI/2;sh.scale.set(0.42,0.42,1);sh.position.y=0.02;g.add(sh);
  g.userData={legs,arms,body,phase:Math.random()*6,speed:0};
  return g;
}
function animPlayer(p,dt,t){
  const u=p.userData;const run=clamp(u.speed/6,0,1);u.phase+=dt*(4+u.speed*1.6);
  const sw=Math.sin(u.phase)*(0.15+0.75*run);
  const L=u.legs,A=u.arms,b=u.body;
  L[0].rotation.x=sw;L[1].rotation.x=-sw;A[0].rotation.x=-sw*0.8;A[1].rotation.x=sw*0.8;A[0].rotation.z=0;A[1].rotation.z=0;
  b.rotation.set(0,0,0);
  let y=Math.abs(Math.sin(u.phase))*0.05*run+(run<0.1?Math.sin(t*2+u.phase)*0.01:0);
  switch(u.pose){
    case'arms':{const j=Math.abs(Math.sin(t*7+u.phase));A[0].rotation.z=-2.7;A[1].rotation.z=2.7;A[0].rotation.x=A[1].rotation.x=0;y=j*0.38;L[0].rotation.x=L[1].rotation.x=-j*0.35;break;}
    case'plane':{A[0].rotation.z=-1.55;A[1].rotation.z=1.55;A[0].rotation.x=A[1].rotation.x=0;b.rotation.z=Math.sin(t*3)*0.35;break;}
    case'slide':{b.rotation.x=0.45;y=-0.33;L[0].rotation.x=L[1].rotation.x=-1.35;A[0].rotation.z=-2.5;A[1].rotation.z=2.5;A[0].rotation.x=A[1].rotation.x=0;break;}
    case'wave':{A[1].rotation.z=2.5+Math.sin(t*8+u.phase)*0.35;A[1].rotation.x=0;break;}
    case'hug':{A[0].rotation.x=A[1].rotation.x=-1.4;A[0].rotation.z=0.45;A[1].rotation.z=-0.45;y+=Math.abs(Math.sin(t*6+u.phase))*0.16;break;}
    case'sad':{b.rotation.x=-0.32;A[0].rotation.x=A[1].rotation.x=0.1;y-=0.04;break;}
    case'clap':{const c=Math.sin(t*14+u.phase);A[0].rotation.x=A[1].rotation.x=-1.25;A[0].rotation.z=-0.2-0.25*c;A[1].rotation.z=0.2+0.25*c;break;}
  }
  b.position.y=y;
}

/* ---------- Partido ---------- */
let G=null;
function disposeScene(sc){
  if(!sc)return;const keepG=new Set(Object.values(GEO)),keepM=new Set(Object.values(MAT)),keepT=new Set(Object.values(NUMTEX));
  sc.traverse(o=>{if(o.geometry&&!keepG.has(o.geometry))o.geometry.dispose();const m=o.material;if(m&&!keepM.has(m)){if(m.map&&!keepT.has(m.map))m.map.dispose();m.dispose();}});
}
function buildWorld(S){
  disposeScene(scene);
  scene=new THREE.Scene();
  {const top=new THREE.Color(S.sky).multiplyScalar(S.night?0.55:0.72),bot=new THREE.Color(S.sky).lerp(new THREE.Color(S.night?0x4a2f7a:0xffffff),0.5);
   scene.background=canvasTex(4,256,(x,w,h)=>{const g=x.createLinearGradient(0,0,0,h);g.addColorStop(0,'#'+top.getHexString());g.addColorStop(1,'#'+bot.getHexString());x.fillStyle=g;x.fillRect(0,0,w,h);});}
  G.crowd=[];G.cheer=0;
  if(S.fog)scene.fog=new THREE.FogExp2(S.sky,S.fog);
  const hemi=new THREE.HemisphereLight(S.night?0x8fa8ff:0xffffff,S.night?0x1a2a1a:0x3a5a2a,S.night?0.5:0.62);scene.add(hemi);
  const dir=new THREE.DirectionalLight(0xfff4e0,S.night?0.65:0.7);dir.position.set(-30,60,40);scene.add(dir);
  const ftex=fieldTexture(S.night);
  const field=new THREE.Mesh(new THREE.PlaneGeometry(80,121),new THREE.MeshLambertMaterial({map:ftex}));field.rotation.x=-Math.PI/2;field.position.set(0,0,52.5);scene.add(field);
  const out=new THREE.Mesh(new THREE.PlaneGeometry(200,240),mat(S.night?0x1f4a28:0x2f7a36));out.rotation.x=-Math.PI/2;out.position.set(0,-0.02,52);scene.add(out);
  // arco
  const white=mat(0xffffff);
  const post=(x,y,z,sx,sy,sz)=>{const m=new THREE.Mesh(GEO.box,white);m.scale.set(sx,sy,sz);m.position.set(x,y,z);scene.add(m);};
  post(-3.72,1.22,0,0.12,2.44,0.12);post(3.72,1.22,0,0.12,2.44,0.12);post(0,2.44,0,7.56,0.12,0.12);
  const netT=canvasTex(128,64,(x,w,h)=>{x.clearRect(0,0,w,h);x.strokeStyle='rgba(255,255,255,.75)';x.lineWidth=1.4;for(let i=0;i<=w;i+=8){x.beginPath();x.moveTo(i,0);x.lineTo(i,h);x.stroke();}for(let j=0;j<=h;j+=8){x.beginPath();x.moveTo(0,j);x.lineTo(w,j);x.stroke();}});
  netT.wrapS=netT.wrapT=THREE.RepeatWrapping;netT.repeat.set(3,1.5);
  const netM=new THREE.MeshBasicMaterial({map:netT,transparent:true,side:THREE.DoubleSide,depthWrite:false});
  const back=new THREE.Mesh(new THREE.PlaneGeometry(7.4,2.4,18,8),netM);back.position.set(0,1.2,-2);scene.add(back);
  G.netBase=Float32Array.from(back.geometry.attributes.position.array);G.netHit=null;
  const roof=new THREE.Mesh(new THREE.PlaneGeometry(7.4,2),netM);roof.rotation.x=Math.PI/2;roof.position.set(0,2.42,-1);scene.add(roof);
  for(const s of[-1,1]){const sd=new THREE.Mesh(new THREE.PlaneGeometry(2,2.4),netM);sd.rotation.y=Math.PI/2;sd.position.set(s*3.7,1.2,-1);scene.add(sd);}
  G.net=back;
  // vallas publicitarias
  const btex=boardTexture(S);btex.wrapS=THREE.RepeatWrapping;
  const board=(len,x,z,ry)=>{const t=btex.clone();t.needsUpdate=true;t.wrapS=THREE.RepeatWrapping;t.repeat.set(len/40,1);const m=new THREE.Mesh(new THREE.PlaneGeometry(len,1),new THREE.MeshBasicMaterial({map:t}));m.position.set(x,0.5,z);m.rotation.y=ry;scene.add(m);};
  board(40,-22,-4,0);board(40,22,-4,0);board(110,-38,52,Math.PI/2);board(110,38,52,-Math.PI/2);
  // tribunas
  const cols=S.night?[S.rc[0],S.rc[1],'#ffd400']:[S.rc[0],S.rc[1],S.rc[2],'#ffd400'];
  const ctex=crowdTexture(cols,S.night);ctex.wrapS=ctex.wrapT=THREE.RepeatWrapping;
  const stand=(w,x,z,ry,rep)=>{const t=ctex.clone();t.needsUpdate=true;t.wrapS=t.wrapT=THREE.RepeatWrapping;t.repeat.set(rep,2.5);G.crowd.push(t);
    const m=new THREE.Mesh(new THREE.PlaneGeometry(w,34),new THREE.MeshLambertMaterial({map:t}));
    const grp=new THREE.Group();grp.position.set(x,0,z);grp.rotation.y=ry;scene.add(grp);
    m.rotation.x=-0.62;m.position.set(0,10.5,-14);grp.add(m);
    const wall=new THREE.Mesh(GEO.box,mat(S.night?0x20284a:0x2a3354));wall.scale.set(w,1.6,0.6);wall.position.set(0,0.8,0);grp.add(wall);
    const rf=new THREE.Mesh(GEO.box,mat(0x1c2238));rf.scale.set(w,0.8,14);rf.position.set(0,26,-24);grp.add(rf);
    return grp;};
  stand(130,0,-8,0,5);stand(150,-44,52,Math.PI/2,6);stand(150,44,52,-Math.PI/2,6);stand(130,0,114,Math.PI,5);
  // banderas
  const ftx=flagTexture(S.flag);G.flags=[];
  for(let i=0;i<9;i++){const f=new THREE.Mesh(new THREE.PlaneGeometry(3,2),new THREE.MeshBasicMaterial({map:ftx,side:THREE.DoubleSide}));
    const side=i%3;if(side===0){f.position.set(-30+i*7,7+Math.random()*8,-14-Math.random()*6);}else{const sx=side===1?-1:1;f.position.set(sx*(50+Math.random()*6),6+Math.random()*9,8+i*7);f.rotation.y=-sx*Math.PI/2;}
    f.userData.base=f.rotation.y;scene.add(f);G.flags.push(f);}
  // reflectores
  if(S.night){for(const[x,z]of[[-42,-12],[42,-12],[-42,80],[42,80]]){const p=new THREE.Mesh(GEO.cyl,mat(0x5a6390));p.scale.set(0.5,34,0.5);p.position.set(x,17,z);scene.add(p);
    const l=new THREE.Mesh(GEO.box,new THREE.MeshBasicMaterial({color:0xfff6c2}));l.scale.set(6,3,1);l.position.set(x,34,z);l.lookAt(0,0,30);scene.add(l);}}
  // balón
  const bacc=accById(save.equip.balon)||ACC[4];
  const ball=new THREE.Mesh(new THREE.SphereGeometry(0.17,18,14),new THREE.MeshLambertMaterial({map:ballTexture(bacc.color),emissive:bacc.id==='b2'?0x332a00:0x000000}));
  ball.position.set(0,0.17,52);scene.add(ball);G.ball=ball;
  const bsh=new THREE.Mesh(GEO.disc,new THREE.MeshBasicMaterial({color:0,transparent:true,opacity:0.3,depthWrite:false}));bsh.rotation.x=-Math.PI/2;bsh.scale.set(0.2,0.2,1);scene.add(bsh);G.ballShadow=bsh;
  // marcador de portador
  const mk=new THREE.Mesh(new THREE.ConeGeometry(0.26,0.6,4),new THREE.MeshBasicMaterial({color:0xffd400}));mk.rotation.x=Math.PI;scene.add(mk);G.marker=mk;
  // equipos
  const T=save.team,P=save.player,sh=SHIRT[T.shirt],so=SHORTS[T.shorts];
  const boot=(accById(save.equip.guayos)||ACC[0]).color;
  const nums=[P.num,7,9,11,8].filter((v,i,a)=>a.indexOf(v)===i);while(nums.length<5)nums.push(nums.length+2);
  G.mates=[];for(let i=0;i<4;i++){const isMe=i===0;const p=makePlayer([sh,so,sh,isMe?boot:'#111827'],isMe?SKIN[P.skin]:SKIN[(i*2+1)%5],isMe?HAIR[P.hair]:HAIR[i%3],nums[i]);p.userData.team='me';p.userData.isMe=isMe;p.userData.num=nums[i];scene.add(p);G.mates.push(p);
    const ring=new THREE.Group();ring.position.y=0.03;scene.add(ring);p.userData.ring=ring;}
  G.zoneTex=canvasTex(8,128,(x,w,h)=>{const g=x.createLinearGradient(0,0,0,h);g.addColorStop(0,'rgba(255,212,0,.62)');g.addColorStop(1,'rgba(255,212,0,.06)');x.fillStyle=g;x.fillRect(0,0,w,h);});
  G.defs=[];for(let i=0;i<7;i++){const RK=rivalKit(S);const p=makePlayer([RK[0],RK[1],RK[2],'#111827'],SKIN[(i*3)%5],HAIR[(i+1)%4],null);p.userData.team='rv';p.rotation.y=Math.PI;scene.add(p);G.defs.push(p);
    const dz=new THREE.Mesh(GEO.disc,new THREE.MeshBasicMaterial({color:0xff2d2d,transparent:true,opacity:0.22,depthWrite:false}));dz.rotation.x=-Math.PI/2;dz.position.y=0.025;scene.add(dz);p.userData.zone=dz;}
  G.keeper=makePlayer(['#2bd46a','#111827','#2bd46a','#111827'],SKIN[2],HAIR[0],null,true);G.keeper.rotation.y=Math.PI;scene.add(G.keeper);
  // confeti
  G.parts=[];const pgeo=new THREE.PlaneGeometry(0.28,0.18),sgeo=new THREE.BoxGeometry(0.4,0.4,0.4);
  for(let i=0;i<340;i++){const sp=i>=200;const m=new THREE.Mesh(sp?sgeo:pgeo,new THREE.MeshBasicMaterial({color:0xffffff,side:THREE.DoubleSide,fog:false}));m.visible=false;scene.add(m);G.parts.push({m,v:new THREE.Vector3(),life:0,max:1,kind:sp?'spark':'conf'});}
  G.trail=[];G.trailPts=[];
  for(let i=0;i<16;i++){const m=new THREE.Mesh(GEO.sph,new THREE.MeshBasicMaterial({color:0xffffff,transparent:true,opacity:0.55*(1-i/16),depthWrite:false}));m.visible=false;scene.add(m);G.trail.push(m);}
  G.crowdCols=[S.rc[0],S.rc[1],'#ffd400','#ffffff',SHIRT[save.team.shirt]];
}

function hexDist(a,b){const x=parseInt(a.slice(1),16),y=parseInt(b.slice(1),16);return Math.hypot((x>>16)-(y>>16),((x>>8)&255)-((y>>8)&255),(x&255)-(y&255));}
function rivalKit(S){const mine=SHIRT[save.team.shirt];if(hexDist(mine,S.rc[0])>120)return S.rc;
  const alts=['#ffffff','#111827','#e3262f','#7c3aed','#ff7a00','#12a150'];const alt=alts.find(c=>hexDist(c,mine)>160&&c!==S.rc[1])||'#ffffff';return[alt,S.rc[0],alt];}
function params(){
  const d=G.d,S=STADIUMS[G.a];
  return{
    nDef:Math.min(6,2+Math.floor(d/5)),
    icpt:Math.max(0.55,0.8+0.03*d-0.03*eff('efecto')),
    lunge:0.3+0.035*d,
    kReach:0.85+0.02*d,
    kSpeed:4+0.1*d,
    kGuess:0.15+0.012*d,
    pRival:0.04+0.006*d,
    recv:2.8+0.2*eff('pase'),
    zoneL:7+0.75*eff('pase'),zoneW:2.6+0.16*eff('pase'),
    passSpd:(15+0.9*eff('pase'))*S.alt,
    shotSpd:(23+1.6*eff('remate'))*S.alt,
    shotErr:Math.max(0.1,1.4-0.11*eff('remate'))*(S.alt>1?1.1:1),
    curveK:Math.min(1,0.35+0.075*eff('efecto')),
  };
}
function startMatch(a,l){
  sel={a,l};
  initGL();
  const S=STADIUMS[a];
  G={a,l,d:a*3+l,my:0,rv:0,fails:0,passes:0,shots:0,goalsMe:0,chance:0,total:5+l,phase:'intro',time:0,t:0,
    wind:S.wind?S.wind*(Math.random()<0.5?-1:1)*rand(0.6,1):0,carrier:null,flight:null,path:null,drawing:false,
    minute:0,events:[],timer:0,pending:null,paused:false,ended:false,penalty:false,penWin:false,shake:0};
  buildWorld(S);
  G.P=params();
  show('game');document.body.classList.add('ingame');
  resize();
  const wp=$('#windPill');if(Math.abs(G.wind)<0.05)wp.classList.add('off');else{wp.classList.remove('off');wp.textContent='💨 Viento '+(G.wind>0?'→':'←')+' '+(Math.abs(G.wind)>1?'fuerte':'suave');}
  hud();
  lineup();
  G.introT=0;G.introDur=3.8;G.kicked=false;G.cheer=1.2;
  banner(S.city,S.name+' · '+LVL_NAMES[l]+' vs '+S.rival,3200);
  setHint(isTouch?'Toca para saltar la presentación':'Clic para saltar la presentación');
  Sound.cheer();papelitos(170);
  G.timer=0;G.pending=null;
  lastT=performance.now();
  if(!rafOn){rafOn=true;requestAnimationFrame(loop);}
}
function lineup(){
  G.mates.forEach((p,i)=>{p.visible=true;p.position.set(-4.5+i*3,0,57);p.userData.target=p.position.clone();p.rotation.y=Math.PI;p.userData.pose='wave';p.userData.ring.visible=false;});
  G.defs.forEach((p,i)=>{p.visible=true;p.position.set(-9+i*3,0,48.5);p.userData.target=p.position.clone();p.rotation.y=Math.PI;p.userData.pose='clap';p.userData.zone.visible=false;});
  G.keeper.position.set(0,0,1);G.keeper.userData.target=G.keeper.position.clone();G.keeper.userData.pose='clap';
  G.ball.position.set(0,0.17,52.5);
}
function spawn(kind,x,y,z,vx,vy,vz,col,life){const p=G.parts.find(o=>o.life<=0&&o.kind===kind);if(!p)return;p.m.visible=true;p.m.position.set(x,y,z);p.v.set(vx,vy,vz);p.m.material.color.set(col);p.life=p.max=life;p.m.scale.setScalar(1);}
function papelitos(n){const cols=G.crowdCols;for(let i=0;i<n;i++){let x,z;if(Math.random()<0.4){x=rand(-40,40);z=rand(-16,-6);}else{const sd=Math.random()<0.5?-1:1;x=sd*rand(38,48);z=rand(0,100);}
  spawn('conf',x,rand(10,24),z,rand(-1,1),rand(0,2),rand(-1,1),cols[i%cols.length],rand(3,5.5));}}
function firework(x,y,z){const cols=['#ffd400','#ff3d8b','#3dff8f','#1a8cff','#ffffff','#ff7a00',SHIRT[save.team.shirt]];const c=cols[(Math.random()*cols.length)|0],c2=cols[(Math.random()*cols.length)|0];
  for(let i=0;i<30;i++){const th=Math.random()*6.283,ph=Math.acos(rand(-1,1)),sp=rand(7,11);spawn('spark',x,y,z,Math.sin(ph)*Math.cos(th)*sp,Math.cos(ph)*sp,Math.sin(ph)*Math.sin(th)*sp,i%3?c:c2,rand(1.1,1.6));}Sound.pop();}
function hud(){
  const T=save.team,S=STADIUMS[G.a];
  $('#hMin').textContent=Math.floor(G.minute)+"'";
  const my=$('#hMy'),rv=$('#hRv');my.textContent=G.my;rv.textContent=G.rv;
  my.style.background=`linear-gradient(${SHIRT[T.shirt]} 0 55%, ${SHORTS[T.shorts]} 55%)`;
  const RK=rivalKit(S);rv.style.background=`linear-gradient(${RK[0]} 0 55%, ${RK[1]} 55%)`;rv.style.color=contrast(RK[0]);my.style.color=contrast(SHIRT[T.shirt]);
  $('#hChance').textContent=G.penalty?'Penal decisivo':'Jugada '+Math.min(G.chance,G.total)+'/'+G.total;
  $('#hFails').textContent='✖ Fallos: '+G.fails;
}
let bannerT=0,toastTm=0;
function banner(t,sub,ms){const b=$('#banner');b.innerHTML=t+(sub?'<small>'+sub+'</small>':'');b.classList.add('show');clearTimeout(bannerT);bannerT=setTimeout(()=>b.classList.remove('show'),ms||1200);}
function toast(t){const e=$('#toast');e.textContent=t;e.classList.add('show');clearTimeout(toastTm);toastTm=setTimeout(()=>e.classList.remove('show'),2200);}
function setHint(t){$('#hint').textContent=t;$('#hint').style.display=t?'block':'none';}

function nextChance(){
  if(G.chance>=G.total){
    if(G.my===G.rv&&!G.penalty){G.penalty=true;layout('penalty');hud();banner('¡Penal decisivo!','Si lo metes, ganas',1500);return;}
    return endMatch();
  }
  G.chance++;
  G.minute=Math.min(89,(G.chance-0.5)*90/G.total+rand(-3,3));
  const fk=G.l>=1&&Math.random()<0.22;
  layout(fk?'freekick':'open');
  hud();
  banner('Jugada '+G.chance,fk?'Tiro libre':'Minuto '+Math.floor(G.minute)+"'",1000);
}
const isPortrait=()=>camera&&camera.aspect<0.9;
function placeMates(cz,cx){
  const P=G.P,n=cz<26?2:3,pts=[],spread=isPortrait()?10:22;
  for(let tries=0;tries<60&&pts.length<n;tries++){
    let z=cz-rand(9,isPortrait()?16:19),x=clamp(cx+rand(-spread,spread),-30,30);
    if(cz<26){z=rand(7,15);x=clamp(cx*0.4+rand(-spread*0.55,spread*0.55),-12,12);}
    z=Math.max(6,z);
    if(Math.hypot(x-cx,z-cz)<7)continue;
    if(pts.some(p=>Math.hypot(p.x-x,p.z-z)<(isPortrait()?5.5:7)))continue;
    pts.push({x,z});
  }
  return pts;
}
function segDist(px,pz,ax,az,bx,bz){const vx=bx-ax,vz=bz-az;const L=vx*vx+vz*vz||1;let t=((px-ax)*vx+(pz-az)*vz)/L;t=clamp(t,0,1);return Math.hypot(px-(ax+vx*t),pz-(az+vz*t));}
function layout(type){
  const P=G.P;G.type=type;
  [...G.mates,...G.defs,G.keeper].forEach(p=>{p.userData.pose=null;p.userData.celeb=false;p.userData.fast=false;});
  G.mates.forEach(p=>p.rotation.y=0);G.defs.forEach(p=>p.rotation.y=Math.PI);G.netHit=null;
  let cx,cz,mates=[],defs=[];
  if(type==='penalty'){cx=0;cz=11;}
  else if(type==='freekick'){cz=rand(19,26);cx=rand(-10,10);
    const dx=-cx,dz=-cz,L=Math.hypot(dx,dz),ux=dx/L,uz=dz/L;const wx=cx+ux*9.15,wz=cz+uz*9.15;const n=3+Math.floor(G.d/9);
    for(let i=0;i<n;i++){const o=(i-(n-1)/2)*0.7;defs.push({x:wx-uz*o,z:wz+ux*o,wall:true});}}
  else{
    const first=!G.carrier||G.type!=='open'||G.newChance;
    if(G.newChance!==false&&(G.stepCount||0)===0){cz=rand(46,58);cx=rand(-14,14);}else{cz=G.carrier.position.z;cx=G.carrier.position.x;}
    void first;
    let ok=false;
    for(let tries=0;tries<40&&!ok;tries++){
      mates=placeMates(cz,cx);defs=[];
      const n=P.nDef;
      for(let i=0;i<n;i++){
        const tgt=Math.random()<0.7&&mates.length?mates[(Math.random()*mates.length)|0]:{x:rand(-6,6),z:2};
        const t=rand(0.35,0.8);let x=lerp(cx,tgt.x,t)+rand(-3.2,3.2),z=lerp(cz,tgt.z,t)+rand(-2,2);
        x=clamp(x,-32,32);z=Math.max(4,z);
        if(Math.hypot(x-cx,z-cz)<3)continue;
        if(defs.some(d=>Math.hypot(d.x-x,d.z-z)<2.2))continue;
        if(mates.some(m=>Math.hypot(m.x-x,m.z-z)<2.2))continue;
        defs.push({x,z});
      }
      const need=P.icpt+P.lunge+0.35;
      ok=mates.some(m=>defs.every(d=>segDist(d.x,d.z,cx,cz,m.x,m.z)>need));
    }
  }
  G.stepCount=(G.stepCount||0);
  // ubicar portador y compañeros
  const me=G.mates[0];
  const all=G.mates;
  let carrier=G.carrier&&type==='open'&&G.stepCount>0?G.carrier:me;
  const others=all.filter(p=>p!==carrier);
  carrier.userData.target=new THREE.Vector3(cx,0,cz);
  if(G.stepCount===0||type!=='open'){carrier.position.set(cx,0,cz);}
  others.forEach((p,i)=>{const m=mates[i];p.visible=!!m;p.userData.ring.visible=!!m;if(m){p.userData.target=new THREE.Vector3(m.x,0,m.z);if(G.stepCount===0||type!=='open')p.position.set(m.x+rand(-2,2),0,m.z+rand(1,4));}});
  carrier.visible=true;carrier.userData.ring.visible=false;
  G.carrier=carrier;G.mateList=others.filter(p=>p.visible);
  G.defs.forEach((p,i)=>{const d=defs[i];p.visible=!!d;p.userData.zone.visible=false;if(d){p.userData.target=new THREE.Vector3(d.x,0,d.z);p.userData.wall=!!d.wall;if(G.stepCount===0||type!=='open')p.position.set(d.x+rand(-2,2),0,d.z-rand(0,3));}});
  G.defList=G.defs.filter(p=>p.visible);
  G.keeper.position.set(0,0,1.0);G.keeper.userData.target=new THREE.Vector3(0,0,1.0);G.keeper.rotation.set(0,Math.PI,0);G.keeper.userData.dive=0;
  G.ball.position.set(cx,0.17,cz-0.45);
  G.phase='aim';G.flight=null;G.path=null;
  updateRings();
  const near=cz<28;
  if(type==='penalty')setHint('Penal: desliza hacia una esquina del arco');
  else if(type==='freekick')setHint('Tiro libre: curva el balón alrededor de la barrera');
  else setHint(near?'¡Remata! Arrastra hasta el rincón del arco, arriba o abajo':'Pasa al pie o al espacio: termina dentro de la sombra amarilla');
  if(save.tutorial&&G.chance===1&&G.stepCount===0)setTimeout(()=>{if(G&&G.phase==='aim'&&!G.drawing)showHand();},900);
}
// Dirección de la sombra: hacia adelante y un poco hacia el arco
function zoneDir(q){let tx=-q.x,tz=-q.z;const l=Math.hypot(tx,tz)||1;let dx=tx/l*0.5,dz=-0.5+tz/l*0.5;const l2=Math.hypot(dx,dz)||1;return[dx/l2,dz/l2];}
// ¿El punto E cae dentro de la sombra del compañero m? (pase al pie o pase en profundidad)
function inZone(m,E){const q=m.userData.target||m.position,P=G.P;const[dx,dz]=zoneDir(q);const ox=E.x-q.x,oz=E.z-q.z;const f=ox*dx+oz*dz,sd=Math.abs(ox*dz-oz*dx);
  if(f<-1.3||f>P.zoneL)return false;const t=(f+1.3)/(P.zoneL+1.3);return sd<=1.5+(P.zoneW-1.5)*t;}
function buildZone(r){const P=G.P,L=P.zoneL,W=P.zoneW;
  const g=new THREE.BufferGeometry();g.setAttribute('position',new THREE.Float32BufferAttribute([-1.5,0,1.3, 1.5,0,1.3, W,0,-L, -W,0,-L],3));
  g.setAttribute('uv',new THREE.Float32BufferAttribute([0,1,1,1,1,0,0,0],2));g.setIndex([0,2,1,0,3,2]);
  r.add(new THREE.Mesh(g,new THREE.MeshBasicMaterial({map:G.zoneTex,transparent:true,depthWrite:false,side:THREE.DoubleSide})));
  const lg=new THREE.BufferGeometry();lg.setAttribute('position',new THREE.Float32BufferAttribute([-1.5,0.01,1.3, -W,0.01,-L, W,0.01,-L, 1.5,0.01,1.3],3));
  r.add(new THREE.Line(lg,new THREE.LineBasicMaterial({color:0xffd400,transparent:true,opacity:0.85})));r.userData.built=true;}
function updateRings(){
  const v=eff('vision'),P=G.P;
  G.mates.forEach(p=>{const r=p.userData.ring;if(!p.visible||p===G.carrier){r.visible=false;return;}if(!r.userData.built)buildZone(r);
    r.visible=v>=1;const[dx,dz]=zoneDir(p.userData.target||p.position);r.rotation.y=Math.atan2(-dx,-dz);});
  const close=G.carrier&&G.carrier.position.z<18;
  G.defs.forEach(p=>{const z=p.userData.zone;z.visible=p.visible&&v>=5&&G.phase==='aim'&&(!close||p.userData.wall);const R=p.userData.wall?0.45:P.icpt+P.lunge;z.scale.set(R,R,1);});
}
function showHand(){
  const h=$('#hand');const b=project(G.ball.position);const m=G.mateList[0];if(!m)return;const e=project(m.userData.target);
  h.style.setProperty('--hx0',(b.x-14)+'px');h.style.setProperty('--hy0',(b.y-6)+'px');h.style.setProperty('--hx1',(e.x-14)+'px');h.style.setProperty('--hy1',(e.y-6)+'px');h.classList.add('on');
}
function hideHand(){$('#hand').classList.remove('on');}

/* --- Entrada: deslizar --- */
const ray=new THREE.Raycaster(),plane=new THREE.Plane(new THREE.Vector3(0,1,0),0),tmpV=new THREE.Vector2(),hitP=new THREE.Vector3();
function worldAt(clientX,clientY){const r=dcv.getBoundingClientRect();tmpV.set(((clientX-r.left)/r.width)*2-1,-((clientY-r.top)/r.height)*2+1);ray.setFromCamera(tmpV,camera);return ray.ray.intersectPlane(plane,hitP)?hitP.clone():null;}
function project(v){const p=v.clone().project(camera);return{x:(p.x+1)/2*dcv.clientWidth,y:(1-p.y)/2*dcv.clientHeight,ok:p.z<1};}
let pid=null,raw=[];
dcv.addEventListener('pointerdown',e=>{
  if(G&&G.phase==='intro'&&!G.paused){e.preventDefault();G.introT=Math.max(G.introT,G.introDur);return;}
  if(!G||G.phase!=='aim'||G.paused)return;e.preventDefault();
  const w=worldAt(e.clientX,e.clientY);if(!w)return;
  pid=e.pointerId;try{dcv.setPointerCapture(pid);}catch(_){}
  raw=[w];G.drawing=true;G.path=[G.ball.position.clone().setY(0)];G.lastScreen={x:e.clientX,y:e.clientY};hideHand();
});
dcv.addEventListener('pointermove',e=>{
  if(!G||!G.drawing||e.pointerId!==pid)return;e.preventDefault();
  G.lastScreen={x:e.clientX,y:e.clientY};
  const w=worldAt(e.clientX,e.clientY);if(!w){if(G.path&&G.path.length>2)G.plan=planKick(G.path);return;}
  const last=raw[raw.length-1];if(w.distanceTo(last)<0.35)return;
  raw.push(w);
  const o=G.ball.position.clone().setY(0).sub(raw[0]);
  G.path=raw.map(p=>p.clone().add(o));
  G.plan=planKick(G.path);
});
function endDraw(e){
  if(!G||!G.drawing||(e&&e.pointerId!==pid))return;
  G.drawing=false;pid=null;
  const path=G.path;G.path=null;G.plan=null;
  if(!path||path.length<3||path[0].distanceTo(path[path.length-1])<2.5){setHint('Desliza más largo, desde el balón hacia donde quieres enviarlo');return;}
  kick(path);
}
dcv.addEventListener('pointerup',endDraw);dcv.addEventListener('pointercancel',endDraw);

/* --- Lógica del pase o remate --- */
const goalPlane=new THREE.Plane(new THREE.Vector3(0,0,1),0);
// Donde el dedo termina sobre el arco en pantalla: da la altura del remate (permite los ángulos superiores)
function goalAim(){if(!G.lastScreen)return null;const r=dcv.getBoundingClientRect();tmpV.set(((G.lastScreen.x-r.left)/r.width)*2-1,-((G.lastScreen.y-r.top)/r.height)*2+1);
  ray.setFromCamera(tmpV,camera);const h=new THREE.Vector3();if(!ray.ray.intersectPlane(goalPlane,h))return null;if(h.y<0.3||h.y>4.5||Math.abs(h.x)>12)return null;return h;}
function shotH(t,ty){return lerp(0.17,ty,t)+0.35*Math.sin(Math.PI*t);}
function resample(path,n){const cum=[0];for(let i=1;i<path.length;i++)cum.push(cum[i-1]+path[i].distanceTo(path[i-1]));const T=cum[cum.length-1]||1,out=[];let j=1;
  for(let k=0;k<=n;k++){const sv=T*k/n;while(j<path.length-1&&cum[j]<sv)j++;const a=cum[j-1],b=cum[j],f=b>a?(sv-a)/(b-a):0;out.push(path[j-1].clone().lerp(path[j],clamp(f,0,1)));}return out;}
function planKick(path){
  const P=G.P,R=resample(path,24),B=R[0].clone(),Er=R[24].clone();
  const cx=Er.x-B.x,cz=Er.z-B.z,L=Math.hypot(cx,cz)||1,nx=-cz/L,nz=cx/L;
  let raw=R.map(q=>(q.x-B.x)*nx+(q.z-B.z)*nz);
  // Una sola curva realista: se toma el punto de mayor desvío y se dibuja un solo arco suave (sin eses ni zigzags)
  let peak=0,pi=12;raw.forEach((v,i)=>{if(Math.abs(v)>Math.abs(peak)){peak=v;pi=i;}});
  peak=clamp(peak,-0.2*L,0.2*L);
  const tp=clamp(pi/24,0.3,0.7);
  const offs=raw.map((v,i)=>{const t=i/24;const u=t<tp?t/tp:(1-t)/(1-tp);return peak*Math.sin(Math.PI*0.5*u);});
  // ¿Remate? Al final del trazo cerca del arco, en tiros libres y penales, o desde la zona de ataque si el trazo va hacia el arco y no termina en un compañero
  let shot=false,E=Er.clone();
  const toGoal=cz<-1,chordX=toGoal?B.x+cx*((0-B.z)/cz):999;
  const mateAtEnd=(G.mateList||[]).some(m=>inZone(m,Er));
  const ga=goalAim();let ty=0.6;
  if(Er.z<3.5||G.type!=='open'||(ga&&B.z<35&&!mateAtEnd)||(B.z<32&&toGoal&&!mateAtEnd&&Math.abs(chordX)<14)){
    shot=true;const a=R[18],b=R[24];let dx=b.x-a.x,dz=b.z-a.z;
    if(dz>-0.05){dx=Er.x-B.x;dz=Math.min(-0.5,Er.z-B.z);}
    const ext=b.z<=0?0:dx*((0-b.z)/dz),lim=Math.max(1,b.z*0.35);
    const gx=b.x+clamp(ext,-lim,lim);E=new THREE.Vector3(clamp(gx,-12,12),0,0);
    if(ga){E.x=ga.x;ty=clamp(ga.y,0.3,3.4);}
  }
  const len=B.distanceTo(E);
  const Eadj=E.clone();Eadj.x+=G.wind*len*0.03;
  let k=P.curveK*Math.min(1.5,len/L);
  const maxCurve=0.22*len;if(Math.abs(peak)*k>maxCurve)k=maxCurve/Math.max(0.001,Math.abs(peak));
  return{B,E:Eadj,aim:E,offs,k,len,shot,ty,curveAmt:Math.abs(peak)*k};
}
function curvePts(plan,N){
  const B=plan.B,E=plan.E,cx=E.x-B.x,cz=E.z-B.z,L=Math.hypot(cx,cz)||1,nx=-cz/L,nz=cx/L,o=plan.offs,M=o.length-1,pts=[];
  for(let i=0;i<=N;i++){const t=i/N,f=t*M,i0=Math.min(M-1,Math.floor(f)),off=lerp(o[i0],o[i0+1],f-i0)*plan.k;pts.push(new THREE.Vector3(B.x+cx*t+nx*off,0,B.z+cz*t+nz*off));}
  return pts;
}
function kick(path){
  const P=G.P,plan=planKick(path);
  save.tutorial=false;hideHand();
  if(plan.shot){const r3=()=>(Math.random()+Math.random()+Math.random()-1.5)/1.5;plan.E.x+=P.shotErr*(plan.len/20)*r3();plan.ty=Math.max(0.2,plan.ty+P.shotErr*0.28*(plan.len/20)*r3());}
  const N=48,pts=curvePts(plan,N);
  let L=0;for(let i=1;i<pts.length;i++)L+=pts[i].distanceTo(pts[i-1]);
  let hitT=null,hitter=null;
  for(const d of G.defList){
    if(plan.B.z<18&&!d.userData.wall)continue; // muy cerca del arco: sin intercepción
    const lungeA=d.userData.wall?0:P.lunge*rand(0.35,1);const R=(d.userData.wall?0.45:P.icpt)+lungeA;
    const dp=d.userData.target||d.position;
    for(let i=2;i<=N;i++){const q=pts[i];const dd=Math.hypot(q.x-dp.x,q.z-dp.z);
      const h=plan.shot?shotH(i/N,plan.ty):(0.3+L*0.035)*Math.sin(Math.PI*i/N);
      if(dd<R&&h<2.0&&(!plan.shot||q.z>1.2)){if(hitT===null||i/N<hitT){hitT=i/N;hitter=d;}break;}}
  }
  const spd=plan.shot?P.shotSpd:P.passSpd;
  const dur=Math.max(0.35,L/spd);
  let result=null,receiver=null;
  if(hitT!==null){result='icpt';}
  else if(plan.shot){
    const gx=plan.E.x;const aim=Math.random()<P.kGuess?gx:rand(-3.3,3.3);
    const move=P.kSpeed*dur;const kx=clamp(aim,-move,move);
    G.keeper.userData.kx=kx;
    const ty=plan.ty,hk=ty>1.8?0.55:ty>1.2?0.85:1;G.keeper.userData.ky=ty;
    if(ty>2.56)result=ty<2.75&&Math.abs(gx)<3.8?'bar':'over';
    else if(Math.abs(gx)>3.66){result=Math.abs(gx)<3.95?'post':'wide';}
    else if(Math.abs(gx-kx)<P.kReach*hk)result='save';
    else result='goal';
  }else{
    const E=plan.E;
    if(Math.abs(E.x)>34||E.z>105||E.z<0)result='out';
    else{let best=null,bd=1e9;for(const m of G.mateList){if(!inZone(m,E))continue;const q=m.userData.target||m.position;const dd=Math.hypot(q.x-E.x,q.z-E.z);if(dd<bd){bd=dd;best=m;}}
      if(best){result='pass';receiver=best;}else result='loose';}
  }
  G.flight={pts,t:0,dur,stop:hitT===null?1:hitT,result,receiver,hitter,shot:plan.shot,L,curve:plan.curveAmt,ty:plan.ty||0.6};G.roll=null;
  G.phase='flight';G.trailPts.length=0;
  const tc=plan.curveAmt>1.2?((accById(save.equip.balon)||ACC[4]).id==='b0'?'#9fe7ff':(accById(save.equip.balon)).color):'#ffffff';
  G.trail.forEach(m=>m.material.color.set(tc));
  if(receiver)receiver.userData.target=plan.E.clone();
  if(hitter){const q=pts[Math.round(hitT*N)];hitter.userData.target=new THREE.Vector3(q.x,0,q.z+0.3);hitter.userData.fast=true;}
  G.carrier.userData.kick=0.25;
  Sound.kick(plan.shot?1.3:0.8);
  setHint('');
  G.defs.forEach(p=>p.userData.zone.visible=false);
}
function resolveFlight(){
  const f=G.flight;G.flight=null;
  switch(f.result){
    case'pass':G.passes++;save.passes++;G.carrier=f.receiver;G.stepCount++;G.phase='between';Sound.click();
      G.timer=0.55;G.pending=()=>layout('open');break;
    case'goal':{G.my++;G.goalsMe++;G.shots++;if(G.penalty)G.penWin=true;hud();
      const sc=G.carrier,u=sc.userData,big=f.L>22||f.curve>2.2;
      Sound.goal();banner(big?'¡GOLAZO!':'¡GOOOL!',u.isMe?save.player.nick+' #'+save.player.num:'Gol del #'+u.num,2600);
      G.netHit={x:G.ball.position.x,y:G.ball.position.y-1.2,amp:0.95};
      startCelebration(sc);break;}
    default:{
      const msg={icpt:['¡Interceptado!','El rival corta el pase'],save:['¡Atajada!','Busca la esquina contraria'],wide:['¡Afuera!','Apunta dentro del arco'],post:['¡Al palo!','Casi entra'],bar:['¡Al travesaño!','Un poquito más abajo'],over:['¡Por encima!','Baja un poco el remate'],out:['¡Balón afuera!','Pase demasiado largo'],loose:['Pase sin dueño','Termina dentro de la sombra amarilla']}[f.result];
      {const n=f.pts.length-1,a=f.pts[Math.max(0,n-3)],b=f.pts[n],dx=b.x-a.x,dz=b.z-a.z,dl=Math.hypot(dx,dz)||1,sp=f.L/f.dur;
       if(f.result==='loose'||f.result==='out'||f.result==='wide'||f.result==='over'){G.roll={v:new THREE.Vector3(dx/dl*sp*0.55,0,dz/dl*sp*0.55),vy:f.result==='over'?2:0,t:0,dur:1.7};
         if(f.result==='loose'||f.result==='out'){let bd=1e9,bdf=null;const stop=G.ball.position.clone().addScaledVector(G.roll.v,0.6);for(const d of G.defList){const dd=d.position.distanceTo(stop);if(dd<bd){bd=dd;bdf=d;}}if(bdf){bdf.userData.target=new THREE.Vector3(stop.x,0,stop.z);bdf.userData.fast=true;}}}
       else if(f.result==='post'||f.result==='bar'){G.roll={v:new THREE.Vector3(-dx/dl*5,0,6),vy:f.result==='bar'?3:1,t:0,dur:1.2};}}
      if(f.shot)G.shots++;
      if(f.result==='post')G.netHit=null;
      G.fails++;Sound.groan();banner(msg[0],msg[1],1500);hud();G.phase='between';G.timer=1.8;G.pending=()=>afterChance(true);
      if(f.result==='save'){G.keeper.userData.hold=true;}
    }
  }
}
function startCelebration(sc){
  G.phase='celebrate';G.celT=0;G.cheer=1.6;G.shake=0.35;G.scorer=sc;hideHand();
  G.mates.forEach(p=>p.userData.ring.visible=false);
  const sd=sc.position.x>=0?1:-1;
  sc.userData.target=new THREE.Vector3(clamp(sc.position.x+sd*7,-30,30),0,clamp(sc.position.z+5,4,100));
  sc.userData.fast=true;sc.userData.pose=null;
  G.celPose=['arms','plane','slide'][(Math.random()*3)|0];
  G.mates.forEach(p=>{p.userData.celeb=p!==sc&&p.visible;});
  G.defs.forEach(p=>{if(p.visible)p.userData.pose='sad';});G.keeper.userData.pose='sad';
  const cols=[SHIRT[save.team.shirt],SHORTS[save.team.shorts],'#ffffff','#ffd400','#ff3d8b'],b=G.ball.position;
  for(let i=0;i<90;i++)spawn('conf',b.x+rand(-2,2),rand(1,3),rand(-1.5,1),rand(-4,4),rand(5,10),rand(-1,4),cols[i%cols.length],rand(2,3.2));
  papelitos(90);
  G.fwT=[0.3,0.85,1.4,2.0,2.6];
  G.timer=3.8;G.pending=()=>{G.scorer=null;G.mates.forEach(p=>p.userData.celeb=false);afterChance(false);};
}
function afterChance(failed){
  G.stepCount=0;G.carrier=null;
  if(G.penalty)return endMatch();
  const p=Math.min(0.6,G.P.pRival+(failed?0.22:0));
  if(Math.random()<p){
    G.rv++;const m=Math.floor(Math.min(90,G.minute+rand(2,8)));
    toast('⚽ Gol de '+STADIUMS[G.a].rival+' ('+m+"')");Sound.alert();hud();
    G.timer=1.6;G.pending=()=>nextChance();G.phase='between';
  }else nextChance();
}

/* --- Fin --- */
function endMatch(){
  G.phase='ended';G.ended=true;G.flight=null;
  Sound.longWhistle();setHint('');
  const won=G.my>G.rv||G.penWin;
  if(won){G.final=true;G.celT=0;G.cheer=1.6;const c=G.mates[0];c.visible=true;
    G.mates.forEach((p,i)=>{p.visible=true;p.userData.ring.visible=false;p.userData.celeb=false;
      if(i===0){p.userData.pose='arms';p.userData.target=null;}else{p.userData.pose=null;p.userData.target=new THREE.Vector3(c.position.x+Math.cos(i*2.1)*1.4,0,c.position.z+Math.sin(i*2.1)*1.4);p.userData.fast=true;p.userData.hugger=true;}});
    G.defs.forEach(p=>{if(p.visible)p.userData.pose='sad';});G.keeper.userData.pose='sad';
    G.fwT=[0.15,0.5,0.9,1.3,1.7,2.1];papelitos(140);banner('¡Ganamos!',save.team.name,2400);}
  setTimeout(()=>{if(G&&G.ended)finish();},won?3000:1100);
}
function finish(){
  if(!G)return;
  document.body.classList.remove('ingame');
  const a=G.a,l=G.l,d=G.d,S=STADIUMS[a];
  const won=G.my>G.rv||G.penWin,draw=!won&&G.my===G.rv;
  const lines=[];let xp=0;
  const add=(t,v)=>{lines.push([t,v]);xp+=v;};
  if(G.passes)add('Pases completos ×'+G.passes,G.passes*(6+d));
  if(G.goalsMe)add('Goles ×'+G.goalsMe,G.goalsMe*(35+6*d));
  if(won)add('Victoria en '+S.city,60+a*25+l*30);
  else if(draw)add('Empate',20+a*5);
  if(G.fails===0&&(won||draw))add('Partido sin fallos',50+5*d);
  const coins=Math.round(xp*0.6);
  let stars=0;if(won){stars=1;if(G.fails<=2)stars++;if(G.fails===0)stars++;}
  const before=levelOf(save.xp),key=a+'-'+l,prevStars=save.stars[key]||0,wasNextLocked=a<8&&!isUnlocked(a+1,0),wasLvlLocked=l<2&&!isUnlocked(a,l+1);
  save.xp+=xp;save.coins+=coins;save.goals+=G.goalsMe;save.matches++;if(won)save.wins++;
  if(stars>prevStars)save.stars[key]=stars;
  persist();
  const after=levelOf(save.xp);
  $('#rTitle').textContent=won?'¡Victoria!':draw?'Empate':'¡Casi!';
  $('#rScore').textContent=`${G.my} – ${G.rv}${G.penWin?' (pen.)':''}`;
  $('#rSub').textContent=save.team.name+' vs '+S.rival+' · '+S.city+' · '+LVL_NAMES[l]+' · Fallos: '+G.fails;
  $('#rStars').innerHTML='★'.repeat(stars)+'<em>'+'★'.repeat(3-stars)+'</em>';
  $('#rLines').innerHTML=lines.map(([t,v])=>`<div class="rl"><span>${t}</span><b>+${v} XP</b></div>`).join('')+`<div class="rl rtotal"><span>Total</span><span>+${xp} XP · +${coins} 🪙</span></div>`;
  $('#rAva').innerHTML=avatarSVG(false);
  const pr=levelProgress(save.xp);$('#rLvl').textContent='Nv '+pr.l+' · '+rankOf(pr.l);$('#rXp').style.width='0%';setTimeout(()=>{$('#rXp').style.width=(pr.cur*100)+'%';},60);
  $('#rXpT').textContent=pr.l>=MAX_LEVEL?'¡Nivel máximo!':pr.have+'/'+pr.span+' XP';
  const unl=[];
  if(after>before){unl.push('⬆️ ¡Subiste al nivel '+after+'!');ACC.filter(x=>x.unlock>before&&x.unlock<=after).forEach(x=>unl.push(x.emoji+' Nuevo accesorio disponible: '+x.name));
    if(statCap()>Math.min(10,3+Math.floor(before/3)))unl.push('💪 Puedes subir más tus habilidades');}
  if(won&&wasNextLocked&&isUnlocked(a+1,0))unl.push('🏟️ Nuevo estadio: '+STADIUMS[a+1].city);
  if(won&&wasLvlLocked&&isUnlocked(a,l+1))unl.push('🔓 Nivel '+LVL_NAMES[l+1]+' en '+S.city);
  if(!won)unl.push(draw?'💡 Empataste: un gol más y era tuyo.':'💡 Cada fallo le da una contra al rival. Pasa a compañeros con camino libre.');
  $('#rUnl').innerHTML=unl.map(t=>`<div>${t}</div>`).join('');
  let nA=a,nL=l;if(won){if(l<2)nL=l+1;else if(a<8){nA=a+1;nL=0;}}
  const nb=$('#rNext');const lastOne=won&&a===8&&l===2;nb.style.display=lastOne?'none':'';nb.disabled=!isUnlocked(nA,nL)||(!won);nb.onclick=()=>{Sound.click();startMatch(nA,nL);};
  $('#rRetry').onclick=()=>{Sound.click();startMatch(a,l);};
  $('#rMenu').onclick=()=>{Sound.click();show('menu');};
  show('results');
  if(after>before)setTimeout(()=>{Sound.level();const av=$('#rAva');av.classList.remove('pulse');void av.offsetWidth;av.classList.add('pulse');},500);
  else if(won)Sound.win();else Sound.lose();
  G=null;
}

/* --- Pausa --- */
function pause(){if(!G||G.ended)return;G.paused=true;G.drawing=false;$('#pause').classList.add('show');}
function resume(){if(!G)return;G.paused=false;$('#pause').classList.remove('show');lastT=performance.now();}
$('#pauseBtn').addEventListener('click',e=>{e.stopPropagation();pause();});
$('#pCont').onclick=resume;
$('#pQuit').onclick=()=>{$('#pause').classList.remove('show');document.body.classList.remove('ingame');G=null;show('menu');};
document.addEventListener('visibilitychange',()=>{if(document.hidden)pause();});
document.addEventListener('keydown',e=>{if(!G)return;if(e.key==='Escape'||e.key==='p'||e.key==='P'){G.paused?resume():pause();}});

/* --- Bucle --- */
let lastT=0,rafOn=false;
function resize(){
  if(!renderer)return;const w=canvas.clientWidth||window.innerWidth,h=canvas.clientHeight||window.innerHeight;
  renderer.setSize(w,h,false);camera.aspect=w/h;camera.fov=w/h<0.9?70:44;camera.updateProjectionMatrix();
  const dpr=Math.min(window.devicePixelRatio||1,2);dcv.width=w*dpr;dcv.height=h*dpr;dctx.setTransform(dpr,0,0,dpr,0,0);
}
window.addEventListener('resize',()=>{if(G)resize();});
const camPos=new THREE.Vector3(0,10,70),camLook=new THREE.Vector3(0,0,40),frameCam=new THREE.PerspectiveCamera(50,1,0.1,400);
function update(dt){
  if(!G||G.paused)return;
  G.t+=dt;
  if(G.timer>0){G.timer-=dt;if(G.timer<=0&&G.pending){const f=G.pending;G.pending=null;f();if(!G)return;}}
  // presentación
  if(G.phase==='intro'){G.introT+=dt;if(G.introT>=G.introDur&&!G.kicked){G.kicked=true;setHint('');banner('¡A jugar!','',900);Sound.whistle(2);
    [...G.mates,...G.defs,G.keeper].forEach(p=>p.userData.pose=null);G.timer=0.9;G.pending=()=>nextChance();}}
  const slow=G.flight&&G.flight.shot&&G.flight.result==='goal'&&G.flight.t>0.55;
  const fdt=slow?dt*0.32:dt;
  // fuegos artificiales
  if(G.fwT&&(G.phase==='celebrate'||G.final)){G.celT+=dt;while(G.fwT.length&&G.celT>G.fwT[0]){G.fwT.shift();firework(rand(-28,28),rand(20,30),rand(-14,-4));}}
  // celebración del gol
  if(G.phase==='celebrate'&&G.scorer){const sc=G.scorer,su=sc.userData;
    if(!su.pose&&(G.celT>1.3||(su.target&&sc.position.distanceTo(su.target)<0.3))){su.pose=G.celPose;su.target=null;}
    if(su.pose)sc.rotation.y=Math.atan2(-(camera.position.x-sc.position.x),-(camera.position.z-sc.position.z));
    G.mates.forEach((p,i)=>{const u=p.userData;if(!u.celeb||!p.visible)return;const a=i*2.1+0.6;const tg=new THREE.Vector3(sc.position.x+Math.cos(a)*1.3,0,sc.position.z+Math.sin(a)*1.3);
      if(!u.pose){u.target=tg;u.fast=true;}
      if(p.position.distanceTo(tg)<0.45||u.pose){u.pose='hug';u.target=null;p.position.lerp(tg,0.1);p.rotation.y=Math.atan2(-(sc.position.x-p.position.x),-(sc.position.z-p.position.z));}});
  }
  if(G.final){const c=G.mates[0];c.rotation.y=Math.atan2(-(camera.position.x-c.position.x),-(camera.position.z-c.position.z));
    G.mates.forEach(p=>{const u=p.userData;if(u.hugger&&u.target&&p.position.distanceTo(u.target)<0.4){u.pose='hug';u.target=null;}if(u.hugger&&u.pose)p.rotation.y=Math.atan2(-(c.position.x-p.position.x),-(c.position.z-p.position.z));});}
  // jugadores
  const all=[...G.mates,...G.defs,G.keeper];
  for(const p of all){if(!p.visible)continue;const u=p.userData;
    if(u.target){const dx=u.target.x-p.position.x,dz=u.target.z-p.position.z,dd=Math.hypot(dx,dz);
      const isRecv=G.flight&&G.flight.receiver===p;
      const sp=isRecv?Math.max(6,dd/Math.max(0.2,G.flight.dur*(1-G.flight.t)-0.05)):(u.fast?9:6.5);
      if(dd>0.05){const st=Math.min(dd,sp*fdt);p.position.x+=dx/dd*st;p.position.z+=dz/dd*st;u.speed=lerp(u.speed,sp,0.2);
        if(u.team==='me'&&!u.pose&&(p!==G.carrier||G.phase==='celebrate'))p.rotation.y=Math.atan2(-dx,-dz);}
      else{u.speed=lerp(u.speed,0,0.2);u.fast=false;if(u.team==='me'&&!u.pose&&G.phase==='aim')p.rotation.y=lerp(p.rotation.y,0,0.1);}
    }else u.speed=lerp(u.speed,0,0.2);
    if(u.team==='me'&&u.ring)u.ring.position.set(p.position.x,0.03,p.position.z);
    if(u.zone)u.zone.position.set(p.position.x,0.025,p.position.z);
    animPlayer(p,fdt,G.t);
  }
  // portero
  const K=G.keeper,ku=K.userData;
  if(G.phase==='aim'){const bx=G.ball.position.x*0.12;ku.target.set(clamp(bx,-1.5,1.5),0,1);ku.dive=0;ku.hold=false;K.rotation.z=0;K.position.y=0;}
  if(G.flight&&G.flight.shot){const kx=ku.kx||0;ku.target.set(kx,0,0.9);const far=Math.abs(kx-K.position.x)>1.2||Math.abs(kx)>1.6;
    const high=(ku.ky||0)>1.5;if((far||high)&&G.flight.t>0.25){ku.dive=Math.min(1,ku.dive+fdt*4);K.rotation.z=-Math.sign(kx||1)*ku.dive*(high?0.7:1.2);K.position.y=Math.sin(ku.dive*Math.PI)*(high?0.8:0.4);}}
  // balón
  const ball=G.ball,prev=ball.position.clone();
  if(G.flight){const f=G.flight;f.t=Math.min(f.stop,f.t+fdt/f.dur);
    const N=f.pts.length-1,fi=f.t*N,i0=Math.min(N-1,Math.floor(fi)),fr=fi-i0;
    const q=f.pts[i0].clone().lerp(f.pts[i0+1],fr);
    const h=f.shot?shotH(f.t,f.ty):(0.17+(0.3+f.L*0.035)*Math.sin(Math.PI*f.t));
    ball.position.set(q.x,h,q.z);
    if(f.t>=f.stop){
      if(f.result==='goal'){G.ballIn={t:0,from:ball.position.clone(),to:new THREE.Vector3(ball.position.x*0.95,Math.max(0.2,ball.position.y*0.7),-1.75)};}
      if(f.result==='save'){ball.position.set(K.position.x,1,0.9);Sound.catch_();}
      resolveFlight();
    }
  }else if(G.ballIn){const bi=G.ballIn;bi.t=Math.min(1,bi.t+dt/0.3);ball.position.lerpVectors(bi.from,bi.to,1-Math.pow(1-bi.t,2));if(bi.t>=1){ball.position.y=Math.max(0.17,ball.position.y-dt*3);if(G.phase!=='celebrate')G.ballIn=null;}}
  else if(G.roll){const r=G.roll;r.t+=dt;ball.position.addScaledVector(r.v,dt);r.v.multiplyScalar(Math.exp(-dt*1.4));
    r.vy-=9.8*dt;ball.position.y+=r.vy*dt;if(ball.position.y<0.17){ball.position.y=0.17;r.vy=Math.abs(r.vy)*0.35;}if(r.t>r.dur)G.roll=null;}
  else if(G.phase==='aim'&&G.carrier){const c=G.carrier.position;ball.position.set(c.x,0.17,c.z-0.45);}
  if(G.phase==='aim'){G.ballIn=null;G.roll=null;}
  // giro del balón: rueda en la dirección del movimiento y gira con el efecto
  {const vx=ball.position.x-prev.x,vz=ball.position.z-prev.z,v=Math.hypot(vx,vz);if(v>1e-4){ball.rotateOnWorldAxis(new THREE.Vector3(vz/v,0,-vx/v),-v/0.17);if(G.flight)ball.rotateOnWorldAxis(new THREE.Vector3(0,1,0),G.flight.curve*fdt*6);}}
  G.ballShadow.position.set(ball.position.x,0.03,ball.position.z);
  const sh=1/(1+ball.position.y*0.6);G.ballShadow.scale.set(0.22*sh+0.05,0.22*sh+0.05,1);
  // estela
  if(G.flight){G.trailPts.unshift(ball.position.clone());if(G.trailPts.length>32)G.trailPts.length=32;}else if(G.trailPts.length){G.trailPts.pop();G.trailPts.pop();}
  G.trail.forEach((m,i)=>{const q=G.trailPts[i*2];if(!q||i===0){m.visible=false;return;}m.visible=true;m.position.copy(q);m.scale.setScalar(0.16*(1-i/16));});
  // red que se infla con el gol
  if(G.netHit){const nh=G.netHit,pos=G.net.geometry.attributes.position,a=pos.array,b=G.netBase;
    for(let i=0;i<a.length;i+=3){const dx=b[i]-nh.x,dy=b[i+1]-nh.y;a[i+2]=b[i+2]-nh.amp*Math.exp(-(dx*dx)/1.4-(dy*dy)/0.9);}
    pos.needsUpdate=true;nh.amp*=Math.exp(-dt*2.2);if(nh.amp<0.01){a.set(b);pos.needsUpdate=true;G.netHit=null;}}
  // marcador del portador
  if(G.carrier&&G.phase==='aim'){G.marker.visible=true;G.marker.position.set(G.carrier.position.x,2.55+Math.sin(G.t*4)*0.12,G.carrier.position.z);G.marker.rotation.y+=dt*2;}else G.marker.visible=false;
  if(G.carrier&&G.carrier.userData.kick>0){G.carrier.userData.kick-=fdt;G.carrier.userData.legs[1].rotation.x=-1.1*Math.sin(Math.PI*(1-G.carrier.userData.kick/0.25));}
  // tribuna, banderas y partículas
  G.cheer=Math.max(0.15,G.cheer-dt*0.25);
  const jump=Math.abs(Math.sin(G.t*13))*0.012*G.cheer;G.crowd.forEach((t,i)=>{t.offset.y=i%2?jump:-jump*0.7;});
  G.flags.forEach((f,i)=>{f.rotation.y=f.userData.base+Math.sin(G.t*(2+G.cheer*3)+i)*(0.3+0.2*G.cheer);});
  for(const o of G.parts){if(o.life<=0)continue;o.life-=dt;
    if(o.kind==='conf'){o.v.y=Math.max(-2.6,o.v.y-6*dt);o.v.x+=Math.sin(G.t*3+o.max*7)*dt*1.5;o.m.rotation.x+=dt*6;o.m.rotation.y+=dt*4;}
    else{o.v.y-=3*dt;o.v.multiplyScalar(0.985);o.m.scale.setScalar(Math.max(0.05,o.life/o.max));}
    o.m.position.addScaledVector(o.v,dt);if(o.life<=0||o.m.position.y<0){o.m.visible=false;o.life=0;}}
  // cámara
  const portrait=camera.aspect<0.9;
  if(G.phase==='intro'&&G.introT<G.introDur){
    const k=G.introT/G.introDur,e=k<0.5?2*k*k:1-Math.pow(-2*k+2,2)/2;
    const ang=lerp(-2.5,0,e),R=lerp(95,portrait?30:24,e),h=lerp(48,portrait?14:10,e);
    camPos.set(Math.sin(ang)*R,h,52.5+Math.cos(ang)*R);camLook.set(0,lerp(0,1,e),lerp(42,48,e));
  }else if((G.phase==='celebrate'&&G.scorer)||G.final){
    const c=(G.final?G.mates[0]:G.scorer).position,a=-0.55+G.celT*0.45,r=portrait?9:7.5;
    camPos.lerp(new THREE.Vector3(c.x+Math.sin(a)*r,2.7,c.z+Math.cos(a)*r),1-Math.exp(-dt*2.5));
    camLook.lerp(new THREE.Vector3(c.x,1.1,c.z),1-Math.exp(-dt*4));
  }else{
    const focus=(G.flight||G.roll)?ball.position:(G.carrier?G.carrier.position:ball.position);
    const src=G.carrier?G.carrier.position:null;
    if(src&&src.z<32&&(G.phase==='aim'||G.phase==='flight'||G.phase==='between')){
      // Cerca del arco: la cámara gira y se aleja para ver al portador, el arco completo y a los compañeros
      // Puntos que siempre deben verse: portador (pies y cabeza), arco completo, compañeros y balón
      const pts=[src.clone(),src.clone().setY(1.9),new THREE.Vector3(-3.7,0,0),new THREE.Vector3(3.7,0,0),new THREE.Vector3(-3.7,2.4,0),new THREE.Vector3(3.7,2.4,0)];
      (G.mateList||[]).forEach(m=>{if(m.visible){const q=m.userData.target||m.position;pts.push(new THREE.Vector3(q.x,0,q.z),new THREE.Vector3(q.x,1.9,q.z));}});
      if(G.flight||G.roll)pts.push(ball.position.clone());
      let dx=src.x*0.6,dz=Math.max(src.z,6)+10;const dl=Math.hypot(dx,dz);dx/=dl;dz/=dl;
      const c=new THREE.Vector3();pts.forEach(q=>c.add(q));c.multiplyScalar(1/pts.length);c.y=0;c.lerp(new THREE.Vector3(src.x,0,src.z),0.25);
      // Se aleja la cámara hasta que todo quepa en pantalla, dejando libre la zona del marcador y del aviso inferior
      const fc=frameCam;fc.fov=camera.fov;fc.aspect=camera.aspect;fc.updateProjectionMatrix();
      let pos=null;
      for(let d=10;d<=72;d+=2){fc.position.set(c.x+dx*d*0.78,d*0.62,c.z+dz*d*0.78);fc.lookAt(c);fc.updateMatrixWorld();
        let ok=true;for(const q of pts){const v=q.clone().project(fc);if(v.z>1||v.x<-0.88||v.x>0.88||v.y<-0.56||v.y>0.7){ok=false;break;}}
        pos=fc.position.clone();if(ok)break;}
      camPos.lerp(pos,1-Math.exp(-dt*2.5));
      camLook.lerp(c,1-Math.exp(-dt*3));
    }else{
    const short=!portrait&&dcv.clientHeight<540;
    const back=portrait?15:(short?12:11),up=portrait?13:(short?9:7.5);
    const tx=focus.x*(portrait?0.95:0.85),tz=focus.z+back;
    const lookZ=Math.max(focus.z-(portrait?15:16),-3);
    camPos.lerp(new THREE.Vector3(tx,up,tz),1-Math.exp(-dt*(G.flight?2.2:3)));
    camLook.lerp(new THREE.Vector3(focus.x*(portrait?0.85:0.55),0,lookZ),1-Math.exp(-dt*3));
    }
  }
  camera.position.copy(camPos);
  if(G.shake>0){G.shake-=dt;camera.position.x+=rand(-0.15,0.15)*G.shake;camera.position.y+=rand(-0.15,0.15)*G.shake;}
  camera.lookAt(camLook);
  if(G.phase==='aim')updateRings();
}
function drawOverlay(){
  const w=dcv.clientWidth,h=dcv.clientHeight;dctx.clearRect(0,0,w,h);
  if(!G||!G.path||G.path.length<2)return;
  const v=eff('vision'),plan=G.plan;
  dctx.lineCap='round';dctx.lineJoin='round';
  // trazo del dedo (tenue)
  const raw=G.path.map(project);
  dctx.strokeStyle='rgba(255,255,255,.28)';dctx.lineWidth=10;dctx.beginPath();raw.forEach((p,i)=>i?dctx.lineTo(p.x,p.y):dctx.moveTo(p.x,p.y));dctx.stroke();
  if(!plan)return;
  // trayectoria real del balón
  const cp=curvePts(plan,36);
  let col='#ffffff';
  if(v>=3&&!plan.shot){const ok=G.mateList.some(m=>inZone(m,plan.E));col=ok?'#3dff8f':'#ffc400';}
  if(plan.shot&&v>=3){col=Math.abs(plan.E.x)<=3.4&&plan.ty<=2.4?'#3dff8f':'#ff5a1f';}
  if(v>=5){let danger=false;for(let i=2;i<cp.length&&!danger;i++){const q=cp[i];for(const d of G.defList){if(plan.B.z<18&&!d.userData.wall)continue;const R=(d.userData.wall?0.45:G.P.icpt)+(d.userData.wall?0:G.P.lunge*0.7);if(Math.hypot(q.x-d.position.x,q.z-d.position.z)<R){danger=true;break;}}}if(danger)col='#ff3b3b';}
  const base=v>=8?cp:curvePts(Object.assign({},plan,{E:plan.aim}),36);
  if(plan.shot)base.forEach((q,i)=>{q.y=shotH(i/(base.length-1),plan.ty);});
  const pts=base.map(project);
  dctx.strokeStyle='rgba(14,20,48,.35)';dctx.lineWidth=11;dctx.beginPath();pts.forEach((p,i)=>i?dctx.lineTo(p.x,p.y):dctx.moveTo(p.x,p.y));dctx.stroke();
  const g=dctx.createLinearGradient(pts[0].x,pts[0].y,pts[pts.length-1].x,pts[pts.length-1].y);g.addColorStop(0,'rgba(255,255,255,.95)');g.addColorStop(1,col);
  dctx.strokeStyle=g;dctx.lineWidth=6;dctx.stroke();
  const e=pts[pts.length-1];
  dctx.fillStyle=col;dctx.strokeStyle='#0e1430';dctx.lineWidth=3;dctx.beginPath();dctx.arc(e.x,e.y,11,0,7);dctx.fill();dctx.stroke();
  if(v>=8&&Math.abs(G.wind)>0.05){const a=project(plan.aim);dctx.setLineDash([6,6]);dctx.strokeStyle='rgba(255,255,255,.8)';dctx.lineWidth=2;dctx.beginPath();dctx.moveTo(a.x,a.y);dctx.lineTo(e.x,e.y);dctx.stroke();dctx.setLineDash([]);}
}
function loop(now){
  requestAnimationFrame(loop);
  if(!G||!renderer)return;
  const dt=Math.min(0.05,(now-lastT)/1000);lastT=now;
  update(dt);
  if(!G)return;
  renderer.render(scene,camera);
  drawOverlay();
}

/* ---------- Arranque ---------- */
setMuteIcons();
if(!save.created)openCreate(true);else renderMenu();
window.__t={curvePts,project,startMatch,get G(){return G},update,finish,kick,layout,params,renderStadiums,renderSkills,renderShop,openCreate,get save(){return save},planKick,show};
})();
</script>
</body>
</html>
$TF$, true, true, true, true, 2, CURRENT_TIMESTAMP)
ON CONFLICT ("slug") DO NOTHING;
