/**
 * Los juegos son HTML autocontenidos que se sirven en un iframe con sandbox
 * (sin allow-same-origin): no pueden leer la sesión ni la página que los
 * contiene. Este script se inyecta para que el juego informe su altura y el
 * iframe crezca sin barra de desplazamiento propia.
 */
export const GAME_HEIGHT_MESSAGE = "tf-game-height";

const HEIGHT_SCRIPT = `<script>(function(){function s(){parent.postMessage({type:"${GAME_HEIGHT_MESSAGE}",height:document.documentElement.scrollHeight},"*")}addEventListener("load",s);if(window.ResizeObserver){new ResizeObserver(s).observe(document.documentElement)}s()})()</script>`;

/**
 * Sin allow-same-origin el juego no tiene localStorage (lanza un error). Este
 * script le da uno en memoria: arranca con lo que la página guardó (viene en el
 * #hash del iframe) y avisa cada cambio para que la página lo guarde por juego.
 */
export const GAME_STORAGE_MESSAGE = "tf-game-storage";
export const GAME_STORAGE_HASH = "tfs=";

const STORAGE_SCRIPT = `<script>(function(){var m={};try{var h=location.hash.slice(1);if(h.indexOf("${GAME_STORAGE_HASH}")===0){var d=JSON.parse(decodeURIComponent(h.slice(${GAME_STORAGE_HASH.length})));if(d&&typeof d==="object")m=d}}catch(e){}
try{window.localStorage.getItem("x");return}catch(e){}
function sync(){try{parent.postMessage({type:"${GAME_STORAGE_MESSAGE}",data:m},"*")}catch(e){}}
var s={getItem:function(k){k=String(k);return Object.prototype.hasOwnProperty.call(m,k)?String(m[k]):null},setItem:function(k,v){m[String(k)]=String(v);sync()},removeItem:function(k){delete m[String(k)];sync()},clear:function(){m={};sync()},key:function(i){return Object.keys(m)[i]||null}};
Object.defineProperty(s,"length",{get:function(){return Object.keys(m).length}});
try{Object.defineProperty(window,"localStorage",{value:s,configurable:true})}catch(e){}})()</script>`;

/**
 * Safari del iPhone no deja usar la pantalla completa del navegador. Si el
 * juego trae su propio botón, este script se lo pide a la página, que usa su
 * pantalla completa propia.
 */
export const GAME_FULLSCREEN_MESSAGE = "tf-game-fullscreen";

const FULLSCREEN_SCRIPT = `<script>(function(){if(document.fullscreenEnabled||document.webkitFullscreenEnabled)return;var on=false;
function set(v){if(on===v)return;on=v;try{document.dispatchEvent(new Event("fullscreenchange"))}catch(e){}}
function ask(v){set(v);try{parent.postMessage({type:"${GAME_FULLSCREEN_MESSAGE}",on:v},"*")}catch(e){}return Promise.resolve()}
addEventListener("message",function(e){if(e.source===parent&&e.data&&e.data.type==="${GAME_FULLSCREEN_MESSAGE}")set(e.data.on===true)});
Element.prototype.requestFullscreen=function(){return ask(true)};Element.prototype.webkitRequestFullscreen=function(){ask(true)};
document.exitFullscreen=function(){return ask(false)};document.webkitExitFullscreen=function(){ask(false)};
try{Object.defineProperty(document,"fullscreenEnabled",{get:function(){return true},configurable:true});Object.defineProperty(document,"fullscreenElement",{get:function(){return on?document.documentElement:null},configurable:true})}catch(e){}})()</script>`;

/** Agrega al HTML del juego el reporte de altura, el almacenamiento local y la pantalla completa del iPhone. */
export function withHeightReporter(html: string) {
  const lower = html.toLowerCase();
  // El almacenamiento va antes de cualquier script del juego.
  const head = lower.indexOf("<head");
  const headEnd = head === -1 ? -1 : lower.indexOf(">", head) + 1;
  const injected = STORAGE_SCRIPT + FULLSCREEN_SCRIPT;
  let out = headEnd > 0 ? html.slice(0, headEnd) + injected + html.slice(headEnd) : injected + html;
  const i = out.toLowerCase().lastIndexOf("</body>");
  out = i === -1 ? out + HEIGHT_SCRIPT : out.slice(0, i) + HEIGHT_SCRIPT + out.slice(i);
  return out;
}

export const GAME_SANDBOX = "allow-scripts allow-forms allow-modals allow-popups allow-popups-to-escape-sandbox allow-downloads";
