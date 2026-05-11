<?php

$dbPath = __DIR__ . '/../data/music.db';
$pdo = new PDO('sqlite:' . $dbPath);
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

$personasColumns = $pdo->query('PRAGMA table_info(personas)')->fetchAll(PDO::FETCH_ASSOC);
$hasEstadoMiembro = false;
$hasMiembroOficialEstable = false;

foreach ($personasColumns as $column) {
    if (($column['name'] ?? '') === 'estadoMiembro') {
        $hasEstadoMiembro = true;
    }

    if (($column['name'] ?? '') === 'miembroOficialEstable') {
        $hasMiembroOficialEstable = true;
    }
}

if (!$hasEstadoMiembro) {
    $pdo->exec("ALTER TABLE personas ADD COLUMN estadoMiembro TEXT NOT NULL DEFAULT 'integrante'");
}

if (!$hasMiembroOficialEstable) {
    $pdo->exec("ALTER TABLE personas ADD COLUMN miembroOficialEstable INTEGER NOT NULL DEFAULT 0");
}

$path = $request->getUri()->getPath();
$method = $request->getMethod();
$response = $response->withHeader('Content-Type', 'application/json');

$writeJson = static function ($response, $data, int $statusCode = 200) {
    $payload = json_encode($data, JSON_UNESCAPED_UNICODE);
    $response->getBody()->write($payload !== false ? $payload : 'null');
    return $response->withStatus($statusCode);
};

if ($method !== 'GET') {
    $response = $writeJson($response, ['error' => 'Metodo no permitido'], 405);
    return;
}

if ($path === '/api/grups') {
    $query = $pdo->query('SELECT id, nombre, COALESCE(img, "https://via.placeholder.com/640x360?text=Sin+imagen") AS img, COALESCE("desc", "Dato sin confirmar") AS descripcion FROM grupos ORDER BY nombre ASC');
    $grups = $query->fetchAll(PDO::FETCH_ASSOC);
    $response = $writeJson($response, $grups);
    return;
}

if (preg_match('#^/api/grups/(\d+)$#', $path, $matches) === 1) {
    $grupId = (int) $matches[1];
    $statement = $pdo->prepare('SELECT id, nombre, COALESCE(img, "https://via.placeholder.com/960x360?text=Sin+imagen") AS img, COALESCE("desc", "Dato sin confirmar") AS descripcion, COALESCE(generos, "Dato sin confirmar") AS generos, COALESCE(fechaCreacion, "Dato sin confirmar") AS fechaCreacion FROM grupos WHERE id = :id');
    $statement->execute(['id' => $grupId]);
    $grup = $statement->fetch(PDO::FETCH_ASSOC);

    if ($grup === false) {
        $response = $writeJson($response, ['error' => 'Grupo no encontrado'], 404);
        return;
    }

    $response = $writeJson($response, $grup);
    return;
}

if (preg_match('#^/api/grups/(\d+)/(albumes|integrants)$#', $path, $matches) === 1) {
    $grupId = (int) $matches[1];
    $resource = $matches[2];

    $groupQuery = $pdo->prepare('SELECT nombre FROM grupos WHERE id = :id');
    $groupQuery->execute(['id' => $grupId]);
    $groupName = $groupQuery->fetchColumn();

    if ($groupName === false) {
        $response = $writeJson($response, ['error' => 'Grupo no encontrado'], 404);
        return;
    }

    if ($resource === 'albumes') {
        $albumesQuery = $pdo->prepare(
            'SELECT id, COALESCE(nombreAlbum, "Album sin nombre") AS nombreAlbum, COALESCE(cancionMasPopular, "Dato sin confirmar") AS cancionMasPopular, COALESCE(fechaLanzamiento, "Dato sin confirmar") AS fechaLanzamiento, COALESCE(generos, "Dato sin confirmar") AS generos, COALESCE(descripcion, "Dato sin confirmar") AS descripcion
            FROM albumes
            WHERE grupo = :grupo
            AND descripcion LIKE "Album. Categoria: studio.%"
            ORDER BY fechaLanzamiento DESC, nombreAlbum ASC'
        );
        $albumesQuery->execute(['grupo' => $groupName]);
        $albumes = $albumesQuery->fetchAll(PDO::FETCH_ASSOC);
        $response = $writeJson($response, $albumes);
        return;
    }

    $integrantsQuery = $pdo->prepare(
        'SELECT id,
        COALESCE(nombre, "Integrante sin nombre") AS nombre,
        CASE WHEN edad IS NULL OR edad <= 0 THEN "Dato sin confirmar" ELSE CAST(edad AS TEXT) END AS edad,
        COALESCE(instrumento, "Dato sin confirmar") AS instrumento,
        COALESCE(fechaNacimiento, "Dato sin confirmar") AS fechaNacimiento,
        COALESCE(estadoMiembro, "integrante") AS estadoMiembro
        FROM personas
        WHERE grupo = :grupo
        AND estadoMiembro IN ("integrante", "exintegrante")
        AND miembroOficialEstable = 1
        ORDER BY nombre ASC'
    );
    $integrantsQuery->execute(['grupo' => $groupName]);
    $integrants = $integrantsQuery->fetchAll(PDO::FETCH_ASSOC);
    $response = $writeJson($response, $integrants);
    return;
}

$response = $writeJson($response, ['error' => 'Ruta no encontrada'], 404);
