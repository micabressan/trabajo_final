<?php
// HTTP
define('HTTP_SERVER', 'http://'.$_SERVER['SERVER_NAME'].'/');

// HTTPS
define('HTTPS_SERVER', 'https://'.$_SERVER['SERVER_NAME'].'/');

// DIR
define('DIR_APPLICATION', '/home/davofvpt/public_html/catalog/');
define('DIR_SYSTEM', '/home/davofvpt/public_html/system/');
define('DIR_IMAGE', '/home/davofvpt/public_html/image/');
define('DIR_STORAGE', '/home/davofvpt/public_html/storage/');
define('DIR_LANGUAGE', DIR_APPLICATION . 'language/');
define('DIR_TEMPLATE', DIR_APPLICATION . 'view/theme/');
define('DIR_CONFIG', DIR_SYSTEM . 'config/');
define('DIR_CACHE', DIR_STORAGE . 'cache/');
define('DIR_DOWNLOAD', DIR_STORAGE . 'download/');
define('DIR_LOGS', DIR_STORAGE . 'logs/');
define('DIR_MODIFICATION', DIR_STORAGE . 'modification/');
define('DIR_SESSION', DIR_STORAGE . 'session/');
define('DIR_UPLOAD', DIR_STORAGE . 'upload/');

// DB
define('DB_DRIVER', 'mysqli');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', 'davofvpt_ocstar');
define('DB_PASSWORD', '4970251217');
define('DB_DATABASE', 'davofvpt_ocstar');
define('DB_PORT', '3306');
define('DB_PREFIX', 'oc_');

// HEADERS
header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");