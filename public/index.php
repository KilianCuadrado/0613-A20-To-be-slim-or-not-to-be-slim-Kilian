<?php
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Factory\AppFactory;

require __DIR__ . '/../vendor/autoload.php';

// Instantiate App
$app = AppFactory::create();

// Add error middleware
$app->addErrorMiddleware(true, true, true);

// Add routes
$app->get('/', function (Request $request, Response $response) {
    ob_start();
    include __DIR__ . '/pages/home.php';
    $html = ob_get_clean();
    $response->getBody()->write($html !== false ? $html : '');
    return $response;
});

$app->get('/grup/{id:[0-9]+}', function (Request $request, Response $response) {
    ob_start();
    include __DIR__ . '/pages/grup.php';
    $html = ob_get_clean();
    $response->getBody()->write($html !== false ? $html : '');
    return $response;
});

$app->get('/api/grups[/{id:[0-9]+}[/{resource}]]', function (Request $request, Response $response) {
    include __DIR__ . '/../src/api/grups.php';
    return $response;
});

$app->run();
