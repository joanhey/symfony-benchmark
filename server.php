<?php
require_once __DIR__ . '/vendor/autoload.php';


use Adapterman\Adapterman;
use Workerman\Worker;
use Workerman\Lib\Timer;

Adapterman::init();

$http_worker                = new Worker('http://0.0.0.0:9805');
$http_worker->count         = (int) shell_exec('nproc');
//$http_worker->count         = (int) shell_exec('nproc') * 4;
$http_worker->name          = 'AdapterMan-Symfony';

$http_worker->onWorkerStart = static function () {
    require __DIR__.'/start.php';
};

$http_worker->onMessage = static function ($connection, $request) {

    $connection->send(run());
};

Worker::runAll();
