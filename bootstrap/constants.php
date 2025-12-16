<?php
// bootstrap/constants.php
// Compatibility shim for PHP 8.5 deprecation:
// Map old PDO::MYSQL_ATTR_SSL_CA to the new Pdo\Mysql::ATTR_SSL_CA constant when available.
if (! defined('PDO::MYSQL_ATTR_SSL_CA')) {
    if (class_exists(\Pdo\Mysql::class)) {
        define('PDO::MYSQL_ATTR_SSL_CA', \Pdo\Mysql::ATTR_SSL_CA);
    } else {
        // harmless fallback so index operations won't crash
        define('PDO::MYSQL_ATTR_SSL_CA', 0);
    }
}
