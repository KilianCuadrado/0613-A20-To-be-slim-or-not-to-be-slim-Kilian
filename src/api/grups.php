<?php

switch ($request->getMethod()) {
    case 'GET':
        if ($request->getUri()->getPath() === "/api/grups") {
            $dbPath = __DIR__ . '/../data/music.db';
            $pdo = new PDO('sqlite:' . $dbPath);
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            $query = $pdo->query(
                'SELECT id, nombre, img, "desc" as descripcion FROM grupos ORDER BY nombre ASC'
            );
            $grups = $query->fetchAll(PDO::FETCH_ASSOC);

            $payload = json_encode($grups);
            $response->getBody()->write($payload !== false ? $payload : '[]');
            break;
        }
}
