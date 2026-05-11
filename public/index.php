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

//REPUSTA JSON AMB TOTS ELS GRUPS
$app->get('/api/grups', function (Request $request, Response $response) {

    include_once __DIR__ . '/../src/api/grups.php';
    return $response->withHeader('Content-Type', 'application/json')->withStatus(200);

});

$app->run();
