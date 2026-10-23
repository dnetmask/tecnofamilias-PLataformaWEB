/**
 * Muestra los detalles de un servicio escritos en texto plano desde el admin.
 * Los bloques se separan con una línea en blanco; "## Título" crea un
 * subtítulo y las líneas que empiezan con "- " forman una lista.
 */
export function ServiceDetails({ text }: { text: string }) {
  const blocks = text.trim().split(/\n\s*\n/);
  return (
    <div className="stack">
      {blocks.map((block, i) => {
        const lines = block.split("\n").map((l) => l.trim()).filter(Boolean);
        const title = lines[0]?.startsWith("## ") ? lines.shift()!.slice(3) : null;
        const items = lines.length > 0 && lines.every((l) => l.startsWith("- "));
        return (
          <div key={i}>
            {title && <h3>{title}</h3>}
            {items ? (
              <ul className="service-details">
                {lines.map((l) => (
                  <li key={l}>{l.slice(2)}</li>
                ))}
              </ul>
            ) : (
              lines.length > 0 && <p className="muted" style={{ whiteSpace: "pre-wrap" }}>{lines.join("\n")}</p>
            )}
          </div>
        );
      })}
    </div>
  );
}
