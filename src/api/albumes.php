<?php

$dbPath = __DIR__ . '/../data/music.db';
$pdo = new PDO('sqlite:' . $dbPath);
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

$path = $request->getUri()->getPath();
$method = $request->getMethod();
$response = $response->withHeader('Content-Type', 'application/json');

$writeJson = static function ($response, $data, int $statusCode = 200) {
    $payload = json_encode($data, JSON_UNESCAPED_UNICODE);
    $response->getBody()->write($payload !== false ? $payload : 'null');
    return $response->withStatus($statusCode);
};

$fetchUrl = static function (string $url): ?string {
    $context = stream_context_create([
        'http' => [
            'method' => 'GET',
            'header' => "User-Agent: Mozilla/5.0 (compatible; AlbumVideoBot/1.0)\r\n",
            'timeout' => 12
        ]
    ]);
    $content = @file_get_contents($url, false, $context);
    if ($content === false) {
        return null;
    }

    return $content;
};

$extractYoutubeVideoId = static function (string $query) use ($fetchUrl): ?string {
    $searchUrl = 'https://www.youtube.com/results?search_query=' . rawurlencode($query);
    $html = $fetchUrl($searchUrl);
    if ($html === null) {
        return null;
    }

    if (preg_match('/"videoId":"([A-Za-z0-9_-]{11})"/', $html, $matches) !== 1) {
        return null;
    }

    return $matches[1];
};

$isEmbeddableYoutubeVideo = static function (string $videoId) use ($fetchUrl): bool {
    $oEmbedUrl = 'https://www.youtube.com/oembed?url='
        . rawurlencode('https://www.youtube.com/watch?v=' . $videoId)
        . '&format=json';
    return $fetchUrl($oEmbedUrl) !== null;
};

if ($method !== 'GET') {
    $response = $writeJson($response, ['error' => 'Metodo no permitido'], 405);
    return;
}

if (preg_match('#^/api/albumes/(\d+)$#', $path, $matches) !== 1) {
    $response = $writeJson($response, ['error' => 'Ruta no encontrada'], 404);
    return;
}

$albumId = (int) $matches[1];
$statement = $pdo->prepare(
    'SELECT id,
    COALESCE(nombreAlbum, "Album sin nombre") AS nombreAlbum,
    COALESCE(cancionMasPopular, "Dato sin confirmar") AS cancionMasPopular,
    COALESCE(fechaLanzamiento, "Dato sin confirmar") AS fechaLanzamiento,
    COALESCE(grupo, "Dato sin confirmar") AS grupo,
    COALESCE(generos, "Dato sin confirmar") AS generos,
    COALESCE(descripcion, "Dato sin confirmar") AS descripcion
    FROM albumes
    WHERE id = :id
    AND descripcion LIKE "Album. Categoria: studio.%"'
);
$statement->execute(['id' => $albumId]);
$album = $statement->fetch(PDO::FETCH_ASSOC);

if ($album === false) {
    $response = $writeJson($response, ['error' => 'Album no encontrado'], 404);
    return;
}

$videoCandidates = [
    trim(($album['grupo'] ?? '') . ' ' . ($album['cancionMasPopular'] ?? '') . ' official video'),
    trim(($album['cancionMasPopular'] ?? '') . ' ' . ($album['grupo'] ?? '') . ' official video'),
    trim(($album['grupo'] ?? '') . ' ' . ($album['cancionMasPopular'] ?? ''))
];

$youtubeVideoId = null;
foreach ($videoCandidates as $videoQuery) {
    if ($videoQuery === '') {
        continue;
    }
    $candidateId = $extractYoutubeVideoId($videoQuery);
    if ($candidateId === null) {
        continue;
    }
    if ($isEmbeddableYoutubeVideo($candidateId)) {
        $youtubeVideoId = $candidateId;
        break;
    }
}

$album['youtubeEmbedUrl'] = $youtubeVideoId !== null
    ? 'https://www.youtube.com/embed/' . $youtubeVideoId
    : null;

$response = $writeJson($response, $album);
