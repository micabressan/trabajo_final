<?php


define("MYSQLUSER", "user");
define("MYSQLPASS", "user");
define("MYSQLDB", "user");

_init();
main();

function main()
{
	$page;
	
    if(! isset($_REQUEST['zte'])) { // not using this test
    
    	if (isset($_GET['q'])){
    		$page = $_GET['q'];
    	}
    	else $page = "";
    }
    else {
    	$page = $_SERVER['QUERY_STRING'];
    }
    
    jump($page);
}

function _init( )
{
    global $CRUD;

    foreach ( array(
            'customerData', 'topTenData', 'contentReport'
            ) as $v )
        $CRUD[$v] = '';

    // connect to the database (persistent)
    try {
        $CRUD['dbh'] = new PDO('mysql:host=localhost;dbname=' . MYSQLDB, MYSQLUSER, MYSQLPASS,
            array( PDO::ATTR_PERSISTENT => true ));
    } catch (PDOException $e) {
        error($e->getMessage());
    }

    // loose "index.php"
    $CRUD["SELF"] = preg_replace('/([\\/\\\])index\\.php$/i', '$1', $CRUD["SELF"]); 
}

function jump( $action )
{
	global $CRUD; // passes dbh to next fn
    switch($action) {
        default:    // default to show main page
            mainPage();
    }
    return;
}

function mainPage()
{
    global $CRUD;
 	require_once "headIndex.php";
    require_once "header.php";
    require_once "contentIndex.php";
    footerIndex();
    exit();
}

?>