-- Podcast de Spotify que va de primero en la Caja de herramientas.
-- Queda como borrador (sin publicar) hasta completar título, autor y descripción en Admin → Caja de herramientas.
INSERT INTO "Resource" ("id", "slug", "kind", "title", "author", "description", "url", "ageStage", "access", "published", "order")
SELECT 'res_podcast_spotify_7dzau', 'podcast-spotify-7dzau', 'PODCAST', 'Podcast recomendado (completar título)', '', '',
       'https://open.spotify.com/episode/7DZAUbhBc0VqYI0IZDMeqt', 'ALL', 'FREE', false,
       COALESCE((SELECT MIN("order") FROM "Resource"), 0) - 1
ON CONFLICT ("slug") DO NOTHING;
