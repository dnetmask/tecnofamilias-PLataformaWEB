const COLORS = ["#3DAEE4", "#EE4836", "#FDBF2E", "#3A5383", "#1F7FB0"];

export function Avatar({ name }: { name: string }) {
  const initials = name
    .split(/\s+/)
    .filter(Boolean)
    .slice(0, 2)
    .map((p) => p[0]?.toUpperCase())
    .join("");
  const color = COLORS[[...name].reduce((a, c) => a + c.charCodeAt(0), 0) % COLORS.length];
  return (
    <span className="avatar" style={{ background: color, color: color === "#FDBF2E" ? "#1E2B47" : "#fff" }} aria-hidden>
      {initials || "?"}
    </span>
  );
}
