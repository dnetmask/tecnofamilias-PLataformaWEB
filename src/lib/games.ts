/**
 * Los juegos son HTML autocontenidos que se sirven en un iframe con sandbox
 * (sin allow-same-origin): no pueden leer la sesión ni la página que los
 * contiene. Este script se inyecta para que el juego informe su altura y el
 * iframe crezca sin barra de desplazamiento propia.
 */
export const GAME_HEIGHT_MESSAGE = "tf-game-height";

const HEIGHT_SCRIPT = `<script>(function(){function s(){parent.postMessage({type:"${GAME_HEIGHT_MESSAGE}",height:document.documentElement.scrollHeight},"*")}addEventListener("load",s);if(window.ResizeObserver){new ResizeObserver(s).observe(document.documentElement)}s()})()</script>`;

export function withHeightReporter(html: string) {
  const i = html.toLowerCase().lastIndexOf("</body>");
  return i === -1 ? html + HEIGHT_SCRIPT : html.slice(0, i) + HEIGHT_SCRIPT + html.slice(i);
}

export const GAME_SANDBOX = "allow-scripts allow-modals allow-popups allow-popups-to-escape-sandbox";
