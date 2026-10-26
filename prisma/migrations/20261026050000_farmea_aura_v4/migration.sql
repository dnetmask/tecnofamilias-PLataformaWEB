-- Farmea aura, nueva versión: diseño de personaje (piel, peinado, ropa y accesorios), bailes y escenarios.
UPDATE "Game" SET
  "html" = $TF$<!DOCTYPE html>
<html lang="es-CO">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>Farmea aura, un juego de Tecnofamilias</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fredoka:wght@500;600;700&family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
:root{
  --sky:#3DAEE4; --sun:#FDBE30; --coral:#EF4A37; --night:#283A60;
  --bg:#EAF2FA; --surface:#FFFFFF; --surface-2:#F3F8FC; --ink:#1C2742; --ink-2:#4B5A79; --line:#D3DFEC;
  --chip:#E1EFFA; --chip-ink:#1E5C84; --talk:#FFF4D6; --talk-ink:#6A4A00; --talk-line:#F6D57A;
  --good:#17865B; --bad:#C63A27; --btn:#283A60; --btn-ink:#FFFFFF; --btn-2:#FFFFFF; --btn-2-ink:#283A60;
  --pick:#3DAEE4; --pick-bg:#E7F5FD;
  --display:"Fredoka","Nunito",ui-rounded,"Arial Rounded MT Bold","Segoe UI",system-ui,sans-serif;
  --body:"Nunito",ui-rounded,"Segoe UI",system-ui,-apple-system,sans-serif;
  color-scheme: light;
  box-sizing:border-box;
  padding-top:env(safe-area-inset-top,0px);
  padding-bottom:env(safe-area-inset-bottom,0px);
}
@media (prefers-color-scheme: dark){
  :root:not([data-theme="light"]){
    --bg:#0E1526; --surface:#17213A; --surface-2:#1D2945; --ink:#ECF2FA; --ink-2:#A9B6CD; --line:#2B3B5D;
    --chip:#1F3152; --chip-ink:#9CD5F5; --talk:#3A3018; --talk-ink:#FFE3A1; --talk-line:#6E5A26;
    --good:#45CB91; --bad:#FF7C68; --btn:#3DAEE4; --btn-ink:#0E1526; --btn-2:#1D2945; --btn-2-ink:#ECF2FA;
    --pick:#3DAEE4; --pick-bg:#18324F;
    color-scheme: dark;
  }
}
:root[data-theme="dark"]{
  --bg:#0E1526; --surface:#17213A; --surface-2:#1D2945; --ink:#ECF2FA; --ink-2:#A9B6CD; --line:#2B3B5D;
  --chip:#1F3152; --chip-ink:#9CD5F5; --talk:#3A3018; --talk-ink:#FFE3A1; --talk-line:#6E5A26;
  --good:#45CB91; --bad:#FF7C68; --btn:#3DAEE4; --btn-ink:#0E1526; --btn-2:#1D2945; --btn-2-ink:#ECF2FA;
  --pick:#3DAEE4; --pick-bg:#18324F;
  color-scheme: dark;
}
html{scroll-padding-top:env(safe-area-inset-top,0px)}
*,*::before,*::after{box-sizing:border-box}
html,body{margin:0}
body{background:var(--bg);color:var(--ink);font-family:var(--body);font-size:17px;line-height:1.5;-webkit-font-smoothing:antialiased;-webkit-tap-highlight-color:transparent}
body::before{content:"";position:fixed;inset:0 0 auto;height:env(safe-area-inset-top,0px);z-index:40;background:var(--bg)}
img{max-width:100%}
button,input{font:inherit;color:inherit}
button{cursor:pointer}
:focus-visible{outline:3px solid var(--sky);outline-offset:2px;border-radius:10px}
[hidden]{display:none!important}

.wrap{max-width:1180px;margin:0 auto;padding:12px 18px 40px}
.topbar{display:flex;align-items:center;justify-content:space-between;gap:12px;padding:6px 0 14px}
.logo-chip{display:inline-flex;align-items:center;background:#fff;border-radius:14px;padding:6px 12px;box-shadow:0 1px 0 rgba(40,58,96,.08)}
.logo-chip img{height:34px;width:auto;display:block}
.top-actions{display:flex;gap:8px;align-items:center}
.icon-btn{display:inline-flex;align-items:center;gap:6px;border:2px solid var(--line);background:var(--surface);border-radius:999px;padding:6px 14px;font-weight:700;font-size:15px}
.icon-btn:hover{border-color:var(--sky)}

/* Intro */
.intro{padding:4px 0 18px;max-width:820px}
.title{font-family:var(--display);font-weight:700;font-size:clamp(52px,10vw,112px);line-height:.92;letter-spacing:-.025em;margin:0;color:var(--ink);
  text-shadow:0 0 28px rgba(61,174,228,.45),0 0 60px rgba(253,190,48,.35)}
.title .wd{display:inline-block;white-space:nowrap}
.title .ch{display:inline-block;animation:letterIn .7s cubic-bezier(.3,1.5,.5,1) both}
@keyframes letterIn{from{opacity:0;transform:translateY(.35em) scale(.7)}to{opacity:1;transform:none}}
.lede{font-size:clamp(18px,2.2vw,21px);margin:14px 0 4px;color:var(--ink);max-width:60ch;font-weight:600}
.def{margin:6px 0 0;color:var(--ink-2);max-width:62ch}
.def b{color:var(--ink)}

/* Arena */
.arena{display:grid;gap:18px;align-items:start}
@media (min-width:980px){
  .arena{grid-template-columns:minmax(0,1.45fr) minmax(360px,1fr)}
  .stage-col{position:sticky;top:calc(env(safe-area-inset-top,0px) + 12px)}
}
@media (max-width:979px){
  body.in-game .stage-col{position:sticky;top:env(safe-area-inset-top,0px);z-index:20;background:var(--bg);padding:6px 0 8px;margin:-6px 0 0}
}

/* Scorebar */
.scorebar{display:grid;grid-template-columns:1fr auto 1fr;gap:10px;align-items:stretch;margin-bottom:10px}
.score{display:flex;align-items:center;gap:10px;background:var(--surface);border:2px solid var(--line);border-radius:18px;padding:8px 12px;min-width:0;transition:border-color .3s,box-shadow .3s}
.score.p1{flex-direction:row-reverse;text-align:right}
.score.active{border-color:var(--sky);box-shadow:0 0 0 4px rgba(61,174,228,.18)}
.score .who{min-width:0}
.score .nm{font-family:var(--display);font-weight:600;font-size:18px;line-height:1.1;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.score .cn{font-size:13px;color:var(--ink-2);white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.score .pts{margin-left:auto;font-family:var(--display);font-weight:700;font-size:24px;line-height:1;white-space:nowrap}
.score.p1 .pts{margin-left:0;margin-right:auto}
.score .pts small{display:block;font-family:var(--body);font-weight:700;font-size:11.5px;color:var(--ink-2);letter-spacing:.01em}
.score.bump .pts{animation:bump .5s}
@keyframes bump{40%{transform:scale(1.18)}}
.turninfo{display:flex;flex-direction:column;align-items:center;justify-content:center;gap:4px;text-align:center;font-size:14px;color:var(--ink-2);font-weight:700;padding:0 4px}
.turninfo b{font-family:var(--display);font-size:20px;color:var(--ink)}
.linkish{background:none;border:0;padding:2px 4px;color:var(--ink-2);text-decoration:underline;font-size:13px;font-weight:700}
@media (max-width:560px){
  .score{padding:6px 9px;gap:6px;border-radius:14px}
  .score .nm{font-size:15px}.score .cn{display:none}.score .pts{font-size:19px}
  .score,.score.p1{flex-direction:column;align-items:flex-start;gap:0}
  .score.p1{align-items:flex-end}
  .score .who{max-width:100%}
  .score .pts,.score.p1 .pts{margin:0}
  .score .pts small{display:inline;margin-left:4px}
  .turninfo{font-size:12px}.turninfo b{font-size:16px}
}

/* Stage */
.stage{position:relative;overflow:hidden;border-radius:28px;background:#1A2645;isolation:isolate;aspect-ratio:4/3.2;max-height:72vh;width:100%;user-select:none;-webkit-user-select:none;
  --fwd:25%; --base:7%}
@media (max-width:979px){.stage{aspect-ratio:auto;height:clamp(250px,44vh,440px)}}
@media (max-width:560px){.stage{--fwd:15%;--base:3%;border-radius:22px;height:clamp(240px,41vh,360px)}}
.stage.finale{--fwd:15%}
@media (max-width:560px){.stage.finale{--fwd:9%}}
.wall{position:absolute;inset:0 0 28% 0;
  background:
    repeating-linear-gradient(90deg,rgba(255,255,255,.035) 0 2px,transparent 2px 46px),
    radial-gradient(120% 90% at 50% 0%,#3A5689 0%,#25385F 52%,#1B2847 100%)}
.floor{position:absolute;left:0;right:0;bottom:0;height:30%;
  background:
    repeating-linear-gradient(90deg,rgba(255,255,255,.05) 0 2px,transparent 2px 9%),
    linear-gradient(#304A7B,#1C2B4C);
  border-top:3px solid rgba(253,190,48,.55);box-shadow:0 -8px 30px rgba(253,190,48,.18)}
.neon{position:absolute;top:6%;left:50%;transform:translateX(-50%);z-index:2;font-family:var(--display);font-weight:600;
  font-size:clamp(17px,2.6vw,30px);line-height:1;color:#EAF7FF;padding:.3em .8em .34em;border:3px solid #86D6FB;border-radius:999px;white-space:nowrap;
  box-shadow:0 0 12px rgba(61,174,228,.9),inset 0 0 12px rgba(61,174,228,.55);text-shadow:0 0 8px #3DAEE4,0 0 18px #3DAEE4;transition:opacity .3s,color .3s,box-shadow .3s}
.stage.speaking .neon{opacity:.12}
.neon.flash{color:#FFF4CF;border-color:#FFD76A;box-shadow:0 0 22px rgba(253,190,48,1),inset 0 0 16px rgba(253,190,48,.7);text-shadow:0 0 10px #FDBE30,0 0 24px #FDBE30}
.spot{position:absolute;top:-6%;bottom:8%;width:40%;z-index:1;pointer-events:none;opacity:.18;transition:opacity .5s;
  background:linear-gradient(rgba(255,246,220,.30),rgba(255,246,220,.05) 80%,transparent);
  clip-path:polygon(44% 0,56% 0,100% 100%,0 100%)}
.spot.s0{left:14%}.spot.s1{right:14%}
.spot.on{opacity:1}

.actor{position:absolute;bottom:13%;height:56%;aspect-ratio:140/220;z-index:3;transition:left .9s cubic-bezier(.45,.05,.3,1),right .9s cubic-bezier(.45,.05,.3,1)}
.actor.a0{left:var(--base)}.actor.a1{right:var(--base)}
.actor.a0.fwd{left:var(--fwd)}.actor.a1.fwd{right:var(--fwd)}
.actor.a0.off{left:-35%}.actor.a1.off{right:-35%}
.actor .char{position:absolute;inset:0}
.actor.kid .char{transform:scale(.86);transform-origin:50% 100%}
.actor .char svg{width:100%;height:100%;display:block;overflow:visible}
.actor.a1 .char svg{transform:scaleX(-1)}
.aura-fx{position:absolute;left:-45%;right:-45%;top:-14%;bottom:-6%;opacity:0;pointer-events:none;transform:scale(.5);transition:opacity .35s,transform .6s cubic-bezier(.3,1.4,.5,1);
  background:radial-gradient(closest-side,rgba(255,226,140,.85),rgba(253,190,48,.45) 35%,rgba(61,174,228,.35) 58%,rgba(61,174,228,0) 76%);filter:blur(3px)}
.aura-fx::after{content:"";position:absolute;inset:14%;border-radius:50%;
  background:conic-gradient(from 0deg,transparent,rgba(255,255,255,.7) 8%,transparent 22%,rgba(253,190,48,.8) 38%,transparent 52%,rgba(61,174,228,.8) 70%,transparent 86%);
  -webkit-mask:radial-gradient(closest-side,transparent 60%,#000 65%,#000 74%,transparent 79%);mask:radial-gradient(closest-side,transparent 60%,#000 65%,#000 74%,transparent 79%);
  animation:spin 2.2s linear infinite}
.actor.glow .aura-fx{opacity:1;transform:scale(1);animation:auraPulse 1s ease-in-out infinite alternate}
@keyframes auraPulse{to{filter:blur(6px) brightness(1.15)}}
@keyframes spin{to{transform:rotate(1turn)}}
.crown{position:absolute;left:50%;top:-14%;transform:translateX(-50%) translateY(-30px);font-size:clamp(26px,4vw,44px);opacity:0;transition:.5s cubic-bezier(.3,1.6,.5,1);z-index:4}
.actor.king .crown{opacity:1;transform:translateX(-50%) translateY(0)}

.bubble{position:absolute;top:4%;max-width:46%;z-index:8;background:#fff;color:#1C2742;font-family:var(--body);font-weight:800;
  font-size:clamp(13px,1.45vw,16px);line-height:1.3;padding:.6em .85em;border-radius:18px;box-shadow:0 5px 0 rgba(0,0,0,.18);
  opacity:0;transform:translateY(8px) scale(.94);transition:opacity .22s,transform .22s;pointer-events:none;
  display:-webkit-box;-webkit-line-clamp:5;-webkit-box-orient:vertical;overflow:hidden}
.bubble.show{opacity:1;transform:none}
.bubble.b0{left:3%}.bubble.b1{right:3%;text-align:right}
.bubble-tail{position:absolute;top:0;width:16px;height:12px;z-index:8;background:#fff;opacity:0;transition:opacity .22s;clip-path:polygon(0 0,100% 0,35% 100%);pointer-events:none}
.bubble-tail.show{opacity:1}

.audience{position:absolute;left:-1%;right:-1%;bottom:-1%;height:22%;z-index:5;pointer-events:none}
.audience svg{width:100%;height:100%;display:block}
.audience .person{transition:transform .3s}
.audience.clap .hl{animation:clapL .14s ease-in-out infinite alternate;animation-delay:var(--d)}
.audience.clap .hr{animation:clapR .14s ease-in-out infinite alternate;animation-delay:var(--d)}
.audience.clap .person{animation:hop .42s ease-in-out infinite alternate;animation-delay:var(--d)}
.audience.laugh .person{animation:giggle .16s ease-in-out infinite alternate;animation-delay:var(--d)}
@keyframes clapL{from{transform:translateX(-3px)}to{transform:translateX(6px)}}
@keyframes clapR{from{transform:translateX(3px)}to{transform:translateX(-6px)}}
@keyframes hop{to{transform:translateY(-6px)}}
@keyframes giggle{from{transform:translateY(0) rotate(-1.5deg)}to{transform:translateY(-2px) rotate(1.5deg)}}

.fx{position:absolute;inset:0;z-index:10;pointer-events:none;overflow:hidden}
.float{position:absolute;font-family:var(--display);font-weight:700;font-size:clamp(22px,3.6vw,42px);line-height:1;white-space:nowrap;transform:translateX(-50%);animation:floatUp 2.1s ease-out forwards}
.float.pos{color:#FFF1C2;text-shadow:0 0 12px rgba(253,190,48,.95),0 3px 0 #B6761A}
.float.neg{color:#FFE0DA;text-shadow:0 0 12px rgba(239,74,55,.85),0 3px 0 #8E2416}
@keyframes floatUp{0%{opacity:0;transform:translate(-50%,12px) scale(.55)}14%{opacity:1;transform:translate(-50%,0) scale(1.12)}26%{transform:translate(-50%,-6px) scale(1)}72%{opacity:1}100%{opacity:0;transform:translate(-50%,-80px)}}
.spark{position:absolute;width:9px;height:9px;border-radius:2px;transform:rotate(45deg);animation:spark .95s ease-out forwards}
@keyframes spark{from{opacity:1;transform:translate(0,0) rotate(45deg) scale(1)}to{opacity:0;transform:translate(var(--dx),var(--dy)) rotate(225deg) scale(.3)}}
.emo{position:absolute;font-size:clamp(20px,3vw,32px);animation:emoUp 1.6s ease-out forwards}
@keyframes emoUp{0%{opacity:0;transform:translateY(10px) scale(.6)}20%{opacity:1;transform:translateY(0) scale(1.1)}100%{opacity:0;transform:translateY(-90px) rotate(var(--r,0deg))}}
.confetti{position:absolute;top:-4%;width:9px;height:14px;border-radius:2px;animation:fall var(--t,2.8s) linear forwards}
@keyframes fall{to{transform:translate(var(--dx,0),118vh) rotate(var(--rot,540deg))}}

/* Camera, cinematic FX */
.cam{position:absolute;inset:0;z-index:1;transition:transform .7s cubic-bezier(.3,.7,.3,1),filter .4s}
.stage.cine .cam{transform:scale(1.14)}
.stage.cine.epic .cam{transform:scale(1.24)}
.stage.cine.good .cam{filter:contrast(1.12) saturate(1.3)}
.stage.sad .cam{filter:grayscale(.8) brightness(.85)}
.cam.shake{animation:shake .55s linear}
@keyframes shake{0%,100%{translate:0 0}12%{translate:-9px 5px}24%{translate:8px -6px}36%{translate:-7px 4px}48%{translate:6px -3px}60%{translate:-4px 3px}72%{translate:3px -2px}84%{translate:-2px 1px}}
.backfx{position:absolute;inset:0;z-index:2;pointer-events:none;overflow:hidden}
.speed{position:absolute;width:230%;aspect-ratio:1;left:50%;top:50%;transform:translate(-50%,-50%);opacity:0;transition:opacity .35s;
  background:repeating-conic-gradient(rgba(255,255,255,.2) 0 1.4deg,transparent 1.4deg 7deg);
  -webkit-mask:radial-gradient(circle,transparent 9%,#000 30%);mask:radial-gradient(circle,transparent 9%,#000 30%)}
.stage.cine.good .speed{opacity:.75;animation:spinr 7s linear infinite}
.stage.cine.epic .speed{opacity:1;background:repeating-conic-gradient(rgba(255,236,170,.28) 0 1.6deg,transparent 1.6deg 6deg)}
@keyframes spinr{to{rotate:1turn}}
.blast{position:absolute;width:120%;aspect-ratio:1;transform:translate(-50%,-50%) scale(.1);border-radius:50%;
  background:radial-gradient(circle,#FFF6D0 0,#FDBE30 22%,#EF4A37 45%,rgba(239,74,55,0) 70%);animation:blast 1.1s ease-out forwards}
@keyframes blast{0%{opacity:1;transform:translate(-50%,-50%) scale(.1)}35%{opacity:1}100%{opacity:0;transform:translate(-50%,-50%) scale(1.4)}}
.ring{position:absolute;width:12%;aspect-ratio:3/1;border:4px solid rgba(255,240,190,.95);border-radius:50%;transform:translate(-50%,-50%) scale(.3);animation:ring .8s ease-out forwards;box-shadow:0 0 14px rgba(253,190,48,.9)}
@keyframes ring{to{opacity:0;transform:translate(-50%,-50%) scale(5)}}
.lb{position:absolute;left:0;right:0;height:0;background:#05080F;z-index:7;transition:height .45s cubic-bezier(.3,.7,.3,1);pointer-events:none}
.lb-t{top:0}.lb-b{bottom:0}
.stage.cine .lb{height:8%}
.stage.cine .bubble{top:10%}
.flashov{position:absolute;inset:0;z-index:9;pointer-events:none;background:#fff;opacity:0}
.flashov.go{animation:flash .45s ease-out}
.flashov.warm{background:#FFD27A}
@keyframes flash{0%{opacity:.85}100%{opacity:0}}
.movecard{position:absolute;left:50%;top:11%;z-index:8;pointer-events:none;white-space:normal;text-align:center;width:max-content;max-width:84%;
  font-family:var(--display);font-weight:700;font-size:clamp(19px,3.3vw,38px);line-height:1.05;color:#FFF3C4;letter-spacing:.01em;
  text-shadow:0 3px 0 #B6761A,0 0 18px rgba(253,190,48,.95),0 0 40px rgba(253,190,48,.6);opacity:0;transform:translateX(-50%) skewX(-9deg) scale(.6)}
.movecard.fail{color:#FFE0DA;text-shadow:0 3px 0 #8E2416,0 0 18px rgba(239,74,55,.9)}
.movecard.show{animation:slam .45s cubic-bezier(.2,1.6,.4,1) forwards}
.movecard.hide{opacity:1;transform:translateX(-50%) skewX(-9deg);animation:cardout .3s ease-in forwards}
@keyframes slam{0%{opacity:0;transform:translateX(-50%) skewX(-9deg) scale(2.4)}60%{opacity:1;transform:translateX(-50%) skewX(-9deg) scale(.94)}100%{opacity:1;transform:translateX(-50%) skewX(-9deg) scale(1)}}
@keyframes cardout{to{opacity:0;transform:translateX(-50%) skewX(-9deg) translateY(-14px)}}
.wind{position:absolute;height:3px;border-radius:3px;background:linear-gradient(90deg,transparent,rgba(255,255,255,.85),transparent);animation:wind .7s ease-out forwards}
@keyframes wind{from{opacity:0;transform:translateX(60px)}30%{opacity:1}to{opacity:0;transform:translateX(-160px)}}
.glass{position:absolute;width:46%;aspect-ratio:1;transform:translate(-50%,-50%);border-radius:50%;
  background:repeating-conic-gradient(rgba(255,255,255,.9) 0 .8deg,transparent .8deg 23deg);-webkit-mask:radial-gradient(circle,#000 0,#000 45%,transparent 70%);mask:radial-gradient(circle,#000 0,#000 45%,transparent 70%);animation:glass 1.3s ease-out forwards}
@keyframes glass{0%{opacity:0;transform:translate(-50%,-50%) scale(.4)}10%{opacity:1;transform:translate(-50%,-50%) scale(1)}70%{opacity:.9}100%{opacity:0}}
.pop-emo{position:absolute;font-size:clamp(26px,4vw,46px);transform:translate(-50%,-50%);animation:popemo 1.1s ease-out forwards}
@keyframes popemo{0%{opacity:0;transform:translate(-50%,-50%) scale(.2) rotate(-20deg)}25%{opacity:1;transform:translate(-50%,-50%) scale(1.25) rotate(8deg)}60%{opacity:1;transform:translate(-50%,-50%) scale(1) rotate(0)}100%{opacity:0;transform:translate(-50%,-70%) scale(.9)}}

/* Rig */
.actor{perspective:800px;--dir:1}
.actor.a1{--dir:-1}
.rig{position:absolute;inset:0;transform-origin:50% 62%}
.cs *{transform-box:view-box}
.cs .body-all{transform-origin:70px 205px;animation:idle 2.6s ease-in-out infinite}
.cs .leg-l{transform-origin:61px 150px}.cs .leg-r{transform-origin:79px 150px}
.cs .leg{transition:transform .3s}
.cs .upper{transform-origin:70px 150px;transition:transform .3s}
.cs .arm{transition:transform .28s cubic-bezier(.3,1.4,.5,1)}
.cs .arm-l{transform-origin:48px 104px}.cs .arm-r{transform-origin:92px 104px}
.cs .fore{transition:transform .28s cubic-bezier(.3,1.4,.5,1)}
.cs .fore-l{transform-origin:41.5px 122.5px}.cs .fore-r{transform-origin:98.5px 122.5px}
.cs .head{transform-origin:70px 88px;transition:transform .3s}
.cs .eyes{transform-origin:70px 57px;transition:transform .2s}
.cs .eyes-in{transform-origin:70px 57px;animation:blink 4.4s infinite}
.cs .eyes-x,.cs .eyes-hap{opacity:0}
.cs .mouth{transform-origin:70px 72px}
.cs .m{opacity:0;transition:opacity .12s}
.cs .m-smile{opacity:1}
.cs .shades{transform-origin:70px 56px;opacity:0;transform:translateY(-80px)}
.cs .steam{animation:steam 1.6s ease-in-out infinite}
@keyframes steam{50%{transform:translateY(-3px);opacity:.4}}
.expr-happy .m-smile,.expr-sad .m-smile,.expr-shock .m-smile,.expr-cool .m-smile,.expr-laugh .m-smile,.expr-pain .m-smile{opacity:0}
.expr-happy .m-big,.expr-laugh .m-big,.expr-sad .m-sad,.expr-shock .m-o,.expr-pain .m-o,.expr-cool .m-smirk{opacity:1}
.expr-shock .eyes{transform:scale(1.4)}
.expr-pain .eyes-in,.expr-laugh .eyes-in{opacity:0}
.expr-pain .eyes-x,.expr-laugh .eyes-hap{opacity:1}
@keyframes idle{0%,100%{transform:translateY(0)}50%{transform:translateY(-2.5px)}}
@keyframes blink{0%,93%,100%{transform:scaleY(1)}96%{transform:scaleY(.12)}}
.walking .body-all{animation:walkbob .2s ease-in-out infinite alternate}
.walking .leg-l,.walking .arm-r{animation:swingA .4s ease-in-out infinite alternate}
.walking .leg-r,.walking .arm-l{animation:swingB .4s ease-in-out infinite alternate}
@keyframes walkbob{to{transform:translateY(-4px)}}
@keyframes swingA{from{transform:rotate(17deg)}to{transform:rotate(-17deg)}}
@keyframes swingB{from{transform:rotate(-17deg)}to{transform:rotate(17deg)}}
.talking .mouth{animation:talk .15s ease-in-out infinite alternate}
@keyframes talk{to{transform:scaleY(1.6)}}

/* Static poses */
.win .body-all{animation:jump .72s cubic-bezier(.3,.6,.4,1) 2}
.win .arm-l{transform:rotate(150deg)}.win .arm-r{transform:rotate(-150deg)}
.win .fore-l{transform:rotate(-25deg)}.win .fore-r{transform:rotate(25deg)}
@keyframes jump{0%{transform:none}15%{transform:scale(1.08,.9)}50%{transform:translateY(-34px) scale(.96,1.05)}85%{transform:scale(1.06,.94)}100%{transform:none}}
.lose .head{transform:rotate(9deg) translateY(5px)}
.lose .upper{transform:rotate(6deg)}
.lose .arm-l{transform:rotate(-6deg)}.lose .arm-r{transform:rotate(6deg)}
.lose .body-all{animation:sag 1.1s ease forwards}
@keyframes sag{0%{transform:none}30%{transform:translateY(5px) scale(1.03,.95)}100%{transform:translateY(3px) scale(1.01,.97)}}
.think .arm-r{transform:rotate(96deg)}.think .fore-r{transform:rotate(106deg)}
.think .arm-l{transform:rotate(-40deg)}.think .fore-l{transform:rotate(-80deg)}
.think .head{animation:thinkhd 1.8s ease-in-out infinite alternate}
@keyframes thinkhd{from{transform:rotate(-7deg)}to{transform:rotate(5deg)}}
.pop .body-all{animation:jump .6s cubic-bezier(.3,.6,.4,1) 1}
.actor.prep .rig{animation:prep .45s ease-out both}
.actor.prep .arm-l{transform:rotate(25deg)}.actor.prep .fore-l{transform:rotate(-80deg)}
.actor.prep .arm-r{transform:rotate(-25deg)}.actor.prep .fore-r{transform:rotate(80deg)}
@keyframes prep{0%{transform:none}60%{transform:translateY(4%) scale(1.04,.94)}100%{transform:translateY(3%) scale(1.03,.95)}}
.actor.charging .aura-fx{opacity:.75;transform:scale(.75);filter:blur(4px) hue-rotate(-25deg) saturate(1.6);animation:charge .12s linear infinite alternate}
@keyframes charge{to{transform:scale(.82)}}

/* Shared */
@keyframes shades-on{0%{opacity:0;transform:translateY(-80px)}8%{opacity:1;transform:translateY(-80px)}20%{opacity:1;transform:translateY(0)}24%{transform:translateY(-4px)}28%,92%{opacity:1;transform:translateY(0)}100%{opacity:0;transform:translateY(0)}}
@keyframes shades-late{0%,56%{opacity:0;transform:translateY(-80px)}60%{opacity:1;transform:translateY(-80px)}70%{opacity:1;transform:translateY(0)}74%{transform:translateY(-3px)}78%,94%{opacity:1;transform:none}100%{opacity:0;transform:none}}

/* 1. Bote legendario */
.m-bote .rig{animation:bote-rig 2.8s ease-in-out both}
@keyframes bote-rig{0%,100%{transform:translate(0,0)}20%{transform:translate(calc(var(--dir)*7%),-3%)}40%{transform:translate(calc(var(--dir)*-6%),0)}60%{transform:translate(calc(var(--dir)*7%),-3%)}80%{transform:translate(calc(var(--dir)*-4%),0)}}
.m-bote .body-all{animation:bote-bob .35s ease-in-out infinite alternate}
@keyframes bote-bob{to{transform:translateY(4px)}}
.m-bote .upper{animation:bote-up 2.8s ease-in-out both}
@keyframes bote-up{0%,100%{transform:none}25%{transform:rotate(-7deg)}50%{transform:rotate(7deg)}75%{transform:rotate(-6deg)}}
.m-bote .arm-l{animation:bote-al 2.8s ease-in-out both}
@keyframes bote-al{0%,100%{transform:none}14%{transform:rotate(125deg)}28%{transform:rotate(45deg)}42%{transform:rotate(135deg)}56%{transform:rotate(40deg)}70%{transform:rotate(125deg)}86%{transform:rotate(80deg)}}
.m-bote .fore-l{animation:bote-fl 2.8s ease-in-out both}
@keyframes bote-fl{0%,100%{transform:none}14%{transform:rotate(-70deg)}28%{transform:rotate(35deg)}42%{transform:rotate(-70deg)}56%{transform:rotate(35deg)}70%{transform:rotate(-70deg)}86%{transform:rotate(-20deg)}}
.m-bote .arm-r{animation:bote-ar 2.8s ease-in-out both}
@keyframes bote-ar{0%,100%{transform:none}21%{transform:rotate(-45deg)}35%{transform:rotate(-135deg)}49%{transform:rotate(-40deg)}63%{transform:rotate(-135deg)}77%{transform:rotate(-50deg)}88%{transform:rotate(-80deg)}}
.m-bote .fore-r{animation:bote-fr 2.8s ease-in-out both}
@keyframes bote-fr{0%,100%{transform:none}21%{transform:rotate(40deg)}35%{transform:rotate(-70deg)}49%{transform:rotate(40deg)}63%{transform:rotate(-70deg)}77%{transform:rotate(30deg)}88%{transform:rotate(0)}}
.m-bote .head{animation:bote-hd 2.8s ease-in-out both}
@keyframes bote-hd{0%,100%{transform:none}30%{transform:rotate(-7deg)}60%{transform:rotate(6deg)}85%{transform:rotate(-4deg)}}
.m-bote .shades{animation:shades-on 2.8s ease-out both}

/* 2. Giro de los lentes */
.m-giro .rig{animation:giro-rig 2.4s cubic-bezier(.4,0,.3,1) both}
@keyframes giro-rig{0%{transform:none}12%{transform:translateY(3%)}20%{transform:translateY(-13%) rotateY(0)}55%{transform:translateY(-13%) rotateY(1440deg)}62%{transform:translateY(0) rotateY(1440deg)}100%{transform:rotateY(1440deg)}}
.m-giro .arm-l{animation:giro-al 2.4s ease-in-out both}
@keyframes giro-al{0%,12%,100%{transform:none}20%,55%{transform:rotate(75deg)}64%,90%{transform:rotate(35deg)}}
.m-giro .fore-l{animation:giro-fl 2.4s ease-in-out both}
@keyframes giro-fl{0%,55%,100%{transform:none}64%,90%{transform:rotate(-115deg)}}
.m-giro .arm-r{animation:giro-ar 2.4s ease-in-out both}
@keyframes giro-ar{0%,12%,100%{transform:none}20%,55%{transform:rotate(-75deg)}64%,90%{transform:rotate(-35deg)}}
.m-giro .fore-r{animation:giro-fr 2.4s ease-in-out both}
@keyframes giro-fr{0%,55%,100%{transform:none}64%,90%{transform:rotate(115deg)}}
.m-giro .leg-l{animation:giro-ll 2.4s ease-in-out both}
@keyframes giro-ll{0%,58%,100%{transform:none}66%,90%{transform:rotate(10deg)}}
.m-giro .leg-r{animation:giro-lr 2.4s ease-in-out both}
@keyframes giro-lr{0%,58%,100%{transform:none}66%,90%{transform:rotate(-10deg)}}
.m-giro .head{animation:giro-hd 2.4s ease-in-out both}
@keyframes giro-hd{0%,64%,100%{transform:none}72%,92%{transform:rotate(-8deg)}}
.m-giro .shades{animation:shades-late 2.4s ease-out both}

/* 3. Rodillazo de campeón */
.m-rodilla .rig{animation:rod-rig 2.6s cubic-bezier(.3,.1,.3,1) both}
@keyframes rod-rig{0%{transform:none}10%{transform:translateY(3%)}22%{transform:translateX(calc(var(--dir)*14%)) translateY(-3%)}36%{transform:translateX(calc(var(--dir)*40%)) translateY(19%)}48%,78%{transform:translateX(calc(var(--dir)*62%)) translateY(19%)}92%{transform:translateX(calc(var(--dir)*18%))}100%{transform:none}}
.m-rodilla .leg-l,.m-rodilla .leg-r{animation:rod-leg 2.6s ease-in-out both}
@keyframes rod-leg{0%,22%,92%,100%{transform:none}34%,80%{transform:rotate(80deg)}}
.m-rodilla .upper{animation:rod-up 2.6s ease-in-out both}
@keyframes rod-up{0%,22%,92%,100%{transform:none}38%,80%{transform:rotate(-17deg)}}
.m-rodilla .arm-l{animation:rod-al 2.6s ease-in-out both}
@keyframes rod-al{0%,100%{transform:none}22%{transform:rotate(-30deg)}38%,80%{transform:rotate(140deg)}}
.m-rodilla .arm-r{animation:rod-ar 2.6s ease-in-out both}
@keyframes rod-ar{0%,100%{transform:none}22%{transform:rotate(30deg)}38%,80%{transform:rotate(-140deg)}}
.m-rodilla .fore-l{animation:rod-fl 2.6s ease-in-out both}
@keyframes rod-fl{0%,30%,100%{transform:none}40%,80%{transform:rotate(-20deg)}}
.m-rodilla .fore-r{animation:rod-fr 2.6s ease-in-out both}
@keyframes rod-fr{0%,30%,100%{transform:none}40%,80%{transform:rotate(20deg)}}
.m-rodilla .head{animation:rod-hd 2.6s ease-in-out both}
@keyframes rod-hd{0%,30%,100%{transform:none}42%,80%{transform:rotate(-12deg)}}

/* 4. Despertar del aura */
.m-poder .rig{animation:pod-rig 2.8s both}
@keyframes pod-rig{0%{transform:none}8%{transform:translateY(5%) scale(1.03,.95)}12%{transform:translate(-1.5%,5%) scale(1.03,.95)}16%{transform:translate(1.5%,5%) scale(1.03,.95)}20%{transform:translate(-1.5%,5%) scale(1.03,.95)}24%{transform:translate(1.5%,5%) scale(1.03,.95)}28%{transform:translate(-2.5%,5%) scale(1.04,.94)}32%{transform:translate(2.5%,5%) scale(1.04,.94)}36%{transform:translate(-2.5%,5%) scale(1.04,.94)}40%{transform:translate(0,6%) scale(1.06,.92)}46%{transform:translateY(-36%) scale(.92,1.1)}56%{transform:translateY(-36%) scale(1)}64%{transform:translateY(0) scale(1.08,.92)}70%,100%{transform:none}}
.m-poder .upper{animation:pod-up 2.8s both}
@keyframes pod-up{0%,46%,100%{transform:none}8%,40%{transform:rotate(7deg)}}
.m-poder .arm-l{animation:pod-al 2.8s both}
@keyframes pod-al{0%,100%{transform:none}8%,40%{transform:rotate(25deg)}46%,62%{transform:rotate(150deg)}72%,92%{transform:rotate(125deg)}}
.m-poder .fore-l{animation:pod-fl 2.8s both}
@keyframes pod-fl{0%,100%{transform:none}8%,40%{transform:rotate(-85deg)}46%,62%{transform:none}72%,92%{transform:rotate(-45deg)}}
.m-poder .arm-r{animation:pod-ar 2.8s both}
@keyframes pod-ar{0%,100%{transform:none}8%,40%{transform:rotate(-25deg)}46%,62%{transform:rotate(-150deg)}72%,92%{transform:rotate(-125deg)}}
.m-poder .fore-r{animation:pod-fr 2.8s both}
@keyframes pod-fr{0%,100%{transform:none}8%,40%{transform:rotate(85deg)}46%,62%{transform:none}72%,92%{transform:rotate(45deg)}}
.m-poder .leg-l{animation:pod-ll 2.8s both}
@keyframes pod-ll{0%,100%{transform:none}8%,40%{transform:rotate(14deg)}46%,56%{transform:rotate(24deg)}64%,92%{transform:rotate(12deg)}}
.m-poder .leg-r{animation:pod-lr 2.8s both}
@keyframes pod-lr{0%,100%{transform:none}8%,40%{transform:rotate(-14deg)}46%,56%{transform:rotate(-24deg)}64%,92%{transform:rotate(-12deg)}}
.m-poder .head{animation:pod-hd 2.8s both}
@keyframes pod-hd{0%,100%{transform:none}8%,40%{transform:rotate(9deg) translateY(3px)}46%,92%{transform:rotate(-4deg)}}

/* 5. Moonwalk de la verdad */
.m-moon .rig{animation:moon-rig 2.6s linear both}
@keyframes moon-rig{0%{transform:none}60%{transform:translateX(calc(var(--dir)*-28%))}66%,86%{transform:translateX(calc(var(--dir)*-28%)) translateY(-4%) rotate(calc(var(--dir)*-5deg))}100%{transform:none}}
.m-moon .leg-l{animation:moon-l 2.6s ease-in-out both}
@keyframes moon-l{0%,100%{transform:none}10%,30%,50%{transform:rotate(-15deg)}20%,40%{transform:rotate(6deg)}60%{transform:rotate(4deg)}66%,86%{transform:rotate(-6deg)}}
.m-moon .leg-r{animation:moon-r 2.6s ease-in-out both}
@keyframes moon-r{0%,100%{transform:none}10%,30%,50%{transform:rotate(6deg)}20%,40%,60%{transform:rotate(-15deg)}66%,86%{transform:rotate(6deg)}}
.m-moon .upper{animation:moon-up 2.6s ease-in-out both}
@keyframes moon-up{0%,100%{transform:none}10%,58%{transform:rotate(5deg)}66%,86%{transform:rotate(-3deg)}}
.m-moon .arm-r{animation:moon-ar 2.6s ease-in-out both}
@keyframes moon-ar{0%,100%{transform:none}10%,58%{transform:rotate(-15deg)}66%,86%{transform:rotate(-150deg)}}
.m-moon .fore-r{animation:moon-fr 2.6s ease-in-out both}
@keyframes moon-fr{0%,100%{transform:none}10%,58%{transform:rotate(-40deg)}66%,86%{transform:rotate(-75deg)}}
.m-moon .arm-l{animation:moon-al 2.6s ease-in-out both}
@keyframes moon-al{0%,100%{transform:none}10%,58%{transform:rotate(15deg)}66%,86%{transform:rotate(-25deg)}}
.m-moon .fore-l{animation:moon-fl 2.6s ease-in-out both}
@keyframes moon-fl{0%,100%{transform:none}10%,58%{transform:rotate(40deg)}66%,86%{transform:rotate(-50deg)}}
.m-moon .head{animation:moon-hd 2.6s ease-in-out both}
@keyframes moon-hd{0%,62%,100%{transform:none}68%,86%{transform:rotate(-9deg)}}

/* 6. Mortal sigma */
.m-mortal .rig{animation:mor-rig 2.6s both;transform-origin:50% 55%}
@keyframes mor-rig{0%{transform:none}14%{transform:translateY(6%) scale(1.04,.93)}20%{transform:translateY(-10%)}34%{transform:translateY(-56%) rotate(calc(var(--dir)*-200deg))}46%{transform:translateY(-6%) rotate(calc(var(--dir)*-360deg))}50%{transform:translateY(11%) rotate(calc(var(--dir)*-360deg)) scale(1.05,.95)}78%{transform:translateY(11%) rotate(calc(var(--dir)*-360deg))}92%,100%{transform:rotate(calc(var(--dir)*-360deg))}}
.m-mortal .upper{animation:mor-up 2.6s both}
@keyframes mor-up{0%,20%,92%,100%{transform:none}30%,44%{transform:rotate(14deg)}50%,78%{transform:rotate(22deg)}}
.m-mortal .leg-l{animation:mor-ll 2.6s both}
@keyframes mor-ll{0%,18%,92%,100%{transform:none}26%,44%{transform:rotate(-50deg)}50%,78%{transform:rotate(-42deg)}}
.m-mortal .leg-r{animation:mor-lr 2.6s both}
@keyframes mor-lr{0%,18%,92%,100%{transform:none}26%,44%{transform:rotate(-50deg)}50%,78%{transform:rotate(62deg)}}
.m-mortal .arm-l{animation:mor-al 2.6s both}
@keyframes mor-al{0%,100%{transform:none}14%{transform:rotate(40deg)}26%,44%{transform:rotate(-50deg)}50%,78%{transform:rotate(100deg)}}
.m-mortal .arm-r{animation:mor-ar 2.6s both}
@keyframes mor-ar{0%,100%{transform:none}14%{transform:rotate(-40deg)}26%,44%{transform:rotate(50deg)}50%,78%{transform:rotate(18deg)}}
.m-mortal .fore-l{animation:mor-fl 2.6s both}
@keyframes mor-fl{0%,100%{transform:none}26%,44%{transform:rotate(-60deg)}50%,78%{transform:rotate(25deg)}}
.m-mortal .head{animation:mor-hd 2.6s both}
@keyframes mor-hd{0%,46%,92%,100%{transform:none}52%{transform:rotate(18deg)}78%{transform:rotate(-6deg)}}

/* 7. Caminata de la explosión */
.m-explosion .rig{animation:exp-rig 3s ease-in-out both}
@keyframes exp-rig{0%{transform:none}55%,82%{transform:translateY(5%) scale(1.34)}100%{transform:none}}
.m-explosion .leg-l{animation:exp-ll 3s ease-in-out both}
@keyframes exp-ll{0%,100%{transform:none}8%,24%,40%{transform:rotate(13deg)}16%,32%,48%{transform:rotate(-13deg)}55%,82%{transform:none}}
.m-explosion .leg-r{animation:exp-lr 3s ease-in-out both}
@keyframes exp-lr{0%,100%{transform:none}8%,24%,40%{transform:rotate(-13deg)}16%,32%,48%{transform:rotate(13deg)}55%,82%{transform:none}}
.m-explosion .arm-l{animation:exp-al 3s ease-in-out both}
@keyframes exp-al{0%,100%{transform:none}8%,24%,40%{transform:rotate(-12deg)}16%,32%,48%{transform:rotate(12deg)}58%,82%{transform:rotate(30deg)}}
.m-explosion .fore-l{animation:exp-fl 3s ease-in-out both}
@keyframes exp-fl{0%,52%,100%{transform:none}58%,82%{transform:rotate(-112deg)}}
.m-explosion .arm-r{animation:exp-ar 3s ease-in-out both}
@keyframes exp-ar{0%,100%{transform:none}8%,24%,40%{transform:rotate(12deg)}16%,32%,48%{transform:rotate(-12deg)}58%,82%{transform:rotate(-30deg)}}
.m-explosion .fore-r{animation:exp-fr 3s ease-in-out both}
@keyframes exp-fr{0%,52%,100%{transform:none}58%,82%{transform:rotate(112deg)}}
.m-explosion .shades{animation:shades-on 3s ease-out both}

/* 8. Melena al viento */
.m-pelo .head{animation:pelo-hd 2.4s ease-in-out both}
@keyframes pelo-hd{0%,100%{transform:none}18%{transform:rotate(22deg) translateY(3px)}34%{transform:rotate(-26deg)}44%,88%{transform:rotate(-8deg)}}
.m-pelo .upper{animation:pelo-up 2.4s ease-in-out both}
@keyframes pelo-up{0%,100%{transform:none}18%{transform:rotate(8deg)}34%{transform:rotate(-11deg)}44%,88%{transform:rotate(-3deg)}}
.m-pelo .arm-r{animation:pelo-ar 2.4s ease-in-out both}
@keyframes pelo-ar{0%,100%{transform:none}14%,30%{transform:rotate(-150deg)}44%{transform:rotate(-20deg)}56%,88%{transform:rotate(-72deg)}}
.m-pelo .fore-r{animation:pelo-fr 2.4s ease-in-out both}
@keyframes pelo-fr{0%,100%{transform:none}14%,30%{transform:rotate(-60deg)}44%{transform:none}56%,88%{transform:rotate(-8deg)}}
.m-pelo .arm-l{animation:pelo-al 2.4s ease-in-out both}
@keyframes pelo-al{0%,36%,100%{transform:none}46%,88%{transform:rotate(32deg)}}
.m-pelo .fore-l{animation:pelo-fl 2.4s ease-in-out both}
@keyframes pelo-fl{0%,36%,100%{transform:none}46%,88%{transform:rotate(-112deg)}}
.m-pelo .rig{animation:pelo-rig 2.4s ease-in-out both}
@keyframes pelo-rig{0%,100%{transform:none}34%{transform:translateY(-3%)}44%,88%{transform:none}}

/* 9. Floss turbo */
.m-floss .arm-l,.m-floss .arm-r{animation:fl-arm .275s ease-in-out 8 alternate both}
@keyframes fl-arm{from{transform:rotate(-64deg)}to{transform:rotate(64deg)}}
.m-floss .upper{animation:fl-up .275s ease-in-out 8 alternate both}
@keyframes fl-up{from{transform:translateX(4px) rotate(3deg)}to{transform:translateX(-4px) rotate(-3deg)}}
.m-floss .rig{animation:fl-rig .275s ease-in-out 8 alternate both}
@keyframes fl-rig{from{transform:translateX(-4.5%) translateY(0)}to{transform:translateX(4.5%) translateY(-3%)}}
.m-floss .head{animation:fl-hd .55s ease-in-out 4 alternate both}
@keyframes fl-hd{from{transform:rotate(-6deg)}to{transform:rotate(6deg)}}

/* 10. Salsa caleña */
.m-salsa .leg-l{animation:sal-l .325s ease-in-out 8 alternate both}
@keyframes sal-l{from{transform:rotate(-13deg)}to{transform:rotate(6deg)}}
.m-salsa .leg-r{animation:sal-r .325s ease-in-out 8 alternate both}
@keyframes sal-r{from{transform:rotate(-6deg)}to{transform:rotate(13deg)}}
.m-salsa .upper{animation:sal-up .325s ease-in-out 8 alternate both}
@keyframes sal-up{from{transform:rotate(-6deg)}to{transform:rotate(6deg)}}
.m-salsa .arm-r{animation:sal-ar 2.6s ease-in-out both}
@keyframes sal-ar{0%,100%{transform:none}10%,90%{transform:rotate(-140deg)}}
.m-salsa .fore-r{animation:sal-fr .65s ease-in-out 4 alternate both}
@keyframes sal-fr{from{transform:rotate(-35deg)}to{transform:rotate(35deg)}}
.m-salsa .arm-l{animation:sal-al 2.6s ease-in-out both}
@keyframes sal-al{0%,100%{transform:none}10%,90%{transform:rotate(32deg)}}
.m-salsa .fore-l{animation:sal-fl 2.6s ease-in-out both}
@keyframes sal-fl{0%,100%{transform:none}10%,90%{transform:rotate(-112deg)}}
.m-salsa .rig{animation:sal-rig 2.6s ease-in-out both}
@keyframes sal-rig{0%,55%{transform:translateY(0) rotateY(0)}70%{transform:translateY(-10%) rotateY(1080deg)}78%,100%{transform:translateY(0) rotateY(1080deg)}}

/* Fails */
.f-resbalon .rig{animation:res-rig 2.4s both;transform-origin:50% 92%}
@keyframes res-rig{0%{transform:none}22%{transform:rotateY(300deg)}30%{transform:translateX(calc(var(--dir)*12%)) rotateY(360deg) rotate(calc(var(--dir)*-22deg)) translateY(-6%)}38%{transform:translateX(calc(var(--dir)*38%)) rotate(calc(var(--dir)*-92deg)) translateY(-4%)}43%{transform:translateX(calc(var(--dir)*38%)) rotate(calc(var(--dir)*-88deg))}47%{transform:translateX(calc(var(--dir)*38%)) rotate(calc(var(--dir)*-91deg)) translateY(-2%)}52%,82%{transform:translateX(calc(var(--dir)*38%)) rotate(calc(var(--dir)*-90deg))}95%,100%{transform:none}}
.f-resbalon .leg-l,.f-resbalon .leg-r{animation:res-leg 2.4s both}
@keyframes res-leg{0%,24%,95%,100%{transform:none}32%,40%{transform:rotate(-60deg)}48%,82%{transform:rotate(-18deg)}}
.f-resbalon .arm-l{animation:res-al 2.4s both}
@keyframes res-al{0%,24%,95%,100%{transform:none}32%,42%{transform:rotate(150deg)}50%,82%{transform:rotate(90deg)}}
.f-resbalon .arm-r{animation:res-ar 2.4s both}
@keyframes res-ar{0%,24%,95%,100%{transform:none}32%,42%{transform:rotate(-150deg)}50%,82%{transform:rotate(-90deg)}}

.f-desinfla .rig{animation:des-rig 2.4s both}
@keyframes des-rig{0%{transform:none}8%{transform:translateY(5%) scale(1.03,.95)}14%{transform:translate(-1.5%,5%) scale(1.03,.95)}20%{transform:translate(1.5%,5%) scale(1.03,.95)}26%{transform:translate(-1.5%,5%) scale(1.03,.95)}32%{transform:translate(1.5%,5%) scale(1.03,.95)}40%{transform:translateY(5%) scale(1.05,.93)}46%{transform:translateY(-6%) scale(.97,1.05)}52%{transform:translateY(9%) scale(1.14,.7)}60%,86%{transform:translateY(9%) scale(1.1,.74)}100%{transform:none}}
.f-desinfla .upper{animation:des-up 2.4s both}
@keyframes des-up{0%,100%{transform:none}8%,40%{transform:rotate(7deg)}52%,86%{transform:rotate(15deg)}}
.f-desinfla .arm-l{animation:des-al 2.4s both}
@keyframes des-al{0%,100%{transform:none}8%,40%{transform:rotate(25deg)}46%{transform:rotate(120deg)}54%,86%{transform:rotate(-8deg)}}
.f-desinfla .fore-l{animation:des-fl 2.4s both}
@keyframes des-fl{0%,100%{transform:none}8%,40%{transform:rotate(-85deg)}46%,86%{transform:none}}
.f-desinfla .arm-r{animation:des-ar 2.4s both}
@keyframes des-ar{0%,100%{transform:none}8%,40%{transform:rotate(-25deg)}46%{transform:rotate(-120deg)}54%,86%{transform:rotate(8deg)}}
.f-desinfla .fore-r{animation:des-fr 2.4s both}
@keyframes des-fr{0%,100%{transform:none}8%,40%{transform:rotate(85deg)}46%,86%{transform:none}}
.f-desinfla .head{animation:des-hd 2.4s both}
@keyframes des-hd{0%,100%{transform:none}8%,40%{transform:rotate(9deg)}54%,86%{transform:rotate(18deg) translateY(4px)}}

.f-espalda .upper{animation:esp-up 2.4s both}
@keyframes esp-up{0%{transform:none}10%{transform:rotate(-7deg)}20%{transform:rotate(7deg)}30%{transform:rotate(-8deg)}38%{transform:rotate(32deg)}42%{transform:rotate(27deg)}46%{transform:rotate(32deg)}50%{transform:rotate(28deg)}54%,86%{transform:rotate(31deg)}100%{transform:none}}
.f-espalda .arm-r{animation:esp-ar 2.4s both}
@keyframes esp-ar{0%,100%{transform:none}8%,30%{transform:rotate(-140deg)}38%,86%{transform:rotate(28deg)}}
.f-espalda .fore-r{animation:esp-fr 2.4s both}
@keyframes esp-fr{0%,100%{transform:none}8%,30%{transform:rotate(30deg)}38%,86%{transform:rotate(115deg)}}
.f-espalda .arm-l{animation:esp-al 2.4s both}
@keyframes esp-al{0%,100%{transform:none}8%,30%{transform:rotate(40deg)}38%,86%{transform:rotate(-22deg)}}
.f-espalda .leg-l{animation:esp-ll 2.4s both}
@keyframes esp-ll{0%,100%{transform:none}10%,30%{transform:rotate(-12deg)}20%{transform:rotate(6deg)}38%,86%{transform:rotate(9deg)}}
.f-espalda .leg-r{animation:esp-lr 2.4s both}
@keyframes esp-lr{0%,100%{transform:none}10%,30%{transform:rotate(6deg)}20%{transform:rotate(-12deg)}38%,86%{transform:rotate(-9deg)}}
.f-espalda .rig{animation:esp-rig 2.4s both}
@keyframes esp-rig{0%,36%,90%,100%{transform:none}40%,48%,56%,64%,72%,80%{transform:translateX(-1%)}44%,52%,60%,68%,76%,84%{transform:translateX(1%)}}

.f-lag .rig{animation:lag-rig 2.2s steps(1) both}
@keyframes lag-rig{0%,30%{filter:none;transform:none;opacity:1}32%{filter:drop-shadow(5px 0 0 #EF4A37) drop-shadow(-5px 0 0 #3DAEE4);transform:translateX(7%)}36%{transform:translateX(-5%) skewX(14deg)}40%{filter:drop-shadow(-6px 0 0 #EF4A37) drop-shadow(6px 0 0 #3DAEE4);transform:translateY(-4%)}44%{transform:translateX(4%) scaleY(.88)}48%{opacity:.35}50%{opacity:1;transform:translateX(-7%)}56%{transform:skewX(-16deg)}62%{filter:none;transform:none}70%{filter:drop-shadow(4px 0 0 #EF4A37) drop-shadow(-4px 0 0 #3DAEE4);transform:translateX(3%)}74%{transform:translateX(-12%)}78%,100%{filter:none;transform:none;opacity:1}}
.f-lag .arm-l,.f-lag .arm-r{animation:lag-arm 2.2s steps(1) both}
@keyframes lag-arm{0%{transform:rotate(-48deg)}8%{transform:rotate(48deg)}16%{transform:rotate(-48deg)}24%{transform:rotate(48deg)}32%,60%{transform:rotate(48deg)}36%{transform:rotate(120deg)}44%{transform:rotate(-80deg)}52%{transform:rotate(48deg)}74%{transform:rotate(160deg)}80%,100%{transform:none}}
.f-lag .head{animation:lag-hd 2.2s steps(1) both}
@keyframes lag-hd{0%,30%,80%,100%{transform:none}34%{transform:rotate(30deg)}42%{transform:rotate(-25deg) translateY(-6px)}54%{transform:rotate(15deg)}}

.f-camara .rig{animation:cam-rig 2.4s both}
@keyframes cam-rig{0%{transform:none}40%{transform:translateY(6%) scale(1.45)}44%{transform:translateY(6%) scale(1.66,1.48)}48%{transform:translateY(6%) scale(1.55,1.6)}60%{transform:translateY(10%) scale(1.52)}76%,84%{transform:translateY(46%) scale(1.45);opacity:1}86%{opacity:0;transform:translateY(46%) scale(1.45)}92%{transform:none;opacity:0}100%{transform:none;opacity:1}}
.f-camara .leg-l{animation:exp-ll 2.4s ease-in-out both}
.f-camara .leg-r{animation:exp-lr 2.4s ease-in-out both}
.f-camara .arm-l{animation:cam-al 2.4s both}
@keyframes cam-al{0%,100%{transform:none}10%,30%{transform:rotate(-14deg)}20%,38%{transform:rotate(14deg)}44%,84%{transform:rotate(130deg)}}
.f-camara .arm-r{animation:cam-ar 2.4s both}
@keyframes cam-ar{0%,100%{transform:none}10%,30%{transform:rotate(14deg)}20%,38%{transform:rotate(-14deg)}44%,84%{transform:rotate(-130deg)}}
.f-camara .shades{animation:shades-on 2.4s ease-out both}

.f-lentes .shades{animation:len-sh 2.4s ease-out both}
@keyframes len-sh{0%{opacity:0;transform:translateY(-80px)}10%{opacity:1;transform:translateY(-80px)}24%{opacity:1;transform:translateY(0)}32%{transform:translateY(5px)}44%{opacity:1;transform:translateY(150px) rotate(25deg)}50%{transform:translateY(136px) rotate(32deg)}56%,100%{opacity:1;transform:translateY(150px) rotate(25deg)}}
.f-lentes .head{animation:len-hd 2.4s ease-in-out both}
@keyframes len-hd{0%,30%,100%{transform:none}38%,60%{transform:rotate(16deg) translateY(4px)}68%,90%{transform:rotate(-6deg)}}
.f-lentes .arm-l{animation:len-al 2.4s ease-in-out both}
@keyframes len-al{0%,100%{transform:none}8%,30%{transform:rotate(35deg)}40%,60%{transform:rotate(155deg)}70%,90%{transform:rotate(60deg)}}
.f-lentes .fore-l{animation:len-fl 2.4s ease-in-out both}
@keyframes len-fl{0%,100%{transform:none}8%,30%{transform:rotate(-115deg)}40%,60%{transform:rotate(10deg)}70%,90%{transform:rotate(-30deg)}}
.f-lentes .arm-r{animation:len-ar 2.4s ease-in-out both}
@keyframes len-ar{0%,100%{transform:none}8%,30%{transform:rotate(-35deg)}40%,60%{transform:rotate(-155deg)}70%,90%{transform:rotate(-60deg)}}
.f-lentes .fore-r{animation:len-fr 2.4s ease-in-out both}
@keyframes len-fr{0%,100%{transform:none}8%,30%{transform:rotate(115deg)}40%,60%{transform:rotate(-10deg)}70%,90%{transform:rotate(30deg)}}

/* Reactions */
.r-boca .rig{animation:boca-rig 1.9s both}
@keyframes boca-rig{0%{transform:none}12%{transform:translateY(-9%) scale(.96,1.06)}24%{transform:translateX(calc(var(--dir)*-8%)) rotate(calc(var(--dir)*-12deg))}30%,86%{transform:translateX(calc(var(--dir)*-6%)) rotate(calc(var(--dir)*-9deg))}100%{transform:none}}
.r-boca .arm-l{animation:boca-al 1.9s both}
@keyframes boca-al{0%,100%{transform:none}18%,86%{transform:rotate(155deg)}}
.r-boca .fore-l{animation:boca-fl 1.9s both}
@keyframes boca-fl{0%,100%{transform:none}18%,86%{transform:rotate(10deg)}}
.r-boca .arm-r{animation:boca-ar 1.9s both}
@keyframes boca-ar{0%,100%{transform:none}18%,86%{transform:rotate(-155deg)}}
.r-boca .fore-r{animation:boca-fr 1.9s both}
@keyframes boca-fr{0%,100%{transform:none}18%,86%{transform:rotate(-10deg)}}

.r-aplauso .arm-l{animation:apl-al 1.8s both}
@keyframes apl-al{0%,100%{transform:none}10%,90%{transform:rotate(-45deg)}}
.r-aplauso .arm-r{animation:apl-ar 1.8s both}
@keyframes apl-ar{0%,100%{transform:none}10%,90%{transform:rotate(45deg)}}
.r-aplauso .fore-l{animation:apl-fl .16s ease-in-out 11 alternate both}
@keyframes apl-fl{from{transform:rotate(-38deg)}to{transform:rotate(-72deg)}}
.r-aplauso .fore-r{animation:apl-fr .16s ease-in-out 11 alternate both}
@keyframes apl-fr{from{transform:rotate(38deg)}to{transform:rotate(72deg)}}

.r-risa .upper{animation:risa-up .3s ease-in-out 6 alternate both}
@keyframes risa-up{from{transform:rotate(10deg)}to{transform:rotate(25deg)}}
.r-risa .arm-r{animation:risa-ar .15s ease-in-out 12 alternate both}
@keyframes risa-ar{from{transform:rotate(-22deg)}to{transform:rotate(22deg)}}
.r-risa .arm-l{animation:risa-al 1.8s both}
@keyframes risa-al{0%,100%{transform:none}10%,90%{transform:rotate(-30deg)}}
.r-risa .fore-l{animation:risa-fl 1.8s both}
@keyframes risa-fl{0%,100%{transform:none}10%,90%{transform:rotate(-85deg)}}
.r-risa .rig{animation:risa-rig .3s ease-in-out 6 alternate both}
@keyframes risa-rig{from{transform:none}to{transform:translateY(-3%)}}

.r-rofl .rig{animation:rofl-rig 2.2s both}
@keyframes rofl-rig{0%{transform:none}14%{transform:translateY(-4%)}26%{transform:translateY(21%) rotate(calc(var(--dir)*-6deg))}34%,50%,66%,82%{transform:translateY(19%) rotate(calc(var(--dir)*-12deg))}42%,58%,74%,88%{transform:translateY(21%) rotate(calc(var(--dir)*-2deg))}100%{transform:none}}
.r-rofl .leg-l{animation:rofl-l 2.2s both}
@keyframes rofl-l{0%,14%,100%{transform:none}26%,38%,62%,88%{transform:rotate(-78deg)}50%,74%{transform:rotate(-64deg)}}
.r-rofl .leg-r{animation:rofl-r 2.2s both}
@keyframes rofl-r{0%,14%,100%{transform:none}26%,50%,74%,88%{transform:rotate(-82deg)}38%,62%{transform:rotate(-66deg)}}
.r-rofl .upper{animation:rofl-up .26s ease-in-out 8 alternate both}
@keyframes rofl-up{from{transform:rotate(-14deg)}to{transform:rotate(4deg)}}
.r-rofl .arm-l{animation:risa-al 2.2s both}.r-rofl .fore-l{animation:risa-fl 2.2s both}
.r-rofl .arm-r{animation:risa-ar .13s ease-in-out 16 alternate both}
.r-cruzado .arm-l,.g-tap .arm-l{animation:cru-al 1.9s both}
@keyframes cru-al{0%,100%{transform:none}12%,88%{transform:rotate(-55deg)}}
.r-cruzado .fore-l,.g-tap .fore-l{animation:cru-fl 1.9s both}
@keyframes cru-fl{0%,100%{transform:none}12%,88%{transform:rotate(-95deg)}}
.r-cruzado .arm-r,.g-tap .arm-r{animation:cru-ar 1.9s both}
@keyframes cru-ar{0%,100%{transform:none}12%,88%{transform:rotate(55deg)}}
.r-cruzado .fore-r,.g-tap .fore-r{animation:cru-fr 1.9s both}
@keyframes cru-fr{0%,100%{transform:none}12%,88%{transform:rotate(95deg)}}
.r-cruzado .head{animation:cru-hd 1.9s both}
@keyframes cru-hd{0%,20%,100%{transform:none}30%,50%,70%{transform:rotate(-8deg)}40%,60%,80%{transform:rotate(8deg)}}
.r-cruzado .leg-r,.g-tap .leg-r{animation:tap .2s ease-in-out 8 alternate both}
@keyframes tap{from{transform:none}to{transform:rotate(-9deg)}}

/* Idle gestures */
.g-wave .arm-r{animation:gw-ar 1.6s both}
@keyframes gw-ar{0%,100%{transform:none}15%,85%{transform:rotate(-150deg)}}
.g-wave .fore-r{animation:gw-fr .2s ease-in-out 8 alternate both}
@keyframes gw-fr{from{transform:rotate(-30deg)}to{transform:rotate(30deg)}}
.g-stretch .arm-l{animation:gs-al 1.8s both}
@keyframes gs-al{0%,100%{transform:none}25%,75%{transform:rotate(155deg)}}
.g-stretch .arm-r{animation:gs-ar 1.8s both}
@keyframes gs-ar{0%,100%{transform:none}25%,75%{transform:rotate(-155deg)}}
.g-stretch .fore-l{animation:gs-fl 1.8s both}
@keyframes gs-fl{0%,100%{transform:none}25%,75%{transform:rotate(-40deg)}}
.g-stretch .fore-r{animation:gs-fr 1.8s both}
@keyframes gs-fr{0%,100%{transform:none}25%,75%{transform:rotate(40deg)}}
.g-stretch .upper{animation:gs-up 1.8s both}
@keyframes gs-up{0%,100%{transform:none}40%{transform:rotate(-6deg)}60%{transform:rotate(6deg)}}
.g-look .head{animation:gl-hd 1.6s ease-in-out both}
@keyframes gl-hd{0%,100%{transform:none}25%,40%{transform:rotate(-12deg)}60%,75%{transform:rotate(12deg)}}
.g-hop .rig{animation:gh-rig .4s ease-in-out 3 both}
@keyframes gh-rig{0%,100%{transform:none}50%{transform:translateY(-7%)}}
.g-hop .arm-l{animation:gh-al 1.2s both}
@keyframes gh-al{0%,100%{transform:none}20%,80%{transform:rotate(60deg)}}
.g-hop .arm-r{animation:gh-ar 1.2s both}
@keyframes gh-ar{0%,100%{transform:none}20%,80%{transform:rotate(-60deg)}}
.g-guard .arm-l{animation:gg-al 2s both}
@keyframes gg-al{0%,100%{transform:none}12%,88%{transform:rotate(-30deg)}}
.g-guard .fore-l{animation:gg-fl 2s both}
@keyframes gg-fl{0%,100%{transform:none}12%,88%{transform:rotate(-125deg)}}
.g-guard .arm-r{animation:gg-ar 2s both}
@keyframes gg-ar{0%,100%{transform:none}12%,88%{transform:rotate(30deg)}}
.g-guard .fore-r{animation:gg-fr 2s both}
@keyframes gg-fr{0%,100%{transform:none}12%,88%{transform:rotate(125deg)}}
.g-guard .rig{animation:gg-rig .25s ease-in-out 8 alternate both}
@keyframes gg-rig{from{transform:none}to{transform:translateY(2.5%)}}
.g-guard .leg-l{animation:gg-ll 2s both}
@keyframes gg-ll{0%,100%{transform:none}12%,88%{transform:rotate(9deg)}}
.g-guard .leg-r{animation:gg-lr 2s both}
@keyframes gg-lr{0%,100%{transform:none}12%,88%{transform:rotate(-9deg)}}
.g-chin .arm-r{animation:gc-ar 1.8s both}
@keyframes gc-ar{0%,100%{transform:none}15%,85%{transform:rotate(96deg)}}
.g-chin .fore-r{animation:gc-fr 1.8s both}
@keyframes gc-fr{0%,100%{transform:none}15%,85%{transform:rotate(106deg)}}
.g-chin .head{animation:gc-hd 1.8s both}
@keyframes gc-hd{0%,100%{transform:none}30%{transform:rotate(-8deg)}60%{transform:rotate(6deg)}}
.g-come .arm-r{animation:gco-ar 1.6s both}
@keyframes gco-ar{0%,100%{transform:none}15%,85%{transform:rotate(-70deg)}}
.g-come .fore-r{animation:gco-fr .2s ease-in-out 8 alternate both}
@keyframes gco-fr{from{transform:rotate(-10deg)}to{transform:rotate(-80deg)}}

@media (prefers-reduced-motion: reduce){
  [class*=" m-"] .rig,[class*=" m-"] .cs *,[class*=" f-"] .rig,[class*=" f-"] .cs *,[class*=" r-"] .rig,[class*=" r-"] .cs *,[class*=" g-"] .rig,[class*=" g-"] .cs *{animation:none!important}
  .cam,.lb{transition:none}
  .speed{display:none}
}


/* Props, expressions, extra FX */
.cs .tp{opacity:0;transition:opacity .2s}
.cs .prop-user{transition:opacity .2s}
.expr-zen .eyes-in{opacity:0}.expr-zen .eyes-hap{opacity:1}
.stage.cine.good .cam{animation:beat .4s ease-in-out infinite}
.stage.cine.good .cam.shake{animation:shake .55s linear,beat .4s ease-in-out infinite}
@keyframes beat{0%,100%{scale:1}50%{scale:1.035}}
.stage.cine.epic .wall{animation:wallhue 1.6s linear infinite}
@keyframes wallhue{0%,100%{filter:none}50%{filter:hue-rotate(40deg) saturate(1.5)}}
.pop-big{position:absolute;font-size:clamp(54px,9vw,112px);line-height:1;transform:translate(-50%,-50%);animation:popbig 1.4s cubic-bezier(.2,1.5,.4,1) forwards;filter:drop-shadow(0 0 18px rgba(253,190,48,.9))}
@keyframes popbig{0%{opacity:0;transform:translate(-50%,-50%) scale(.2) rotate(-25deg)}25%{opacity:1;transform:translate(-50%,-50%) scale(1.25) rotate(6deg)}45%{transform:translate(-50%,-50%) scale(1) rotate(0)}80%{opacity:1}100%{opacity:0;transform:translate(-50%,-62%) scale(1.05)}}
.fly{position:absolute;font-size:clamp(28px,4.5vw,50px);line-height:1;animation:fly 1.1s cubic-bezier(.3,.6,.5,1) forwards}
@keyframes fly{0%{transform:translate(-50%,-50%) rotate(0)}100%{opacity:0;transform:translate(calc(-50% + var(--fx,120px)),-240px) rotate(720deg)}}
.wavering{position:absolute;width:12%;aspect-ratio:2/1;border:4px solid rgba(134,214,251,.95);border-bottom:0;border-radius:999px 999px 0 0;transform:translate(-50%,-50%) scale(.4);animation:wavering .9s ease-out forwards;box-shadow:0 -4px 14px rgba(61,174,228,.7)}
@keyframes wavering{to{opacity:0;transform:translate(-50%,-80%) scale(3.2)}}
.loadbar{position:absolute;width:20%;min-width:120px;height:18px;transform:translate(-50%,-100%);background:rgba(10,16,30,.88);border:2px solid #86D6FB;border-radius:999px;overflow:hidden;font:800 11px/14px var(--body);color:#fff;text-align:center}
.loadbar i{position:absolute;inset:0 auto 0 0;width:0;background:linear-gradient(90deg,#3DAEE4,#45CB91)}
.loadbar b{position:relative}

/* Pesca al revés */
.m-pesca .tp-rod{opacity:1}.m-pesca .prop-user{opacity:0}
.m-pesca .arm-r{animation:pes-ar 3.2s both}
@keyframes pes-ar{0%,100%{transform:none}10%,14%{transform:rotate(-165deg)}22%{transform:rotate(-60deg)}30%{transform:rotate(-80deg)}34%{transform:rotate(-96deg)}38%{transform:rotate(-78deg)}42%{transform:rotate(-98deg)}46%{transform:rotate(-80deg)}50%{transform:rotate(-102deg)}56%,66%{transform:rotate(-172deg)}74%{transform:rotate(-30deg)}82%,92%{transform:rotate(-150deg)}}
.m-pesca .fore-r{animation:pes-fr 3.2s both}
@keyframes pes-fr{0%,100%{transform:none}10%,14%{transform:rotate(-45deg)}22%,50%{transform:none}56%,66%{transform:rotate(-20deg)}74%{transform:rotate(20deg)}82%,92%{transform:rotate(-25deg)}}
.m-pesca .arm-l{animation:pes-al 3.2s both}
@keyframes pes-al{0%,100%{transform:none}22%,52%{transform:rotate(-40deg)}56%,92%{transform:rotate(150deg)}}
.m-pesca .fore-l{animation:pes-fl 3.2s both}
@keyframes pes-fl{0%,20%,100%{transform:none}24%,32%,40%,48%{transform:rotate(-120deg)}28%,36%,44%,52%{transform:rotate(-60deg)}56%,92%{transform:rotate(-25deg)}}
.m-pesca .upper{animation:pes-up 3.2s both}
@keyframes pes-up{0%,100%{transform:none}10%,14%{transform:rotate(-12deg)}22%{transform:rotate(12deg)}30%,50%{transform:rotate(-20deg)}56%,66%{transform:rotate(-26deg)}74%{transform:rotate(14deg)}82%,92%{transform:rotate(-6deg)}}
.m-pesca .rig{animation:pes-rig 3.2s both}
@keyframes pes-rig{0%{transform:translate(0,0) rotateY(0)}22%{transform:translate(calc(var(--dir)*6%),0) rotateY(0)}30%{transform:translate(calc(var(--dir)*-2%),0) rotateY(0)}34%{transform:translate(calc(var(--dir)*-5%),1%) rotateY(0)}38%{transform:translate(calc(var(--dir)*-3%),0) rotateY(0)}42%{transform:translate(calc(var(--dir)*-7%),1%) rotateY(0)}46%{transform:translate(calc(var(--dir)*-5%),0) rotateY(0)}50%{transform:translate(calc(var(--dir)*-9%),0) rotateY(0)}56%{transform:translate(calc(var(--dir)*-14%),-20%) rotateY(0)}62%,66%{transform:translate(calc(var(--dir)*-16%),0) rotateY(0)}74%{transform:translate(calc(var(--dir)*-8%),0) rotateY(0)}82%{transform:translate(0,-14%) rotateY(360deg)}92%,100%{transform:translate(0,0) rotateY(360deg)}}
.m-pesca .leg-l{animation:pes-ll 3.2s both}
@keyframes pes-ll{0%,100%{transform:none}30%,52%{transform:rotate(20deg)}56%,62%{transform:rotate(32deg)}}
.m-pesca .leg-r{animation:pes-lr 3.2s both}
@keyframes pes-lr{0%,100%{transform:none}30%,52%{transform:rotate(-12deg)}56%,62%{transform:rotate(-32deg)}}

/* Candado humano */
.m-candado .rig,.m-candado .cs .arm,.m-candado .cs .fore{animation-timing-function:cubic-bezier(.8,0,.2,1)!important}
.m-candado .arm-l{animation:can-al 3s both}
@keyframes can-al{0%,100%{transform:none}12%,52%{transform:rotate(160deg)}60%,90%{transform:rotate(-55deg)}}
.m-candado .fore-l{animation:can-fl 3s both}
@keyframes can-fl{0%,100%{transform:none}12%,52%{transform:rotate(-75deg)}60%,90%{transform:rotate(-95deg)}}
.m-candado .arm-r{animation:can-ar 3s both}
@keyframes can-ar{0%,100%{transform:none}12%,52%{transform:rotate(-160deg)}60%,90%{transform:rotate(55deg)}}
.m-candado .fore-r{animation:can-fr 3s both}
@keyframes can-fr{0%,100%{transform:none}12%,52%{transform:rotate(75deg)}60%,90%{transform:rotate(95deg)}}
.m-candado .rig{animation:can-rig 3s both}
@keyframes can-rig{0%{transform:translateY(0) rotate(0) rotateY(0)}12%{transform:translateY(4%) rotate(0) rotateY(0)}18%{transform:translateY(4%) rotate(calc(var(--dir)*9deg)) rotateY(0)}24%{transform:translateY(4%) rotate(calc(var(--dir)*-9deg)) rotateY(0)}30%{transform:translateY(4%) rotate(calc(var(--dir)*9deg)) rotateY(0)}36%{transform:translateY(4%) rotate(calc(var(--dir)*-9deg)) rotateY(0)}42%{transform:translateY(-16%) rotate(0) rotateY(0)}52%{transform:translateY(-16%) rotate(0) rotateY(720deg)}57%{transform:translateY(6%) rotate(0) rotateY(720deg)}62%,100%{transform:translateY(0) rotate(0) rotateY(720deg)}}
.m-candado .leg-l{animation:can-ll 3s both}
@keyframes can-ll{0%,57%,100%{transform:none}62%,90%{transform:rotate(13deg)}}
.m-candado .leg-r{animation:can-lr 3s both}
@keyframes can-lr{0%,57%,100%{transform:none}62%,90%{transform:rotate(-13deg)}}
.m-candado .head{animation:can-hd 3s both}
@keyframes can-hd{0%,58%,100%{transform:none}64%,90%{transform:rotate(-8deg)}}

/* Antena 5G */
.m-antena .arm-l{animation:ant-al 3s both}
@keyframes ant-al{0%,100%{transform:none}14%,66%{transform:rotate(128deg)}74%{transform:rotate(70deg)}82%{transform:rotate(115deg)}90%{transform:rotate(70deg)}}
.m-antena .fore-l{animation:ant-fl 3s both}
@keyframes ant-fl{0%,100%{transform:none}14%,66%{transform:rotate(-58deg)}74%{transform:rotate(60deg)}82%{transform:rotate(-40deg)}90%{transform:rotate(30deg)}}
.m-antena .arm-r{animation:ant-ar 3s both}
@keyframes ant-ar{0%,100%{transform:none}14%,66%{transform:rotate(-128deg)}74%{transform:rotate(-115deg)}82%{transform:rotate(-70deg)}90%{transform:rotate(-115deg)}}
.m-antena .fore-r{animation:ant-fr 3s both}
@keyframes ant-fr{0%,100%{transform:none}14%,66%{transform:rotate(58deg)}74%{transform:rotate(40deg)}82%{transform:rotate(-60deg)}90%{transform:rotate(40deg)}}
.m-antena .rig{animation:ant-rig 3s both}
@keyframes ant-rig{0%,100%{transform:none}14%{transform:translateY(2%)}20%,30%,40%,50%,60%{transform:translateY(-11%) scale(.96,1.05)}25%,35%,45%,55%,65%{transform:translateY(3%) scale(1.05,.94)}72%{transform:none}}
.m-antena .head{animation:ant-hd .3s ease-in-out 10 alternate both}
@keyframes ant-hd{from{transform:rotate(-7deg)}to{transform:rotate(7deg)}}
.m-antena .leg-l{animation:ant-ll 3s both}
@keyframes ant-ll{0%,100%{transform:none}14%,66%{transform:rotate(10deg)}}
.m-antena .leg-r{animation:ant-lr 3s both}
@keyframes ant-lr{0%,100%{transform:none}14%,66%{transform:rotate(-10deg)}}

/* Escudo legendario */
.m-escudo .rig{animation:esc-rig 3.2s both}
@keyframes esc-rig{0%{transform:translate(0,0) rotate(0)}12%{transform:translate(0,6%) rotate(0)}22%{transform:translate(calc(var(--dir)*14%),-36%) rotate(calc(var(--dir)*-14deg))}32%{transform:translate(calc(var(--dir)*28%),-20%) rotate(calc(var(--dir)*-4deg))}38%,48%{transform:translate(calc(var(--dir)*30%),12%) rotate(0)}58%,86%{transform:translate(calc(var(--dir)*30%),0) rotate(0)}100%{transform:translate(0,0) rotate(0)}}
.m-escudo .upper{animation:esc-up 3.2s both}
@keyframes esc-up{0%,100%{transform:none}38%,48%{transform:rotate(24deg)}58%,86%{transform:rotate(4deg)}}
.m-escudo .leg-l{animation:esc-ll 3.2s both}
@keyframes esc-ll{0%,100%{transform:none}18%,32%{transform:rotate(-45deg)}38%,48%{transform:rotate(-42deg)}58%,86%{transform:rotate(15deg)}}
.m-escudo .leg-r{animation:esc-lr 3.2s both}
@keyframes esc-lr{0%,100%{transform:none}18%,32%{transform:rotate(-30deg)}38%,48%{transform:rotate(62deg)}58%,86%{transform:rotate(-15deg)}}
.m-escudo .arm-l{animation:esc-al 3.2s both}
@keyframes esc-al{0%,100%{transform:none}8%{transform:rotate(60deg)}18%,32%{transform:rotate(150deg)}38%,48%{transform:rotate(100deg)}58%,86%{transform:rotate(-70deg)}}
.m-escudo .fore-l{animation:esc-fl 3.2s both}
@keyframes esc-fl{0%,52%,100%{transform:none}58%,86%{transform:rotate(-62deg)}}
.m-escudo .arm-r{animation:esc-ar 3.2s both}
@keyframes esc-ar{0%,100%{transform:none}8%{transform:rotate(-60deg)}18%,32%{transform:rotate(-150deg)}38%,48%{transform:rotate(15deg)}58%,86%{transform:rotate(70deg)}}
.m-escudo .fore-r{animation:esc-fr 3.2s both}
@keyframes esc-fr{0%,52%,100%{transform:none}58%,86%{transform:rotate(62deg)}}
.m-escudo .head{animation:esc-hd 3.2s both}
@keyframes esc-hd{0%,34%,56%,100%{transform:none}40%,48%{transform:rotate(18deg)}}

/* Lupa detective */
.m-detective .tp-lupa{opacity:1}.m-detective .prop-user{opacity:0}
.m-detective .rig{animation:det-rig 3.4s both}
@keyframes det-rig{0%{transform:translate(0,0) rotateY(0)}8%{transform:translate(calc(var(--dir)*-7%),5%) rotateY(0)}16%{transform:translate(calc(var(--dir)*-11%),2%) rotateY(0)}24%{transform:translate(calc(var(--dir)*-4%),5%) rotateY(0)}32%{transform:translate(calc(var(--dir)*7%),2%) rotateY(0)}40%{transform:translate(calc(var(--dir)*11%),5%) rotateY(0)}46%{transform:translate(calc(var(--dir)*11%),0) rotateY(0)}50%{transform:translate(calc(var(--dir)*15%),-12%) rotateY(0)}56%,66%{transform:translate(calc(var(--dir)*15%),0) rotateY(0)}76%{transform:translate(calc(var(--dir)*8%),-10%) rotateY(360deg)}86%,100%{transform:translate(0,0) rotateY(360deg)}}
.m-detective .upper{animation:det-up 3.4s both}
@keyframes det-up{0%,100%{transform:none}4%,40%{transform:rotate(15deg)}46%{transform:rotate(6deg)}50%,66%{transform:rotate(-8deg)}}
.m-detective .leg-l{animation:det-ll 3.4s both}
@keyframes det-ll{0%,46%,100%{transform:none}8%,24%,40%{transform:rotate(-38deg)}16%,32%{transform:rotate(6deg)}}
.m-detective .leg-r{animation:det-lr 3.4s both}
@keyframes det-lr{0%,46%,100%{transform:none}8%,24%,40%{transform:rotate(6deg)}16%,32%{transform:rotate(38deg)}}
.m-detective .head{animation:det-hd 3.4s both}
@keyframes det-hd{0%,100%{transform:none}8%{transform:rotate(-15deg)}20%{transform:rotate(13deg)}32%{transform:rotate(-13deg)}42%{transform:rotate(10deg)}46%{transform:rotate(6deg)}50%,66%{transform:rotate(-6deg)}}
.m-detective .arm-r{animation:det-ar 3.4s both}
@keyframes det-ar{0%,100%{transform:none}4%,40%{transform:rotate(-75deg)}44%,48%{transform:rotate(-125deg)}50%,66%{transform:rotate(-160deg)}76%{transform:none}}
.m-detective .fore-r{animation:det-fr 3.4s both}
@keyframes det-fr{0%,100%{transform:none}4%,40%{transform:rotate(-25deg)}44%,48%{transform:rotate(-85deg)}50%,66%{transform:rotate(-20deg)}76%{transform:none}}
.m-detective .arm-l{animation:det-al 3.4s both}
@keyframes det-al{0%,100%{transform:none}4%,40%{transform:rotate(-15deg)}50%,66%{transform:rotate(-60deg)}}
.m-detective .fore-l{animation:det-fl 3.4s both}
@keyframes det-fl{0%,100%{transform:none}4%,40%{transform:rotate(70deg)}50%,66%{transform:rotate(-45deg)}}

/* Levitación zen */
.m-zen .rig{animation:zen-rig 3.4s ease-in-out both}
@keyframes zen-rig{0%{transform:translateY(0) scale(1)}14%,24%{transform:translateY(15%) scale(1)}44%{transform:translateY(-18%) scale(1)}52%{transform:translateY(-13%) scale(1)}60%{transform:translateY(-20%) scale(1)}68%{transform:translateY(-14%) scale(1)}76%{transform:translateY(-18%) scale(1)}82%{transform:translateY(4%) scale(1.06,.92)}88%,100%{transform:translateY(0) scale(1)}}
.m-zen .leg-l{animation:zen-ll 3.4s both}
@keyframes zen-ll{0%,82%,100%{transform:none}12%,78%{transform:rotate(-72deg)}}
.m-zen .leg-r{animation:zen-lr 3.4s both}
@keyframes zen-lr{0%,82%,100%{transform:none}12%,78%{transform:rotate(72deg)}}
.m-zen .arm-l{animation:zen-al 3.4s both}
@keyframes zen-al{0%,100%{transform:none}12%,40%{transform:rotate(30deg)}48%,76%{transform:rotate(158deg)}84%,96%{transform:rotate(-150deg)}}
.m-zen .fore-l{animation:zen-fl 3.4s both}
@keyframes zen-fl{0%,100%{transform:none}12%,40%{transform:rotate(-55deg)}48%,76%{transform:rotate(18deg)}84%,96%{transform:rotate(-100deg)}}
.m-zen .arm-r{animation:zen-ar 3.4s both}
@keyframes zen-ar{0%,100%{transform:none}12%,40%{transform:rotate(-30deg)}48%,76%{transform:rotate(-158deg)}84%,96%{transform:rotate(-120deg)}}
.m-zen .fore-r{animation:zen-fr 3.4s both}
@keyframes zen-fr{0%,100%{transform:none}12%,40%{transform:rotate(55deg)}48%,76%{transform:rotate(-18deg)}84%,96%{transform:none}}
.m-zen .head{animation:zen-hd 3.4s both}
@keyframes zen-hd{0%,80%,100%{transform:none}86%,96%{transform:rotate(20deg)}}

/* Robot actualizado */
.m-robot .rig,.m-robot .cs .arm,.m-robot .cs .fore,.m-robot .cs .head,.m-robot .cs .leg,.m-robot .cs .upper{animation-timing-function:cubic-bezier(.85,0,.15,1)!important}
.m-robot .arm-l{animation:rob-al 3.2s both}
@keyframes rob-al{0%,4%,100%{transform:none}10%,46%{transform:rotate(72deg)}52%{transform:rotate(30deg)}58%{transform:rotate(100deg)}64%{transform:rotate(72deg)}72%,90%{transform:rotate(150deg)}}
.m-robot .fore-l{animation:rob-fl 3.2s both}
@keyframes rob-fl{0%,10%,64%,100%{transform:none}16%,46%{transform:rotate(90deg)}52%{transform:rotate(-30deg)}58%{transform:rotate(60deg)}}
.m-robot .arm-r{animation:rob-ar 3.2s both}
@keyframes rob-ar{0%,18%,100%{transform:none}24%,46%{transform:rotate(-72deg)}52%{transform:rotate(-100deg)}58%{transform:rotate(-30deg)}64%{transform:rotate(-72deg)}72%,90%{transform:rotate(-150deg)}}
.m-robot .fore-r{animation:rob-fr 3.2s both}
@keyframes rob-fr{0%,24%,64%,100%{transform:none}30%,46%{transform:rotate(-90deg)}52%{transform:rotate(-60deg)}58%{transform:rotate(30deg)}}
.m-robot .head{animation:rob-hd 3.2s both}
@keyframes rob-hd{0%,34%,46%,100%{transform:none}38%{transform:rotate(18deg)}42%{transform:rotate(-18deg)}}
.m-robot .rig{animation:rob-rig 3.2s both}
@keyframes rob-rig{0%,46%{transform:translate(0,0) scale(1) rotateY(0)}50%{transform:translate(calc(var(--dir)*7%),0) scale(1) rotateY(0)}54%{transform:translate(calc(var(--dir)*-7%),0) scale(1) rotateY(0)}58%{transform:translate(calc(var(--dir)*7%),0) scale(1) rotateY(0)}62%{transform:translate(0,0) scale(1) rotateY(0)}66%{transform:translate(0,-16%) scale(1) rotateY(0)}70%{transform:translate(0,0) scale(1.05,.94) rotateY(0)}76%{transform:translate(0,-7%) scale(1) rotateY(0)}88%{transform:translate(0,-7%) scale(1) rotateY(360deg)}100%{transform:translate(0,0) scale(1) rotateY(360deg)}}
.m-robot .leg-l{animation:rob-ll 3.2s both}
@keyframes rob-ll{0%,46%,62%,100%{transform:none}50%,58%{transform:rotate(-15deg)}54%{transform:rotate(11deg)}}
.m-robot .leg-r{animation:rob-lr 3.2s both}
@keyframes rob-lr{0%,46%,62%,100%{transform:none}50%,58%{transform:rotate(11deg)}54%{transform:rotate(-15deg)}}
.m-robot .upper{animation:rob-up 3.2s both}
@keyframes rob-up{0%,4%,30%,100%{transform:none}10%{transform:rotate(-7deg)}24%{transform:rotate(7deg)}}

/* Cuelgue legendario */
.m-cuelgue .tp-tel{opacity:1}.m-cuelgue .prop-user{opacity:0}
.m-cuelgue .arm-r{animation:cue-ar 3s both}
@keyframes cue-ar{0%,100%{transform:none}8%,32%{transform:rotate(-120deg)}40%,46%{transform:rotate(-172deg)}52%{transform:rotate(-20deg)}60%,90%{transform:rotate(-72deg)}}
.m-cuelgue .fore-r{animation:cue-fr 3s both}
@keyframes cue-fr{0%,100%{transform:none}8%,32%{transform:rotate(-55deg)}40%,46%{transform:rotate(-30deg)}52%{transform:rotate(10deg)}60%,90%{transform:none}}
.m-cuelgue .arm-l{animation:cue-al 3s both}
@keyframes cue-al{0%,100%{transform:none}8%,32%{transform:rotate(32deg)}40%,46%{transform:rotate(60deg)}60%,90%{transform:rotate(32deg)}}
.m-cuelgue .fore-l{animation:cue-fl 3s both}
@keyframes cue-fl{0%,100%{transform:none}8%,32%{transform:rotate(-112deg)}40%,46%{transform:none}60%,90%{transform:rotate(-112deg)}}
.m-cuelgue .head{animation:cue-hd 3s both}
@keyframes cue-hd{0%,100%{transform:none}8%,20%,32%{transform:rotate(10deg)}14%,26%{transform:rotate(15deg) translateY(2px)}36%{transform:rotate(-8deg)}64%,90%{transform:rotate(-10deg)}}
.m-cuelgue .rig{animation:cue-rig 3s both}
@keyframes cue-rig{0%,32%{transform:translate(0,0) rotate(0) rotateY(0)}36%{transform:translate(0,-9%) rotate(0) rotateY(0)}40%,46%{transform:translate(0,0) rotate(calc(var(--dir)*-7deg)) rotateY(0)}52%{transform:translate(calc(var(--dir)*7%),0) rotate(calc(var(--dir)*7deg)) rotateY(0)}56%{transform:translate(0,-16%) rotate(0) rotateY(0)}66%{transform:translate(0,-16%) rotate(0) rotateY(720deg)}72%{transform:translate(0,3%) rotate(0) rotateY(720deg)}78%,100%{transform:translate(0,0) rotate(0) rotateY(720deg)}}
.m-cuelgue .upper{animation:cue-up 3s both}
@keyframes cue-up{0%,60%,100%{transform:none}40%,46%{transform:rotate(-15deg)}52%{transform:rotate(15deg)}}

/* Breakdance de campeonato */
.m-breakdance .rig{animation:brk-rig 3.4s both}
@keyframes brk-rig{0%{transform:translate(0,0) rotate(0) rotateY(0)}4%{transform:translate(calc(var(--dir)*-4%),0) rotate(0) rotateY(0)}8%{transform:translate(calc(var(--dir)*4%),0) rotate(0) rotateY(0)}12%{transform:translate(0,14%) rotate(0) rotateY(0)}18%,22%{transform:translate(0,-17%) rotate(180deg) rotateY(0)}50%{transform:translate(0,-17%) rotate(180deg) rotateY(1800deg)}56%{transform:translate(0,-32%) rotate(360deg) rotateY(1800deg)}62%{transform:translate(0,8%) rotate(calc(360deg + var(--dir)*-55deg)) rotateY(1800deg)}64%,86%{transform:translate(0,10%) rotate(calc(360deg + var(--dir)*-62deg)) rotateY(1800deg)}100%{transform:translate(0,0) rotate(360deg) rotateY(1800deg)}}
.m-breakdance .leg-l{animation:brk-ll 3.4s both}
@keyframes brk-ll{0%,100%{transform:none}4%{transform:rotate(-20deg)}8%{transform:rotate(10deg)}18%,50%{transform:rotate(40deg)}26%,42%{transform:rotate(62deg)}34%{transform:rotate(18deg)}62%,86%{transform:rotate(-60deg)}}
.m-breakdance .leg-r{animation:brk-lr 3.4s both}
@keyframes brk-lr{0%,100%{transform:none}4%{transform:rotate(-10deg)}8%{transform:rotate(20deg)}18%,50%{transform:rotate(-40deg)}26%,42%{transform:rotate(-18deg)}34%{transform:rotate(-62deg)}62%,86%{transform:rotate(22deg)}}
.m-breakdance .arm-l{animation:brk-al 3.4s both}
@keyframes brk-al{0%,100%{transform:none}14%,52%{transform:rotate(150deg)}62%,86%{transform:rotate(150deg)}}
.m-breakdance .fore-l{animation:brk-fl 3.4s both}
@keyframes brk-fl{0%,100%{transform:none}14%,52%{transform:rotate(-60deg)}62%,86%{transform:rotate(-20deg)}}
.m-breakdance .arm-r{animation:brk-ar 3.4s both}
@keyframes brk-ar{0%,100%{transform:none}14%,52%{transform:rotate(-150deg)}62%,86%{transform:rotate(12deg)}}
.m-breakdance .fore-r{animation:brk-fr 3.4s both}
@keyframes brk-fr{0%,100%{transform:none}14%,52%{transform:rotate(60deg)}62%,86%{transform:none}}
.m-breakdance .head{animation:brk-hd 3.4s both}
@keyframes brk-hd{0%,58%,100%{transform:none}64%,86%{transform:rotate(-12deg)}}

/* Salto de split */
.m-split .rig{animation:spl-rig 3s both}
@keyframes spl-rig{0%{transform:translateY(0) scale(1)}12%{transform:translateY(6%) scale(1.04,.93)}26%{transform:translateY(-40%) scale(1)}36%{transform:translateY(20%) scale(1)}40%{transform:translateY(17%) scale(1)}44%,74%{transform:translateY(20%) scale(1)}80%{transform:translateY(-6%) scale(1)}90%,100%{transform:translateY(0) scale(1)}}
.m-split .leg-l{animation:spl-ll 3s both}
@keyframes spl-ll{0%,12%,92%,100%{transform:none}24%,28%{transform:rotate(86deg)}36%,76%{transform:rotate(88deg)}}
.m-split .leg-r{animation:spl-lr 3s both}
@keyframes spl-lr{0%,12%,92%,100%{transform:none}24%,28%{transform:rotate(-86deg)}36%,76%{transform:rotate(-88deg)}}
.m-split .arm-l{animation:spl-al 3s both}
@keyframes spl-al{0%,100%{transform:none}12%{transform:rotate(-20deg)}24%,28%{transform:rotate(82deg)}36%,76%{transform:rotate(150deg)}}
.m-split .arm-r{animation:spl-ar 3s both}
@keyframes spl-ar{0%,100%{transform:none}12%{transform:rotate(20deg)}24%,28%{transform:rotate(-82deg)}36%,76%{transform:rotate(-150deg)}}
.m-split .fore-l{animation:spl-fl 3s both}
@keyframes spl-fl{0%,40%,76%,100%{transform:none}44%,52%,60%,68%{transform:rotate(-32deg)}48%,56%,64%,72%{transform:rotate(26deg)}}
.m-split .fore-r{animation:spl-fr 3s both}
@keyframes spl-fr{0%,40%,76%,100%{transform:none}44%,52%,60%,68%{transform:rotate(32deg)}48%,56%,64%,72%{transform:rotate(-26deg)}}
.m-split .upper{animation:spl-up 3s both}
@keyframes spl-up{0%,40%,76%,100%{transform:none}44%,52%,60%,68%{transform:rotate(-7deg)}48%,56%,64%,72%{transform:rotate(7deg)}}

/* Guitarra de aire */
.m-guitarra .tp-gtr{opacity:.9}
.m-guitarra .rig{animation:gui-rig 3.2s both}
@keyframes gui-rig{0%{transform:translate(0,0)}8%{transform:translate(0,3%)}20%{transform:translate(calc(var(--dir)*34%),19%)}28%,84%{transform:translate(calc(var(--dir)*42%),19%)}94%{transform:translate(calc(var(--dir)*12%),0)}100%{transform:translate(0,0)}}
.m-guitarra .leg-l,.m-guitarra .leg-r{animation:gui-leg 3.2s both}
@keyframes gui-leg{0%,8%,94%,100%{transform:none}18%,86%{transform:rotate(80deg)}}
.m-guitarra .upper{animation:gui-up 3.2s both}
@keyframes gui-up{0%,100%{transform:none}20%{transform:rotate(-22deg)}28%,36%,44%,52%,60%,68%,76%{transform:rotate(-26deg)}32%,40%,48%,56%,64%,72%,80%{transform:rotate(-6deg)}86%{transform:rotate(-16deg)}}
.m-guitarra .head{animation:gui-hd 3.2s both}
@keyframes gui-hd{0%,24%,90%,100%{transform:none}28%,36%,44%,52%,60%,68%,76%{transform:rotate(-15deg)}32%,40%,48%,56%,64%,72%,80%{transform:rotate(17deg) translateY(3px)}}
.m-guitarra .arm-l{animation:gui-al 3.2s both}
@keyframes gui-al{0%,100%{transform:none}20%,86%{transform:rotate(62deg)}}
.m-guitarra .fore-l{animation:gui-fl 3.2s both}
@keyframes gui-fl{0%,100%{transform:none}20%,86%{transform:rotate(-24deg)}}
.m-guitarra .arm-r{animation:gui-ar 3.2s both}
@keyframes gui-ar{0%,100%{transform:none}20%,86%{transform:rotate(36deg)}}
.m-guitarra .fore-r{animation:gui-fr 3.2s both}
@keyframes gui-fr{0%,20%,90%,100%{transform:none}24%,30%,36%,42%,48%,54%,60%,66%,72%,78%,84%{transform:rotate(82deg)}27%,33%,39%,45%,51%,57%,63%,69%,75%,81%{transform:rotate(28deg)}}

/* Paso de cumbia */
.m-cumbia .leg-l{animation:cum-ll 3s both}
@keyframes cum-ll{0%,100%{transform:none}8%,33%,58%,83%{transform:rotate(24deg)}20%,45%,70%,95%{transform:rotate(-4deg)}}
.m-cumbia .leg-r{animation:cum-lr 3s both}
@keyframes cum-lr{0%,100%{transform:none}8%,33%,58%,83%{transform:rotate(4deg)}20%,45%,70%,95%{transform:rotate(-24deg)}}
.m-cumbia .rig{animation:cum-rig 3s both}
@keyframes cum-rig{0%,100%{transform:translate(0,0) rotate(0) rotateY(0)}8%,33%{transform:translate(calc(var(--dir)*-7%),0) rotate(calc(var(--dir)*-5deg)) rotateY(0)}20%,45%{transform:translate(calc(var(--dir)*7%),0) rotate(calc(var(--dir)*5deg)) rotateY(0)}58%{transform:translate(0,-10%) rotate(0) rotateY(0)}70%{transform:translate(0,-10%) rotate(0) rotateY(360deg)}83%{transform:translate(calc(var(--dir)*-7%),0) rotate(calc(var(--dir)*-5deg)) rotateY(360deg)}95%{transform:translate(calc(var(--dir)*7%),0) rotate(calc(var(--dir)*5deg)) rotateY(360deg)}}
.m-cumbia .upper{animation:cum-up .375s ease-in-out 8 alternate both}
@keyframes cum-up{from{transform:rotate(-9deg)}to{transform:rotate(9deg)}}
.m-cumbia .arm-r{animation:cum-ar 3s both}
@keyframes cum-ar{0%,100%{transform:none}8%,92%{transform:rotate(-150deg)}}
.m-cumbia .fore-r{animation:cum-fr .375s ease-in-out 8 alternate both}
@keyframes cum-fr{from{transform:rotate(-40deg)}to{transform:rotate(40deg)}}
.m-cumbia .arm-l{animation:cum-al 3s both}
@keyframes cum-al{0%,100%{transform:none}8%,92%{transform:rotate(32deg)}}
.m-cumbia .fore-l{animation:cum-fl 3s both}
@keyframes cum-fl{0%,100%{transform:none}8%,92%{transform:rotate(-112deg)}}

/* Seis-siete supremo */
.m-seisiete .arm-l{animation:ss-al 2.8s both}
@keyframes ss-al{0%,100%{transform:none}8%,90%{transform:rotate(-15deg)}}
.m-seisiete .arm-r{animation:ss-ar 2.8s both}
@keyframes ss-ar{0%,100%{transform:none}8%,90%{transform:rotate(15deg)}}
.m-seisiete .fore-l{animation:ss-fl 2.8s both}
@keyframes ss-fl{0%,100%{transform:none}10%,26%,42%,74%{transform:rotate(112deg)}18%,34%,50%,82%{transform:rotate(68deg)}58%,66%{transform:rotate(90deg)}}
.m-seisiete .fore-r{animation:ss-fr 2.8s both}
@keyframes ss-fr{0%,100%{transform:none}10%,26%,42%,74%{transform:rotate(-68deg)}18%,34%,50%,82%{transform:rotate(-112deg)}58%,66%{transform:rotate(-90deg)}}
.m-seisiete .rig{animation:ss-rig 2.8s both}
@keyframes ss-rig{0%,100%{transform:none}10%,26%,42%{transform:translateY(-5%) rotate(calc(var(--dir)*-4deg))}18%,34%,50%{transform:translateY(0) rotate(calc(var(--dir)*4deg))}58%,66%{transform:translateY(0) rotate(0)}74%{transform:translateY(-22%) rotate(0)}82%{transform:translateY(2%) rotate(0)}90%{transform:none}}
.m-seisiete .head{animation:ss-hd 2.8s both}
@keyframes ss-hd{0%,100%{transform:none}10%,26%,42%{transform:rotate(-11deg)}18%,34%,50%{transform:rotate(11deg)}58%,66%{transform:none}}
.m-seisiete .leg-l{animation:ss-ll 2.8s both}
@keyframes ss-ll{0%,100%{transform:none}10%,90%{transform:rotate(9deg)}74%{transform:rotate(26deg)}}
.m-seisiete .leg-r{animation:ss-lr 2.8s both}
@keyframes ss-lr{0%,100%{transform:none}10%,90%{transform:rotate(-9deg)}74%{transform:rotate(-26deg)}}

/* Creator */
.ptabs{display:grid;grid-template-columns:1fr 1fr;gap:8px;margin-bottom:12px}
.ptab{display:flex;flex-direction:column;align-items:flex-start;gap:1px;text-align:left;border:2px solid var(--line);background:var(--surface-2);border-radius:16px;padding:9px 12px;min-width:0}
.ptab:hover{border-color:var(--sky)}
.ptab[aria-selected="true"]{border-color:var(--sky);background:var(--pick-bg);box-shadow:0 0 0 3px rgba(61,174,228,.2)}
.pt-role{font-family:var(--display);font-weight:600;font-size:17px;line-height:1.2;color:var(--ink)}
.scene{position:absolute;inset:0;z-index:0;pointer-events:none}
.scene svg{width:100%;height:100%;display:block}
.stage:not([data-scene="teatro"]) .wall,.stage:not([data-scene="teatro"]) .floor{display:none}
.stage.day .spot,.stage.day .spot.on{opacity:0}
.stage.day .neon{background:rgba(28,39,66,.82)}
.stage.cine.epic .scene{animation:wallhue 1.6s linear infinite}
.scene-pick{margin:0 0 6px}
.tiles.scenes{grid-template-columns:repeat(auto-fill,minmax(118px,1fr))}
.tile.scene-tile .tv{aspect-ratio:16/10}
.pt-name{font-family:var(--display);font-weight:600;font-size:18px;line-height:1.2;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;max-width:100%}
.pt-name.empty{color:var(--ink-2);font-family:var(--body);font-weight:700;font-style:italic;font-size:14.5px}
.ed-actions{display:flex;gap:8px;flex-wrap:wrap;margin:0 0 12px}
.chipbtn{border:2px solid var(--line);background:var(--surface);border-radius:999px;padding:7px 14px;font-weight:800;font-size:15px}
.chipbtn:hover{border-color:var(--sky)}
.ctabs{display:flex;gap:6px;overflow-x:auto;padding:2px 2px 8px;margin:0 -2px 8px;scrollbar-width:thin}
.ctab{flex:0 0 auto;border:2px solid var(--line);background:var(--surface-2);border-radius:999px;padding:6px 13px;font-weight:800;font-size:14.5px;white-space:nowrap}
.ctab:hover{border-color:var(--sky)}
.ctab[aria-selected="true"]{background:var(--btn);border-color:var(--btn);color:var(--btn-ink)}
.cpanel{min-height:200px}
.csec{margin-bottom:16px}
.csec h4{margin:0 0 8px;font-size:14px;font-weight:800;color:var(--ink-2)}
.tiles{display:grid;grid-template-columns:repeat(auto-fill,minmax(76px,1fr));gap:8px}
.tile{display:flex;flex-direction:column;align-items:center;gap:3px;border:2px solid var(--line);background:var(--surface-2);border-radius:14px;padding:5px 4px 6px;min-width:0}
.tile:hover{border-color:var(--sky)}
.tile[aria-pressed="true"]{border-color:var(--sky);background:var(--pick-bg);box-shadow:0 0 0 3px rgba(61,174,228,.22)}
.tile .tv{width:100%;aspect-ratio:1;border-radius:10px;background:radial-gradient(80% 90% at 50% 100%,#3A5689,#22345A);display:block;overflow:hidden}
.tile .tv svg{width:100%;height:100%;display:block}
.tile .tv svg *{animation:none!important}
.tile .tn{font-size:12px;font-weight:800;line-height:1.15;text-align:center;color:var(--ink)}
.swatches{display:flex;flex-wrap:wrap;gap:8px}
.sw{width:34px;height:34px;border-radius:50%;border:3px solid var(--surface);background:var(--c);box-shadow:0 0 0 1.5px var(--line);padding:0}
.sw[aria-pressed="true"]{box-shadow:0 0 0 3px var(--sky)}
.err{color:var(--bad);font-weight:800;min-height:1.3em;margin:4px 0 8px;font-size:15px}
.setup-foot{border-top:1px dashed var(--line);padding-top:14px;margin-top:4px}
@media (max-width:979px){
  body.in-setup .stage-col{position:sticky;top:env(safe-area-inset-top,0px);z-index:20;background:var(--bg);padding:6px 0 8px;margin:-6px 0 0}
  body.in-setup .stage{height:clamp(200px,32vh,300px)}
}
@media (max-width:560px){.tiles{grid-template-columns:repeat(auto-fill,minmax(66px,1fr));gap:6px}.tile .tn{font-size:11px}.sw{width:32px;height:32px}}

/* Panels */
.panel{background:var(--surface);border-radius:24px;padding:22px 22px 24px;border:1px solid var(--line)}
@media (max-width:560px){.panel{padding:18px 16px 20px;border-radius:20px}}
.panel h2{font-family:var(--display);font-weight:600;font-size:23px;line-height:1.15;margin:0 0 4px}
.panel h3{font-family:var(--display);font-weight:600;font-size:19px;margin:0 0 8px}
.muted{color:var(--ink-2)}
.setup-block{padding:4px 0 18px}
.setup-block + .setup-block{border-top:1px dashed var(--line);padding-top:18px}
.field{display:block;margin:8px 0 12px}
.field span{display:block;font-weight:700;font-size:14px;color:var(--ink-2);margin-bottom:4px}
.field input,.word-input{width:100%;border:2px solid var(--line);background:var(--surface-2);border-radius:14px;padding:10px 14px;font-size:17px;font-weight:700}
.field input:focus,.word-input:focus{border-color:var(--sky);outline:none;box-shadow:0 0 0 4px rgba(61,174,228,.2)}
.seg{display:flex;flex-wrap:wrap;gap:8px;margin:6px 0 16px;border:0;padding:0}
.seg legend{font-weight:700;font-size:14px;color:var(--ink-2);margin-bottom:6px;padding:0}
.seg label{position:relative}
.seg input{position:absolute;opacity:0;inset:0;cursor:pointer}
.seg span{display:inline-block;border:2px solid var(--line);border-radius:999px;padding:7px 14px;font-weight:700;font-size:15px;background:var(--surface-2)}
.seg input:checked + span{border-color:var(--sky);background:var(--pick-bg)}
.seg input:focus-visible + span{outline:3px solid var(--sky);outline-offset:2px}
.btn{display:inline-flex;align-items:center;justify-content:center;gap:8px;border:0;border-radius:16px;padding:13px 22px;font-family:var(--display);font-weight:600;font-size:19px;background:var(--btn);color:var(--btn-ink);transition:transform .12s,filter .2s}
.btn:hover{filter:brightness(1.08)}
.btn:active{transform:scale(.97)}
.btn.wide{width:100%}
.btn.alt{background:var(--btn-2);color:var(--btn-2-ink);border:2px solid var(--line)}
.btn:disabled{opacity:.5;cursor:default}
.howto{margin-top:18px;display:grid;gap:10px}
.howto p{margin:0;font-size:15px;color:var(--ink-2)}
.howto b{color:var(--ink)}
details.dict{margin-top:16px;border-top:1px dashed var(--line);padding-top:12px}
details.dict summary{font-weight:800;cursor:pointer}
details.dict dl{margin:10px 0 0;font-size:15px}
details.dict dt{font-weight:800;margin-top:8px}
details.dict dd{margin:0;color:var(--ink-2)}

/* Round */
.turn-head{display:flex;align-items:baseline;flex-wrap:wrap;gap:4px 10px;margin-bottom:10px}
.turn-head .tw{font-family:var(--display);font-weight:600;font-size:24px;line-height:1.1;margin:0}
.turn-head .tc{font-size:14px;color:var(--ink-2);font-weight:700}
.roulette{display:inline-flex;align-items:center;gap:8px;background:var(--chip);color:var(--chip-ink);border-radius:999px;padding:7px 16px;font-family:var(--display);font-weight:600;font-size:18px;min-width:12ch}
.roulette.spinning{filter:saturate(1.3)}
.roulette.landed{animation:land .45s cubic-bezier(.3,1.6,.5,1)}
@keyframes land{40%{transform:scale(1.12)}}
.round{margin-top:14px}
.theme-chip{display:inline-block;font-size:13px;font-weight:800;color:var(--chip-ink);background:var(--chip);border-radius:999px;padding:3px 11px;margin-bottom:8px}
.situation{font-size:19px;line-height:1.42;font-weight:700;margin:0 0 14px}
.options{display:grid;gap:9px}
.opt{display:flex;align-items:center;gap:10px;text-align:left;width:100%;border:2px solid var(--line);background:var(--surface-2);border-radius:16px;padding:12px 14px;font-weight:700;font-size:16px;line-height:1.35;transition:border-color .2s,background .2s,opacity .3s}
.opt:hover:not(:disabled){border-color:var(--sky)}
.opt .ov{margin-left:auto;font-family:var(--display);font-weight:600;font-size:15px;white-space:nowrap;opacity:0;transition:opacity .3s}
.options.revealed .ov{opacity:1}
.options.revealed .opt{cursor:default}
.options.revealed .opt:not(.chosen){opacity:.62}
.opt.chosen{border-color:var(--sky);background:var(--pick-bg);opacity:1}
.ov.up{color:var(--good)}.ov.down{color:var(--bad)}
.opt.right{border-color:var(--good)}
.opt.wrong{border-color:var(--bad)}
.bigword{font-family:var(--display);font-weight:700;font-size:clamp(34px,5vw,48px);line-height:1;margin:6px 0 10px;color:var(--ink)}
.word-row{display:flex;gap:8px}
.word-row .btn{padding:10px 16px;font-size:17px;white-space:nowrap}
.ideas{display:flex;flex-wrap:wrap;align-items:center;gap:6px;margin-top:10px;font-size:14px;color:var(--ink-2);font-weight:700}
.idea{border:2px dashed var(--line);background:transparent;border-radius:999px;padding:3px 11px;font-weight:700;font-size:14px;color:var(--ink)}
.idea:hover{border-color:var(--sky)}
.small-note{font-size:13px;color:var(--ink-2);margin:10px 0 0}
.thinking{font-weight:700;color:var(--ink-2);margin:12px 0 0}
.thinking::after{content:"";display:inline-block;width:1.2em;text-align:left;animation:dots 1.2s steps(4) infinite}
@keyframes dots{0%{content:""}25%{content:"."}50%{content:".."}75%{content:"..."}}

.result{margin-top:16px;display:flex;align-items:baseline;gap:12px;flex-wrap:wrap}
.result .delta{font-family:var(--display);font-weight:700;font-size:38px;line-height:1}
.result .delta.up{color:var(--good)}.result .delta.down{color:var(--bad)}
.result p{margin:0;flex:1 1 220px;font-weight:700}
.said{margin:14px 0 0;padding:10px 14px;border-radius:14px;background:var(--surface-2);border:1px solid var(--line)}
.said .lbl{display:block;font-size:13px;font-weight:800;color:var(--ink-2)}
.said q,.said .tx{font-weight:700}
.dato{margin-top:14px;padding:12px 14px;border-left:5px solid var(--sky);background:var(--surface-2);border-radius:6px 14px 14px 6px;font-size:15.5px}
.dato .lbl,.talk .lbl{display:block;font-family:var(--display);font-weight:600;font-size:15px;margin-bottom:2px}
.dato .lbl{color:var(--chip-ink)}
.talk{margin-top:12px;padding:12px 14px;background:var(--talk);border:2px solid var(--talk-line);border-radius:16px;color:var(--ink);font-size:16px;font-weight:700}
.talk .lbl{color:var(--talk-ink)}
.vote{margin-top:16px;padding:14px;border-radius:18px;border:2px solid var(--sky);background:var(--pick-bg)}
.vote p{margin:0 0 4px;font-weight:800;font-size:17px}
.vote .sub{font-weight:600;font-size:14.5px;color:var(--ink-2);margin-bottom:10px}
.vote-btns{display:flex;gap:8px;flex-wrap:wrap}
.vote-btns .btn{flex:1 1 140px;font-size:17px;padding:11px 14px}
.next-row{margin-top:18px}

/* End */
.end-tiles{display:grid;grid-template-columns:1fr 1fr;gap:10px;margin:14px 0}
.tile{border:2px solid var(--line);border-radius:18px;padding:10px 14px;background:var(--surface-2)}
.tile.win{border-color:var(--sun)}
.tile .nm{font-family:var(--display);font-weight:600;font-size:18px}
.tile .v{font-family:var(--display);font-weight:700;font-size:28px;line-height:1.1}
.family{padding:12px 14px;border-radius:16px;background:var(--chip);color:var(--ink);font-weight:700;margin-bottom:6px}
.family b{font-family:var(--display);font-size:22px}
.endsec{margin-top:18px}
.chips{display:flex;flex-wrap:wrap;gap:6px}
.wchip{border:2px solid var(--line);background:var(--surface-2);border-radius:999px;padding:4px 12px;font-weight:800;font-size:14.5px}
.wchip[aria-expanded="true"]{border-color:var(--sky);background:var(--pick-bg)}
.wdef{margin:8px 0 0;font-size:15px;color:var(--ink-2);min-height:1.2em}
.qlist,.retos{margin:6px 0 0;padding-left:1.1em}
.qlist li,.retos li{margin:6px 0;font-size:15.5px}
.qlist li b{font-weight:800}
.golden{margin-top:18px;padding:14px 16px;border-radius:18px;background:var(--night);color:#fff;font-weight:700}
.golden .lbl{display:block;font-family:var(--display);font-weight:600;color:var(--sun);font-size:16px}
.end-btns{display:flex;gap:10px;flex-wrap:wrap;margin-top:18px}
.end-btns .btn{flex:1 1 180px}

.foot{margin-top:28px;font-size:14px;color:var(--ink-2);text-align:center}

@media (prefers-reduced-motion: reduce){
  .cs .body-all,.cs .eyes,.cs .steam,.walking .leg-l,.walking .leg-r,.walking .arm-l,.walking .arm-r,.audience .person,.audience .hl,.audience .hr,.aura-fx::after,.title .ch{animation:none!important}
  .actor{transition-duration:.01s}
  .confetti{display:none}
}
</style>
</head>
<body>
<div class="wrap">
  <header class="topbar">
    <span class="logo-chip"><img src="data:image/png;base64,/9j/4AAQSkZJRgABAgAAAQABAAD/wAARCAEYAtgDACIAAREBAhEB/9sAQwAIBgYHBgUIBwcHCQkICgwUDQwLCwwZEhMPFB0aHx4dGhwcICQuJyAiLCMcHCg3KSwwMTQ0NB8nOT04MjwuMzQy/9sAQwEJCQkMCwwYDQ0YMiEcITIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIy/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMAAAERAhEAPwD3+iiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoorO1DXdO0vi5uVEn/ADzX5m/IdPxppNuyFKSirydkaNFcXdeP0BItLFmH96V8foP8az28eamT8sFoo/3WP/s1dCwddq/Kcksww0XZy/M9Eorz6Lx9fg/vbS2Yf7O5f6mtaz8d2ExC3UEtuT/EPnUflz+lEsJWiruIRx+Gk7KX6fmdXRUFreW17EJbWdJU9UOcfX0qeuZq2jOtNNXQUUUUDCiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigApk00dvC8srqkaDLMxwAKcSFUkkADkk9q808T+IX1a5NvAxFnGflx/y0P94/0rahQlWlyo58TiYYeHNL5It654znumaDTS0MHQy9Hf6eg/WuUJLEkkknkk0lFe9SoQpK0UfMV8TUryvN/5BRRRWpgFFFFAE9pe3NjOJrWZ4pB3U9fr613/AIf8Wxaky2t5tiujwrDhZP8AA+1ec0A4OR1rnr4eFZa79zqw2LqYd+7t2PbaK5bwl4iOoR/Ybt83MY+Rz/y0Uf1FdTXhVaUqUuWR9PRrQrQU4bBRRRWZqFFFFABRRRQAUUUUAFFFFABRRWZquq/YNscahpWGeegFZ1asKUHObskVCEpy5Y7mnRXKf29ff3k/75o/t6+/vJ/3zXmf23hO7+46vqNY6uiuU/t6+/vJ/wB80f29ff3k/wC+aP7bwnd/cH1GsdXRXKf29ff3k/75o/t6+/vJ/wB80f23hO7+4PqNY6uiuU/t6+/vJ/3zV/Tdcee4WC5VcucK6jHPvV084wtSSina/dEywdWKvY3KKKK9Q5QooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAOW8basbSwWxibEtwDvx1Cf/AF+n5153Wt4kvTfa/dSZyiN5afReP8T+NZNe/g6Sp0l3ep8tmFd1a7XRaBRRRXUcQUUUUAFFFFABRRRQBLbXEtpcx3ELbZI2DKfevXtNvo9S06C7j6SLkj0PcfnXjld14BvS0N1YsfuE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E+mOtfTHw+8PT+GvCFrY3eBdMWmmUHO1m7fgMD6104VQxYAZPU4pa0qVudWsTGFnczfEGl/234e1DTA4RrmBo1Y9AxHBP44r5W1PSb/Rr6Sy1C1kt50OCrjGfcHuPcV9d0hVWxkA45GR0pU6vIEocx5D8GfC19Yz3Wu3sDwRyw+RbrIMFwWDFsenyjHrzXr9FFTObm7jjHlVipqemWesadNYX8CzW0owyN/MehHrXg3i34T6vokslxpSSajp/UbBmWMejKOv1H5CvoSinCo4bBKKkfHLo0blHUqynBUjBBpK+uL/AEPSdUOb/TLO6PrNCrn8yKoR+CfC8Um9NA07d1+aBSPyNdCxEeqM/ZM+atE8Oav4iuRBpdjLcHOGcDCJ/vMeBXqh+Da2vgy8QSLc686h0YHCLg5KLn1GRk+3QZr1yGGK3iWKGNI414VEUAD6AU+s5V29ilTS3Pj+ezurW7a1nt5YrhW2mJ0IYH0x1r3z4ReGL3QNCurvUImgnv3VhC4wyooOMjsTuPH0r0MqpYMQMjocUtKdfmjawRp2dynqml2Ws6dNYahAs9tKMMjfzB7EeteF+KfhDrGlSyT6OrajZckKuPOQehX+L6j8hX0BRUQqShsVKKkfHtxbT2kzQ3MMkMq9UkUqw/A1FX1/d2Nnfx+XeWsFwn92aMOPyNZD+B/C0jbm0DTwf9mBVH5Ct1iF1Rm6TPlhVZ2CqCzE4AAyTXfeEvhVrGuzRz6lHJp2n5BZpBiWQeiqen1P617xYaFpGlnNhplnat/ehgVT+YGa0KUsR/Khqn3KmmabaaPp0NhYwrDbQrtRF/mfUnrmrdFFcrdzUKKKKACiiigAooooAKKKKACiiigAooooAKhubS2vYDBdW8U8TdUlQMp/A1NRQBwusfCTwtqm54LeXT5Tzutnwuf905GPpit/wn4f/wCEX8OwaSLn7QIWciTZtyGYt0yfWtuiqc5NWbEopO6CiiipGFFFFABRRRQAVleJNH/4SDw9eaUJ/I+0oE8zbu28g9MjPStWihOwHAaP8H/DOm7Xu0m1GUc5nfamfZVx+ua7ezsLPToBBZWsNtEOiQxhB+QqxRVSnKW7EopbBRRRUjCiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAP/2Q==" alt="Tecnofamilias" width="88" height="34"></span>
    <div class="top-actions">
      <button type="button" id="soundBtn" class="icon-btn" aria-pressed="true"><span aria-hidden="true">🔊</span><span class="lbl">Sonido</span></button>
    </div>
  </header>

  <section class="intro" id="intro">
    <h1 class="title" id="title" aria-label="Farmea aura">Farmea aura</h1>
    <p class="lede">Un duelo de risas entre generaciones para aprender a cuidarse en internet. Diseña tu personaje, ponle tu nombre y que empiece la batalla de aura.</p>
    <p class="def"><b>Farmear aura</b> es hacer algo tan genial que todos te respetan. <b>Perder aura</b> es hacer el oso. Aquí se gana aura cuidándose en línea, y se gana más hablando en familia.</p>
  </section>

  <div class="arena">
    <div class="stage-col">
      <div class="scorebar" id="scorebar" hidden>
        <div class="score p0" id="score0"><div class="who"><div class="nm"></div><div class="cn"></div></div><div class="pts"><span class="num">0</span><small>aura</small></div></div>
        <div class="turninfo"><span>Turno <b id="turnNum">1</b> de <span id="turnTot">10</span></span><button type="button" class="linkish" id="endNow">Terminar</button></div>
        <div class="score p1" id="score1"><div class="who"><div class="nm"></div><div class="cn"></div></div><div class="pts"><span class="num">0</span><small>aura</small></div></div>
      </div>
      <div class="stage" id="stage" data-scene="teatro" role="img" aria-label="Escenario: los dos personajes frente a frente, con público">
        <div class="cam" id="cam">
          <div class="wall"></div>
          <div class="scene" id="scene"></div>
          <div class="spot s0" id="spot0"></div>
          <div class="spot s1" id="spot1"></div>
          <div class="neon" id="neon">farmea aura</div>
          <div class="floor"></div>
          <div class="backfx" id="backfx"><div class="speed" id="speed"></div></div>
          <div class="actor a0 off" id="actor0"><div class="rig"><div class="aura-fx"></div><div class="crown">👑</div><div class="char"></div></div></div>
          <div class="actor a1 kid off" id="actor1"><div class="rig"><div class="aura-fx"></div><div class="crown">👑</div><div class="char"></div></div></div>
        </div>
        <div class="bubble b0" id="bubble0"></div><div class="bubble-tail" id="tail0"></div>
        <div class="bubble b1" id="bubble1"></div><div class="bubble-tail" id="tail1"></div>
        <div class="audience" id="audience"></div>
        <div class="lb lb-t"></div><div class="lb lb-b"></div>
        <div class="movecard" id="movecard"></div>
        <div class="flashov" id="flashov"></div>
        <div class="fx" id="fx"></div>
      </div>
    </div>

    <div class="side">
      <section class="panel setup" id="setupPanel" aria-label="Diseña tu personaje">
        <div class="ptabs" role="tablist" aria-label="Jugadores">
          <button type="button" class="ptab" id="ptab0" role="tab"><span class="pt-role">Jugador adulto</span></button>
          <button type="button" class="ptab" id="ptab1" role="tab"><span class="pt-role">Jugador chico o chica</span></button>
        </div>
        <label class="field"><span>Tu nombre</span><input id="pname" maxlength="16" autocomplete="off" placeholder="Escribe tu nombre"></label>
        <div class="ed-actions"><button type="button" class="chipbtn" id="randBtn">🎲 Sorpréndeme</button><button type="button" class="chipbtn" id="clearBtn">🧽 Empezar de cero</button><button type="button" class="chipbtn" id="tryBtn">💃 Probar un baile</button></div>
        <div class="ctabs" id="ctabs" role="tablist" aria-label="Partes del personaje"></div>
        <div class="cpanel" id="cpanel"></div>
        <div class="setup-foot">
          <div class="csec scene-pick"><h4>Escenario</h4><div class="tiles scenes" id="scenePicks"></div></div>
          <fieldset class="seg" id="lenSeg">
            <legend>Duración</legend>
            <label><input type="radio" name="len" value="6"><span>Rápida, 6 turnos</span></label>
            <label><input type="radio" name="len" value="10" checked><span>Normal, 10 turnos</span></label>
            <label><input type="radio" name="len" value="14"><span>Larga, 14 turnos</span></label>
          </fieldset>
          <p class="err" id="startErr" role="alert"></p>
          <button type="button" class="btn wide" id="startBtn">¡A farmear aura!</button>
        </div>
        <div class="howto">
          <p>🎨 <b>Diseña tu personaje.</b> Arranca en blanco: cada jugador le pone piel, peinado, ropa y accesorios, y escribe su nombre.</p>
          <p>🎲 <b>Situación sorpresa.</b> Sale un caso de la vida digital, eliges qué harías y tu personaje se lanza con un baile relacionado con el tema.</p>
          <p>✍️ <b>Tú pones la palabra.</b> Escribes una palabra y tu personaje la baila como la entienda. El otro jugador decide si farmeó aura.</p>
          <p>🔤 <b>Traductor generacional.</b> Adivinas qué significa una palabra de la otra generación.</p>
          <p>Después de cada turno aparece una pregunta para conversar. Ahí está el verdadero premio.</p>
        </div>
        <details class="dict" id="dictBox" hidden><summary id="dictSum">Diccionario familiar</summary><dl id="dictList"></dl></details>
      </section>

      <section class="panel" id="panel" hidden aria-live="polite"></section>
    </div>
  </div>

  <p class="foot">Tecnofamilias protege a las familias en el mundo digital. tecnofamilias.com</p>
</div>
<script>
const rpick = a => a[Math.floor(Math.random() * a.length)];

const shade = (hex, amt) => {
  let c = String(hex).replace('#', ''); if (c.length === 3) c = c.split('').map(x => x + x).join('');
  const n = parseInt(c, 16), r = n >> 16, g = (n >> 8) & 255, b = n & 255;
  const f = v => Math.max(0, Math.min(255, Math.round(amt < 0 ? v * (1 + amt) : v + (255 - v) * amt)));
  return '#' + [f(r), f(g), f(b)].map(v => v.toString(16).padStart(2, '0')).join('');
};
const isLight = hex => { const n = parseInt(String(hex).slice(1), 16); return (((n >> 16) * 299 + ((n >> 8) & 255) * 587 + (n & 255) * 114) / 1000) > 165; };

const PAL = {
  skin: [['#FCE3CF','Muy clara'],['#F5D2B5','Clara'],['#F1C7A5','Clara rosada'],['#E8B48A','Trigueña clara'],['#D9A07A','Trigueña'],['#C98B5E','Canela'],['#B97A50','Morena clara'],['#A8704C','Morena'],['#8D5A3B','Morena oscura'],['#6B4430','Oscura'],['#4E3022','Muy oscura']],
  hair: [['#1C1714','Negro'],['#3B2619','Castaño oscuro'],['#6B4226','Castaño'],['#9A6A3A','Castaño claro'],['#E3B85C','Rubio'],['#F1E3B8','Rubio platino'],['#C8642B','Pelirrojo'],['#A9A9A9','Canoso'],['#E8E8E8','Blanco'],['#F48FB1','Rosado'],['#8E5BD0','Morado'],['#3D7BE4','Azul'],['#6FD3B5','Menta']],
  cloth: [['#283A60','Azul marino'],['#3DAEE4','Azul cielo'],['#34558A','Jean'],['#FDBE30','Amarillo'],['#EF4A37','Rojo'],['#F48FB1','Rosado'],['#B79AD6','Lila'],['#6D4BA8','Morado'],['#2E9E6A','Verde'],['#7FCFB7','Menta'],['#8B6A4A','Café'],['#1F1A24','Negro'],['#9AA4B8','Gris'],['#F2F4F8','Blanco']]
};

const HAIR = {
  ninguno:{n:'Sin pelo'},
  rapado:{n:'Rapado', f:c=>`<path d="M41 52 Q40 26 70 26 Q100 26 99 52 Q97 38 86 35 Q70 31 54 35 Q43 38 41 52Z" fill="${c}" opacity=".88"/>`},
  calvo:{n:'Calvo', f:c=>`<path d="M42 50 Q38 58 42 67 M98 50 Q102 58 98 67" stroke="${c}" stroke-width="6" fill="none" stroke-linecap="round"/><ellipse cx="60" cy="35" rx="9" ry="4" fill="#fff" opacity=".22"/>`},
  corto:{n:'Corto', f:c=>`<path d="M40 54 Q38 25 70 24 Q102 25 100 54 Q98 38 86 36 Q76 30 64 35 Q50 34 40 54Z" fill="${c}"/>`},
  copete:{n:'Copete', f:c=>`<path d="M41 54 Q40 30 58 26 Q70 11 90 21 Q102 29 99 54 Q96 40 88 37 Q76 30 64 34 Q49 37 41 54Z" fill="${c}"/>`},
  hongo:{n:'Corte hongo', f:c=>`<path d="M37 60 Q33 22 70 21 Q107 22 103 60 Q100 51 94 49 Q88 53 82 48 Q76 53 70 48 Q64 53 58 48 Q52 53 46 49 Q40 51 37 60Z" fill="${c}"/>`},
  taper:{n:'Rizos con degradado', f:c=>`<path d="M41 56 Q40 46 44 40 M99 56 Q100 46 96 40" stroke="${c}" stroke-width="4" opacity=".45" fill="none" stroke-linecap="round"/><g fill="${c}"><circle cx="49" cy="38" r="8.5"/><circle cx="58" cy="30" r="10"/><circle cx="70" cy="27" r="10.5"/><circle cx="82" cy="30" r="10"/><circle cx="91" cy="38" r="8.5"/><circle cx="62" cy="40" r="6"/><circle cx="76" cy="40" r="6.5"/></g>`},
  mullet:{n:'Mullet', b:c=>`<path d="M40 56 Q38 94 54 99 Q70 103 86 99 Q102 94 100 56Z" fill="${c}"/>`, f:c=>`<path d="M41 52 Q40 27 70 25 Q100 27 99 52 Q93 40 84 42 Q78 33 70 40 Q62 33 56 42 Q47 40 41 52Z" fill="${c}"/>`},
  wolf:{n:'Wolf cut', b:c=>`<path d="M38 56 Q36 22 70 22 Q104 22 102 56 L104 82 L96 76 L98 90 L88 80 L90 66 L50 66 L52 80 L42 90 L44 76 L36 82Z" fill="${c}"/>`, f:c=>`<path d="M40 58 Q40 24 70 24 Q100 24 100 58 L96 46 L92 52 L88 42 L82 50 L76 40 L70 49 L64 40 L58 50 L52 42 L48 52 L44 46Z" fill="${c}"/>`},
  afro:{n:'Afro', b:c=>`<circle cx="70" cy="45" r="41" fill="${c}"/>`, f:c=>`<path d="M38 56 Q36 30 52 24 Q70 16 88 24 Q104 30 102 56 Q98 41 88 37 Q70 31 52 37 Q42 41 38 56Z" fill="${c}"/>`},
  rizos:{n:'Rizos', b:c=>`<g fill="${c}"><circle cx="44" cy="48" r="13"/><circle cx="52" cy="32" r="14"/><circle cx="70" cy="25" r="16"/><circle cx="88" cy="32" r="14"/><circle cx="96" cy="48" r="13"/><circle cx="40" cy="66" r="10"/><circle cx="100" cy="66" r="10"/></g>`, f:c=>`<g fill="${c}"><circle cx="54" cy="37" r="9"/><circle cx="66" cy="32" r="10"/><circle cx="78" cy="32" r="10"/><circle cx="88" cy="38" r="8.5"/></g>`},
  rizoslargos:{n:'Rizos largos', b:c=>`<g fill="${c}"><circle cx="48" cy="34" r="14"/><circle cx="70" cy="25" r="16"/><circle cx="92" cy="34" r="14"/><circle cx="40" cy="54" r="13"/><circle cx="100" cy="54" r="13"/><circle cx="37" cy="74" r="12"/><circle cx="103" cy="74" r="12"/><circle cx="40" cy="93" r="11"/><circle cx="100" cy="93" r="11"/><circle cx="45" cy="108" r="9"/><circle cx="95" cy="108" r="9"/></g>`, f:c=>`<g fill="${c}"><circle cx="54" cy="37" r="9"/><circle cx="66" cy="32" r="10"/><circle cx="78" cy="32" r="10"/><circle cx="88" cy="38" r="8.5"/></g>`},
  lisolargo:{n:'Liso largo', b:c=>`<path d="M38 56 Q36 22 70 22 Q104 22 102 56 L106 110 Q97 118 90 106 L91 70 L49 70 L50 106 Q43 118 34 110Z" fill="${c}"/>`, f:c=>`<path d="M40 58 Q38 26 70 25 Q100 25 100 52 Q86 35 66 36 Q50 40 40 58Z" fill="${c}"/>`},
  bob:{n:'Melena con flequillo', b:c=>`<path d="M37 58 Q35 22 70 22 Q105 22 103 58 L104 84 Q96 90 88 84 L90 66 L50 66 L52 84 Q44 90 36 84Z" fill="${c}"/>`, f:c=>`<path d="M40 56 Q40 25 70 25 Q100 25 100 56 Q99 47 94 47 L46 47 Q41 47 40 56Z" fill="${c}"/>`},
  cola:{n:'Cola alta', b:c=>`<path d="M86 30 Q119 22 113 66 Q108 46 94 40Z" fill="${c}"/>`, f:(c,a)=>`<path d="M40 57 Q40 25 70 26 Q100 26 100 54 Q90 34 74 40 Q60 34 40 57Z" fill="${c}"/><circle cx="90" cy="30" r="5.5" fill="${a}"/>`},
  mono:{n:'Moño alto', b:c=>`<circle cx="70" cy="20" r="12" fill="${c}"/>`, f:c=>`<path d="M40 58 Q37 25 70 25 Q103 25 100 58 Q97 37 70 36 Q43 37 40 58Z" fill="${c}"/>`},
  monitos:{n:'Dos moñitos', b:c=>`<g fill="${c}"><circle cx="49" cy="27" r="10.5"/><circle cx="91" cy="27" r="10.5"/></g>`, f:c=>`<path d="M40 58 Q38 25 70 25 Q102 25 100 58 Q96 36 80 38 L72 31 L64 38 Q46 38 40 58Z" fill="${c}"/>`},
  trenzas:{n:'Trenzas', b:c=>`<g fill="${c}"><ellipse cx="43" cy="80" rx="6" ry="9"/><ellipse cx="41" cy="96" rx="5.5" ry="8"/><ellipse cx="40" cy="110" rx="4.5" ry="6"/><ellipse cx="97" cy="80" rx="6" ry="9"/><ellipse cx="99" cy="96" rx="5.5" ry="8"/><ellipse cx="100" cy="110" rx="4.5" ry="6"/></g>`, f:c=>`<path d="M40 56 Q38 25 70 25 Q102 25 100 56 Q96 38 70 37 Q44 38 40 56Z" fill="${c}"/><path d="M70 26 L70 37" stroke="${shade(c,-.3)}" stroke-width="1.5"/>`},
  coletas:{n:'Coletas', b:c=>`<g fill="${c}"><ellipse cx="31" cy="60" rx="9" ry="17" transform="rotate(22 31 60)"/><ellipse cx="109" cy="60" rx="9" ry="17" transform="rotate(-22 109 60)"/></g>`, f:(c,a)=>`<path d="M40 56 Q38 25 70 25 Q102 25 100 56 Q96 38 70 37 Q44 38 40 56Z" fill="${c}"/><circle cx="38" cy="47" r="4" fill="${a}"/><circle cx="102" cy="47" r="4" fill="${a}"/>`},
  rastas:{n:'Rastas', b:c=>`<g stroke="${c}" stroke-width="6.5" stroke-linecap="round" fill="none"><path d="M42 48 L38 104"/><path d="M48 40 L45 110"/><path d="M92 40 L95 110"/><path d="M98 48 L102 104"/><path d="M55 34 L53 100"/><path d="M85 34 L87 100"/></g>`, f:c=>`<path d="M40 54 Q38 25 70 24 Q102 25 100 54 Q96 38 70 35 Q44 38 40 54Z" fill="${c}"/><g stroke="${c}" stroke-width="6" stroke-linecap="round"><path d="M46 44 L42 64"/><path d="M94 44 L98 64"/></g>`}
};

const BEARD = {
  ninguna:{n:'Sin barba'},
  bigote:{n:'Bigote', o:c=>`<path d="M54 67 Q62 58 70 64 Q78 58 86 67 Q78 72 70 68 Q62 72 54 67Z" fill="${c}"/>`},
  candado:{n:'Candado', u:c=>`<path d="M60 80 Q70 92 80 80 Q75 86 70 86 Q65 86 60 80Z" fill="${c}"/>`, o:c=>`<path d="M58 67 Q64 62 70 65 Q76 62 82 67 Q76 69.5 70 67.5 Q64 69.5 58 67Z" fill="${c}"/>`},
  corta:{n:'Barba corta', u:c=>`<path d="M42 62 Q44 91 70 92 Q96 91 98 62 Q95 77 86 81 Q78 86 70 86 Q62 86 54 81 Q45 77 42 62Z" fill="${c}" opacity=".42"/>`},
  completa:{n:'Barba completa', u:c=>`<path d="M42 60 Q43 95 70 96 Q97 95 98 60 Q95 77 86 81 Q78 86 70 86 Q62 86 54 81 Q45 77 42 60Z" fill="${c}"/>`, o:c=>`<path d="M57 67 Q64 61 70 65 Q76 61 83 67 Q76 70 70 68 Q64 70 57 67Z" fill="${c}"/>`},
  chivera:{n:'Chivera', u:c=>`<path d="M64 82 Q70 96 76 82 Q73 86 70 86 Q67 86 64 82Z" fill="${c}"/>`}
};

const DETAIL = {
  ninguno:{n:'Ninguno'},
  pecas:{n:'Pecas', u:()=>`<g fill="#B5643A" opacity=".55"><circle cx="54" cy="66" r="1.2"/><circle cx="57.5" cy="69" r="1.2"/><circle cx="51" cy="69" r="1.1"/><circle cx="86" cy="66" r="1.2"/><circle cx="82.5" cy="69" r="1.2"/><circle cx="89" cy="69" r="1.1"/></g>`},
  rubor:{n:'Rubor', u:()=>`<g fill="#F2667A" opacity=".45"><ellipse cx="53" cy="68" rx="7" ry="4.5"/><ellipse cx="87" cy="68" rx="7" ry="4.5"/></g>`},
  lunar:{n:'Lunar', u:()=>`<circle cx="83" cy="73" r="1.7" fill="#3B2619"/>`},
  pestanas:{n:'Pestañas', o:()=>`<path d="M54.5 53 l-3 -3 M56.5 52 l-1.5 -3.5 M85.5 53 l3 -3 M83.5 52 l1.5 -3.5" stroke="#1B1F33" stroke-width="1.8" stroke-linecap="round"/>`},
  brillos:{n:'Brillitos', o:()=>`<g fill="#FFE27A"><path d="M50 66 l1.2 2.6 2.6 1.2 -2.6 1.2 -1.2 2.6 -1.2 -2.6 -2.6 -1.2 2.6 -1.2Z"/><path d="M90 66 l1.2 2.6 2.6 1.2 -2.6 1.2 -1.2 2.6 -1.2 -2.6 -2.6 -1.2 2.6 -1.2Z"/></g><g fill="#fff"><circle cx="56" cy="70" r=".9"/><circle cx="84" cy="70" r=".9"/></g>`},
  corazones:{n:'Stickers de corazón', o:()=>`<g fill="#EF4A37"><path d="M52 71 l-3 -3 a1.9 1.9 0 0 1 3 -2.3 a1.9 1.9 0 0 1 3 2.3Z"/><path d="M88 71 l-3 -3 a1.9 1.9 0 0 1 3 -2.3 a1.9 1.9 0 0 1 3 2.3Z"/></g>`},
  curita:{n:'Curita', o:()=>`<g transform="rotate(-25 86 68)"><rect x="79" y="65" width="14" height="6" rx="3" fill="#F3C892"/><rect x="84" y="65" width="4" height="6" fill="#E8B07A"/></g>`}
};

const GLASSES = {
  ninguna:{n:'Sin gafas'},
  redondas:{n:'Redondas', f:a=>`<g fill="rgba(255,255,255,.2)" stroke="${a}" stroke-width="2.8"><circle cx="59" cy="57" r="8.5"/><circle cx="81" cy="57" r="8.5"/></g><path d="M67.5 56 Q70 54 72.5 56" stroke="${a}" stroke-width="2.8" fill="none"/>`},
  cuadradas:{n:'Cuadradas', f:a=>`<g fill="rgba(255,255,255,.18)" stroke="${a}" stroke-width="2.6"><rect x="50" y="51" width="18" height="12" rx="3"/><rect x="72" y="51" width="18" height="12" rx="3"/></g><path d="M68 56 h4" stroke="${a}" stroke-width="2.6"/>`},
  grandes:{n:'Marco grueso', f:()=>`<g fill="rgba(255,255,255,.15)" stroke="#1F1A24" stroke-width="3.6"><rect x="47.5" y="49" width="21" height="15" rx="5"/><rect x="71.5" y="49" width="21" height="15" rx="5"/></g><path d="M68.5 55 h3" stroke="#1F1A24" stroke-width="3.6"/>`},
  sol:{n:'De sol', f:()=>`<g fill="#1B1F33"><path d="M48 52 Q58 49 68 52 Q67 63 58 63 Q49 63 48 52Z"/><path d="M72 52 Q82 49 92 52 Q91 63 82 63 Q73 63 72 52Z"/></g><path d="M68 52.5 Q70 51 72 52.5" stroke="#C9A24A" stroke-width="2" fill="none"/><path d="M52 54 h5 M76 54 h5" stroke="rgba(255,255,255,.55)" stroke-width="1.8" stroke-linecap="round"/>`},
  corazon:{n:'Corazón', f:()=>`<g fill="#F48FB1" stroke="#C2185B" stroke-width="1.6"><path d="M59 64 l-9 -8 a5 5 0 0 1 9 -6 a5 5 0 0 1 9 6Z"/><path d="M81 64 l-9 -8 a5 5 0 0 1 9 -6 a5 5 0 0 1 9 6Z"/></g><path d="M68 55 h4" stroke="#C2185B" stroke-width="2"/>`},
  estrella:{n:'Estrella', f:()=>`<g fill="#FDBE30" stroke="#C9851A" stroke-width="1.4"><path d="M59 48 l2.6 5.4 5.9 .8 -4.3 4.1 1 5.9 -5.2 -2.8 -5.2 2.8 1 -5.9 -4.3 -4.1 5.9 -.8Z"/><path d="M81 48 l2.6 5.4 5.9 .8 -4.3 4.1 1 5.9 -5.2 -2.8 -5.2 2.8 1 -5.9 -4.3 -4.1 5.9 -.8Z"/></g>`},
  deportivas:{n:'Deportivas', f:a=>`<path d="M43 53 Q70 44 97 53 L95 61 Q70 55 45 61Z" fill="${a}" opacity=".9"/><path d="M50 53 Q62 49 74 51" stroke="#fff" stroke-width="1.8" fill="none" opacity=".7"/>`}
};

const HEADACC = {
  ninguno:{n:'Nada'},
  gorra:{n:'Gorra', f:a=>`<path d="M39 44 Q41 19 70 18 Q99 19 101 44 Q70 35 39 44Z" fill="${a}"/><path d="M70 41 Q98 33 117 44 Q101 51 72 47Z" fill="${shade(a,-.25)}"/><circle cx="70" cy="19" r="3" fill="${shade(a,.4)}"/>`},
  reves:{n:'Gorra al revés', f:a=>`<path d="M42 42 Q44 21 70 20 Q96 21 98 42 Q70 33 42 42Z" fill="${a}"/><path d="M44 38 Q29 36 20 44 Q31 49 45 45Z" fill="${shade(a,-.25)}"/><rect x="62" y="29" width="16" height="6" rx="3" fill="${shade(a,-.25)}"/>`},
  plana:{n:'Gorra plana', f:a=>`<path d="M40 44 Q41 17 70 16 Q99 17 100 44Z" fill="${a}"/><rect x="34" y="40" width="72" height="7" rx="3" fill="${shade(a,-.3)}"/><circle cx="70" cy="30" r="5" fill="${shade(a,.45)}"/>`},
  gorro:{n:'Gorro de lana', f:a=>`<path d="M38 50 Q36 16 70 15 Q104 16 102 50Z" fill="${a}"/><rect x="36" y="42" width="68" height="11" rx="5.5" fill="${shade(a,-.18)}"/><circle cx="70" cy="13" r="7" fill="${shade(a,.4)}"/><path d="M48 44 v7 M56 44 v7 M64 44 v7 M72 44 v7 M80 44 v7 M88 44 v7" stroke="${shade(a,-.35)}" stroke-width="1.4"/>`},
  pescador:{n:'Sombrero de pescador', f:a=>`<path d="M44 42 Q46 18 70 18 Q94 18 96 42Z" fill="${a}"/><path d="M30 46 Q70 33 110 46 L105 53 Q70 42 35 53Z" fill="${shade(a,-.15)}"/>`},
  sombrero:{n:'Sombrero de paja', f:a=>`<ellipse cx="70" cy="42" rx="48" ry="9" fill="#E6C27A"/><path d="M48 42 Q48 16 70 16 Q92 16 92 42Z" fill="#EBCB86"/><path d="M48 35 Q70 39 92 35 L92 41 Q70 45 48 41Z" fill="${a}"/>`},
  balaca:{n:'Balaca', f:a=>`<path d="M41 47 Q70 23 99 47" stroke="${a}" stroke-width="5" fill="none" stroke-linecap="round"/>`},
  sudadera:{n:'Balaca deportiva', f:a=>`<path d="M40 43 Q70 34 100 43 L100 51 Q70 42 40 51Z" fill="${a}"/><path d="M41 47 Q70 38 99 47" stroke="#fff" stroke-width="1.6" fill="none"/>`},
  lazo:{n:'Lazo', f:a=>`<g fill="${a}"><path d="M86 30 Q72 17 74 32 Q75 41 86 33Z"/><path d="M88 30 Q102 17 100 32 Q99 41 88 33Z"/><path d="M85 33 L80 47 L84 45Z M89 33 L94 47 L90 45Z"/></g><circle cx="87" cy="31" r="3.4" fill="${shade(a,-.25)}"/>`},
  pinzas:{n:'Pinzas', f:a=>`<rect x="46" y="38" width="13" height="4.5" rx="2.2" fill="${a}" transform="rotate(-28 52 40)"/><rect x="52" y="31" width="13" height="4.5" rx="2.2" fill="#FDBE30" transform="rotate(-22 58 33)"/><rect x="82" y="33" width="12" height="4.5" rx="2.2" fill="#F48FB1" transform="rotate(25 88 35)"/>`},
  garra:{n:'Pinza de garra', f:a=>`<path d="M58 22 Q70 14 82 22 L80 30 Q70 25 60 30Z" fill="${a}"/><path d="M61 29 l-1 6 M66 27 l-.5 6 M70 26.5 v6 M74 27 l.5 6 M79 29 l1 6" stroke="${shade(a,-.25)}" stroke-width="2.4" stroke-linecap="round"/>`},
  gato:{n:'Orejas de gato', f:a=>`<path d="M41 47 Q70 23 99 47" stroke="${a}" stroke-width="4" fill="none" stroke-linecap="round"/><path d="M44 41 L46 19 L61 32Z" fill="${a}"/><path d="M96 41 L94 19 L79 32Z" fill="${a}"/><path d="M47 37 L48 25 L57 32Z M93 37 L92 25 L83 32Z" fill="#F7A9B8"/>`},
  corona:{n:'Corona', f:()=>`<path d="M50 34 L48 16 L58 26 L70 12 L82 26 L92 16 L90 34Z" fill="#FDBE30" stroke="#C9851A" stroke-width="1.5"/><circle cx="70" cy="27" r="2.6" fill="#EF4A37"/><circle cx="58" cy="30" r="2" fill="#3DAEE4"/><circle cx="82" cy="30" r="2" fill="#3DAEE4"/>`},
  audifonos:{n:'Audífonos', f:a=>`<path d="M37 58 Q36 18 70 18 Q104 18 103 58" stroke="${a}" stroke-width="6" fill="none" stroke-linecap="round"/><rect x="31" y="49" width="13" height="23" rx="6" fill="${a}"/><rect x="96" y="49" width="13" height="23" rx="6" fill="${a}"/>`},
  bandana:{n:'Bandana', f:a=>`<path d="M39 46 Q40 20 70 19 Q100 20 101 46 Q70 38 39 46Z" fill="${a}"/><path d="M99 42 L112 50 L104 54 L110 62 L98 52Z" fill="${a}"/><g fill="#fff" opacity=".7"><circle cx="56" cy="32" r="1.6"/><circle cx="70" cy="27" r="1.6"/><circle cx="84" cy="32" r="1.6"/></g>`},
  flores:{n:'Corona de flores', f:a=>`<path d="M41 46 Q70 25 99 46" stroke="#2E9E6A" stroke-width="3" fill="none"/>` + [[44,42,a],[54,34,'#F48FB1'],[65,30,'#fff'],[76,30,a],[86,34,'#FDBE30'],[96,42,'#F48FB1']].map(([x,y,col])=>`<circle cx="${x}" cy="${y}" r="4.6" fill="${col}"/><circle cx="${x}" cy="${y}" r="1.7" fill="#FDBE30"/>`).join('')}
};

const EARS = {
  ninguno:{n:'Sin aretes'},
  argollas:{n:'Argollas', f:()=>`<g fill="none" stroke="#E8B84A" stroke-width="1.9"><circle cx="41" cy="71" r="4.2"/><circle cx="99" cy="71" r="4.2"/></g>`},
  perlas:{n:'Perlas', f:()=>`<g fill="#FBF7EE" stroke="#D8D2C2" stroke-width=".8"><circle cx="41" cy="68.5" r="2.7"/><circle cx="99" cy="68.5" r="2.7"/></g>`},
  estrellas:{n:'Estrellitas', f:()=>`<g fill="#FDBE30"><path d="M41 65 l1.3 2.7 3 .4 -2.2 2.1 .5 3 -2.6 -1.4 -2.6 1.4 .5 -3 -2.2 -2.1 3 -.4Z"/><path d="M99 65 l1.3 2.7 3 .4 -2.2 2.1 .5 3 -2.6 -1.4 -2.6 1.4 .5 -3 -2.2 -2.1 3 -.4Z"/></g>`},
  colgantes:{n:'Colgantes', f:a=>`<path d="M41 67 v7 M99 67 v7" stroke="#E8B84A" stroke-width="1.3"/><g fill="${a}"><path d="M41 74 l-3 4 3 4 3 -4Z"/><path d="M99 74 l-3 4 3 4 3 -4Z"/></g>`},
  piercing:{n:'Piercing', f:()=>`<g fill="#D9DEE7"><circle cx="40" cy="57" r="1.5"/><circle cx="41" cy="68" r="1.7"/><circle cx="100" cy="57" r="1.5"/><circle cx="99" cy="68" r="1.7"/></g>`}
};

const NECK = {
  ninguno:{n:'Nada'},
  cadena:{n:'Cadena', f:()=>`<path d="M58 93 Q70 109 82 93" stroke="#E8B84A" stroke-width="2.2" fill="none"/><circle cx="70" cy="104" r="3" fill="#E8B84A"/>`},
  perlas:{n:'Collar de perlas', f:()=>`<g fill="#FBF7EE"><circle cx="57" cy="96" r="2.4"/><circle cx="63" cy="100.5" r="2.4"/><circle cx="70" cy="102.5" r="2.4"/><circle cx="77" cy="100.5" r="2.4"/><circle cx="83" cy="96" r="2.4"/></g>`},
  choker:{n:'Choker', f:()=>`<path d="M63 89 Q70 92.5 77 89" stroke="#1F1A24" stroke-width="3.6" fill="none" stroke-linecap="round"/><circle cx="70" cy="92.5" r="1.8" fill="#D9DEE7"/>`},
  bufanda:{n:'Bufanda', f:a=>`<path d="M55 90 Q70 101 85 90 L86 98 Q70 109 54 98Z" fill="${a}"/><rect x="73" y="98" width="10" height="26" rx="3" fill="${shade(a,-.12)}"/><path d="M75 124 v4 M78 124 v4 M81 124 v4" stroke="${shade(a,-.12)}" stroke-width="1.6"/>`},
  corbata:{n:'Corbata', f:a=>`<path d="M66 92 L74 92 L72.5 97 L67.5 97Z" fill="${shade(a,-.2)}"/><path d="M67.5 97 L72.5 97 L75 122 L70 128 L65 122Z" fill="${a}"/>`},
  corbatin:{n:'Corbatín', f:a=>`<path d="M70 95 L61 90 L61 100Z M70 95 L79 90 L79 100Z" fill="${a}"/><circle cx="70" cy="95" r="2.6" fill="${shade(a,-.25)}"/>`},
  carnet:{n:'Carnet', f:a=>`<path d="M58 92 L68 120 M82 92 L72 120" stroke="${a}" stroke-width="2.4"/><rect x="62" y="118" width="16" height="20" rx="2" fill="#fff" stroke="#9AA4B8" stroke-width="1"/><rect x="65" y="121" width="10" height="7" rx="1" fill="#3DAEE4"/><path d="M65 131 h10 M65 134 h7" stroke="#9AA4B8" stroke-width="1.2"/>`},
  corazon:{n:'Collar de corazón', f:()=>`<path d="M59 93 Q70 106 81 93" stroke="#D9DEE7" stroke-width="1.4" fill="none"/><path d="M70 108 l-4 -4 a2.5 2.5 0 0 1 4 -3 a2.5 2.5 0 0 1 4 3Z" fill="#EF4A37"/>`}
};

const TOP = {
  base:{n:'Básico', sl:'none', base:'#FFFFFF', x:()=>`<path d="M60 92 Q70 99 80 92" stroke="#D5DBE5" stroke-width="2" fill="none"/>`},
  camiseta:{n:'Camiseta', sl:'short', x:c=>`<path d="M60 92 Q70 99 80 92" stroke="${shade(c,-.25)}" stroke-width="2.4" fill="none"/>`},
  esqueleto:{n:'Esqueleto', sl:'none', x:(c,L,tx,tw)=>`<path d="M${tx+1} 100 Q${tx+3} 91 ${tx+12} 91 L58 91 Q57 99 ${tx+6} 108Z" fill="${L.skin}"/><path d="M${tx+tw-1} 100 Q${tx+tw-3} 91 ${tx+tw-12} 91 L82 91 Q83 99 ${tx+tw-6} 108Z" fill="${L.skin}"/><path d="M58 91 Q70 104 82 91Z" fill="${L.skin}"/>`},
  buzo:{n:'Buzo con capucha', sl:'long', x:c=>`<path d="M50 94 Q70 108 90 94 Q88 86 70 86 Q52 86 50 94Z" fill="${shade(c,-.18)}"/><path d="M64 100 L63 116 M76 100 L77 116" stroke="#fff" stroke-width="2" stroke-linecap="round"/><rect x="55" y="128" width="30" height="15" rx="7" fill="${shade(c,-.15)}"/>`},
  polo:{n:'Polo', sl:'short', x:c=>`<path d="M58 91 L64 101 L70 94 L76 101 L82 91" fill="${shade(c,-.12)}" stroke="${shade(c,-.3)}" stroke-width="1.5" stroke-linejoin="round"/><circle cx="70" cy="104" r="1.6" fill="${shade(c,-.35)}"/><circle cx="70" cy="111" r="1.6" fill="${shade(c,-.35)}"/>`},
  hawaiana:{n:'Camisa de flores', sl:'short', x:c=>`<g fill="#fff" opacity=".85"><circle cx="54" cy="112" r="3"/><circle cx="83" cy="104" r="3"/><circle cx="62" cy="136" r="3"/><circle cx="86" cy="128" r="3"/><circle cx="72" cy="121" r="2.5"/></g><g fill="#FDBE30"><circle cx="54" cy="112" r="1.2"/><circle cx="83" cy="104" r="1.2"/><circle cx="62" cy="136" r="1.2"/><circle cx="86" cy="128" r="1.2"/></g><g fill="#2E9E6A" opacity=".75"><ellipse cx="60" cy="104" rx="4" ry="1.8" transform="rotate(-30 60 104)"/><ellipse cx="78" cy="140" rx="4" ry="1.8" transform="rotate(30 78 140)"/></g><path d="M60 91 L70 104 L80 91" stroke="${shade(c,-.3)}" stroke-width="2" fill="none"/>`},
  jean:{n:'Chaqueta de jean', sl:'long', base:'#F2F4F8', x:(c,L,tx,tw)=>`<path d="M${tx} 97 Q${tx} 91 ${tx+11} 91 L61 91 L60 155 L${tx} 155Z" fill="${c}"/><path d="M${tx+tw} 97 Q${tx+tw} 91 ${tx+tw-11} 91 L79 91 L80 155 L${tx+tw} 155Z" fill="${c}"/><g fill="${shade(c,.4)}"><circle cx="57" cy="112" r="1.5"/><circle cx="57" cy="128" r="1.5"/><circle cx="83" cy="112" r="1.5"/><circle cx="83" cy="128" r="1.5"/></g>`},
  blazer:{n:'Blazer', sl:'long', base:'#F2F4F8', x:(c,L,tx,tw)=>`<path d="M${tx} 98 Q${tx} 91 ${tx+9} 91 L70 117 L70 155 L${tx} 155Z" fill="${c}"/><path d="M${tx+tw} 98 Q${tx+tw} 91 ${tx+tw-9} 91 L70 117 L70 155 L${tx+tw} 155Z" fill="${c}"/><path d="M58 92 L66 116 M82 92 L74 116" stroke="${shade(c,-.3)}" stroke-width="2"/><circle cx="70" cy="132" r="2" fill="${shade(c,-.35)}"/>`},
  sueter:{n:'Suéter', sl:'long', x:(c,L,tx,tw)=>`<path d="M60 92 Q70 100 80 92" stroke="${shade(c,-.25)}" stroke-width="3" fill="none"/><rect x="${tx}" y="146" width="${tw}" height="9" rx="4" fill="${shade(c,-.15)}"/>`},
  deportiva:{n:'Camiseta deportiva', sl:'short', x:c=>{const k=isLight(c)?'#283A60':'#fff'; return `<path d="M58 93 L58 150 M82 93 L82 150" stroke="${k}" stroke-width="4"/><path d="M60 91 L70 100 L80 91" stroke="${k}" stroke-width="3" fill="none"/>`;}},
  zip:{n:'Chaqueta deportiva', sl:'long', x:c=>`<path d="M70 92 L70 155" stroke="${shade(c,-.3)}" stroke-width="2.2"/><circle cx="70" cy="99" r="2" fill="#D9DEE7"/><path d="M60 91 L70 96 L80 91" stroke="${shade(c,-.3)}" stroke-width="3" fill="none"/>`},
  vestido:{n:'Vestido', sl:'short', dress:true, x:c=>`<path d="M60 92 Q70 100 80 92" stroke="${shade(c,-.25)}" stroke-width="2.4" fill="none"/><path d="M44 134 L96 134" stroke="${shade(c,-.25)}" stroke-width="3"/>`},
  overol:{n:'Overol', sl:'short', x:(c,L)=>`<rect x="55" y="112" width="30" height="44" rx="4" fill="${L.bottomColor}"/><path d="M57 113 L52 92 M83 113 L88 92" stroke="${L.bottomColor}" stroke-width="5" stroke-linecap="round"/><circle cx="58" cy="116" r="2" fill="#FDBE30"/><circle cx="82" cy="116" r="2" fill="#FDBE30"/><rect x="64" y="122" width="12" height="9" rx="2" fill="${shade(L.bottomColor,-.15)}"/>`}
};

const PRINT = {
  ninguno:{n:'Liso'},
  corazon:{n:'Corazón', f:k=>`<path d="M70 124 l-8 -8 a5 5 0 0 1 8 -6 a5 5 0 0 1 8 6Z" fill="${k}"/>`},
  estrella:{n:'Estrella', f:k=>`<path d="M70 106 l3.6 7.2 7.8 1.1 -5.7 5.5 1.4 7.8 -7.1 -3.7 -7.1 3.7 1.4 -7.8 -5.7 -5.5 7.8 -1.1Z" fill="${k}"/>`},
  rayo:{n:'Rayo', f:k=>`<path d="M73 103 L62 122 L70 122 L66 139 L80 116 L72 116 L77 103Z" fill="${k}"/>`},
  carita:{n:'Carita feliz', f:k=>{const e=k==='#FFFFFF'?'#283A60':'#FFFFFF'; return `<circle cx="70" cy="120" r="10" fill="${k}"/><circle cx="66.5" cy="117.5" r="1.6" fill="${e}"/><circle cx="73.5" cy="117.5" r="1.6" fill="${e}"/><path d="M65 122 Q70 127 75 122" stroke="${e}" stroke-width="1.8" fill="none" stroke-linecap="round"/>`;}},
  escudo:{n:'Escudo', f:()=>`<path d="M70 106 L82 111 Q82 126 70 133 Q58 126 58 111Z" fill="#45CB91"/><path d="M65 119 l4 4 l7 -8" stroke="#fff" stroke-width="2.5" fill="none" stroke-linecap="round"/>`},
  rayas:{n:'Rayas', f:(k,tx,tw)=>`<path d="M${tx+3} 112 H${tx+tw-3} M${tx+2} 124 H${tx+tw-2} M${tx+3} 136 H${tx+tw-3}" stroke="${k}" stroke-width="4" opacity=".85"/>`},
  planeta:{n:'Planeta', f:k=>`<circle cx="70" cy="120" r="8" fill="${k}"/><ellipse cx="70" cy="120" rx="14" ry="4" fill="none" stroke="${k}" stroke-width="2" transform="rotate(-18 70 120)"/>`}
};

const BOTTOM = {
  base:{n:'Básico', k:'pants', fixed:'#FFFFFF'},
  jean:{n:'Jean', k:'pants', seam:true},
  pantalon:{n:'Pantalón', k:'pants', crease:true},
  jogger:{n:'Sudadera', k:'pants', cuff:true},
  cargo:{n:'Cargo ancho', k:'wide'},
  leggings:{n:'Leggings', k:'pants', thin:true},
  shorts:{n:'Shorts', k:'shorts'},
  falda:{n:'Falda', k:'skirt'},
  prenses:{n:'Falda de prenses', k:'skirt', pleats:true}
};

const SHOES = {
  ninguno:{n:'Descalzo', f:(x,c,L)=>`<ellipse cx="${x}" cy="200" rx="9.5" ry="5.5" fill="${L.skin}"/>`},
  tenis:{n:'Tenis', f:(x,c)=>`<ellipse cx="${x}" cy="200" rx="11.5" ry="6.5" fill="${c}"/><path d="M${x-11} 202.5 Q${x} 207 ${x+11} 202.5" stroke="#fff" stroke-width="2.4" fill="none"/>`},
  altos:{n:'Tenis altos', f:(x,c)=>`<rect x="${x-8}" y="185" width="16" height="15" rx="4" fill="${c}"/><ellipse cx="${x}" cy="201" rx="12" ry="6" fill="${c}"/><path d="M${x-12} 203 Q${x} 208 ${x+12} 203" stroke="#fff" stroke-width="2.6" fill="none"/><path d="M${x-4} 189 h8 M${x-4} 193 h8" stroke="#fff" stroke-width="1.2"/>`},
  botas:{n:'Botas', f:(x,c)=>`<rect x="${x-8.5}" y="177" width="17" height="25" rx="4" fill="${c}"/><ellipse cx="${x}" cy="202" rx="11.5" ry="5.5" fill="${c}"/><path d="M${x-11.5} 204.5 h23" stroke="${shade(c,-.4)}" stroke-width="3"/>`},
  formales:{n:'Zapatos formales', f:(x,c)=>`<ellipse cx="${x}" cy="201" rx="11" ry="5.5" fill="${c}"/><ellipse cx="${x-3}" cy="199" rx="4" ry="1.5" fill="#fff" opacity=".35"/>`},
  suecos:{n:'Suecos de goma', f:(x,c)=>`<ellipse cx="${x}" cy="200" rx="12.5" ry="7.5" fill="${c}"/><g fill="rgba(0,0,0,.22)"><circle cx="${x-5}" cy="197" r="1.3"/><circle cx="${x}" cy="196" r="1.3"/><circle cx="${x+5}" cy="197" r="1.3"/></g><path d="M${x-11} 199 Q${x} 192 ${x+11} 199" stroke="${shade(c,-.25)}" stroke-width="2" fill="none"/>`},
  sandalias:{n:'Sandalias', f:(x,c,L)=>`<ellipse cx="${x}" cy="201" rx="10" ry="5" fill="${L.skin}"/><path d="M${x-12} 205.5 h24" stroke="${c}" stroke-width="3" stroke-linecap="round"/><path d="M${x-7} 200 L${x} 197 L${x+7} 200" stroke="${c}" stroke-width="3" fill="none" stroke-linecap="round"/>`}
};

const HAND = {
  ninguno:{n:'Nada'},
  celular:{n:'Celular', s:'<rect x="99" y="126" width="13" height="22" rx="3" fill="#1E2B47"/><rect x="101" y="129" width="9" height="15" rx="1.5" fill="#3DAEE4"/>'},
  termo:{n:'Termo gigante', s:'<rect x="99" y="114" width="15" height="36" rx="6" fill="#FDBE30"/><rect x="101.5" y="109" width="10" height="7" rx="2" fill="#283A60"/><rect x="101.5" y="124" width="10" height="3" fill="rgba(255,255,255,.65)"/>'},
  cafe:{n:'Café', s:'<rect x="97" y="130" width="15" height="16" rx="3" fill="#fff"/><path d="M112 133 Q119 137.5 112 143" stroke="#fff" stroke-width="3" fill="none"/><rect x="97" y="135" width="15" height="3" fill="#3DAEE4"/><path class="steam" d="M101 126 Q99 122 102 119 M107 126 Q105 122 108 119" stroke="rgba(255,255,255,.75)" stroke-width="1.6" fill="none" stroke-linecap="round"/>'},
  control:{n:'Control de juego', s:'<rect x="95" y="138" width="25" height="13" rx="6.5" fill="#2B2F3A"/><circle cx="114" cy="142.5" r="1.9" fill="#EF4A37"/><circle cx="117.5" cy="146" r="1.9" fill="#3DAEE4"/><path d="M99.5 144.5 h5.5 M102.25 141.75 v5.5" stroke="#9AA4B8" stroke-width="1.7"/>'},
  balon:{n:'Balón', s:'<circle cx="113" cy="140" r="9" fill="#fff" stroke="#1E2B47" stroke-width="1.5"/><path d="M113 135 l4 3 -1.5 4.5 h-5 L109 138Z" fill="#1E2B47"/>'},
  lightstick:{n:'Lightstick', s:'<rect x="104" y="122" width="4" height="22" rx="2" fill="#E5E7EB"/><circle cx="106" cy="117" r="8" fill="#B79AD6" stroke="#fff" stroke-width="2"/><path d="M103 117 l3 -3 l3 3 l-3 3Z" fill="#fff"/>'},
  laptop:{n:'Laptop', s:'<rect x="95" y="132" width="25" height="15" rx="2" fill="#9AA4B8"/><rect x="97" y="134" width="21" height="11" rx="1" fill="#1E2B47"/><path d="M100 138 h6 M100 141 h11" stroke="#45CB91" stroke-width="1.4"/>'},
  libro:{n:'Libro', s:'<rect x="96" y="128" width="20" height="16" rx="2" fill="#EF4A37"/><rect x="98" y="130" width="16" height="12" rx="1" fill="#fff"/><path d="M106 130 v12" stroke="#EF4A37" stroke-width="1.4"/>'},
  microfono:{n:'Micrófono', s:'<rect x="103" y="128" width="6" height="18" rx="3" fill="#2B2F3A"/><circle cx="106" cy="124" r="6" fill="#9AA4B8"/><path d="M101 124 h10 M106 119 v10" stroke="#6B7280" stroke-width=".8"/>'},
  tetero:{n:'Tetero', s:'<rect x="100.5" y="126" width="11" height="18" rx="4" fill="rgba(255,255,255,.92)"/><rect x="100.5" y="133" width="11" height="8" fill="#FFE7A8"/><path d="M103 126 Q106 117 109 126Z" fill="#F7A9B8"/>'},
  remoto:{n:'Control remoto', s:'<rect x="100" y="131" width="11" height="25" rx="3.5" fill="#2B2F3A"/><circle cx="105.5" cy="136" r="2.1" fill="#EF4A37"/><circle cx="103" cy="142" r="1.3" fill="#9AA4B8"/><circle cx="108" cy="142" r="1.3" fill="#9AA4B8"/>'},
  flor:{n:'Flor', s:'<path d="M106 146 L111 118" stroke="#2E9E6A" stroke-width="2.4"/><ellipse cx="107.5" cy="130" rx="4.5" ry="2" fill="#2E9E6A" transform="rotate(-35 107.5 130)"/><circle cx="111" cy="115" r="6" fill="#EF4A37"/><circle cx="111" cy="115" r="2.2" fill="#FDBE30"/>'}
};

const BUILD = { delgado:{n:'Delgada', w:46}, normal:{n:'Normal', w:52}, ancho:{n:'Ancha', w:60} };

const CATS = [
  {id:'piel', n:'Piel', sec:[{t:'Tono de piel', key:'skin', sw:'skin'}]},
  {id:'pelo', n:'Pelo', sec:[{t:'Peinado', key:'hair', opts:HAIR, view:'head'},{t:'Color de pelo', key:'hairColor', sw:'hair'}]},
  {id:'cara', n:'Cara', sec:[{t:'Detalles', key:'detail', opts:DETAIL, view:'head'},{t:'Barba y bigote', key:'beard', opts:BEARD, view:'head', role:'adulto'},{t:'Gafas', key:'glasses', opts:GLASSES, view:'head'}]},
  {id:'acc', n:'Accesorios', sec:[{t:'En la cabeza', key:'headAcc', opts:HEADACC, view:'head'},{t:'Aretes', key:'ears', opts:EARS, view:'head'},{t:'En el cuello', key:'neck', opts:NECK, view:'torso'},{t:'Color de accesorios', key:'acc', sw:'cloth'}]},
  {id:'ropa', n:'Ropa', sec:[{t:'Arriba', key:'top', opts:TOP, view:'torso'},{t:'Color de arriba', key:'topColor', sw:'cloth'},{t:'Abajo', key:'bottom', opts:BOTTOM, view:'legs'},{t:'Color de abajo', key:'bottomColor', sw:'cloth'}]},
  {id:'zap', n:'Zapatos', sec:[{t:'Zapatos', key:'shoes', opts:SHOES, view:'feet'},{t:'Color de zapatos', key:'shoesColor', sw:'cloth'}]},
  {id:'mano', n:'En la mano', sec:[{t:'Lleva en la mano', key:'hand', opts:HAND, view:'hand'}]}
];

function randomLook(role) {
  const r = Math.random, k = o => rpick(Object.keys(o)), col = a => rpick(a)[0];
  const natural = PAL.hair.slice(0, 7), fantasy = PAL.hair.slice(9);
  const L = {
    skin: col(PAL.skin),
    hair: rpick(Object.keys(HAIR).slice(1)),
    hairColor: role === 'adulto' && r() < 0.2 ? rpick(['#A9A9A9', '#E8E8E8']) : (r() < 0.18 ? col(fantasy) : col(natural)),
    beard: role === 'adulto' && r() < 0.35 ? rpick(['bigote', 'candado', 'corta', 'completa', 'chivera']) : 'ninguna',
    detail: r() < 0.45 ? rpick(Object.keys(DETAIL).slice(1)) : 'ninguno',
    glasses: r() < 0.35 ? rpick(Object.keys(GLASSES).slice(1)) : 'ninguna',
    headAcc: r() < 0.5 ? rpick(Object.keys(HEADACC).slice(1)) : 'ninguno',
    ears: r() < 0.35 ? rpick(Object.keys(EARS).slice(1)) : 'ninguno',
    neck: r() < 0.3 ? rpick(Object.keys(NECK).slice(1)) : 'ninguno',
    top: rpick(Object.keys(TOP).slice(1)), topColor: col(PAL.cloth),
    print: 'ninguno',
    bottom: rpick(Object.keys(BOTTOM).slice(1)), bottomColor: rpick(['#34558A', '#283A60', '#1F1A24', '#8B6A4A', '#9AA4B8', col(PAL.cloth)]),
    shoes: rpick(Object.keys(SHOES).slice(1)), shoesColor: col(PAL.cloth),
    hand: r() < 0.6 ? rpick(Object.keys(HAND).slice(1)) : 'ninguno',
    acc: col(PAL.cloth),
    build: 'normal'
  };
  if (L.topColor === L.bottomColor) L.bottomColor = '#34558A';
  return L;
}
function blankLook() {
  return { skin:'#E4E7EC', hair:'ninguno', hairColor:'#3B2619', beard:'ninguna', detail:'ninguno', glasses:'ninguna', headAcc:'ninguno', ears:'ninguno', neck:'ninguno',
    top:'base', topColor:'#3DAEE4', print:'ninguno', bottom:'base', bottomColor:'#34558A', shoes:'ninguno', shoesColor:'#F2F4F8', hand:'ninguno', acc:'#EF4A37', build:'normal' };
}


const REACT = {
  adulto:{pos:['¡Uy, qué nivel!','¿Y eso dónde lo aprendiste?','Me sacaste las lágrimas 🥲','¡Así se hace!','Ese es el orgullo de la casa.'],
          neg:['¿Qué fue eso? 😂','Esto se lo cuento a la abuela.','Ay, Dios mío bendito.','Tranqui, de todo se aprende.','Te voy a quitar el wifi… mentiras 😅']},
  chico:{pos:['Ok… respeto 😳','Aura de veterano, no lo voy a negar.','Eso fue goated, la verdad.','Esto va pa’ mis historias ✨','Farmeó de verdad.'],
         neg:['Cero aura 💀','Skill issue 😭','Eso fue muy cringe 😂','Me muero 😂','NPC detectado.']}
};

const LINES = {
  adulto:{
    win:['¿Qué le dijo un wifi a otro? ¡Qué buena conexión!','Aura de adulto con datos ilimitados.','Esto amerita un chiste malo. Y un cafecito.','Aura aprobada por el comité.','Uno no es viejo: es vintage.','¿Vieron? Los adultos también farmeamos.','Diez mil pasos y diez mil de aura.','Cinco sobre cinco. Aura con honores.','Esto lo pongo en mis estados. Con permiso, obvio.','Me tiré el paso prohibido de las fiestas.'],
    lose:['En mis tiempos eso no pasaba…','Perdí aura pero gané experiencia.','Me congelé como cuando se cae el wifi en una reunión.','Necesito otro café para procesar esto.','Perdí más aura que señal en el ascensor.','Esto no se lo cuenten a la abuela.','Ese trend ya pasó de moda, ¿cierto?','Dormí dos horas, no cuenta.','¿Eso no era verdad? Me lo mandó la comadre…','Tarea para la casa: no hacer eso.']
  },
  chico:{
    win:['GG fácil. Aura desbloqueada 🎮','Literal, slay ✨','Eso fue un speedrun de aura.','*mewing de la victoria* 🗿','Me la comí. Sin discusión.','Subí de rango en la vida real.','Acceso concedido: aura desbloqueada 💻','¡GOOOL de aura!','Seis… siete. Ni yo sé por qué, pero gané.','Una W gigante.'],
    lose:['Lag. Fue el lag, lo juro.','Ok, eso fue cringe hasta para mí.','Borren esto del internet, porfa.','Error 404: aura no encontrada.','Necesito respawnear.','Eso fue autogol.','Mi aura está en modo avión.','Cero aura… pero mucho flow.','Eso no contó, estaba en el tutorial.','Sigma por fuera, NPC por dentro.']
  }
};

const ROLE_DESC = {
  adulto:'un adulto latinoamericano (puede ser papá, mamá, tío, abuela o profe) con humor de adulto: chistes malos, el grupo familiar de WhatsApp, el trabajo y el “en mis tiempos”',
  chico:'un niño o niña latinoamericano de 9 a 15 años que habla con jerga actual de internet, memes y videojuegos'
};

const TEMA_MOVE = {
  'Desinformación':'detective','Ciberseguridad':'pesca','Privacidad':'candado','Contraseñas':'candado','Fraude telefónico':'cuelgue',
  'Bienestar digital':'zen','Wi-Fi público':'antena','Control parental':'escudo','Comunicación':'guitarra','Ingeniería social':'detective',
  'Actualizaciones':'robot','Permisos de apps':'robot','Estafas en juegos':'pesca','Contacto con extraños':'escudo','Ciberacoso':'escudo',
  'Fotos y privacidad':'candado','Sueño y pantallas':'zen','Retos virales':'split','Phishing':'pesca','Huella digital':'detective',
  'Datos personales':'candado','Autoestima':'zen','Compras en juegos':'candado'
};

// t: 'chico' = jerga actual · 'adulto' = palabras y dichos de grandes · 'ciber' = vocabulario de seguridad
// c: respuesta correcta corta · f: tres opciones falsas creíbles · mv: baile relacionado
const DICT = [
  {"w":"aura","t":"chico","d":"La vibra o el respeto que ganas cuando haces algo genial. Se gana (se farmea) o se pierde.","c":"El respeto o la vibra que ganas por hacer algo genial","f":["Un perfume caro de la abuela","La luz que sale del router"],"ad":"¿Aura? Como la del horóscopo. Hoy mi aura dice: pague los servicios.","ch":"Yo no farmeo aura. El aura me farmea a mí.","mv":"bote"},
  {"w":"farmear","a":["farmear aura","farmeo"],"t":"chico","d":"Repetir algo una y otra vez para acumular puntos, monedas o aura. Viene de los videojuegos.","c":"Repetir algo para acumular puntos o aura","f":["Ir a la farmacia","Trabajar en una finca"],"ad":"¿Farmear? Ya voy a la farmacia. ¿Qué le traigo, acetaminofén?","ch":"Llevo tres días farmeando aura haciendo la tarea sin que me la pidan.","mv":"bote"},
  {"w":"green flag","a":["greenflag","bandera verde"],"t":"chico","d":"Una señal de que algo o alguien es bueno, sano y confiable. Lo contrario de red flag.","c":"Una señal de que algo o alguien es bueno y confiable","f":["Una bandera de reciclaje","Un semáforo en verde"],"ad":"¿Green flag? Ah, la bandera del parque ecológico.","ch":"Que alguien te pregunte antes de subir tu foto: green flag 💚","mv":"giro"},
  {"w":"NPC","a":["npc"],"t":"chico","d":"Alguien que actúa como personaje de relleno de un videojuego: sin opinión propia y repitiendo lo mismo.","c":"Alguien sin personalidad, como relleno de videojuego","f":["Una nueva EPS","Número de Pin del Celular"],"ad":"¿NPC? Eso es “No Pagué la Cuota”. Ese soy yo cada fin de mes.","ch":"No seas NPC: piensa antes de reenviar ese meme.","mv":"robot"},
  {"w":"cringe","t":"chico","d":"Vergüenza ajena: algo que da pena ver.","c":"Vergüenza ajena","f":["Una crema para las arrugas","Un pan francés"],"ad":"¿Cringe? Me lo recetó el dermatólogo para las patas de gallina.","ch":"Lo más cringe del mundo: mis papás bailando en TikTok sin permiso.","mv":"floss"},
  {"w":"delulu","t":"chico","d":"Alguien que se ilusiona demasiado o se cree cosas que no son reales.","c":"Que se ilusiona o se cree cosas irreales","f":["Un dulce típico con arequipe","Un pájaro del Amazonas"],"ad":"¿Delulu? Uy, eso con arequipe queda delicioso.","ch":"Ser delulu es creer que el link del iPhone gratis es real.","mv":"zen"},
  {"w":"PRO","a":["pro","pros"],"t":"chico","d":"Alguien muy bueno en algo, sobre todo en los videojuegos. Lo contrario de noob.","c":"Alguien muy bueno en algo, sobre todo en juegos","f":["Un profesor, pero abreviado","Una marca de celulares"],"ad":"¿PRO? Profesional, claro. Como yo con el control remoto.","ch":"Pro de verdad es el que gana sin hacer trampa.","mv":"breakdance"},
  {"w":"red flag","a":["redflag","bandera roja"],"t":"chico","d":"Una señal de alerta de que algo o alguien no está bien.","c":"Una señal de alerta","f":["La bandera del equipo","Un semáforo en rojo"],"ad":"¿Red flag? ¡La bandera del Poderoso! Rojo y azul, mijo.","ch":"Un desconocido que te pide fotos: red flag gigante 🚩.","mv":"escudo"},
  {"w":"ghostear","a":["ghosting","ghosteo","ghost"],"t":"chico","d":"Dejar de responderle a alguien de un momento a otro, sin explicación.","c":"Dejar de responder sin explicación","f":["Disfrazarse de fantasma","Borrar el historial"],"ad":"¿Ghostear? Lo que hace mi cuñado cuando le cobro lo que le presté.","ch":"Ghosteé a un desconocido que me escribió raro… y luego le conté a mi mamá.","mv":"candado"},
  {"w":"POV","a":["pov"],"t":"chico","d":"Del inglés point of view: una situación contada desde el punto de vista de alguien.","c":"Punto de vista de alguien","f":["Pago Obligatorio Vencido","Un pollo a la plancha"],"ad":"¿POV? Pago Obligatorio Vencido. Lo conozco muy bien.","ch":"POV: descubres que la clave del Wi-Fi no es 1234.","mv":"detective"},
  {"w":"GOAT","a":["goat"],"t":"chico","d":"Del inglés greatest of all time: el mejor de todos los tiempos.","c":"El mejor de todos los tiempos","f":["Simplemente una cabra 🐐","Una marca de gorras"],"ad":"¿GOAT? Yo tuve una cabra en la finca. Se llamaba Rosita.","ch":"Mi abuela usando doble factor de autenticación: la GOAT.","mv":"mortal"},
  {"w":"skill issue","a":["skill","skillissue"],"t":"chico","d":"“Problema de habilidad”: cuando algo sale mal porque te falta práctica.","c":"Falta de habilidad o de práctica","f":["Un problema con la EPS","Una pastilla para el estrés"],"ad":"¿Skill issue? Eso es lo que tengo con la licuadora nueva.","ch":"¿Caíste en un link falso? Skill issue. Activa el filtro de spam.","mv":"breakdance"},
  {"w":"random","a":["ramdom"],"t":"chico","d":"Algo inesperado, raro o sin sentido. También un desconocido.","c":"Algo raro o inesperado, o un desconocido","f":["Un número del chance","Una marca de cereal"],"ad":"¿Random? Voy a jugar el random del chance esta semana.","ch":"Un random me agregó en el juego. Lo bloqueé, obvio.","mv":"seisiete"},
  {"w":"basado","a":["based"],"t":"chico","d":"Alguien que dice lo que piensa con seguridad, aunque no sea popular.","c":"Que dice lo que piensa con seguridad","f":["Una arepa con base de queso","Un edificio con buenos cimientos"],"ad":"¿Basado? Mi casa está bien basada, con cimientos de 1987.","ch":"Decir “no comparto mi contraseña ni con mi crush”: basado.","mv":"explosion"},
  {"w":"funar","a":["funa","funado","funada"],"t":"chico","d":"Exponer públicamente a alguien por algo malo que hizo, muchas veces en redes.","c":"Exponer públicamente a alguien en redes","f":["Fumar, en otro país","Fundir un bombillo"],"ad":"¿Funar? Ay no, yo dejé de fumar hace años.","ch":"Antes de funar a alguien, habla con un adulto. Funar también puede ser acoso.","mv":"escudo"},
  {"w":"facto","a":["factos","facts","es facto"],"t":"chico","d":"“Es un hecho, es totalmente cierto”. Se usa para decir que estás de acuerdo.","c":"“Es verdad, totalmente de acuerdo”","f":["Una factura por pagar","Algo hecho en una fábrica"],"ad":"¿Facto? ¿La factura de la luz? Ya la pagué.","ch":"Contraseña larga y doble factor: facto, eso es aura.","mv":"detective"},
  {"w":"Tralalero Tralala","a":["tralalero","tralalero tralala","tralalero tralalá"],"t":"chico","d":"Personaje de un meme absurdo hecho con inteligencia artificial: un tiburón con tenis, de los memes llamados “brainrot italiano”.","c":"Un tiburón con tenis de un meme absurdo hecho con IA","f":["Una canción infantil de cumpleaños","Un trabalenguas de los abuelos"],"ad":"¿Tralalero tralalá? Esa la cantaba yo en la escuela.","ch":"Tralalero tralalá… y después, descanso de pantalla.","mv":"seisiete"},
  {"w":"lowkey","a":["low key"],"t":"chico","d":"Un poquito, en secreto o sin hacer escándalo.","c":"Un poquito o en secreto","f":["Una llave pequeña","El volumen bajo del radio"],"ad":"¿Lowkey? La llave de abajo, la del contador del agua.","ch":"Lowkey me encanta cuando juegan conmigo en la casa.","mv":"zen"},
  {"w":"glow up","a":["glowup"],"t":"chico","d":"Un cambio muy positivo en tu apariencia o en tu vida.","c":"Un cambio muy positivo","f":["Una lámpara de noche","Un tipo de pegante"],"ad":"¿Glow up? Lo que le pasó a mi celular cuando le subí el brillo.","ch":"Mi glow up digital: contraseñas largas y cuenta privada.","mv":"giro"},
  {"w":"mid","t":"chico","d":"Algo regular: ni bueno ni malo.","c":"Regular, del montón","f":["Mediodía","Medio kilo"],"ad":"¿Mid? ¡Mediodía! Hora del almuerzo: a lavarse las manos.","ch":"La pizza con piña es mid… pero cero peleas en los comentarios.","mv":"cumbia"},
  {"w":"brainrot","a":["brain rot"],"t":"chico","d":"Contenido absurdo y repetitivo que “pudre el cerebro” cuando ves demasiado.","c":"Contenido absurdo que “pudre el cerebro”","f":["Un dolor de cabeza fuerte","Un juego de memoria"],"ad":"¿Brainrot? Lo que me da con los audios larguísimos del grupo.","ch":"Llevo dos horas de brainrot. Hora de un descanso de pantalla.","mv":"robot"},
  {"w":"tilteado","a":["tilt","tiltear","tilteada"],"t":"chico","d":"Frustrado o con rabia después de perder en un juego.","c":"Frustrado después de perder","f":["Inclinado hacia un lado","Con mucho sueño"],"ad":"¿Tilteado? Como el cuadro de la sala, que nadie endereza.","ch":"Cuando estoy tilteado, suelto el control. Gritar no sube el rango.","mv":"zen"},
  {"w":"noob","a":["nub"],"t":"chico","d":"Principiante: alguien nuevo en un juego o en un tema.","c":"Principiante","f":["Una nube, en inglés","Un nudo"],"ad":"¿Noob? Sí, hoy está muy noob… digo, nublado.","ch":"Hasta el más pro fue noob. Por eso le enseño a mi familia a configurar la privacidad.","mv":"floss"},
  {"w":"seis siete","a":["67","6 7","6-7","six seven","sixseven"],"t":"chico","d":"Un meme sin significado: se dice “six seven” moviendo las manos como balanza, solo para hacer reír.","c":"Un meme sin significado que se dice para hacer reír","f":["La hora de la novela","La talla de zapatos del papá"],"ad":"¿Seis siete? Cuarenta y dos. Tranquilo, la tabla del seis es fácil.","ch":"Seis… siete 🤲 (y nadie sabe por qué).","mv":"seisiete"},
  {"w":"carrear","a":["carry","carreo","carrearon"],"t":"chico","d":"“Cargar” al equipo: jugar tan bien que ganas por todos.","c":"Jugar tan bien que ganas por el equipo","f":["Llevar el mercado","Manejar un carro"],"ad":"¿Carrear? Claro, yo carreo el mercado todos los sábados: doce bolsas.","ch":"Hoy carreé a mi equipo… y ninguno sabía mi contraseña.","mv":"rodilla"},
  {"w":"chill","a":["chil"],"t":"chico","d":"Tranquilo, relajado.","c":"Tranquilo, relajado","f":["Ají, en inglés","Frío extremo"],"ad":"¿Chill? ¿Chili? Pásame el ají, que el sancocho está simple.","ch":"Cuenta privada, contraseña larga y yo bien chill.","mv":"zen"},
  {"w":"stalkear","a":["stalk","stalkeo"],"t":"chico","d":"Revisar a fondo el perfil o las publicaciones de alguien.","c":"Revisar a fondo el perfil de alguien","f":["Hacer estiramientos","Guardar en el congelador"],"ad":"¿Stalkear? Lo que hago con las ofertas del supermercado.","ch":"Si alguien te stalkea demasiado: red flag. Bloquea y cuéntale a un adulto.","mv":"detective"},
  {"w":"crush","t":"chico","d":"La persona que te gusta.","c":"La persona que te gusta","f":["Un jugo de naranja","Aplastar algo"],"ad":"¿Crush? La gaseosa de naranja de los noventa. ¡Qué época!","ch":"Ni a mi crush le doy mi contraseña. Aura intacta.","mv":"pelo"},
  {"w":"dar papaya","a":["papaya","no dar papaya"],"t":"adulto","d":"Exponerse o dar la oportunidad para que te pase algo malo. En internet: compartir de más.","c":"Exponerse a que te pase algo malo","f":["Regalar fruta en el colegio","Hacer jugo"],"ch":"¿Dar papaya? Le llevé una papaya a la profe y me subió la nota.","ad":"Publicar la ubicación en vivo es dar papaya, y yo no doy papaya ni en el mercado.","mv":"escudo"},
  {"w":"estar pilas","a":["pilas","ponerse pilas"],"t":"adulto","d":"Estar atento y alerta.","c":"Estar atento y alerta","f":["Estar cargando el celular","Tener muchas baterías"],"ch":"¿Pilas? Ya busco unas doble A para el control.","ad":"Pilas con los links raros: uno ve “premio” y ya está hackeado.","mv":"detective"},
  {"w":"estar en la olla","a":["en la olla","la olla"],"t":"adulto","d":"Estar mal de plata o metido en un problema.","c":"Estar mal de plata o en problemas","f":["Estar cocinando","Esconderse en la cocina"],"ch":"¿En la olla? ¿Mi familia metida en la olla del sancocho? Qué miedo.","ad":"Quedé en la olla por comprar en una tienda falsa. Ahora verifico antes.","mv":"candado"},
  {"w":"hacer vaca","a":["vaca","una vaca"],"t":"adulto","d":"Recoger plata entre varias personas para algo.","c":"Recoger plata entre varios","f":["Ordeñar una vaca","Disfrazarse de vaca"],"ch":"¿Hacer vaca? Muuuu. ¿Así?","ad":"Hicimos vaca para el regalo de la profe y pagamos por la app del banco, no por un link raro.","mv":"cumbia"},
  {"w":"qué boleta","a":["boleta","que boleta"],"t":"adulto","d":"¡Qué vergüenza! Algo exagerado o ridículo.","c":"¡Qué vergüenza! Algo exagerado","f":["Un tiquete de cine","Una multa de tránsito"],"ch":"¿Boleta? ¡Para el concierto! ¿Me la compran?","ad":"Qué boleta mandar un audio al grupo equivocado. Por eso reviso antes de enviar.","mv":"moon"},
  {"w":"pedir cacao","a":["cacao"],"t":"adulto","d":"Rendirse o pedir clemencia.","c":"Rendirse o pedir clemencia","f":["Pedir chocolate caliente","Pedir el postre"],"ch":"¿Pedir cacao? Sí, con pan y quesito, por favor.","ad":"Le pedí cacao a la impresora. Ella ganó, como siempre.","mv":"zen"},
  {"w":"ser una lámpara","a":["lampara","lámpara","una lampara"],"t":"adulto","d":"Alguien que quiere llamar la atención o presumir.","c":"Alguien que presume para llamar la atención","f":["Ser muy inteligente","Tener insomnio"],"ch":"¿Una lámpara? ¡Es que soy brillante!","ad":"Subir fotos del carro nuevo con la placa a la vista: lámpara y peligro.","mv":"pelo"},
  {"w":"ojo pues","a":["ojo","ojo pue"],"t":"adulto","d":"¡Cuidado! ¡Atención!","c":"¡Cuidado, atención!","f":["Mirar con un solo ojo","Ir al oculista"],"ch":"¿Ojo pues? *se tapa un ojo* ¿Así?","ad":"Ojo pues con las apps que piden permiso a todo. Una linterna no necesita mis contactos.","mv":"detective"},
  {"w":"me dejó el bus","a":["dejo el bus","me dejo el bus","dejar el bus"],"t":"adulto","d":"Se me pasó la oportunidad o el tiempo; quedarse atrás.","c":"Se me pasó la oportunidad","f":["Me regalaron un bus","El bus se varó"],"ch":"¿Te dejó el bus? Pide un carro por app, más fácil.","ad":"Con TikTok me dejó el bus, pero aquí estoy aprendiendo con ustedes.","mv":"moon"},
  {"w":"rebobinar","a":["rebobinar casete","casete","cassette"],"t":"adulto","d":"Devolver la cinta de un casete o de un VHS. Muchas veces se hacía con un lápiz.","c":"Devolver la cinta de un casete, a veces con un lápiz","f":["Volver a hacer el bobo","Un pokémon eléctrico"],"ch":"¿Rebobinar? ¿Volver a hacer el bobo? Eso lo hago gratis.","ad":"Yo rebobinaba casetes con un lápiz. Eso sí era tecnología de punta.","mv":"robot"},
  {"w":"disquete","a":["diskette","disket"],"t":"adulto","d":"Un cuadrito de plástico donde cabían 1,44 MB. Hoy es el ícono de “Guardar”.","c":"Un cuadrito donde cabían 1,44 MB","f":["Una galleta cuadrada","Una discoteca pequeña"],"ch":"¿Disquete? ¿El ícono de guardar existe en la vida real?","ad":"En un disquete cabía media foto tuya. Hoy guardo copias en la nube, con buena contraseña.","mv":"robot"},
  {"w":"zumbido","a":["zumbido messenger","messenger"],"t":"adulto","d":"En Messenger, una vibración que sacudía la ventana del chat para llamar la atención.","c":"Una vibración que sacudía la ventana del chat","f":["Un zancudo","El ruido de la nevera"],"ch":"¿Zumbido? Eso es un zancudo. ¡Mátalo!","ad":"Yo mandaba zumbidos en Messenger. Hoy sé que insistirle mucho a alguien también incomoda.","mv":"antena"},
  {"w":"el fijo","a":["fijo","telefono fijo","teléfono fijo"],"t":"adulto","d":"El teléfono de la casa, con cable, que solo servía para llamar.","c":"El teléfono de la casa, con cable","f":["Un tatuaje","Un precio que no cambia"],"ch":"¿El fijo? ¿Un celular que no se puede llevar? Qué estafa.","ad":"Al fijo uno contestaba “¿Aló? ¿Quién habla?”. Hoy no contesto números raros.","mv":"cuelgue"},
  {"w":"hacer el oso","a":["oso","el oso","que oso","qué oso"],"t":"adulto","d":"Hacer el ridículo.","c":"Hacer el ridículo","f":["Hibernar","Abrazar muy fuerte"],"ch":"¿Hacer el oso? *ruge* ¿Así?","ad":"Hacer el oso es normal. Lo grave es que quede grabado para siempre en internet.","mv":"floss"},
  {"w":"a la orden","a":["alaorden"],"t":"adulto","d":"Frase colombiana para decir “con gusto, para servirle”.","c":"Con gusto, para servirle","f":["Una orden del ejército","Pedir un domicilio"],"ch":"¿A la orden? ¡Sí, mi general!","ad":"A la orden, pero mi contraseña no se la doy ni al técnico del cable.","mv":"salsa"},
  {"w":"echar carreta","a":["carreta"],"t":"adulto","d":"Hablar mucho, a veces exagerando o inventando.","c":"Hablar mucho, exagerando","f":["Empujar una carretilla","Pasear en coche de caballos"],"ch":"¿Carreta? *empuja una carretilla imaginaria*","ad":"Los que prometen premios por internet echan mucha carreta. No les creo.","mv":"cuelgue"},
  {"w":"phishing","a":["fishing","pishing","suplantacion","suplantación"],"t":"ciber","mv":"pesca","d":"Engaño por correo, mensaje o página falsa para robar tus datos.","l":"¡Phishing detectado! Este pez no muerde el anzuelo 🎣"},
  {"w":"malware","a":["virus","troyano","spyware"],"t":"ciber","mv":"robot","d":"Programa malicioso que daña o espía tu dispositivo.","l":"Descargo apps solo de la tienda oficial. Malware, aquí no entras."},
  {"w":"grooming","t":"ciber","mv":"escudo","d":"Cuando un adulto engaña a un menor por internet para ganarse su confianza con malas intenciones.","l":"Si alguien me pide secretos o fotos, se lo cuento a un adulto de confianza. Eso es aura."},
  {"w":"ciberacoso","a":["ciberbullying","cyberbullying","bullying","acoso"],"t":"ciber","mv":"escudo","d":"Usar internet para molestar, humillar o amenazar a alguien.","l":"Yo no reenvío burlas. Apoyo al que la está pasando mal."},
  {"w":"sexting","t":"ciber","mv":"candado","d":"Enviar fotos o videos íntimos por internet. Una vez enviados, se pierde el control sobre ellos.","l":"Una foto enviada ya no es tuya. Si alguien te pide fotos íntimas, bloquea y cuéntalo."},
  {"w":"contraseña","a":["password","clave","contrasena","pin"],"t":"ciber","mv":"candado","d":"Tu llave secreta. Debe ser larga, única y no se presta.","l":"Mi contraseña es tan larga que necesita intermedio 🔐"},
  {"w":"doble factor","a":["2fa","autenticacion","autenticación","verificacion en dos pasos","verificación en dos pasos","dos pasos"],"t":"ciber","mv":"candado","d":"Un segundo candado: además de la contraseña, un código en tu celular.","l":"Activé el doble factor. Ahora mi cuenta tiene guardaespaldas."},
  {"w":"VPN","a":["vpn"],"t":"ciber","mv":"antena","d":"Un túnel cifrado para conectarte de forma más segura, sobre todo en wifi público.","l":"Wifi del centro comercial con VPN: modo agente secreto activado."},
  {"w":"control parental","a":["family link","control"],"t":"ciber","mv":"escudo","d":"Herramientas para que los adultos ajusten qué apps y contenidos usan los menores.","l":"El control parental no es desconfianza: es el cinturón de seguridad de internet."},
  {"w":"huella digital","a":["huella"],"t":"ciber","mv":"detective","d":"El rastro que dejas en internet con lo que publicas, comentas y buscas.","l":"Mi huella digital es tan limpia que brilla. Pienso antes de publicar."},
  {"w":"deepfake","a":["deep fake"],"t":"ciber","mv":"detective","d":"Video o audio falso hecho con inteligencia artificial que imita a una persona real.","l":"Si la abuela me pide plata por video, primero la llamo. Puede ser un deepfake."},
  {"w":"catfish","a":["perfil falso","cuenta falsa"],"t":"ciber","mv":"pesca","d":"Alguien que usa un perfil falso para hacerse pasar por otra persona.","l":"Foto de modelo, dice tener mi edad y “vive cerquita”… catfish detectado 🐟"},
  {"w":"spam","t":"ciber","mv":"pesca","d":"Mensajes masivos que no pediste, muchas veces con engaños.","l":"Spam a la papelera y yo, a farmear aura."},
  {"w":"troll","a":["trol","trolear"],"t":"ciber","mv":"escudo","d":"Alguien que comenta solo para provocar peleas.","l":"Al troll no se le da comida. Lo silencio y sigo con mi vida."},
  {"w":"hacker","a":["hackear","jaquear","hackeo","hackers"],"t":"chico","d":"En los videojuegos, alguien que usa trampas o programas para ganar. En seguridad, hay hackers éticos que protegen los sistemas.","c":"Alguien que usa trampas o programas para ganar en un juego","f":["Alguien que arregla computadores","Un leñador con hacha"],"ad":"¿Hacker? El señor que vino a arreglar el wifi, ¿no?","ch":"Ese jugador es hacker: reportado y bloqueado. Sin trampas se gana mejor.","mv":"robot"},
  {"w":"antivirus","t":"ciber","mv":"robot","d":"Programa que detecta y elimina software malicioso.","l":"Antivirus actualizado: mi celular está vacunado 💉"},
  {"w":"wifi","a":["wi-fi","wi fi","wifi publico","wifi público","red abierta","internet"],"t":"ciber","mv":"antena","d":"Red inalámbrica. Las redes públicas y abiertas pueden dejar ver lo que envías.","l":"En wifi público no entro al banco, aunque la red se llame “Confía_en_mí”."},
  {"w":"pantallazo","a":["captura","captura de pantalla","screenshot"],"t":"ciber","mv":"detective","d":"Foto de lo que hay en tu pantalla. Sirve como evidencia si alguien te acosa.","l":"Pantallazo, bloqueo y reporte: el combo de aura máxima."},
  {"w":"privacidad","a":["cuenta privada","privado"],"t":"ciber","mv":"candado","d":"Tu derecho a decidir qué información tuya ve cada persona.","l":"Cuenta privada: si no te conozco en la vida real, no pasas."},
  {"w":"estafa","a":["estafador","fraude"],"t":"ciber","mv":"pesca","d":"Engaño para quitarte plata o datos.","l":"Si es demasiado bueno para ser verdad, es estafa. Aura de detective."},
  {"w":"cookies","a":["cookie","galletas"],"t":"ciber","mv":"robot","d":"Archivos que guardan información de lo que haces en una página web.","l":"¿Cookies? Solo acepto las de chocolate… y reviso la configuración."},
  {"w":"bot","a":["bots"],"t":"ciber","mv":"robot","d":"Programa automático que puede hacerse pasar por persona en redes.","l":"Cuenta sin fotos, con nueve mil seguidos y cero seguidores: bot detectado 🤖"},
  {"w":"link","a":["enlace","links"],"t":"ciber","mv":"pesca","d":"Un enlace a otra página. Antes de abrirlo, revisa de dónde viene.","l":"Link raro no se toca. Primero miro a dónde lleva."},
  {"w":"inteligencia artificial","a":["ia","ai","chatgpt","claude"],"t":"ciber","mv":"robot","d":"Programas que aprenden de datos para escribir, crear imágenes o responder preguntas. Útil, pero hay que verificar lo que dice.","l":"La IA me ayuda, pero igual verifico. Robot con criterio 🤖"}
];

const SIT = [
  {r:'adulto',tema:'Desinformación',s:'Llega al grupo de la familia: “Si no reenvías esto a 10 contactos, WhatsApp empezará a cobrar”.',o:[
    {t:'Reenviarlo a 10 grupos, por si acaso.',a:-3000,r:'Cadena reenviada: la tía de la tía ya la recibió 14 veces.'},
    {t:'Responder “es falso” con un sticker de florecitas y un link de verificación.',a:5000,r:'Desmentir con cariño (y con stickers) es aura nivel experto.'},
    {t:'Mandar un audio de 7 minutos explicando por qué es falso.',a:1000,r:'Tenías razón, pero nadie llegó al minuto dos.'}],
    d:'Las cadenas usan el miedo para que reenvíes sin pensar. Antes de compartir, busca la noticia en un medio confiable o en un sitio de verificación de datos de tu país.',
    q:'¿Qué es lo más raro que te ha llegado por un grupo o por redes?'},
  {r:'adulto',tema:'Ciberseguridad',s:'Te llega un SMS: “Su paquete está retenido. Pague aquí para liberarlo”, con un link raro. No has pedido nada.',o:[
    {t:'Pagar rápido, es poquita plata.',a:-4000,r:'Fue poquita plata… y los datos completos de la tarjeta.'},
    {t:'No abrir el link y revisar en la app oficial de la transportadora.',a:5000,r:'Mensaje con prisa más link raro: no se toca. Aura de detective.'},
    {t:'Responder: “¿Y de qué paquete hablamos, mi amor?”.',a:1000,r:'Chistoso, pero al responder confirmas que tu número está activo.'}],
    d:'Esto se llama smishing: phishing por mensaje de texto. Las empresas no cobran por links acortados. Si dudas, entra tú a la página oficial.',
    q:'¿Alguna vez te llegó un mensaje que parecía real pero era trampa? Cuéntale a {p}.'},
  {r:'adulto',tema:'Privacidad',s:'Tu hijo o hija hizo el oso más tierno del año y quieres subir el video a Facebook, donde tienes 800 “amigos”.',o:[
    {t:'Subirlo ya, con la ubicación y el nombre del colegio.',a:-4000,r:'Ahora 800 personas (y sus amigos) saben dónde estudia.'},
    {t:'Preguntarle primero si le parece bien que lo publiques.',a:6000,r:'Pedir permiso es el aura más difícil de farmear. Lo lograste.'},
    {t:'Mandarlo “solo” al grupo de la familia, que tiene 48 personas.',a:500,r:'Menos gente, sí… pero el permiso también aplica en el grupo.'}],
    d:'Publicar la vida de los hijos sin preguntarles se llama sharenting. Todo lo que subimos arma su huella digital, y ellos también tienen derecho a decidir.',
    q:'¿Hay alguna foto tuya que no te gustaría que {p} publicara?'},
  {r:'adulto',tema:'Contraseñas',s:'El banco te pide una contraseña nueva. Tu idea brillante: tu nombre y tu año de nacimiento.',o:[
    {t:'Perfecto, nadie lo va a adivinar.',a:-3000,r:'Lo adivina cualquiera que haya visto tu perfil. O tu cédula.'},
    {t:'Una frase larga, como “ArepaConQuesitoEnElBalcón!”, guardada en un gestor de contraseñas.',a:5000,r:'Larga, única y deliciosa. Aura de bóveda bancaria.'},
    {t:'Anotarla en un papelito pegado a la pantalla.',a:-2000,r:'Aura del post-it: visible para todo el que pase.'}],
    d:'Una buena contraseña es larga (más de 12 caracteres), única para cada cuenta y difícil de adivinar. Un gestor como Bitwarden la recuerda por ti.',
    q:'¿Tus contraseñas son secretas o alguien más las sabe?'},
  {r:'adulto',tema:'Fraude telefónico',s:'Te llaman: “Le hablamos del banco. Para proteger su cuenta, dígame el código que le acaba de llegar”.',o:[
    {t:'Dar el código, suenan muy profesionales.',a:-5000,r:'Con ese código entraron a la cuenta. Aura en rojo.'},
    {t:'Colgar y llamar tú al número oficial del banco.',a:5000,r:'El banco nunca pide códigos. Colgar también es farmear aura.'},
    {t:'Decir: “Un momentico, le paso a alguien de la casa que sabe de esto”.',a:2000,r:'Aura delegada: no diste el código y además pediste ayuda.'}],
    d:'Se llama vishing, el fraude por llamada. Ningún banco te pide códigos, claves ni que instales apps por teléfono. Cuelga y llama tú.',
    q:'Si alguien llama diciendo que es de la familia y pide plata, ¿qué deberían hacer en casa?'},
  {r:'adulto',tema:'Bienestar digital',s:'Llevas dos horas viendo videos de recetas que nunca vas a cocinar… y le dices a tu hijo o hija que suelte el celular.',o:[
    {t:'Seguir viendo y decir: “Es diferente, yo soy adulto”.',a:-3000,r:'Aura de doble moral. Los chicos toman nota de todo.'},
    {t:'Proponer: a la hora de comer, todos los celulares descansan en la cocina.',a:5000,r:'Las reglas que aplican para todos sí se cumplen.'},
    {t:'Esconder tu celular dentro de una olla para no caer en la tentación.',a:1500,r:'Creativo. Raro, pero creativo.'}],
    d:'Los niños aprenden más de lo que ven que de lo que oyen. Los acuerdos de pantalla funcionan mejor cuando los adultos también los cumplen.',
    q:'¿En qué momentos sientes que {p} usa mucho el celular? Dilo con cariño.'},
  {r:'adulto',tema:'Wi-Fi público',s:'En el centro comercial aparece una red abierta llamada “WiFi_Gratis_100%_Real”. Quieres revisar el saldo del banco.',o:[
    {t:'Conectarte y entrar al banco de una.',a:-4000,r:'En una red abierta, otros pueden ver lo que envías.'},
    {t:'Usar tus datos móviles para el banco y el Wi-Fi solo para cosas sin claves.',a:5000,r:'Banco con datos propios: aura con candado.'},
    {t:'Preguntarle al señor de las empanadas si el Wi-Fi es confiable.',a:500,r:'El de las empanadas sabe de empanadas, no de redes.'}],
    d:'Las redes Wi-Fi abiertas no cifran tu información. Para el banco usa tus datos, o una VPN si no hay otra opción.',
    q:'¿Te conectas a redes Wi-Fi públicas? ¿Para qué las usas?'},
  {r:'adulto',tema:'Control parental',s:'Tu hijo o hija de 10 años te pide instalar un juego nuevo que tiene chat con desconocidos.',o:[
    {t:'Decir que sí sin mirar nada.',a:-3000,r:'El juego venía con chat abierto para todo el planeta.'},
    {t:'Configurarlo juntos: chat solo con amigos y control parental activado.',a:6000,r:'Ni prohibir ni soltar: acompañar. Aura de crianza digital.'},
    {t:'Prohibirlo todo sin explicar por qué.',a:-1000,r:'Lo más probable es que lo juegue donde un amigo, sin ti.'}],
    d:'Herramientas como Google Family Link o Tiempo en pantalla de Apple ayudan, pero lo que más protege es configurar juntos y explicar el porqué.',
    q:'¿Qué juego te gustaría que {p} aprendiera a jugar contigo?'},
  {r:'adulto',tema:'Comunicación',s:'Tu hijo o hija dice: “Eso fue muy random, bro, cero aura”.',o:[
    {t:'Responder: “Sí, sí, muy aura, mijo”.',a:500,r:'Aura de NPC: asentiste sin entender nada.'},
    {t:'Preguntar con curiosidad qué significa.',a:4000,r:'Preguntar sin juzgar abre más puertas que cualquier regla.'},
    {t:'Decir: “En mis tiempos se hablaba bien”.',a:-2000,r:'En tus tiempos también inventaban palabras. ¿O no?'}],
    d:'Cada generación inventa palabras. Mostrar curiosidad por su mundo digital hace que te cuenten más cosas, incluidas las difíciles.',
    q:'Enséñale a {p} una palabra que uses con tus amigos y cómo se usa.'},
  {r:'adulto',tema:'Ingeniería social',s:'Te escribe un número desconocido con la foto de tu sobrino: “Hola, cambié de número. Estoy en un lío, préstame plata urgente y no le digas a mi mamá”.',o:[
    {t:'Transferir de una. Es familia y está en problemas.',a:-5000,r:'Era un estafador usando la foto de tu sobrino. La plata no vuelve.'},
    {t:'Llamar a tu sobrino al número de siempre antes de hacer cualquier cosa.',a:5000,r:'Una llamada al número conocido desarma el engaño. Aura de familia protegida.'},
    {t:'Hacerle una pregunta que solo él sabría, como el nombre del perro de la casa.',a:1500,r:'Bien pensado, pero esas respuestas a veces están en redes. Lo más seguro es llamar.'}],
    d:'Esto se llama suplantación: alguien se hace pasar por un familiar y usa la prisa y el secreto para que no verifiques. Antes de enviar plata, llama al número que ya conocías.',
    q:'Inventen juntos una palabra clave familiar para confirmar que un mensaje urgente de verdad es de alguien de la casa.',both:true},
  {r:'adulto',tema:'Actualizaciones',s:'El celular lleva tres meses diciendo “Actualización disponible”.',o:[
    {t:'Tocar “Recordarme mañana” por día número 94.',a:-2000,r:'Mañana nunca llega, y los huecos de seguridad siguen abiertos.'},
    {t:'Actualizarlo esta noche mientras carga.',a:4000,r:'Actualizado y cargado: aura completa.'},
    {t:'Pedirle a tu hijo o hija que lo haga, a cambio de un helado.',a:2000,r:'Negocio justo. El helado también es aura.'}],
    d:'Las actualizaciones corrigen fallas que los delincuentes usan para entrar. Activa las actualizaciones automáticas.',
    q:'¿Le ayudas a {p} a revisar si sus apps están actualizadas? Háganlo juntos esta semana.'},
  {r:'adulto',tema:'Permisos de apps',s:'Descargas una app de linterna y te pide acceso a tus contactos, tus fotos y el micrófono.',o:[
    {t:'Aceptar todo. Total, es una linterna.',a:-3000,r:'Esa linterna ahora conoce a toda tu familia.'},
    {t:'Negar lo que no tiene sentido y borrar la app.',a:5000,r:'Una linterna solo necesita la linterna. Aura iluminada.'},
    {t:'Leer los términos y condiciones completos: 47 páginas.',a:500,r:'Valiente. Te dormiste en la página dos.'}],
    d:'Revisa los permisos de cada app. Si pide más de lo que necesita para funcionar, desconfía.',
    q:'¿Revisas qué permisos piden tus apps y juegos?'},

  {r:'chico',tema:'Estafas en juegos',s:'En un juego, alguien te ofrece 10.000 monedas gratis si le das tu usuario y contraseña.',o:[
    {t:'Dárselos. ¿Quién no quiere monedas gratis?',a:-5000,r:'Cuenta perdida, skins perdidas, aura perdida.'},
    {t:'Bloquear, reportar y contarle a un adulto.',a:6000,r:'Cero aura para el estafador. Toda para ti.'},
    {t:'Pedirle 20.000 para negociar.',a:-1000,r:'Negociar con un estafador no es aura, es skill issue.'}],
    d:'Nadie regala monedas virtuales como Robux, diamantes o pavos. Es una de las estafas más comunes en los juegos para robar cuentas.',
    q:'¿Alguna vez te intentaron estafar a ti? Cuéntale a {p} cómo fue.'},
  {r:'chico',tema:'Contacto con extraños',s:'Alguien con quien juegas hace semanas dice tener tu edad. Ahora te pide hablar por un chat privado y que no le cuentes a nadie.',o:[
    {t:'Pasar al chat privado. Ya es tu amigo.',a:-5000,r:'Si alguien te pide secretos, eso no es amistad.'},
    {t:'Decirle que no y contárselo a un adulto de confianza.',a:7000,r:'Contarlo nunca es ser chismoso. Es el aura más poderosa del juego.'},
    {t:'Responderle “NPC detectado” y seguir jugando.',a:1000,r:'Buen instinto, pero falta lo más importante: contarlo.'}],
    d:'Cuando alguien de internet busca tu confianza, te pide secretos o te lleva a chats privados, es una alerta roja. Cuéntalo siempre a un adulto de confianza.',
    q:'Prométele a {p} que, si te cuenta algo así, primero vas a escuchar, sin regaños ni castigos.'},
  {r:'chico',tema:'Ciberacoso',s:'En el grupo del salón están haciendo stickers con la cara de un compañero para burlarse de él.',o:[
    {t:'Mandar el sticker más gracioso.',a:-4000,r:'El que reenvía también hace parte del acoso.'},
    {t:'No reenviar, escribirle al compañero y avisar a un adulto.',a:6000,r:'Defender al otro: aura de protagonista.'},
    {t:'Salirte del grupo sin decir nada.',a:1000,r:'Algo es algo, pero tu compañero sigue solo.'}],
    d:'El ciberacoso duele igual que el acoso en persona, y no se queda en el colegio: llega hasta la casa. Guardar pantallazos y avisar ayuda a frenarlo.',
    q:'¿Viviste acoso escolar en tu época de colegio? ¿Qué te hubiera gustado que alguien hiciera?'},
  {r:'chico',tema:'Contraseñas',s:'Tu mejor amigo o amiga te pide tu contraseña de TikTok “como prueba de amistad”.',o:[
    {t:'Dársela. La amistad es primero.',a:-3000,r:'Las amistades cambian; las contraseñas regadas se quedan.'},
    {t:'Decirle: “La amistad no se mide en contraseñas”.',a:5000,r:'Frase de película. Aura de amistad de verdad.'},
    {t:'Darle la contraseña del Wi-Fi en vez de esa.',a:1500,r:'Jugada maestra… pero tampoco regales la del Wi-Fi.'}],
    d:'Las contraseñas son como el cepillo de dientes: no se prestan. Ni a la mejor amistad, ni al crush.',
    q:'¿Le has prestado tu contraseña a alguien? ¿Qué pasó?'},
  {r:'chico',tema:'Fotos y privacidad',s:'Una cuenta que no conoces te escribe: “Tienes cara de estrella. Mándanos unas fotos tuyas para un casting”.',o:[
    {t:'Mandarlas. ¡Voy a ser estrella!',a:-5000,r:'Una foto enviada ya no es tuya. Nunca sabes a dónde llega.'},
    {t:'No mandar nada, bloquear y contarle a un adulto.',a:6000,r:'Los castings de verdad hablan con tus papás. Aura protegida.'},
    {t:'Mandarles una foto de tu gato.',a:1500,r:'Aura felina, pero lo seguro es bloquear y contar.'}],
    d:'Pedir fotos con promesas de fama o regalos es una táctica de engaño. Ningún casting serio le escribe a un menor por mensaje privado.',
    q:'¿Qué harías si alguien le pidiera fotos a {p} por internet? Díganlo en voz alta.'},
  {r:'chico',tema:'Sueño y pantallas',s:'Son las 11:47 p. m., mañana hay colegio y el autoplay dice: “Siguiente video en 3, 2, 1…”.',o:[
    {t:'Uno más… (ya van 47).',a:-3000,r:'Mañana vas a ser un NPC en clase.'},
    {t:'Poner el celular a cargar fuera del cuarto y dormir.',a:5000,r:'Dormir es el power-up más subestimado.'},
    {t:'Ver el video con un ojo cerrado para “ir descansando”.',a:500,r:'Ingenioso, pero el cerebro no se lo cree.'}],
    d:'La luz de la pantalla engaña al cerebro y no lo deja dormir. Dejar el celular fuera del cuarto ayuda a descansar mejor.',
    q:'Sean honestos: ¿a qué hora suelta cada uno el celular en la noche?',both:true},
  {r:'chico',tema:'Retos virales',s:'Se volvió viral un reto peligroso que hay que grabar y subir para “demostrar valentía”.',o:[
    {t:'Hacerlo por los likes.',a:-5000,r:'El aura no se farmea en urgencias.'},
    {t:'Pasar de largo y avisarle a tu grupo que es peligroso.',a:5000,r:'Lo valiente es decir que no. Aura de líder.'},
    {t:'Inventar tu propio reto: 10 sentadillas con cara seria.',a:3000,r:'Reto seguro y chistoso. Eso sí se vuelve viral.'}],
    d:'Algunos retos virales han causado lesiones graves. Ningún like vale tu salud: si un reto te pone en riesgo, no es un reto, es una trampa.',
    q:'¿Cuál era el “reto” de moda cuando tenías la edad de {p}?'},
  {r:'chico',tema:'Phishing',s:'Te llega un link: “Skins gratis para tu juego favorito. Solo inicia sesión aquí”.',o:[
    {t:'Entrar e iniciar sesión.',a:-4000,r:'Esa página era falsa. Adiós cuenta.'},
    {t:'Ignorarlo: si es demasiado bueno para ser verdad, es estafa.',a:5000,r:'Detector de estafas al nivel máximo.'},
    {t:'Mandarlo al grupo del salón para que todos tengan skins.',a:-5000,r:'Acabas de estafar a todo el salón sin querer.'}],
    d:'El phishing imita páginas reales para robar tus datos. Revisa la dirección web y entra solo desde la app o la página oficial.',
    q:'¿Cómo sabes tú si un link es confiable? Comparen sus trucos.'},
  {r:'chico',tema:'Huella digital',s:'Estás con rabia y quieres dejar un comentario muy pesado en el video de alguien.',o:[
    {t:'Comentar sin pensar. Que le duela.',a:-3000,r:'Los pantallazos son para siempre. Tu rabia no.'},
    {t:'Esperar diez minutos y solo escribir lo que dirías en persona.',a:5000,r:'Pensar antes de publicar: aura de sabio.'},
    {t:'Escribirlo en las notas del celular y nunca enviarlo.',a:3000,r:'Desahogo sin víctimas. Bien jugado.'}],
    d:'Lo que se publica puede quedar guardado aunque lo borres. Antes de comentar, pregúntate: ¿se lo diría en la cara?',
    q:'¿Alguna vez escribiste algo en internet de lo que te arrepentiste?'},
  {r:'chico',tema:'Datos personales',s:'Quieres subir una historia desde la puerta de tu casa, con el uniforme del colegio puesto.',o:[
    {t:'Subirla tal cual. Me veo bien.',a:-3000,r:'Ahora cualquiera sabe dónde vives y dónde estudias.'},
    {t:'Subirla después, sin ubicación ni uniforme a la vista.',a:5000,r:'Mismo outfit, cero datos. Slay seguro.'},
    {t:'Taparte la cara con un emoji gigante, pero dejar la dirección visible.',a:-1000,r:'Escondiste lo que no era y mostraste lo que sí era.'}],
    d:'El uniforme, la fachada de la casa, las placas de los carros y la ubicación en vivo dan pistas de dónde estás. Compártelas solo con quien conoces.',
    q:'¿Qué cosas de la familia creen que no deberían publicarse? Hagan una lista corta.',both:true},
  {r:'chico',tema:'Autoestima',s:'Ves a un influencer con una “vida perfecta” y empiezas a sentirte mal contigo.',o:[
    {t:'Seguir viéndolo hasta sentirte peor.',a:-2000,r:'El algoritmo te va a mostrar más de lo mismo.'},
    {t:'Recordar que es un filtro y hablar con alguien de cómo te sientes.',a:5000,r:'Nadie vive en filtro. Hablarlo es aura real.'},
    {t:'Silenciar la cuenta y ver videos de gatos.',a:3000,r:'Proteger tu paz también es farmear aura.'}],
    d:'Lo que ves en redes está editado y escogido. Tu valor no se mide en likes ni en seguidores.',
    q:'¿Qué te hacía sentir inseguro o insegura cuando tenías la edad de {p}?'},
  {r:'chico',tema:'Compras en juegos',s:'Encuentras la tarjeta de crédito de la casa justo cuando el pase de batalla está en oferta.',o:[
    {t:'Comprarlo. Después explico.',a:-5000,r:'Aura en bancarrota. Y castigo incluido.'},
    {t:'Pedir permiso y proponer ganártelo con tareas de la casa.',a:5000,r:'Negociación transparente: aura de emprendedor.'},
    {t:'Comprar solo un poquito, que no se note.',a:-3000,r:'Se nota. Los extractos del banco se notan.'}],
    d:'Las compras dentro de los juegos suman rápido. Pedir permiso y acordar un presupuesto evita sustos (y regaños).',
    q:'¿Y si acuerdan un presupuesto mensual para juegos? Propongan una cifra entre los dos.',both:true}
];

// t: 'chico' = jerga actual, 'adulto' = expresiones de grandes, 'ciber' = vocabulario de seguridad

const RETOS = [
  'Elijan juntos el lugar donde duermen los celulares por la noche.',
  'Inventen una palabra clave familiar: si alguien llama diciendo ser de la familia y pide plata, se la preguntan.',
  'Revisen juntos la privacidad de una app que use el chico o la chica.',
  'Cada uno le enseña al otro su app o juego favorito durante 15 minutos.',
  'Activen el doble factor en una cuenta importante de cada uno.',
  'Acuerden una frase para pedir ayuda sin miedo: “Necesito contarte algo que pasó en internet”.',
  'Busquen juntos una noticia falsa reciente y descubran cómo la desmintieron.'
];

const BAD = ['hp','hpta','hijueputa','gonorrea','malparido','malparida','puta','puto','putas','mierda','marica','maricon','verga','culo','pendejo','pendeja','imbecil','idiota','estupido','estupida','fuck','shit','bitch','perra','zorra','chimba','carechimba','careverga','ptm','porno','xxx','nudes','sexo','tetas','pene','vagina'];


(function(){
'use strict';
const $ = (s, r=document) => r.querySelector(s);
const el = (tag, cls, txt) => { const e = document.createElement(tag); if (cls) e.className = cls; if (txt != null) e.textContent = txt; return e; };
const pick = a => a[Math.floor(Math.random() * a.length)];
const shuffle = a => { a = a.slice(); for (let i = a.length - 1; i > 0; i--) { const j = Math.floor(Math.random() * (i + 1)); [a[i], a[j]] = [a[j], a[i]]; } return a; };
const sleep = ms => new Promise(r => setTimeout(r, ms));
const fmt = n => Math.abs(n).toLocaleString('es-CO');
const signed = n => (n >= 0 ? '+' : '−') + fmt(n);
const norm = s => String(s).toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g, '').replace(/[^a-z0-9 ]/g, ' ').replace(/\s+/g, ' ').trim();
const fill = (s, ctx) => s.replace(/\{p\}/g, ctx.p).replace(/\{o\}/g, ctx.o);
const RM = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;

const store = {
  get(k, d) { try { const v = localStorage.getItem('tf-aura-' + k); return v == null ? d : JSON.parse(v); } catch (e) { return d; } },
  set(k, v) { try { localStorage.setItem('tf-aura-' + k, JSON.stringify(v)); } catch (e) {} }
};

/* ---------- Sound ---------- */
const Sfx = (() => {
  let ctx = null, on = store.get('sound', true), noise = null, music = null;
  function ensure() {
    if (!on) return null;
    if (!ctx) { try { ctx = new (window.AudioContext || window.webkitAudioContext)(); } catch (e) { return null; } }
    if (ctx.state === 'suspended') ctx.resume();
    return ctx;
  }
  function getNoise(c) {
    if (noise) return noise;
    const len = Math.floor(c.sampleRate * 1.6);
    noise = c.createBuffer(1, len, c.sampleRate);
    const d = noise.getChannelData(0);
    for (let i = 0; i < len; i++) d[i] = Math.random() * 2 - 1;
    return noise;
  }
  function env(g, t, a, peak, d) { g.gain.setValueAtTime(0.0001, t); g.gain.exponentialRampToValueAtTime(peak, t + a); g.gain.exponentialRampToValueAtTime(0.0001, t + d); }
  function nz(c, t, o = {}) {
    const s = c.createBufferSource(); s.buffer = getNoise(c);
    const f = c.createBiquadFilter(); f.type = o.type || 'bandpass'; f.frequency.value = o.f || 1200; f.Q.value = o.q ?? 0.8;
    const g = c.createGain(); env(g, t, 0.004, o.vol || 0.2, o.d || 0.09);
    s.connect(f).connect(g).connect(o.dest || c.destination);
    s.start(t, Math.random() * 0.8, (o.d || 0.09) + 0.05);
  }
  function tone(c, type, f0, f1, t, d, vol, dest) {
    const o = c.createOscillator(); o.type = type; o.frequency.setValueAtTime(f0, t);
    if (f1) o.frequency.exponentialRampToValueAtTime(f1, t + d);
    const g = c.createGain(); env(g, t, 0.02, vol, d);
    o.connect(g).connect(dest || c.destination); o.start(t); o.stop(t + d + 0.05);
  }
  function applause(dur = 1.8, density = 26, vol = 0.22) {
    const c = ensure(); if (!c) return;
    const t0 = c.currentTime + 0.02, n = Math.round(dur * density);
    for (let i = 0; i < n; i++) { const t = t0 + Math.random() * dur; const fade = 1 - ((t - t0) / dur) * 0.65; nz(c, t, { f: 1000 + Math.random() * 1000, vol: vol * fade * (0.45 + Math.random() * 0.55), d: 0.085 }); }
  }
  function aura() {
    const c = ensure(); if (!c) return; const t = c.currentTime + 0.01;
    tone(c, 'sine', 392, 1568, t, 0.55, 0.16); tone(c, 'triangle', 523, 2093, t + 0.05, 0.6, 0.07);
    [1319, 1568, 2093, 2637].forEach((f, i) => tone(c, 'sine', f, null, t + 0.36 + i * 0.07, 0.28, 0.055));
  }
  function fail() {
    const c = ensure(); if (!c) return; const t = c.currentTime + 0.01;
    [392, 370, 349, 311].forEach((f, i) => {
      const st = t + i * 0.27, d = i === 3 ? 0.75 : 0.25;
      const o = c.createOscillator(); o.type = 'sawtooth'; o.frequency.setValueAtTime(f, st);
      if (i === 3) o.frequency.linearRampToValueAtTime(f * 0.93, st + d);
      const lp = c.createBiquadFilter(); lp.type = 'lowpass'; lp.frequency.value = 850;
      const g = c.createGain(); env(g, st, 0.03, 0.08, d);
      o.connect(lp).connect(g).connect(c.destination); o.start(st); o.stop(st + d + 0.05);
    });
  }
  function tick() { const c = ensure(); if (!c) return; tone(c, 'square', 900, null, c.currentTime, 0.035, 0.03); }
  function pop() { const c = ensure(); if (!c) return; tone(c, 'sine', 520, 1250, c.currentTime, 0.13, 0.12); }
  function boom() { const c = ensure(); if (!c) return; const t = c.currentTime + 0.01; tone(c, 'sine', 100, 28, t, 1.1, 0.55); nz(c, t, { type: 'lowpass', f: 450, q: 0.4, vol: 0.4, d: 0.7 }); }
  function sweep(f0, f1, f2, d, vol) {
    const c = ensure(); if (!c) return; const t = c.currentTime + 0.01;
    const s = c.createBufferSource(); s.buffer = getNoise(c);
    const f = c.createBiquadFilter(); f.type = 'bandpass'; f.Q.value = 1.6;
    f.frequency.setValueAtTime(f0, t); f.frequency.exponentialRampToValueAtTime(f1, t + d * (f2 ? 0.5 : 1)); if (f2) f.frequency.exponentialRampToValueAtTime(f2, t + d);
    const g = c.createGain(); g.gain.setValueAtTime(0.0001, t); g.gain.exponentialRampToValueAtTime(vol, t + d * 0.4); g.gain.exponentialRampToValueAtTime(0.0001, t + d);
    s.connect(f).connect(g).connect(c.destination); s.start(t, 0, d + 0.05);
  }
  const whoosh = (d = 0.5) => sweep(300, 3200, 0, d, 0.25);
  const scratch = () => sweep(700, 3200, 500, 0.32, 0.3);
  function bonk() { const c = ensure(); if (!c) return; const t = c.currentTime + 0.01; tone(c, 'sine', 420, 110, t, 0.28, 0.3); tone(c, 'triangle', 950, 300, t, 0.1, 0.1); }
  function glitch() { const c = ensure(); if (!c) return; const t = c.currentTime + 0.01; for (let i = 0; i < 12; i++) tone(c, 'square', 180 + Math.random() * 1100, null, t + i * 0.045, 0.035, 0.05); }
  function deflate() { const c = ensure(); if (!c) return; const t = c.currentTime + 0.01; tone(c, 'sine', 900, 160, t, 0.95, 0.13); nz(c, t, { type: 'lowpass', f: 900, vol: 0.12, d: 0.6 }); }
  function crack() { const c = ensure(); if (!c) return; const t = c.currentTime + 0.01; nz(c, t, { type: 'highpass', f: 2500, vol: 0.4, d: 0.05 }); nz(c, t + 0.07, { type: 'highpass', f: 2000, vol: 0.3, d: 0.05 }); }
  function roll(d = 0.45) {
    const c = ensure(); if (!c) return; const t = c.currentTime + 0.01, n = 12;
    for (let k = 0; k < n; k++) { const x = k / n; nz(c, t + d * (1 - Math.pow(1 - x, 1.6)), { type: 'highpass', f: 1600, vol: 0.05 + x * 0.1, d: 0.05 }); }
  }
  function stopMusic() {
    if (music && ctx) {
      const g = music, now = ctx.currentTime;
      try { g.gain.cancelScheduledValues(now); g.gain.setValueAtTime(g.gain.value, now); g.gain.linearRampToValueAtTime(0, now + 0.15); } catch (e) {}
      setTimeout(() => { try { g.disconnect(); } catch (e) {} }, 400);
      music = null;
    }
  }
  function phonk(d = 2.4, inten = 1) {
    const c = ensure(); if (!c) return; stopMusic();
    const bus = c.createGain(); bus.gain.value = 1; bus.connect(c.destination); music = bus;
    const t0 = c.currentTime + 0.02, step = 0.2, n = Math.max(2, Math.floor(d / step));
    const mel = [659, 659, 784, 659, 587, 523, 587, 659, 659, 784, 880, 784, 659, 587, 523, 494];
    for (let i = 0; i < n; i++) {
      const t = t0 + i * step;
      const bp = c.createBiquadFilter(); bp.type = 'bandpass'; bp.frequency.value = mel[i % 16] * 1.4; bp.Q.value = 1.5;
      const g = c.createGain(); env(g, t, 0.004, 0.05 * inten, 0.24); bp.connect(g).connect(bus);
      [mel[i % 16], mel[i % 16] * 1.48].forEach(fr => { const o = c.createOscillator(); o.type = 'square'; o.frequency.value = fr; o.connect(bp); o.start(t); o.stop(t + 0.28); });
      if (i % 4 === 0 || (i % 4 === 3 && inten > 0.8)) { const o = c.createOscillator(); o.type = 'sine'; o.frequency.setValueAtTime(150, t); o.frequency.exponentialRampToValueAtTime(42, t + 0.3); const kg = c.createGain(); env(kg, t, 0.005, 0.32 * inten, 0.38); o.connect(kg).connect(bus); o.start(t); o.stop(t + 0.42); }
      if (i % 2 === 1) nz(c, t, { type: 'highpass', f: 7000, vol: 0.03, d: 0.03, dest: bus });
    }
  }
  function clank() { const c = ensure(); if (!c) return; const t = c.currentTime + 0.01; tone(c, 'square', 880, 440, t, 0.12, 0.07); tone(c, 'triangle', 1320, 660, t + 0.03, 0.3, 0.1); nz(c, t, { type: 'highpass', f: 3000, vol: 0.28, d: 0.06 }); }
  function beep() { const c = ensure(); if (!c) return; const t = c.currentTime + 0.01; tone(c, 'square', 1000, null, t, 0.07, 0.05); tone(c, 'square', 1000, null, t + 0.12, 0.07, 0.05); tone(c, 'square', 700, null, t + 0.26, 0.2, 0.05); }
  function zap() { const c = ensure(); if (!c) return; const t = c.currentTime + 0.01; tone(c, 'sawtooth', 220, 1900, t, 0.28, 0.06); tone(c, 'sine', 440, 2600, t + 0.05, 0.3, 0.05); }
  return { applause, aura, fail, tick, pop, boom, whoosh, scratch, bonk, glitch, deflate, crack, roll, phonk, stopMusic, clank, beep, zap, get on() { return on; }, set(v) { on = v; store.set('sound', v); if (v) ensure(); else stopMusic(); } };
})();

/* ---------- Character builder ---------- */
const VIEWS = { full:'0 0 140 220', head:'28 9 84 84', torso:'27 80 86 86', legs:'28 134 84 84', feet:'30 174 80 40', hand:'80 104 54 54' };
function legSVG(side, L, B) {
  const left = side === 'l', hip = left ? 61 : 79, ank = left ? 59 : 81, foot = left ? 56 : 84, bc = B.fixed || L.bottomColor, sk = L.skin;
  let s = '';
  if (B.k === 'pants') {
    s += `<path d="M${hip} 150 L${ank} 195" stroke="${bc}" stroke-width="${B.thin ? 11.5 : 14}" stroke-linecap="round"/>`;
    if (B.cuff) s += `<path d="M${ank} 189 L${ank} 194" stroke="${shade(bc, -0.25)}" stroke-width="15"/>`;
    if (B.seam) s += `<path d="M${hip + (left ? 3 : -3)} 154 L${ank + (left ? 3 : -3)} 191" stroke="${shade(bc, 0.3)}" stroke-width="1"/>`;
    if (B.crease) s += `<path d="M${hip} 155 L${ank} 192" stroke="${shade(bc, -0.2)}" stroke-width="1"/>`;
  } else if (B.k === 'wide') {
    s += `<path d="M${hip} 150 L${left ? ank - 2 : ank + 2} 193" stroke="${bc}" stroke-width="19" stroke-linecap="round"/><rect x="${left ? hip - 12 : hip + 4}" y="164" width="8" height="10" rx="1.5" fill="${shade(bc, -0.15)}"/>`;
  } else if (B.k === 'shorts') {
    s += `<path d="M${hip} 150 L${ank} 195" stroke="${sk}" stroke-width="11" stroke-linecap="round"/><path d="M${hip} 150 L${(hip + ank) / 2 + (left ? -1 : 1)} 170" stroke="${bc}" stroke-width="16" stroke-linecap="round"/>`;
  } else {
    s += `<path d="M${hip} 150 L${ank} 195" stroke="${sk}" stroke-width="11" stroke-linecap="round"/>`;
  }
  s += (SHOES[L.shoes] || SHOES.tenis).f(foot, L.shoesColor, L);
  return `<g class="leg leg-${side}">${s}</g>`;
}
function hipsSVG(L, T, B, tx, tw) {
  if (T.dress) return `<path d="M${tx + 2} 132 L${tx - 7} 167 L${tx + tw + 7} 167 L${tx + tw - 2} 132Z" fill="${L.topColor}"/><path d="M${tx - 6} 164 L${tx + tw + 6} 164" stroke="${shade(L.topColor, -0.2)}" stroke-width="3"/>`;
  if (B.k === 'skirt') {
    let s = `<path d="M${tx + 1} 138 L${tx - 7} 166 L${tx + tw + 7} 166 L${tx + tw - 1} 138Z" fill="${L.bottomColor}"/>`;
    if (B.pleats) { const c = shade(L.bottomColor, -0.25); for (let i = 1; i < 6; i++) { const x0 = tx + (tw * i) / 6, x1 = tx - 7 + ((tw + 14) * i) / 6; s += `<path d="M${x0} 142 L${x1} 165" stroke="${c}" stroke-width="1.4"/>`; } }
    return s;
  }
  return '';
}
function armSVG(side, L, T) {
  const left = side === 'l', sx = left ? 48 : 92, ex = left ? 41.5 : 98.5, wx = left ? 35 : 105, hx = left ? 34 : 106;
  const sl = T.sl, col = L.topColor;
  const foreCol = sl === 'long' ? col : L.skin, upCol = sl === 'none' ? L.skin : col;
  const foreW = sl === 'long' ? 12 : 10.5, upW = sl === 'none' ? 11 : (sl === 'long' ? 12.5 : 13.5);
  let props = '';
  if (!left) {
    props = `<g class="prop-user">${(HAND[L.hand] || {}).s || ''}</g>` +
      `<g class="tp tp-rod"><path d="M104 150 L141 64" stroke="#8B5A2B" stroke-width="3" stroke-linecap="round"/><path d="M141 64 Q147 98 143 126" stroke="#fff" stroke-width="1" fill="none"/><path d="M143 126 q3 4 0 6" stroke="#ddd" stroke-width="1.4" fill="none"/><circle cx="105" cy="147" r="4" fill="#3B3B3B"/></g>` +
      `<g class="tp tp-lupa"><path d="M106 146 L117 127" stroke="#5B3A26" stroke-width="4" stroke-linecap="round"/><circle cx="122" cy="118" r="10" fill="rgba(180,230,255,.45)" stroke="#283A60" stroke-width="3"/><path d="M117 113 q3 -3 7 -2" stroke="#fff" stroke-width="1.6" fill="none"/></g>` +
      `<g class="tp tp-tel"><rect x="99" y="127" width="14" height="24" rx="3" fill="#1E2B47"/><rect x="101" y="130" width="10" height="16" rx="1.5" fill="#3DAEE4"/></g>`;
  }
  const fore = `<g class="fore fore-${side}"><path d="M${ex} 122.5 L${wx} 141" stroke="${foreCol}" stroke-width="${foreW}" stroke-linecap="round"/>${props}<circle cx="${hx}" cy="146" r="7.5" fill="${L.skin}"/></g>`;
  const up = `<path d="M${sx} 104 L${ex} 122.5" stroke="${upCol}" stroke-width="${upW}" stroke-linecap="round"/>`;
  return `<g class="arm arm-${side}">${fore}${up}</g>`;
}
function charSVG(L, view = 'full') {
  const T = TOP[L.top] || TOP.camiseta, B = BOTTOM[L.bottom] || BOTTOM.jean, H = HAIR[L.hair] || HAIR.corto;
  const tw = (BUILD[L.build] || BUILD.normal).w, tx = 70 - tw / 2, tr = tw >= 58 ? 26 : (tw <= 46 ? 18 : 20);
  const base = T.base || L.topColor, ink = isLight(base) ? '#283A60' : '#FFFFFF';
  const hc = L.hairColor, a = L.acc, brow = shade(hc, -0.25);
  const P = PRINT[L.print] || PRINT.ninguno, D = DETAIL[L.detail] || DETAIL.ninguno, BR = BEARD[L.beard] || BEARD.ninguna;
  const G = GLASSES[L.glasses] || GLASSES.ninguna, HA = HEADACC[L.headAcc] || HEADACC.ninguno, E = EARS[L.ears] || EARS.ninguno, N = NECK[L.neck] || NECK.ninguno;
  return `<svg viewBox="${VIEWS[view] || VIEWS.full}" class="cs" aria-hidden="true" focusable="false">
${view === 'full' ? '<ellipse cx="70" cy="206" rx="36" ry="7" fill="rgba(0,0,0,.3)"/>' : ''}
<g class="body-all">
${legSVG('l', L, B)}${legSVG('r', L, B)}
${hipsSVG(L, T, B, tx, tw)}
<g class="upper">
<rect x="63" y="80" width="14" height="16" rx="5" fill="${L.skin}"/>
<rect class="torso" x="${tx}" y="91" width="${tw}" height="64" rx="${tr}" fill="${base}"/>
${P.f ? P.f(ink, tx, tw) : ''}${T.x ? T.x(L.topColor, L, tx, tw) : ''}${N.f ? N.f(a) : ''}
<g class="tp tp-gtr"><path d="M42 106 L80 133" stroke="#fff" stroke-width="3" stroke-dasharray="4 3" stroke-linecap="round"/><ellipse cx="86" cy="137" rx="13" ry="10" fill="rgba(255,255,255,.12)" stroke="#fff" stroke-width="2" stroke-dasharray="4 3" transform="rotate(34 86 137)"/><circle cx="84" cy="135" r="3" fill="none" stroke="#fff" stroke-width="1.6"/></g>
${armSVG('l', L, T)}${armSVG('r', L, T)}
<g class="head">
${H.b ? H.b(hc, a) : ''}
<circle cx="41" cy="61" r="6.5" fill="${L.skin}"/><circle cx="99" cy="61" r="6.5" fill="${L.skin}"/>
<circle cx="70" cy="57" r="30" fill="${L.skin}"/>
${E.f ? E.f(a) : ''}
<circle cx="54" cy="67" r="5" fill="#F07C6C" opacity=".3"/><circle cx="86" cy="67" r="5" fill="#F07C6C" opacity=".3"/>
${D.u ? D.u() : ''}${BR.u ? BR.u(hc) : ''}
<g class="eyes"><g class="eyes-in"><circle cx="59" cy="57" r="3.8" fill="#1B1F33"/><circle cx="81" cy="57" r="3.8" fill="#1B1F33"/><circle cx="60.3" cy="55.7" r="1.2" fill="#fff"/><circle cx="82.3" cy="55.7" r="1.2" fill="#fff"/></g>
<g class="eyes-x"><path d="M55.5 53.5 L62 57 L55.5 60.5 M84.5 53.5 L78 57 L84.5 60.5" stroke="#1B1F33" stroke-width="2.6" fill="none" stroke-linecap="round" stroke-linejoin="round"/></g>
<g class="eyes-hap"><path d="M55 58.5 Q59 53 63 58.5 M77 58.5 Q81 53 85 58.5" stroke="#1B1F33" stroke-width="2.8" fill="none" stroke-linecap="round"/></g></g>
${D.o ? D.o() : ''}
<path d="M53 48 Q59 45 65 48 M75 48 Q81 45 87 48" stroke="${brow}" stroke-width="2.8" fill="none" stroke-linecap="round"/>
<g class="mouth">
<path class="m m-smile" d="M61 70.5 Q70 78 79 70.5" stroke="#5A2430" stroke-width="2.8" fill="none" stroke-linecap="round"/>
<path class="m m-big" d="M58 68.5 Q70 89 82 68.5 Z" fill="#5A2430"/>
<path class="m m-sad" d="M61 77 Q70 70 79 77" stroke="#5A2430" stroke-width="2.8" fill="none" stroke-linecap="round"/>
<ellipse class="m m-o" cx="70" cy="73.5" rx="5" ry="6.5" fill="#5A2430"/>
<path class="m m-smirk" d="M62 72.5 Q73 77.5 81 68.5" stroke="#5A2430" stroke-width="2.8" fill="none" stroke-linecap="round"/>
</g>
${BR.o ? BR.o(hc) : ''}${H.f ? H.f(hc, a) : ''}${G.f ? G.f(a) : ''}${HA.f ? HA.f(a) : ''}
<g class="shades"><rect x="48.5" y="50" width="19" height="12" rx="5" fill="#0F1422"/><rect x="72.5" y="50" width="19" height="12" rx="5" fill="#0F1422"/><path d="M67 54 h6 M48.5 54 L41 52 M91.5 54 L99 52" stroke="#0F1422" stroke-width="2.6" stroke-linecap="round"/><path d="M52 53.5 h5 M76 53.5 h5" stroke="rgba(255,255,255,.6)" stroke-width="2" stroke-linecap="round"/></g>
</g>
</g>
</g></svg>`;
}
function fixLook(L, role) {
  const base = blankLook(), out = Object.assign({}, base, L || {});
  const maps = { hair: HAIR, beard: BEARD, detail: DETAIL, glasses: GLASSES, headAcc: HEADACC, ears: EARS, neck: NECK, top: TOP, print: PRINT, bottom: BOTTOM, shoes: SHOES, hand: HAND, build: BUILD };
  Object.entries(maps).forEach(([k, m]) => { if (!m[out[k]]) out[k] = base[k]; });
  ['skin', 'hairColor', 'topColor', 'bottomColor', 'shoesColor', 'acc'].forEach(k => { if (!/^#[0-9a-fA-F]{6}$/.test(out[k] || '')) out[k] = base[k]; });
  if (role !== 'adulto') out.beard = 'ninguna';
  out.build = 'normal'; out.print = 'ninguno';
  return out;
}

/* ---------- Audience ---------- */
function buildAudience() {
  const bodies = ['#2C3F69', '#33497A', '#2A3B63', '#3A5288', '#304574'];
  const heads = ['#46608F', '#52699A', '#3F5786', '#5A73A3', '#4B6595'];
  const hats = ['', '', '', 'bun', 'cap', 'curl', ''];
  function person(x, y, s) {
    const b = pick(bodies), h = pick(heads), hat = pick(hats), d = (-Math.random() * 0.5).toFixed(2);
    let extra = '';
    if (hat === 'bun') extra = `<circle cx="0" cy="-34" r="8" fill="${h}"/>`;
    if (hat === 'cap') extra = `<path d="M-19 -18 Q-18 -36 0 -36 Q18 -36 19 -18Z" fill="${b}"/><path d="M8 -20 Q22 -22 28 -16 Q18 -14 8 -16Z" fill="${b}"/>`;
    if (hat === 'curl') extra = `<g fill="${h}"><circle cx="-14" cy="-24" r="9"/><circle cx="0" cy="-31" r="10"/><circle cx="14" cy="-24" r="9"/></g>`;
    return `<g class="person" style="--d:${d}s"><g transform="translate(${x.toFixed(1)} ${y}) scale(${s})">
<path d="M-32 60 Q-32 8 0 8 Q32 8 32 60Z" fill="${b}"/>${extra}<circle cx="0" cy="-12" r="20" fill="${h}"/>
<g class="hl"><circle cx="-10" cy="24" r="7.5" fill="${h}"/></g><g class="hr"><circle cx="10" cy="24" r="7.5" fill="${h}"/></g></g></g>`;
  }
  let back = '', front = '';
  for (let i = 0; i < 15; i++) back += person(20 + i * (960 / 14) + (Math.random() * 14 - 7), 82, 0.82);
  for (let i = 0; i < 12; i++) front += person(55 + i * (890 / 11) + (Math.random() * 14 - 7), 112, 1);
  return `<svg viewBox="0 0 1000 130" preserveAspectRatio="xMidYMax slice" aria-hidden="true">${back}${front}</svg>`;
}

/* ---------- DOM refs ---------- */
const stage = $('#stage'), fx = $('#fx'), aud = $('#audience'), neon = $('#neon'), cam = $('#cam'), backfx = $('#backfx'), speed = $('#speed'), movecard = $('#movecard'), flashov = $('#flashov');
const actors = [$('#actor0'), $('#actor1')];
const bubbles = [$('#bubble0'), $('#bubble1')];
const tails = [$('#tail0'), $('#tail1')];
const spots = [$('#spot0'), $('#spot1')];
const panel = $('#panel');
const charEl = i => actors[i].querySelector('.char');
const POSES = ['win', 'lose', 'laugh', 'shock', 'think', 'pop'];
let gen = 0;
const later = (ms, fn) => { const g = gen; setTimeout(() => { if (g === gen) fn(); }, ms); };

function setPose(i, pose) { const c = charEl(i); POSES.forEach(p => c.classList.remove(p)); if (pose) { void c.offsetWidth; c.classList.add(pose); } }
function setExpr(i, e) { const c = charEl(i); c.classList.remove('expr-happy', 'expr-sad', 'expr-shock', 'expr-cool', 'expr-laugh', 'expr-pain', 'expr-zen'); if (e) c.classList.add('expr-' + e); }

function placeTail(i) {
  const sr = stage.getBoundingClientRect(), br = bubbles[i].getBoundingClientRect(), ar = actors[i].getBoundingClientRect();
  const ax = ar.left + ar.width / 2 - sr.left;
  const min = br.left - sr.left + 18, max = br.right - sr.left - 34;
  const x = Math.max(min, Math.min(max, ax - 8));
  tails[i].style.left = x + 'px';
  tails[i].style.top = (br.bottom - sr.top - 1) + 'px';
  tails[i].style.transform = ax < br.left - sr.left + br.width / 2 ? 'scaleX(-1)' : 'none';
}
function say(i, text, opts = {}) {
  const b = bubbles[i], c = charEl(i);
  b.textContent = text; b.classList.add('show'); tails[i].classList.add('show');
  requestAnimationFrame(() => placeTail(i));
  c.classList.add('talking');
  const d = Math.min(3200, Math.max(1100, text.length * 55));
  clearTimeout(b._t1); clearTimeout(b._t2);
  b._t1 = setTimeout(() => c.classList.remove('talking'), opts.keep ? 1300 : d);
  if (!opts.keep) b._t2 = setTimeout(() => hideBubble(i), d + (opts.hold ?? 2600));
  updateNeon();
}
function hideBubble(i) { bubbles[i].classList.remove('show'); tails[i].classList.remove('show'); charEl(i).classList.remove('talking'); updateNeon(); }
function clearBubbles() { [0, 1].forEach(i => { clearTimeout(bubbles[i]._t1); clearTimeout(bubbles[i]._t2); hideBubble(i); }); }
function updateNeon() { stage.classList.toggle('speaking', bubbles.some(b => b.classList.contains('show'))); }
window.addEventListener('resize', () => [0, 1].forEach(i => { if (bubbles[i].classList.contains('show')) placeTail(i); }));

function walk(i, ms = 950) { const c = charEl(i); c.classList.add('walking'); setTimeout(() => c.classList.remove('walking'), RM ? 10 : ms); }
function setForward(pi) {
  [0, 1].forEach(i => {
    const want = pi === 'both' ? true : pi === i;
    if (actors[i].classList.contains('fwd') !== want) { actors[i].classList.toggle('fwd', want); walk(i); }
  });
  spots.forEach((s, i) => s.classList.toggle('on', pi === 'both' || pi === i));
  stage.classList.toggle('finale', pi === 'both');
}

function actorPoint(i) {
  const sr = stage.getBoundingClientRect(), ar = charEl(i).getBoundingClientRect();
  return { x: (ar.left + ar.width / 2 - sr.left) / sr.width * 100, y: (ar.top - sr.top) / sr.height * 100, h: ar.height / sr.height * 100 };
}
function floatText(i, txt, cls) {
  const p = actorPoint(i), f = el('div', 'float ' + cls, txt);
  f.style.left = p.x + '%'; f.style.top = Math.max(2, p.y + p.h * 0.05) + '%';
  fx.append(f); setTimeout(() => f.remove(), 2200);
}
function sparkles(i, n = 16) {
  if (RM) return;
  const p = actorPoint(i), cols = ['#FDBE30', '#3DAEE4', '#FFFFFF', '#FFE08A'];
  for (let k = 0; k < n; k++) {
    const s = el('span', 'spark'); const a = Math.random() * Math.PI * 2, r = 60 + Math.random() * 90;
    s.style.left = p.x + '%'; s.style.top = (p.y + p.h * 0.4) + '%'; s.style.background = pick(cols);
    s.style.setProperty('--dx', Math.cos(a) * r + 'px'); s.style.setProperty('--dy', Math.sin(a) * r + 'px');
    fx.append(s); setTimeout(() => s.remove(), 1000);
  }
}
function emoji(i, e, n = 1) {
  const p = actorPoint(i);
  for (let k = 0; k < n; k++) {
    const s = el('span', 'emo', e);
    s.style.left = (p.x + (Math.random() * 16 - 8)) + '%'; s.style.top = (p.y + p.h * 0.1) + '%';
    s.style.setProperty('--r', (Math.random() * 40 - 20) + 'deg'); s.style.animationDelay = (k * 0.15) + 's';
    fx.append(s); setTimeout(() => s.remove(), 1800 + k * 150);
  }
}
function audClaps(n) {
  for (let k = 0; k < n; k++) {
    const s = el('span', 'emo', '👏');
    s.style.left = (8 + Math.random() * 84) + '%'; s.style.top = (78 + Math.random() * 8) + '%';
    s.style.animationDelay = (Math.random() * 0.9) + 's';
    fx.append(s); setTimeout(() => s.remove(), 2700);
  }
}
let audT = null;
function audience(mode, ms) {
  clearTimeout(audT); aud.classList.remove('clap', 'laugh'); void aud.offsetWidth; aud.classList.add(mode);
  audT = setTimeout(() => aud.classList.remove(mode), ms);
}
function flashNeon() { neon.classList.add('flash'); setTimeout(() => neon.classList.remove('flash'), 1400); }
function confetti() {
  if (RM) return;
  const cols = ['#FDBE30', '#3DAEE4', '#EF4A37', '#FFFFFF'];
  for (let k = 0; k < 70; k++) {
    const c = el('span', 'confetti'); c.style.left = Math.random() * 100 + '%'; c.style.background = pick(cols);
    c.style.setProperty('--t', (2.2 + Math.random() * 1.8) + 's'); c.style.setProperty('--dx', (Math.random() * 120 - 60) + 'px');
    c.style.setProperty('--rot', (Math.random() * 900 - 450) + 'deg'); c.style.animationDelay = Math.random() * 0.8 + 's';
    fx.append(c); setTimeout(() => c.remove(), 5000);
  }
}

/* ---------- Moves ---------- */
const MOVES = {
  bote:{name:'Bote legendario', dur:2800, hit:1000, emo:'🗿'},
  giro:{name:'Giro de los lentes', dur:2400, hit:1560, emo:'😎', wind:true, whoosh:400},
  rodilla:{name:'Rodillazo de campeón', dur:2600, hit:1250, emo:'🔥', floor:true, whoosh:420},
  poder:{name:'Despertar del aura', dur:2800, hit:1290, emo:'⚡', shake:true, boom:true, bolts:true, charge:true},
  moon:{name:'Moonwalk de la verdad', dur:2600, hit:1720, emo:'🕶️'},
  mortal:{name:'Mortal sigma', dur:2600, hit:1300, emo:'💥', shake:true, boom:true, ring:true, whoosh:450},
  explosion:{name:'Caminata de la explosión', dur:3000, hit:620, emo:'🗿', blast:true, shake:true, boom:true},
  pelo:{name:'Melena al viento', dur:2400, hit:950, emo:'✨', wind:true},
  floss:{name:'Floss turbo', dur:2200, hit:1300, emo:'🔥'},
  salsa:{name:'Salsa de fiesta', dur:2600, hit:1800, emo:'💃'},
  pesca:{name:'Pesca al revés', dur:3200, hit:1790, emo:'🎣', big:'🐟', whoosh:600},
  candado:{name:'Candado humano', dur:3000, hit:1710, big:'🔐', snd:'clank', ring:true, flash:true},
  antena:{name:'Antena 5G', dur:3000, hit:1500, big:'📶', snd:'zap', waves:[600, 900, 1200, 1500, 1800]},
  escudo:{name:'Escudo legendario', dur:3200, hit:1216, big:'🛡️', ring:true, boom:true, shake:true, whoosh:300},
  detective:{name:'Lupa detective', dur:3400, hit:1700, big:'🔍', emo:'‼️', flash:true},
  zen:{name:'Levitación zen', dur:3400, hit:1500, emo:'🧘', big:'✨', glowAt:500, expr:'zen'},
  robot:{name:'Robot actualizado', dur:3200, hit:2110, emo:'🤖', snd:'zap', loadbar:true},
  cuelgue:{name:'Cuelgue legendario', dur:3000, hit:1560, emo:'📞', fly:'📵', snd:'beep', flash:true},
  breakdance:{name:'Breakdance de campeonato', dur:3400, hit:2176, emo:'❄️', whoosh:550, flash:true, shake:true},
  split:{name:'Salto de split', dur:3000, hit:1080, emo:'🤸', ring:true, boom:true, shake:true, ouch:true},
  guitarra:{name:'Guitarra de aire', dur:3200, hit:1600, emo:'🎸', bolts:true, boom:true, flash:true},
  cumbia:{name:'Paso de cumbia', dur:3000, hit:2100, emo:'🎶'},
  seisiete:{name:'Seis-siete supremo', dur:2800, hit:1680, emo:'🤲', big:'🗿'}
};
const FAILS = {
  resbalon:{name:'Resbalón histórico', dur:2400, hit:900, emo:'💫', snd:'bonk'},
  desinfla:{name:'Aura desinflada', dur:2400, hit:1250, emo:'💨', snd:'deflate', charge:true},
  espalda:{name:'¡Ay, la espalda!', dur:2400, hit:900, emo:'😖', snd:'crack', role:'adulto', expr:'pain'},
  lag:{name:'Lag de la vergüenza', dur:2200, hit:700, emo:'📶', snd:'glitch', role:'chico'},
  camara:{name:'Choque con la cámara', dur:2400, hit:1050, emo:'💥', snd:'bonk', glass:true, shake:true},
  lentes:{name:'Lentes perdidos', dur:2400, hit:1000, emo:'👀', snd:'bonk', expr:'shock'}
};
const EPIC = ['poder', 'mortal', 'explosion', 'bote', 'rodilla', 'giro', 'pelo', 'breakdance', 'split'];
const FUNNY = ['floss', 'salsa', 'moon', 'cumbia', 'guitarra', 'seisiete'];
const GDUR = { wave:1600, stretch:1800, look:1600, hop:1200, guard:2000, tap:1900, chin:1800, come:1600 };

function chooseMove(p, delta, hint) {
  const last = p.lastMove;
  let m;
  if (hint && MOVES[hint] && delta > 1200 && Math.random() < 0.85) m = hint;
  else {
    const pool = delta >= 4000 ? EPIC : delta > 1500 ? EPIC.concat(FUNNY) : FUNNY;
    const rest = pool.filter(x => x !== last);
    m = pick(rest.length ? rest : pool);
  }
  p.lastMove = m; return m;
}
function chooseFail(p) {
  const own = Object.keys(FAILS).filter(k => FAILS[k].role === p.role && k !== p.lastFail);
  const gen = Object.keys(FAILS).filter(k => !FAILS[k].role && k !== p.lastFail);
  const m = Math.random() < 0.3 && own.length ? pick(own) : pick(gen);
  p.lastFail = m; return m;
}

const busyUntil = [0, 0], nextG = [0, 0];
function busy(i, ms) { busyUntil[i] = Math.max(busyUntil[i], performance.now() + ms); }
function clearAct(i) {
  const a = actors[i];
  [...a.classList].forEach(c => { if (/^(m|f|r|g)-/.test(c)) a.classList.remove(c); });
  a.classList.remove('prep', 'charging');
}
function act(i, cls, ms) {
  if (RM) return;
  const a = actors[i]; clearAct(i); void a.offsetWidth; a.classList.add(cls); busy(i, ms + 150);
  const tok = (a._tok = (a._tok || 0) + 1);
  setTimeout(() => { if (a._tok === tok) a.classList.remove(cls); }, ms);
}
function gesture(i, name) { act(i, 'g-' + name, GDUR[name] || 1600); }
function gestureList(i) {
  if (S.phase === 'setup') return ['wave', 'stretch', 'look', 'hop', 'guard', 'come'];
  if (S.phase === 'end') return ['hop', 'wave', 'look', 'stretch'];
  if (!S.cur || !S.thinking) return null;
  if (S.cur.pi === i) return ['look', 'chin'];
  return ['tap', 'guard', 'look', 'come', 'chin'];
}
function idleTick() {
  if (document.hidden || RM) return;
  const now = performance.now();
  for (const i of [0, 1]) {
    if (now < busyUntil[i] || now < nextG[i] || stage.classList.contains('cine')) continue;
    const c = charEl(i);
    if (['win', 'lose', 'pop', 'walking'].some(p => c.classList.contains(p))) continue;
    const list = gestureList(i);
    if (!list) { nextG[i] = now + 800; continue; }
    const g = pick(list); gesture(i, g);
    nextG[i] = now + GDUR[g] + 900 + Math.random() * 2400;
  }
}

function camPoint(i) {
  const a = actors[i];
  return { x: (a.offsetLeft + a.offsetWidth / 2) / cam.offsetWidth * 100, y: (a.offsetTop + a.offsetHeight * 0.42) / cam.offsetHeight * 100, feet: (a.offsetTop + a.offsetHeight * 0.93) / cam.offsetHeight * 100 };
}
function cine(pi, good, epic) {
  if (RM) return;
  const p = camPoint(pi);
  cam.style.transformOrigin = `${p.x}% ${p.y}%`;
  speed.style.left = p.x + '%'; speed.style.top = p.y + '%';
  stage.classList.add('cine'); stage.classList.toggle('good', !!good); stage.classList.toggle('epic', !!epic);
}
function cineOff() { stage.classList.remove('cine', 'good', 'epic'); requestAnimationFrame(() => [0, 1].forEach(i => { if (bubbles[i].classList.contains('show')) placeTail(i); })); }
function shake() { if (RM) return; cam.classList.remove('shake'); void cam.offsetWidth; cam.classList.add('shake'); setTimeout(() => cam.classList.remove('shake'), 600); }
function flash(warm) { flashov.classList.remove('go', 'warm'); void flashov.offsetWidth; if (warm) flashov.classList.add('warm'); flashov.classList.add('go'); }
function moveCard(text, fail) { movecard.textContent = text; movecard.className = 'movecard show' + (fail ? ' fail' : ''); }
function moveCardOut() { if (movecard.classList.contains('show')) movecard.className = 'movecard hide' + (movecard.classList.contains('fail') ? ' fail' : ''); }
function backAt(cls, x, y) { const d = el('div', cls); d.style.left = x + '%'; d.style.top = y + '%'; backfx.append(d); setTimeout(() => d.remove(), 1400); }
function fxAt(cls, x, y, txt, delay) { const d = el('div', cls, txt); d.style.left = x + '%'; d.style.top = y + '%'; if (delay) d.style.animationDelay = delay + 's'; fx.append(d); setTimeout(() => d.remove(), 1700 + (delay || 0) * 1000); return d; }
function windLines(i) {
  if (RM) return; const p = actorPoint(i);
  for (let k = 0; k < 9; k++) { const w = el('div', 'wind'); w.style.left = (p.x - 26 + Math.random() * 30) + '%'; w.style.top = (p.y + p.h * (0.08 + Math.random() * 0.8)) + '%'; w.style.width = (16 + Math.random() * 26) + '%'; w.style.animationDelay = (k * 0.06) + 's'; fx.append(w); setTimeout(() => w.remove(), 1300); }
}
function bolts(i) { const p = actorPoint(i); for (let k = 0; k < 4; k++) fxAt('pop-emo', p.x + (k % 2 ? -1 : 1) * (9 + Math.random() * 9), p.y + p.h * (0.05 + Math.random() * 0.6), '⚡', k * 0.08); }
function floorSparks(i) {
  if (RM) return; const p = actorPoint(i), cols = ['#FDBE30', '#FFFFFF', '#FFE08A', '#EF4A37'];
  for (let k = 0; k < 16; k++) { const s = el('span', 'spark'); s.style.left = (p.x + (Math.random() * 12 - 6)) + '%'; s.style.top = (p.y + p.h * 0.92) + '%'; s.style.background = pick(cols); s.style.setProperty('--dx', (Math.random() * 160 - 80) + 'px'); s.style.setProperty('--dy', (-30 - Math.random() * 70) + 'px'); fx.append(s); setTimeout(() => s.remove(), 1000); }
}

/* Pre-hit choreography effects, relative to the start of the move */
function danceStartFx(pi, M) {
  if (M.expr) setExpr(pi, M.expr);
  if (M.charge) actors[pi].classList.add('charging');
  if (M.whoosh) later(M.whoosh, () => Sfx.whoosh(0.45));
  if (M.glowAt) later(M.glowAt, () => actors[pi].classList.add('glow'));
  if (M.waves) M.waves.forEach(t => later(t, () => { const p = actorPoint(pi); fxAt('wavering', p.x, p.y + p.h * 0.02); }));
  if (M.loadbar) {
    const p = actorPoint(pi), bar = el('div', 'loadbar'), fill = el('i'), lbl = el('b', null, 'Actualizando…');
    bar.append(fill, lbl); bar.style.left = p.x + '%'; bar.style.top = Math.max(10, p.y - 3) + '%'; fx.append(bar);
    fill.style.transition = `width ${M.hit}ms linear`; requestAnimationFrame(() => requestAnimationFrame(() => { fill.style.width = '100%'; }));
    later(M.hit, () => { lbl.textContent = 'Aura 2.0 instalada ✓'; });
    setTimeout(() => bar.remove(), M.hit + 1400);
  }
}
/* The big moment of a successful move */
function danceHitFx(pi, M, epic, p) {
  actors[pi].classList.remove('charging');
  const pt = actorPoint(pi), dir = pi === 0 ? 1 : -1;
  if (M.boom) Sfx.boom();
  if (M.snd && Sfx[M.snd]) Sfx[M.snd]();
  if (M.shake) shake();
  if (M.blast) { const cp = camPoint(pi); backAt('blast', cp.x, cp.y); flash(true); }
  else if (M.flash || epic) flash();
  if (M.ring) { const cp = camPoint(pi); backAt('ring', cp.x, cp.feet); }
  if (M.bolts) bolts(pi);
  if (M.wind) windLines(pi);
  if (M.floor) floorSparks(pi);
  if (M.big) fxAt('pop-big', pt.x + dir * 13, pt.y + pt.h * 0.42, M.big);
  if (M.fly) { const f = fxAt('fly', pt.x + dir * 6, pt.y + pt.h * 0.15, M.fly); f.style.setProperty('--fx', (dir * 160) + 'px'); }
  if (M.ouch && p && p.role === 'adulto') { later(250, () => setExpr(pi, 'pain')); later(1000, () => setExpr(pi, 'happy')); }
  emoji(pi, M.emo || '✨', epic ? 2 : 1);
  if (epic && M.emo !== '🗿' && M.big !== '🗿') emoji(pi, '🗿', 1);
}

function perform(pi, delta, opts = {}) {
  return new Promise(resolve => {
    const p = S.players[pi], oi = 1 - pi, op = S.players[oi], good = delta > 0;
    const quick = !!opts.quick || RM;
    const name = opts.move || (good ? chooseMove(p, delta, opts.hint) : chooseFail(p));
    const M = good ? MOVES[name] : FAILS[name];
    const epic = good && delta >= 4000;
    if (good && (!p.best || delta > p.best.d)) p.best = { d: delta, m: name };
    clearAct(pi); clearAct(oi); setPose(pi, null); setPose(oi, null); hideBubble(pi); hideBubble(oi);
    const prep = quick ? 0 : 450, hit = quick ? 0 : prep + M.hit, end = quick ? 1100 : prep + M.dur;
    busy(pi, end + 2600); busy(oi, end + 2600);
    if (!quick) {
      cine(pi, good, epic);
      actors[pi].classList.add('prep'); setExpr(pi, 'cool'); Sfx.roll(0.45);
      moveCard(good ? '✦ ' + M.name + ' ✦' : M.name, false);
      setExpr(oi, 'shock');
      later(prep, () => {
        actors[pi].classList.remove('prep');
        act(pi, (good ? 'm-' : 'f-') + name, M.dur);
        if (good) danceStartFx(pi, M); else if (M.charge) actors[pi].classList.add('charging');
        Sfx.phonk(good ? M.dur / 1000 + 0.4 : Math.max(0.4, M.hit / 1000), epic ? 1 : 0.7);
        if (good && delta >= 3000) later(Math.max(0, M.hit - 500), () => audience('clap', 1200));
      });
    }
    later(hit, () => {
      moveCardOut(); actors[pi].classList.remove('charging');
      floatText(pi, signed(delta) + ' aura', good ? 'pos' : 'neg');
      addAura(pi, delta);
      const line = opts.speech || pick(LINES[p.role][good ? 'win' : 'lose']);
      if (good || quick) say(pi, line); else later(950, () => say(pi, line));
      if (good) {
        if (!M.expr) setExpr(pi, epic ? 'cool' : 'happy');
        actors[pi].classList.add('glow'); Sfx.aura(); sparkles(pi, epic ? 24 : 14); flashNeon();
        if (quick) { setPose(pi, 'win'); flash(); emoji(pi, M.emo || '✨', 1); }
        else danceHitFx(pi, M, epic, p);
      } else {
        moveCard(M.name, true);
        later(900, moveCardOut);
        Sfx.stopMusic(); Sfx.scratch(); if (M.snd && Sfx[M.snd]) Sfx[M.snd](); later(320, () => Sfx.fail());
        setExpr(pi, M.expr || 'sad'); emoji(pi, M.emo || '💀', 1); emoji(pi, '💀', 1);
        if (M.shake) shake();
        if (M.glass) { const pp = actorPoint(pi); fxAt('glass', pp.x, pp.y + pp.h * 0.35); }
        if (name === 'desinfla') { const pp = actorPoint(pi); fxAt('pop-emo', pp.x, Math.max(6, pp.y - 2), '🌧️'); }
        if (!quick) stage.classList.add('sad');
      }
      resolve();
    });
    later(end, () => {
      clearAct(pi); cineOff(); stage.classList.remove('sad');
      setPose(pi, good ? 'win' : 'lose');
      if (good) { audience('clap', epic ? 2600 : 1800); Sfx.applause(epic ? 2.3 : 1.5); audClaps(epic ? 9 : 4); }
      else { audience('laugh', 1600); Sfx.applause(0.9, 12, 0.1); }
      const r = good ? (epic ? pick(['boca', 'boca', 'aplauso']) : pick(['cruzado', 'aplauso'])) : (delta <= -3000 ? pick(['rofl', 'rofl', 'risa']) : 'risa');
      act(oi, 'r-' + r, r === 'rofl' ? 2200 : 1900);
      say(oi, pick(REACT[op.role][good ? 'pos' : 'neg']));
      setExpr(oi, good ? (r === 'cruzado' ? 'cool' : 'shock') : 'laugh');
      if (!good) emoji(oi, '😂', 2);
    });
    later(end + 2300, () => {
      actors[pi].classList.remove('glow');
      setPose(pi, null); setPose(oi, null); setExpr(oi, null); setExpr(pi, good ? 'happy' : null);
    });
  });
}

/* A move used as an attempt (free-word round) or a preview: no scoring */
function dance(pi, name, label, opts = {}) {
  return new Promise(resolve => {
    const M = MOVES[name], oi = 1 - pi;
    clearAct(pi); setPose(pi, null); hideBubble(pi); hideBubble(oi);
    if (RM) { if (opts.speech) say(pi, opts.speech, { keep: true }); resolve(); return; }
    const prep = 450;
    busy(pi, prep + M.dur + 600); busy(oi, prep + M.dur + 600);
    cine(pi, true, !!opts.epic); moveCard(label || '✦ ' + M.name + ' ✦', false);
    actors[pi].classList.add('prep'); setExpr(pi, 'cool'); if (opts.watch !== false) setExpr(oi, 'shock'); Sfx.roll(0.45);
    later(prep, () => {
      actors[pi].classList.remove('prep');
      act(pi, 'm-' + name, M.dur);
      danceStartFx(pi, M);
      Sfx.phonk(M.dur / 1000, opts.vol || 0.75);
    });
    later(prep + M.hit, () => {
      moveCardOut(); if (opts.speech) say(pi, opts.speech, { keep: true });
      sparkles(pi, 12); danceHitFx(pi, M, !!opts.epic, null);
      if (opts.react && opts.watch !== false) { act(oi, 'r-boca', 1900); }
    });
    later(prep + M.dur, () => { clearAct(pi); cineOff(); Sfx.stopMusic(); actors[pi].classList.remove('glow', 'charging'); setExpr(pi, 'happy'); setExpr(oi, null); resolve(); });
  });
}
function resetStage() {
  [0, 1].forEach(i => { clearAct(i); setPose(i, null); setExpr(i, null); actors[i].classList.remove('glow'); });
  cineOff(); stage.classList.remove('sad'); movecard.className = 'movecard'; Sfx.stopMusic();
}

/* ---------- Panel helpers ---------- */
function resultBlock(delta, text) {
  const r = el('div', 'result');
  r.append(el('span', 'delta ' + (delta > 0 ? 'up' : 'down'), signed(delta) + ' aura'), el('p', null, text));
  return r;
}
function datoBlock(text) { const d = el('div', 'dato'); d.append(el('span', 'lbl', 'Dato Tecnofamilias'), document.createTextNode(text)); return d; }
function talkBlock(to, q) {
  const t = el('div', 'talk'); t.append(el('span', 'lbl', 'Para conversar, ' + to), document.createTextNode(q));
  S.log.q.push({ to, q }); return t;
}
function saidBlock(label, text, quote) { const s = el('div', 'said'); s.append(el('span', 'lbl', label), el(quote ? 'q' : 'span', quote ? null : 'tx', text)); return s; }
function nextBtn(box) {
  const row = el('div', 'next-row'), b = el('button', 'btn wide', S.t + 1 >= S.n ? 'Ver resultados' : 'Siguiente turno'); b.type = 'button';
  b.addEventListener('click', () => { if (S.busy) return; S.t++; startTurn(); });
  row.append(b); box.append(row);
  if (window.innerWidth < 980) setTimeout(() => b.scrollIntoView({ behavior: RM ? 'auto' : 'smooth', block: 'nearest' }), 250);
}
function ctxNames(pi) { return { p: S.players[pi].name, o: S.players[1 - pi].name }; }

function isBad(w) {
  const n = ' ' + norm(w) + ' ', compact = norm(w).replace(/ /g, '');
  return BAD.some(b => n.includes(' ' + b + ' ') || (b.length >= 6 && compact.includes(b)));
}
function findEntry(w) {
  const n = norm(w); if (!n) return null;
  let best = null;
  for (const e of DICT) {
    const keys = [e.w, ...(e.a || [])].map(norm);
    if (keys.includes(n)) return e;
    if (!best && keys.some(k => k.length >= 3 && (' ' + n + ' ').includes(' ' + k + ' '))) best = e;
  }
  return best;
}
function ideasFor(role) {
  const own = DICT.filter(d => d.t === role), other = DICT.filter(d => d.t !== role && d.t !== 'ciber'), cyb = DICT.filter(d => d.t === 'ciber');
  return shuffle([...shuffle(own).slice(0, 2), pick(cyb), pick(other)]);
}

let samplePromise = null, aiOff = false;
function getSample() {
  if (!samplePromise) {
    samplePromise = (window.claude && typeof window.claude.use === 'function') ? window.claude.use('sample').catch(() => null) : Promise.resolve(null);
  }
  return Promise.race([samplePromise, sleep(4000).then(() => null)]);
}
/* ---------- State ---------- */
const TYPES = { sit: '🎲 Situación sorpresa', libre: '✍️ Tú pones la palabra', trad: '🔤 Traductor generacional' };
const ROLE_LABEL = { adulto: 'Adulto', chico: 'Chico o chica' };
const S = { players: [], t: 0, n: 10, first: 0, plan: {}, decks: {}, trad: {}, log: { q: [], words: new Map() }, busy: false, phase: 'setup', thinking: false };
const roleOf = i => (i === 0 ? 'adulto' : 'chico');
const ED = { looks: [], names: ['', ''], ed: 0, cat: 'piel' };
{
  const sl = store.get('looks3', null), sn = store.get('names2', null);
  ED.looks = [fixLook(sl && sl[0], 'adulto'), fixLook(sl && sl[1], 'chico')];
  if (Array.isArray(sn)) ED.names = [String(sn[0] || '').slice(0, 16), String(sn[1] || '').slice(0, 16)];
}
function saveED() { store.set('looks3', ED.looks); store.set('names2', ED.names); }
function mountActors() { [0, 1].forEach(i => { charEl(i).innerHTML = charSVG(ED.looks[i]); }); }

/* ---------- Character creator ---------- */
const pname = $('#pname'), ctabs = $('#ctabs'), cpanel = $('#cpanel'), startErr = $('#startErr');
function renderTabs() {
  [0, 1].forEach(i => { $('#ptab' + i).setAttribute('aria-selected', String(ED.ed === i)); });
  pname.value = ED.names[ED.ed];
  pname.placeholder = ED.ed === 0 ? 'Ej. Mamá, Papá, Profe Ana' : 'Ej. Sofi, Mateo';
}
function renderCtabs() {
  ctabs.innerHTML = '';
  CATS.forEach(c => {
    const b = el('button', 'ctab', c.n); b.type = 'button'; b.setAttribute('role', 'tab');
    b.setAttribute('aria-selected', String(ED.cat === c.id));
    b.addEventListener('click', () => { ED.cat = c.id; renderCtabs(); renderCat(); });
    ctabs.append(b);
  });
}
function renderCat(focus) {
  const cat = CATS.find(c => c.id === ED.cat) || CATS[0], L = ED.looks[ED.ed], role = roleOf(ED.ed);
  cpanel.innerHTML = '';
  cat.sec.forEach(sec => {
    if (sec.role && sec.role !== role) return;
    const s = el('div', 'csec'); s.append(el('h4', null, sec.t));
    if (sec.sw) {
      const row = el('div', 'swatches');
      PAL[sec.sw].forEach(([hex, name]) => {
        const b = el('button', 'sw'); b.type = 'button'; b.style.setProperty('--c', hex);
        b.setAttribute('aria-label', name); b.title = name; b.dataset.k = sec.key; b.dataset.v = hex;
        b.setAttribute('aria-pressed', String(L[sec.key] === hex));
        b.addEventListener('click', () => setLook(sec.key, hex));
        row.append(b);
      });
      s.append(row);
    } else {
      const grid = el('div', 'tiles');
      Object.entries(sec.opts).forEach(([id, o]) => {
        const b = el('button', 'tile'); b.type = 'button'; b.dataset.k = sec.key; b.dataset.v = id;
        b.setAttribute('aria-pressed', String(L[sec.key] === id));
        const v = el('span', 'tv'); v.innerHTML = charSVG(Object.assign({}, L, { [sec.key]: id }), sec.view);
        b.append(v, el('span', 'tn', o.n));
        b.addEventListener('click', () => setLook(sec.key, id));
        grid.append(b);
      });
      s.append(grid);
    }
    cpanel.append(s);
  });
  if (focus) { const b = cpanel.querySelector(`[data-k="${focus[0]}"][data-v="${focus[1]}"]`); if (b) b.focus({ preventScroll: true }); }
}
function setLook(key, val) {
  const i = ED.ed, hadFocus = cpanel.contains(document.activeElement);
  ED.looks[i][key] = val; saveED();
  charEl(i).innerHTML = charSVG(ED.looks[i]);
  if (!RM) { act(i, 'g-hop', 1200); sparkles(i, 8); }
  Sfx.pop();
  renderCat(hadFocus ? [key, val] : null);
}
function selectPlayer(i) {
  ED.ed = i; renderTabs(); renderCat(); startErr.textContent = '';
  [0, 1].forEach(k => { actors[k].classList.toggle('fwd', k === i); spots[k].classList.toggle('on', k === i); });
  walk(i, 900);
}
function previewMove(i) {
  const name = pick(Object.keys(MOVES));
  dance(i, name, null, { vol: 0.55, watch: false, speech: ED.names[i].trim() ? '¡Así baila ' + ED.names[i].trim() + '!' : '¡Mira este paso!' });
}

/* ---------- Setup extras ---------- */
function renderDict() {
  const words = store.get('dict', []), box = $('#dictBox');
  if (!words.length) { box.hidden = true; return; }
  box.hidden = false;
  $('#dictSum').textContent = `Diccionario familiar: ${words.length} ${words.length === 1 ? 'palabra' : 'palabras'} aprendidas`;
  const dl = $('#dictList'); dl.innerHTML = '';
  words.slice().sort((a, b) => a.w.localeCompare(b.w, 'es')).forEach(x => dl.append(el('dt', null, x.w), el('dd', null, x.d)));
}

/* ---------- Game flow ---------- */
function buildPlan(per) {
  const libre = Math.max(1, Math.round(per * 0.3)), trad = Math.max(1, Math.round(per * 0.2));
  const sit = Math.max(1, per - libre - trad);
  const arr = shuffle([...Array(libre).fill('libre'), ...Array(trad).fill('trad'), ...Array(sit).fill('sit')]).slice(0, per);
  const i = arr.indexOf('sit'); if (i > 0) [arr[0], arr[i]] = [arr[i], arr[0]];
  return arr;
}
function draw(deck, key, src) { if (!deck[key] || !deck[key].length) deck[key] = shuffle(src()); return deck[key].pop(); }
function unlock(w, d) { if (w && d) S.log.words.set(norm(w), { w, d }); }
const signedPts = n => (n < 0 ? '−' : '') + fmt(n);
function renderScores() {
  [0, 1].forEach(i => {
    const p = S.players[i], box = $('#score' + i);
    box.querySelector('.nm').textContent = p.name;
    box.querySelector('.cn').textContent = ROLE_LABEL[p.role];
    box.querySelector('.num').textContent = signedPts(p.aura);
    box.classList.toggle('active', S.phase === 'play' && S.cur && S.cur.pi === i);
  });
  $('#turnNum').textContent = Math.min(S.t + 1, S.n);
  $('#turnTot').textContent = S.n;
}
function addAura(pi, delta) {
  const p = S.players[pi], from = p.aura, to = p.aura + delta; p.aura = to;
  const box = $('#score' + pi), num = box.querySelector('.num');
  box.classList.remove('bump'); void box.offsetWidth; box.classList.add('bump');
  if (RM) { num.textContent = signedPts(to); return; }
  const t0 = performance.now(), dur = 900;
  const step = now => { const k = Math.min(1, (now - t0) / dur), e = 1 - Math.pow(1 - k, 3); num.textContent = signedPts(Math.round((from + (to - from) * e) / 50) * 50); if (k < 1) requestAnimationFrame(step); else num.textContent = signedPts(to); };
  requestAnimationFrame(step);
}

/* ---------- Turns ---------- */
async function startTurn() {
  gen++; clearBubbles(); resetStage(); S.thinking = false;
  if (S.t >= S.n) return endGame();
  const pi = (S.first + S.t) % 2, p = S.players[pi];
  const type = S.plan[pi][Math.floor(S.t / 2)] || 'sit';
  S.cur = { pi, type }; S.busy = true;
  renderScores();
  setForward(pi);
  panel.innerHTML = '';
  const head = el('div', 'turn-head');
  head.append(el('p', 'tw', 'Turno de ' + p.name), el('span', 'tc', ROLE_LABEL[p.role]));
  const rou = el('div', 'roulette', '…');
  panel.append(head, rou);
  const myGen = gen;
  await spin(rou, type);
  if (myGen !== gen) return;
  S.busy = false;
  if (type === 'sit') renderSit(pi); else if (type === 'libre') renderLibre(pi); else renderTrad(pi);
}
async function spin(rou, type) {
  const labels = Object.values(TYPES);
  if (RM) { rou.textContent = TYPES[type]; return; }
  rou.classList.add('spinning');
  let delay = 70;
  for (let k = 0; k < 11; k++) { rou.textContent = labels[k % 3]; Sfx.tick(); await sleep(delay); delay += 14; }
  rou.textContent = TYPES[type]; rou.classList.remove('spinning'); rou.classList.add('landed'); Sfx.pop();
  await sleep(300);
}

function renderSit(pi) {
  const p = S.players[pi], o = S.players[1 - pi];
  const card = draw(S.decks, p.role, () => SIT.filter(s => s.r === p.role));
  const box = el('div', 'round');
  box.append(el('span', 'theme-chip', card.tema), el('p', 'situation', card.s));
  const opts = el('div', 'options');
  setPose(pi, 'think'); S.thinking = true;
  say(pi, pick(['Mmm… ¿qué hago?', 'A ver, a ver…', 'Esta me la sé. Creo.', 'Déjenme pensar…']), { hold: 600 });
  shuffle(card.o).forEach(opt => {
    const b = el('button', 'opt'); b.type = 'button';
    b.append(el('span', null, opt.t), el('span', 'ov ' + (opt.a > 0 ? 'up' : 'down'), signed(opt.a)));
    b.addEventListener('click', async () => {
      if (S.busy || opts.classList.contains('revealed')) return;
      S.busy = true; S.thinking = false; opts.classList.add('revealed'); b.classList.add('chosen');
      opts.querySelectorAll('button').forEach(x => { x.disabled = true; });
      await perform(pi, opt.a, { hint: TEMA_MOVE[card.tema] });
      box.append(resultBlock(opt.a, opt.r), datoBlock(card.d), talkBlock(card.both ? 'los dos' : o.name, fill(card.q, ctxNames(pi))));
      S.busy = false; nextBtn(box);
    });
    opts.append(b);
  });
  box.append(opts); panel.append(box);
}

async function askAI(p, w) {
  if (aiOff) return null;
  const sample = await getSample();
  if (!sample) return null;
  const moves = 'pesca (estafas, links, anzuelos), candado (contraseñas, privacidad, secretos), antena (wifi, redes, señal), escudo (proteger, acoso, defender), detective (investigar, chismes, verificar), zen (calma, emociones, dormir), robot (tecnología, apps, juegos, IA), cuelgue (llamadas, hablar mucho), breakdance (habilidad, presumir), split (retos, deporte), guitarra (música, fiesta), cumbia (comida, familia, fiesta), seisiete (memes absurdos), mortal (ganar, ser el mejor), pelo (estilo, belleza, coquetear), poder (energía, esfuerzo), bote (aura, actitud tranquila), explosion (drama, actitud sigma)';
  const prompt = `Eres guionista de “Farmea aura”, un juego familiar de Tecnofamilias para Latinoamérica en el que padres e hijos se ríen juntos y aprenden de ciberseguridad, autocuidado y responsabilidad digital.
Quien juega es ${ROLE_DESC[p.role]}.
Escribió esta palabra o frase: "${w.replace(/"/g, '')}"
Su personaje intenta “farmear aura” (hacer algo genial para ganar respeto) bailando esa palabra según lo que entiende. Si es jerga de otra generación, la malinterpreta de forma chistosa. Si se puede, conecta con un consejo de seguridad digital.
Reglas: apto para niños desde 8 años; español latinoamericano neutro; sin groserías; sin contenido sexual, violento ni burlas a grupos de personas; nunca pidas datos personales. Si la palabra es ofensiva o inapropiada, el personaje la rechaza con humor y el aura es negativa.
Elige el baile más relacionado con la palabra, usando exactamente una de estas claves: ${moves}.
Responde solo con un objeto JSON, sin texto adicional, con esta forma:
{"entendio":"lo que el personaje cree que significa, máximo 12 palabras","frase":"lo que dice el personaje en primera persona, chistoso, máximo 18 palabras","significado":"significado real en máximo 18 palabras, o cadena vacía si no existe","aura":2500,"tip":"consejo breve de ciberseguridad o autocuidado relacionado, máximo 18 palabras","baile":"clave"}
El campo aura es un entero entre -3000 y 6000, múltiplo de 500.`;
  try {
    const j = await sample.json(prompt, { modelTier: 'quick' });
    if (!j || typeof j !== 'object') return null;
    const s = (v, n) => (typeof v === 'string' ? v.trim().slice(0, n) : '');
    const out = { entendio: s(j.entendio, 120), frase: s(j.frase, 160), significado: s(j.significado, 160), tip: s(j.tip, 160), baile: MOVES[s(j.baile, 20)] ? s(j.baile, 20) : null };
    let a = Math.round(Number(j.aura) / 500) * 500; if (!isFinite(a)) a = 2000; out.aura = Math.max(-3000, Math.min(6000, a)) || 1000;
    if (!out.frase) return null;
    if ([out.entendio, out.frase, out.significado, out.tip].some(isBad)) return null;
    return out;
  } catch (e) {
    if (e && ['not_granted', 'sampling_disabled', 'not_declared', 'capability_disabled', 'capability_removed'].includes(e.code)) aiOff = true;
    return null;
  }
}

function renderLibre(pi) {
  const p = S.players[pi];
  const box = el('div', 'round');
  box.append(el('p', 'situation', `${p.name}, escribe una palabra o frase corta: de tu mundo, de internet o de ciberseguridad. Tu personaje la va a bailar como la entienda.`));
  const form = el('form', 'word-row'); form.setAttribute('autocomplete', 'off');
  const input = el('input', 'word-input'); input.maxLength = 40; input.placeholder = 'Ej. ' + ideasFor(p.role)[0].w; input.setAttribute('aria-label', 'Tu palabra');
  const go = el('button', 'btn', '¡A farmear!'); go.type = 'submit';
  form.append(input, go);
  const ideas = el('div', 'ideas'); ideas.append(el('span', null, 'Ideas:'));
  ideasFor(p.role).forEach(e => { const b = el('button', 'idea', e.w); b.type = 'button'; b.addEventListener('click', () => { input.value = e.w; input.focus(); }); ideas.append(b); });
  const note = el('p', 'small-note', aiOff ? 'Si la palabra no está en nuestro diccionario, el otro jugador decide si vale.' : 'Si la palabra no está en nuestro diccionario, Claude ayuda a tu personaje a interpretarla y a escoger el baile.');
  box.append(form, ideas, note); panel.append(box);
  setPose(pi, 'think'); S.thinking = true;
  say(pi, pick(['Dame una palabra y la bailo.', 'Lista la mente. Bueno, casi.', 'Escribe algo y lo convierto en aura.']), { hold: 800 });
  form.addEventListener('submit', async ev => {
    ev.preventDefault();
    const w = input.value.trim();
    if (!w || S.busy) { input.focus(); return; }
    S.busy = true; S.thinking = false; setPose(pi, null); input.disabled = true; go.disabled = true; ideas.querySelectorAll('button').forEach(x => x.disabled = true);
    const myGen = gen;
    await handleWord(pi, w, box);
    if (myGen === gen) S.busy = false;
  });
}

async function handleWord(pi, w, box) {
  const p = S.players[pi], o = S.players[1 - pi];
  if (isBad(w)) {
    await perform(pi, -1000, { speech: '¡Uy! Esa palabra le baja el aura a toda la casa 🙊' });
    box.append(resultBlock(-1000, 'Hay palabras que lastiman aunque suenen chistosas. Aquí se farmea aura con respeto.'),
      talkBlock('los dos', 'Hablen: ¿qué palabras no les gusta escuchar en internet, y por qué?'));
    nextBtn(box); return;
  }
  const entry = findEntry(w);
  let it;
  if (entry) {
    if (entry.t === 'ciber') it = { speech: entry.l, real: entry.d, base: 4000, kind: 'ciber' };
    else {
      const line = p.role === 'adulto' ? entry.ad : entry.ch;
      it = entry.t === p.role ? { speech: line, real: entry.d, base: 3000, kind: 'pro' } : { speech: line, real: entry.d, base: 1500, kind: 'confuso' };
    }
    it.word = entry.w; it.mv = entry.mv;
  } else {
    setPose(pi, 'think'); say(pi, 'Mmm… déjenme pensar qué es eso 🤔', { keep: true });
    const status = el('p', 'thinking', `Tu personaje está interpretando “${w}”`); box.append(status);
    const myGen = gen;
    const ai = await askAI(p, w);
    if (myGen !== gen) return;
    status.remove(); setPose(pi, null);
    if (ai) it = { speech: ai.frase, entendio: ai.entendio, real: ai.significado, tip: ai.tip, base: ai.aura, kind: 'ai', word: w, mv: ai.baile };
    else {
      const lines = p.role === 'adulto'
        ? [`¿“${w}”? Claro, eso existía desde antes del internet.`, `Con “${w}” yo farmeo aura hasta en la fila del banco.`, `“${w}”… lo dije con tanta seguridad que hasta yo me lo creí.`]
        : [`“${w}” es tendencia desde hace como tres horas.`, `Literal, “${w}” y ya. Aura instantánea.`, `Si no sabes qué es “${w}”, skill issue.`];
      it = { speech: pick(lines), base: 2000, kind: 'nuevo', word: w };
    }
  }
  const mv = it.mv && MOVES[it.mv] ? it.mv : (it.kind === 'confuso' ? pick(FUNNY) : pick(Object.keys(MOVES)));
  const shown = w.length > 22 ? w.slice(0, 21) + '…' : w;
  box.append(saidBlock(`Lo que dijo ${p.name}`, it.speech, true));
  if (it.entendio) box.append(saidBlock(`Lo que entendió ${p.name}`, it.entendio));
  if (it.real) box.append(saidBlock('Lo que significa de verdad', it.real));
  if (it.tip) box.append(datoBlock(it.tip));
  if (it.real) unlock(it.word, it.real);
  const myGen2 = gen;
  await dance(pi, mv, '“' + shown + '”: ' + MOVES[mv].name, { speech: it.speech, react: it.kind !== 'confuso' });
  if (myGen2 !== gen) return;

  const vote = el('div', 'vote');
  vote.append(el('p', null, `${o.name}, ¿${p.name} farmeó aura con “${w}”?`));
  const sub = it.kind === 'confuso' ? `${p.name} no entendió nada, pero ¿te hizo reír? Eso también cuenta.`
    : it.kind === 'pro' || it.kind === 'ciber' ? 'Tú eres el jurado. Sé justo… o no.'
    : `Antes de votar, ${p.name} te explica qué quiso decir.`;
  vote.append(el('p', 'sub', sub));
  const btns = el('div', 'vote-btns');
  const yes = el('button', 'btn', 'Sí, se lo ganó'), no = el('button', 'btn alt', 'No, cero aura');
  yes.type = no.type = 'button';
  btns.append(yes, no); vote.append(btns); box.append(vote);
  if (window.innerWidth < 980) setTimeout(() => vote.scrollIntoView({ behavior: RM ? 'auto' : 'smooth', block: 'nearest' }), 200);
  const decide = async ok => {
    yes.disabled = no.disabled = true;
    hideBubble(pi);
    const delta = ok ? it.base : -500;
    await perform(pi, delta, ok && it.base > 0 ? { quick: true, move: mv } : {});
    const msg = ok ? (it.kind === 'confuso' ? 'Aura de comedia: no entendió, pero hizo reír.' : it.base > 0 ? 'El jurado aprobó.' : 'El jurado aprobó… pero la palabra no sumaba.') : `${o.name} no se lo creyó. El jurado es duro.`;
    box.append(resultBlock(delta, msg));
    let q;
    if (it.kind === 'confuso') q = `Explícale a ${p.name} cómo se usa “${it.word}” de verdad, con un ejemplo.`;
    else if (it.kind === 'ciber') q = `¿A alguno de los dos le ha pasado algo relacionado con “${it.word}”? Cuéntenlo.`;
    else if (it.kind === 'pro') q = `¿Conocías “${it.word}”? Intenta usarla en una frase y que ${p.name} te califique.`;
    else q = `¿Conocías “${w}”? Inventen juntos una frase con esa palabra.`;
    box.append(talkBlock(it.kind === 'ciber' ? 'los dos' : o.name, q));
    nextBtn(box);
  };
  yes.addEventListener('click', () => decide(true));
  no.addEventListener('click', () => decide(false));
}

function renderTrad(pi) {
  const p = S.players[pi], o = S.players[1 - pi];
  const otherRole = p.role === 'adulto' ? 'chico' : 'adulto';
  const e = draw(S.trad, p.role, () => DICT.filter(d => d.t === otherRole));
  const box = el('div', 'round');
  box.append(el('p', 'situation', `${p.name}, esta palabra es del mundo de ${p.role === 'adulto' ? 'los chicos' : 'los adultos'}. ¿Qué significa?`));
  box.append(el('p', 'bigword', '“' + e.w + '”'));
  setPose(pi, 'think'); S.thinking = true;
  say(pi, p.role === 'adulto' ? pick(['¿“' + e.w + '”? Eso me suena…', 'Esa la oí en el carro…', 'Déjame pensar… no me ayuden.']) : pick(['¿“' + e.w + '”? Eso suena muy de grandes.', 'Esa la dice mi abuela…', 'Ni idea, pero confíen.']), { hold: 700 });
  const opts = el('div', 'options');
  const list = shuffle([{ t: e.c, ok: true }, ...e.f.map(t => ({ t }))]);
  const btnFor = new Map();
  list.forEach(op => {
    const b = el('button', 'opt'); b.type = 'button'; b.append(el('span', null, op.t)); btnFor.set(op, b);
    b.addEventListener('click', async () => {
      if (S.busy || opts.classList.contains('revealed')) return;
      S.busy = true; S.thinking = false; opts.classList.add('revealed'); b.classList.add('chosen', op.ok ? 'right' : 'wrong');
      opts.querySelectorAll('button').forEach(x => { x.disabled = true; });
      if (!op.ok) btnFor.get(list.find(x => x.ok)).classList.add('right', 'chosen');
      const delta = op.ok ? 3000 : -1000;
      const okLines = p.role === 'adulto' ? ['¡Lo sabía! Estoy más actualizado que el celular.', 'Uno no es viejo: es vintage.', 'Traductor oficial de la casa.'] : ['Obvio. Hablo adulto fluido.', 'Eso lo dicen en mi casa todo el tiempo.', 'Traductor oficial de la casa.'];
      await perform(pi, delta, { speech: op.ok ? pick(okLines) : (p.role === 'adulto' ? e.ad : e.ch), hint: e.mv });
      box.append(resultBlock(delta, op.ok ? 'Traducción correcta.' : 'Traducción creativa, pero no.'));
      box.append(saidBlock('Lo que significa de verdad', e.d));
      unlock(e.w, e.d);
      box.append(talkBlock(o.name, `Dale a ${p.name} un ejemplo de cuándo dirías “${e.w}”.`));
      S.busy = false; nextBtn(box);
    });
    opts.append(b);
  });
  box.append(opts); panel.append(box);
}

/* ---------- End ---------- */
async function endGame() {
  S.phase = 'end'; gen++; clearBubbles(); S.busy = false; S.thinking = false;
  renderScores(); resetStage();
  [0, 1].forEach(i => actors[i].classList.remove('king'));
  const [a, k] = S.players;
  const win = a.aura === k.aura ? -1 : (a.aura > k.aura ? 0 : 1);
  setForward('both');
  panel.innerHTML = '';
  const box = el('div');
  box.append(el('h2', null, win >= 0 ? `${S.players[win].name} es quien más aura farmeó` : 'Empate técnico de aura'));
  const tiles = el('div', 'end-tiles');
  S.players.forEach((p, i) => { const t = el('div', 'tile' + (i === win ? ' win' : '')); t.append(el('div', 'nm', (i === win ? '👑 ' : '') + p.name), el('div', 'v', signedPts(p.aura)), el('div', 'muted', ROLE_LABEL[p.role])); tiles.append(t); });
  box.append(tiles);
  const fam = el('div', 'family');
  fam.append(document.createTextNode('Aura familiar: '), el('b', null, signedPts(a.aura + k.aura)), document.createTextNode('. La juntaron entre los dos, y lo que más suma es lo que hablaron.'));
  box.append(fam);
  const words = [...S.log.words.values()];
  if (words.length) {
    const sec = el('div', 'endsec'); sec.append(el('h3', null, 'Palabras desbloqueadas'));
    const chips = el('div', 'chips'), def = el('p', 'wdef', 'Toca una palabra para ver qué significa.');
    words.forEach(x => { const b = el('button', 'wchip', x.w); b.type = 'button'; b.setAttribute('aria-expanded', 'false'); b.addEventListener('click', () => { chips.querySelectorAll('.wchip').forEach(y => y.setAttribute('aria-expanded', 'false')); b.setAttribute('aria-expanded', 'true'); def.textContent = x.w + ': ' + x.d; }); chips.append(b); });
    sec.append(chips, def); box.append(sec);
    const saved = store.get('dict', []), have = new Set(saved.map(x => norm(x.w)));
    words.forEach(x => { if (!have.has(norm(x.w))) saved.push(x); }); store.set('dict', saved.slice(-200));
  }
  if (S.log.q.length) {
    const sec = el('div', 'endsec'); sec.append(el('h3', null, 'Preguntas para seguir hablando'));
    const ul = el('ul', 'qlist');
    S.log.q.slice(-6).forEach(x => { const li = el('li'); li.append(el('b', null, x.to.charAt(0).toUpperCase() + x.to.slice(1) + ': '), document.createTextNode(x.q)); ul.append(li); });
    sec.append(ul); box.append(sec);
  }
  const rs = el('div', 'endsec'); rs.append(el('h3', null, 'Retos para esta semana'));
  const ol = el('ul', 'retos'); shuffle(RETOS).slice(0, 3).forEach(r => ol.append(el('li', null, r))); rs.append(ol); box.append(rs);
  const gold = el('div', 'golden'); gold.append(el('span', 'lbl', 'Regla de oro Tecnofamilias'), document.createTextNode('Si algo raro pasa en internet, se cuenta en casa. Primero escuchamos, después resolvemos.'));
  box.append(gold);
  const btns = el('div', 'end-btns');
  const again = el('button', 'btn', 'Revancha'), change = el('button', 'btn alt', 'Cambiar personajes');
  again.type = change.type = 'button';
  again.addEventListener('click', () => startGame(true));
  change.addEventListener('click', backToSetup);
  btns.append(again, change); box.append(btns);
  panel.append(box);

  await sleep(RM ? 50 : 1000);
  if (S.phase !== 'end') return;
  if (win >= 0 && !RM) {
    const fav = (S.players[win].best && S.players[win].best.m) || 'explosion';
    await dance(win, fav, '✦ ' + MOVES[fav].name + ': la final ✦', { epic: true, react: true, vol: 1 });
    if (S.phase !== 'end') return;
  }
  if (win >= 0) {
    const l = 1 - win;
    actors[win].classList.add('king', 'glow'); setPose(win, 'win'); setExpr(win, 'happy'); say(win, pick(LINES[S.players[win].role].win), { keep: true });
    setTimeout(() => { if (S.phase !== 'end') return; act(l, 'r-aplauso', 1800); setExpr(l, 'happy'); say(l, S.players[l].role === 'chico' ? 'Revancha. Ya. Ahora.' : 'Ganaste esta… pero yo pago el internet 😅', { keep: true }); }, 1300);
  } else {
    [0, 1].forEach(i => { actors[i].classList.add('glow'); setExpr(i, 'happy'); act(i, 'm-cumbia', 3000); });
    say(0, '¿Empate? Entonces ganamos los dos.', { keep: true });
    setTimeout(() => say(1, 'Aura compartida. Slay familiar ✨', { keep: true }), 1200);
  }
  confetti(); flashNeon(); Sfx.aura(); setTimeout(() => Sfx.applause(3, 30, 0.24), 300);
  audience('clap', 3800); audClaps(10);
  setTimeout(() => { if (S.phase === 'end') [0, 1].forEach(i => setPose(i, null)); }, 3400);
}

/* ---------- Start / reset ---------- */
function tryStart() {
  const n0 = ED.names[0].trim(), n1 = ED.names[1].trim();
  if (!n0 || !n1) {
    const miss = !n0 ? 0 : 1;
    selectPlayer(miss);
    startErr.textContent = miss === 0 ? 'Falta el nombre del jugador adulto.' : 'Falta el nombre del jugador chico o chica.';
    pname.focus(); return;
  }
  startErr.textContent = '';
  startGame(false);
}
function startGame(rematch) {
  if (!rematch) {
    S.players = [0, 1].map(i => ({ role: roleOf(i), name: ED.names[i].trim(), look: ED.looks[i], aura: 0 }));
    S.n = Number((document.querySelector('input[name="len"]:checked') || {}).value || 10);
    store.set('len', S.n);
  } else S.players.forEach(p => { p.aura = 0; p.best = null; p.lastMove = null; });
  S.t = 0; S.first = Math.random() < 0.5 ? 0 : 1; S.phase = 'play'; S.busy = false; S.cur = null; S.thinking = false;
  S.plan = { 0: buildPlan(S.n / 2), 1: buildPlan(S.n / 2) };
  S.decks = {}; S.trad = {}; S.log = { q: [], words: new Map() };
  [0, 1].forEach(i => actors[i].classList.remove('king', 'glow', 'fwd')); stage.classList.remove('finale');
  document.body.classList.add('in-game'); document.body.classList.remove('in-setup');
  $('#intro').hidden = true; $('#setupPanel').hidden = true; $('#scorebar').hidden = false; panel.hidden = false;
  mountActors(); renderScores();
  [0, 1].forEach(i => $('#score' + i).querySelector('.num').textContent = '0');
  window.scrollTo({ top: 0, behavior: RM ? 'auto' : 'smooth' });
  gen++; clearBubbles(); resetStage();
  panel.innerHTML = '';
  const first = S.players[S.first];
  panel.append(el('h2', null, '¡Que empiece la batalla de aura!'), el('p', 'muted', `Por sorteo, empieza ${first.name}. El público ya está listo.`));
  Sfx.applause(1.6); audience('clap', 1800); audClaps(5);
  [0, 1].forEach(i => { setExpr(i, 'happy'); act(i, 'g-hop', 1200); });
  say(0, pick(['¿Listos para farmear aura?', 'Hoy se farmea en serio.', 'Prepárate, que vengo con todo.']));
  setTimeout(() => say(1, pick(['Nací listo ✨', 'GG desde ya.', 'Prepárate para perder aura.'])), 700);
  setTimeout(() => { if (S.phase === 'play' && !S.cur) { act(0, 'g-guard', 2000); act(1, 'g-guard', 2000); } }, 1300);
  const g = gen;
  setTimeout(() => { if (g === gen && S.phase === 'play') startTurn(); }, RM ? 1200 : 2600);
}
function backToSetup() {
  gen++; S.phase = 'setup'; clearBubbles(); resetStage(); S.thinking = false;
  document.body.classList.remove('in-game'); document.body.classList.add('in-setup');
  [0, 1].forEach(i => { actors[i].classList.remove('king', 'glow', 'fwd'); });
  spots.forEach(s => s.classList.remove('on')); stage.classList.remove('finale');
  $('#intro').hidden = false; $('#setupPanel').hidden = false; $('#scorebar').hidden = true; panel.hidden = true;
  mountActors(); renderTabs(); renderCtabs(); renderCat(); renderDict(); renderScenes(); selectPlayer(ED.ed);
  window.scrollTo({ top: 0, behavior: RM ? 'auto' : 'smooth' });
}

/* ---------- Scenes ---------- */
const SCENES = { teatro: { n: 'Teatro' }, cancha: { n: 'Cancha de baloncesto' }, parque: { n: 'Parque', day: true }, calle: { n: 'Calle de la ciudad' } };
function seeded(seed) { let s = seed; return () => (s = (s * 9301 + 49297) % 233280) / 233280; }
function sceneSVG(id, k, fit) {
  const g = n => `${n}-${k}`;
  const open = `<svg viewBox="0 0 1400 700" preserveAspectRatio="${fit || 'xMidYMax slice'}" aria-hidden="true" focusable="false">`;
  const grad = (n, a, b) => `<linearGradient id="${g(n)}" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="${a}"/><stop offset="1" stop-color="${b}"/></linearGradient>`;
  if (id === 'teatro') {
    let st = ''; for (let x = 0; x <= 1400; x += 46) st += `<rect x="${x}" width="2" height="490" fill="#fff" opacity=".035"/>`;
    return open + `<defs>${grad('tw', '#3A5689', '#1B2847')}${grad('tf', '#304A7B', '#1C2B4C')}</defs><rect width="1400" height="490" fill="url(#${g('tw')})"/>${st}<rect y="490" width="1400" height="210" fill="url(#${g('tf')})"/><rect y="488" width="1400" height="5" fill="#FDBE30" opacity=".6"/><path d="M380 0 L460 0 L640 490 L200 490Z M940 0 L1020 0 L1200 490 L760 490Z" fill="#FFF6DC" opacity=".14"/><rect x="560" y="40" width="280" height="64" rx="32" fill="none" stroke="#86D6FB" stroke-width="5"/></svg>`;
  }
  if (id === 'cancha') {
    const r = seeded(7), heads = ['#4B6595', '#5A73A3', '#3F5786', '#EF4A37', '#FDBE30', '#3DAEE4'];
    let crowd = '', bleach = '', planks = '';
    for (let row = 0; row < 5; row++) {
      bleach += `<rect y="${330 + row * 34}" width="1400" height="10" fill="#33497A"/>`;
      for (let x = 20 + (row % 2) * 18; x < 1400; x += 36) if (r() < 0.78) crowd += `<circle cx="${x}" cy="${320 + row * 34}" r="9" fill="${heads[Math.floor(r() * 6)]}" opacity="${r() < 0.7 ? 0.5 : 0.8}"/>`;
    }
    for (let x = 0; x <= 1400; x += 56) planks += `<path d="M${x} 490 L${700 + (x - 700) * 1.6} 700" stroke="#8B5A2B" stroke-width="1.5" opacity=".28"/>`;
    return open + `<defs>${grad('cw', '#2E4372', '#1D2C4F')}${grad('cf', '#D9995A', '#B07034')}</defs>
<rect width="1400" height="490" fill="url(#${g('cw')})"/><rect y="296" width="1400" height="194" fill="#24365E"/>${bleach}${crowd}
<path d="M150 30 h120 v74 l-60 24 l-60 -24Z" fill="#EF4A37"/><path d="M1130 30 h120 v74 l-60 24 l-60 -24Z" fill="#3DAEE4"/><path d="M210 52 l7 14 15 2 -11 11 3 15 -14 -7 -14 7 3 -15 -11 -11 15 -2Z M1190 52 l7 14 15 2 -11 11 3 15 -14 -7 -14 7 3 -15 -11 -11 15 -2Z" fill="#FDBE30"/>
<circle cx="430" cy="34" r="70" fill="#FFF6DC" opacity=".12"/><ellipse cx="430" cy="30" rx="40" ry="10" fill="#FFF6DC"/><circle cx="970" cy="34" r="70" fill="#FFF6DC" opacity=".12"/><ellipse cx="970" cy="30" rx="40" ry="10" fill="#FFF6DC"/>
<path d="M700 0 V150" stroke="#9AA4B8" stroke-width="8"/><rect x="600" y="150" width="200" height="120" rx="8" fill="#F4F7FB" stroke="#9AA4B8" stroke-width="4"/><rect x="666" y="198" width="68" height="50" fill="none" stroke="#EF4A37" stroke-width="5"/><path d="M700 270 V282" stroke="#9AA4B8" stroke-width="6"/>
<path d="M664 288 L678 336 M682 290 L690 338 M700 292 V340 M718 290 L710 338 M736 288 L722 336 M670 304 L730 304 M676 320 L724 320" stroke="#fff" stroke-width="2.5" opacity=".9"/><ellipse cx="700" cy="286" rx="38" ry="8" fill="none" stroke="#EF4A37" stroke-width="6"/>
<rect y="490" width="1400" height="210" fill="url(#${g('cf')})"/>${planks}
<path d="M520 490 L880 490 L960 700 L440 700Z" fill="#EF4A37" opacity=".5"/><path d="M520 490 L440 700 M880 490 L960 700" stroke="#fff" stroke-width="5"/><path d="M170 490 Q700 770 1230 490" fill="none" stroke="#fff" stroke-width="5"/><rect y="487" width="1400" height="6" fill="#fff" opacity=".85"/><ellipse cx="700" cy="575" rx="520" ry="42" fill="#fff" opacity=".07"/></svg>`;
  }
  if (id === 'parque') {
    const r = seeded(3);
    const tree = (x, s) => `<g transform="translate(${x} 0)"><rect x="${-11 * s}" y="${490 - 110 * s}" width="${22 * s}" height="${110 * s}" fill="#8B5A2B"/><circle cx="0" cy="${490 - 150 * s}" r="${62 * s}" fill="#3E9B57"/><circle cx="${-46 * s}" cy="${490 - 118 * s}" r="${46 * s}" fill="#4FB36A"/><circle cx="${48 * s}" cy="${490 - 122 * s}" r="${48 * s}" fill="#46A862"/><circle cx="${8 * s}" cy="${490 - 196 * s}" r="${44 * s}" fill="#56BD72"/></g>`;
    const cloud = (x, y, s) => `<g fill="#fff" opacity=".92"><circle cx="${x}" cy="${y}" r="${28 * s}"/><circle cx="${x + 30 * s}" cy="${y - 14 * s}" r="${34 * s}"/><circle cx="${x + 66 * s}" cy="${y}" r="${26 * s}"/><rect x="${x}" y="${y}" width="${66 * s}" height="${26 * s}"/></g>`;
    let fl = ''; for (let i = 0; i < 46; i++) { const x = r() * 1400, y = 505 + r() * 190; if (x > 560 && x < 840) continue; fl += `<circle cx="${x.toFixed(0)}" cy="${y.toFixed(0)}" r="${(3 + r() * 3).toFixed(1)}" fill="${['#FDBE30', '#F48FB1', '#FFFFFF', '#EF4A37'][Math.floor(r() * 4)]}"/>`; }
    return open + `<defs>${grad('ps', '#78C6EE', '#D6F1FB')}${grad('pg', '#6CC26B', '#3F9547')}</defs>
<rect width="1400" height="490" fill="url(#${g('ps')})"/><circle cx="1150" cy="105" r="90" fill="#FFE9A0" opacity=".35"/><circle cx="1150" cy="105" r="50" fill="#FDD45C"/>
${cloud(200, 120, 1)}${cloud(760, 70, 0.8)}${cloud(960, 165, 0.6)}
<path d="M0 400 Q300 300 620 395 Q920 305 1400 385 V490 H0Z" fill="#A6DDA1"/><path d="M0 445 Q360 385 720 440 Q1060 395 1400 432 V490 H0Z" fill="#86CC85"/>
${tree(110, 1.1)}${tree(320, 0.85)}${tree(1080, 0.9)}${tree(1300, 1.15)}
<g transform="translate(880 432)"><rect x="0" y="0" width="120" height="8" rx="3" fill="#A0693A"/><rect x="0" y="20" width="120" height="10" rx="3" fill="#8B5A2B"/><rect x="10" y="30" width="8" height="26" fill="#5B3A26"/><rect x="102" y="30" width="8" height="26" fill="#5B3A26"/></g>
<rect x="497" y="300" width="8" height="190" fill="#3A4560"/><rect x="485" y="284" width="32" height="22" rx="6" fill="#283A60"/><circle cx="501" cy="300" r="8" fill="#FFF3C4"/>
<rect y="490" width="1400" height="210" fill="url(#${g('pg')})"/><path d="M610 490 L790 490 L1010 700 L390 700Z" fill="#E2C38F"/>${fl}</svg>`;
  }
  const r = seeded(11), cols = ['#1E2A47', '#243457', '#2A3B63', '#1B2541'];
  let stars = '', bld = '', side = '', dash = '', cross = '';
  for (let i = 0; i < 40; i++) stars += `<circle cx="${(r() * 1400).toFixed(0)}" cy="${(r() * 190).toFixed(0)}" r="${(0.8 + r() * 1.6).toFixed(1)}" fill="#fff" opacity="${(0.4 + r() * 0.5).toFixed(2)}"/>`;
  for (let x = -20; x < 1420;) {
    const w = 110 + Math.floor(r() * 120), h = 170 + Math.floor(r() * 230), y = 455 - h;
    bld += `<rect x="${x}" y="${y}" width="${w}" height="${h}" fill="${cols[Math.floor(r() * 4)]}"/>`;
    for (let wy = y + 18; wy < 430; wy += 34) for (let wx = x + 14; wx < x + w - 22; wx += 30) bld += `<rect x="${wx}" y="${wy}" width="14" height="18" rx="2" fill="${r() < 0.45 ? '#FDDB6D' : '#3A4E7A'}" opacity=".88"/>`;
    x += w + 6;
  }
  for (let x = 0; x <= 1400; x += 70) side += `<path d="M${x} 455 V497" stroke="#7A88A6" stroke-width="2" opacity=".35"/>`;
  for (let x = 0; x < 1400; x += 150) if (x < 520 || x > 860) dash += `<rect x="${x}" y="612" width="80" height="9" fill="#F2F4F8" opacity=".7"/>`;
  for (let x = 560; x < 840; x += 46) cross += `<path d="M${x} 518 L${x + 28} 518 L${x + 28 + (x - 700) * 0.25} 700 L${x + (x - 700) * 0.25} 700Z" fill="#E8ECF2" opacity=".85"/>`;
  const lamp = x => `<circle cx="${x + 34}" cy="240" r="80" fill="#FFE9A0" opacity=".12"/><rect x="${x - 4}" y="250" width="8" height="210" fill="#3A4560"/><path d="M${x} 252 q0 -24 30 -24" stroke="#3A4560" stroke-width="7" fill="none"/><ellipse cx="${x + 34}" cy="232" rx="15" ry="6" fill="#FFF3C4"/>`;
  return open + `<defs>${grad('cs', '#0F1830', '#2A3D66')}</defs><rect width="1400" height="490" fill="url(#${g('cs')})"/>${stars}<circle cx="1200" cy="80" r="32" fill="#F4F1DE"/><circle cx="1186" cy="70" r="30" fill="#14203B"/>${bld}${lamp(180)}${lamp(1150)}
<rect y="455" width="1400" height="45" fill="#56647F"/>${side}<rect y="500" width="1400" height="200" fill="#2B3245"/><rect y="496" width="1400" height="6" fill="#9AA4B8"/>${cross}${dash}</svg>`;
}
function applyScene(id, anim) {
  if (!SCENES[id]) id = 'teatro';
  stage.dataset.scene = id; stage.classList.toggle('day', !!SCENES[id].day);
  $('#scene').innerHTML = id === 'teatro' ? '' : sceneSVG(id, 's');
  store.set('scene', id);
  if (anim) { Sfx.pop(); flash(); audience('clap', 900); audClaps(3); }
}
function renderScenes() {
  const box = $('#scenePicks'); box.innerHTML = '';
  const cur = stage.dataset.scene || 'teatro';
  Object.entries(SCENES).forEach(([id, s]) => {
    const b = el('button', 'tile scene-tile'); b.type = 'button'; b.setAttribute('aria-pressed', String(cur === id));
    const v = el('span', 'tv'); v.innerHTML = sceneSVG(id, 'p' + id, 'xMidYMid slice');
    b.append(v, el('span', 'tn', s.n));
    b.addEventListener('click', () => { applyScene(id, true); renderScenes(); });
    box.append(b);
  });
}

/* ---------- Init ---------- */
function init() {
  aud.innerHTML = buildAudience();
  applyScene(store.get('scene', 'teatro')); renderScenes();
  document.body.classList.add('in-setup');
  mountActors(); renderTabs(); renderCtabs(); renderCat(); renderDict();
  const len = String(store.get('len', 10));
  const r = document.querySelector(`input[name="len"][value="${len}"]`); if (r) r.checked = true;

  const t = $('#title'), txt = t.textContent; t.textContent = '';
  let li = 0;
  txt.split(' ').forEach((word, wi) => {
    if (wi) t.append(document.createTextNode(' '));
    const wd = el('span', 'wd'); wd.setAttribute('aria-hidden', 'true');
    [...word].forEach(ch => { const s = el('span', 'ch', ch); s.style.animationDelay = (0.05 * li++) + 's'; wd.append(s); });
    t.append(wd);
  });

  const sb = $('#soundBtn');
  const syncSound = () => { sb.setAttribute('aria-pressed', String(Sfx.on)); sb.querySelector('span').textContent = Sfx.on ? '🔊' : '🔇'; sb.querySelector('.lbl').textContent = Sfx.on ? 'Sonido' : 'Sin sonido'; };
  sb.addEventListener('click', () => { Sfx.set(!Sfx.on); syncSound(); if (Sfx.on) Sfx.pop(); });
  syncSound();

  [0, 1].forEach(i => $('#ptab' + i).addEventListener('click', () => selectPlayer(i)));
  pname.addEventListener('input', () => { ED.names[ED.ed] = pname.value.slice(0, 16); saveED(); renderTabs(); if (pname.value.trim()) startErr.textContent = ''; });
  $('#randBtn').addEventListener('click', () => { const i = ED.ed; ED.looks[i] = randomLook(roleOf(i)); saveED(); charEl(i).innerHTML = charSVG(ED.looks[i]); act(i, 'g-hop', 1200); sparkles(i, 14); Sfx.pop(); renderCat(); });
  $('#tryBtn').addEventListener('click', () => previewMove(ED.ed));
  $('#clearBtn').addEventListener('click', () => { const i = ED.ed; ED.looks[i] = blankLook(); saveED(); charEl(i).innerHTML = charSVG(ED.looks[i]); act(i, 'g-hop', 1200); Sfx.pop(); ED.cat = 'piel'; renderCtabs(); renderCat(); });
  $('#startBtn').addEventListener('click', tryStart);
  $('#endNow').addEventListener('click', () => { if (S.phase === 'play') endGame(); });

  if (RM) { actors.forEach(a => a.classList.remove('off')); selectPlayer(0); }
  else {
    setTimeout(() => { [0, 1].forEach(i => { actors[i].classList.remove('off'); walk(i, 1000); }); }, 350);
    setTimeout(() => { audience('clap', 1400); audClaps(4); [0, 1].forEach(i => setExpr(i, 'happy')); }, 1400);
    setTimeout(() => say(0, '¡Diséñame a tu estilo!'), 1700);
    setTimeout(() => say(1, 'A mí también ✨'), 2600);
    setTimeout(() => { [0, 1].forEach(i => setExpr(i, null)); if (S.phase === 'setup') selectPlayer(ED.ed); }, 3600);
  }
  getSample();
  setInterval(idleTick, 400);
}
init();
})();

</script>
</body>
</html>
$TF$,
  "description" = $TF$Un duelo de risas entre generaciones: un adulto y un chico o chica diseñan su personaje, resuelven situaciones de la vida digital, ponen palabras a prueba y traducen la jerga de la otra generación. Después de cada turno, una pregunta para conversar en familia.$TF$,
  "updatedAt" = CURRENT_TIMESTAMP
WHERE "slug" = 'farmea-aura';
