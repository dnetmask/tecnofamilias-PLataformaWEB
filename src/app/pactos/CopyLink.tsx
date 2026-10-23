"use client";

import { useState } from "react";

export function CopyLink({ path }: { path: string }) {
  const [copied, setCopied] = useState(false);
  const [url, setUrl] = useState(path);
  return (
    <div className="row" style={{ flexWrap: "nowrap" }}>
      <input
        className="input"
        readOnly
        value={url}
        onFocus={(e) => {
          setUrl(`${window.location.origin}${path}`);
          e.currentTarget.select();
        }}
      />
      <button
        type="button"
        className="btn btn-sm"
        onClick={async () => {
          const full = `${window.location.origin}${path}`;
          setUrl(full);
          await navigator.clipboard.writeText(full);
          setCopied(true);
        }}
      >
        {copied ? "Copiado" : "Copiar"}
      </button>
    </div>
  );
}
