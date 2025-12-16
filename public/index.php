<?php

use Illuminate\Foundation\Application;
use Illuminate\Http\Request;

// Compatibility for PHP 8.5+ deprecation of PDO::MYSQL_ATTR_SSL_CA
// Put this BEFORE any vendor/autoload or framework files are loaded.
if (! defined('PDO::MYSQL_ATTR_SSL_CA')) {
    // \Pdo\Mysql::ATTR_SSL_CA exists on PHP 8.5+. If class exists we map the old constant.
    if (class_exists(\Pdo\Mysql::class)) {
        define('PDO::MYSQL_ATTR_SSL_CA', \Pdo\Mysql::ATTR_SSL_CA);
    } else {
        // fallback to a harmless integer to avoid "undefined constant" notices if class not present
        define('PDO::MYSQL_ATTR_SSL_CA', 0);
    }
}

define('LARAVEL_START', microtime(true));

// Determine if the application is in maintenance mode...
if (file_exists($maintenance = __DIR__.'/../storage/framework/maintenance.php')) {
    require $maintenance;
}

// Register the Composer autoloader...
require __DIR__.'/../vendor/autoload.php';

// Compatibility for PHP 8.5+ deprecation of PDO::MYSQL_ATTR_SSL_CA
if (! defined('PDO::MYSQL_ATTR_SSL_CA') && class_exists(\Pdo\Mysql::class)) {
    // define the old PDO constant name to the new PHP 8.5 class constant
    define('PDO::MYSQL_ATTR_SSL_CA', \Pdo\Mysql::ATTR_SSL_CA);
}


// Bootstrap Laravel and handle the request...
/** @var Application $app */
$app = require_once __DIR__.'/../bootstrap/app.php';

$app->handleRequest(Request::capture());
