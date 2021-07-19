<?php

use Onliner\Counter\Manager\VisitManager;

require_once '../vendor/autoload.php';
require_once '../src/bootstrap.php';

session_start();

if (isset($_GET['stat'])) {
    $page = $_GET['stat'];

    if (\function_exists('fastcgi_finish_request')) {
        fastcgi_finish_request();
    }

    $redisArray = new \RedisArray(REDIS_ARRAY_POOL);

    $keySignature = \sprintf("%s:page:%s", $_REQUEST['PHPSESSID'], $page);
    $visitTTL = (\mktime(24,0,0) - time());

    $key = $redisArray->get($keySignature);
    if (!$key) {
        $status = $redisArray->set($keySignature, 1, ['ex' => $visitTTL]);

        $pdo = new \PDO(sprintf('sqlite:../data/%s.sqlite', $page));
        $visitManager = new VisitManager($pdo, $page);
        $visitManager->init();
        $visitManager->visit();
        $visitManager->cleanup();

        unset($visitManager, $pdo);
    }
}

if (isset($_GET['page'])) {
    $page = $_GET['page'];

    $pdo = new \PDO(sprintf('sqlite:../data/%s.sqlite', $page));
    $visitManager = new VisitManager($pdo, $page);
    $visitManager->init();

    echo $visitManager->getVisitors();
}
