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

/** Agrega al HTML del juego el reporte de altura y el almacenamiento local. */
export function withHeightReporter(html: string) {
  const lower = html.toLowerCase();
  // El almacenamiento va antes de cualquier script del juego.
  const head = lower.indexOf("<head");
  const headEnd = head === -1 ? -1 : lower.indexOf(">", head) + 1;
  let out = headEnd > 0 ? html.slice(0, headEnd) + STORAGE_SCRIPT + html.slice(headEnd) : STORAGE_SCRIPT + html;
  const i = out.toLowerCase().lastIndexOf("</body>");
  out = i === -1 ? out + HEIGHT_SCRIPT : out.slice(0, i) + HEIGHT_SCRIPT + out.slice(i);
  return out;
}

export const GAME_SANDBOX = "allow-scripts allow-forms allow-modals allow-popups allow-popups-to-escape-sandbox allow-downloads";
