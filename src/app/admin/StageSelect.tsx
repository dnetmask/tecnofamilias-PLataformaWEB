import type { AgeStage } from "@prisma/client";
import { AGE_STAGES } from "@/lib/format";

export function StageSelect({ defaultValue }: { defaultValue: AgeStage }) {
  return (
    <select className="select" name="ageStage" defaultValue={defaultValue}>
      {AGE_STAGES.map((s) => (
        <option key={s.value} value={s.value}>{s.label}</option>
      ))}
    </select>
  );
}
