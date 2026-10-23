import { resolveVideo } from "@/lib/video";

export function VideoPlayer({ url, title }: { url: string; title: string }) {
  const source = resolveVideo(url);
  if (source.type === "iframe") {
    return (
      <iframe
        className="player"
        src={source.src}
        title={title}
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; fullscreen"
        allowFullScreen
        referrerPolicy="strict-origin-when-cross-origin"
      />
    );
  }
  if (source.type === "file") {
    return <video className="player" src={source.src} controls controlsList="nodownload" preload="metadata" />;
  }
  return (
    <div className="locked">
      <div>
        <h3>Video en preparación</h3>
        <p>Muy pronto podrás ver esta clase.</p>
      </div>
    </div>
  );
}
