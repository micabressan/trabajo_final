<?php 
require("db/connect.php");
$bericht = $_POST['message'];

if(isset($bericht)){
	echo "ok";
	$mysqli->query("INSERT INTO messages VALUES(NULL,$bericht,'time')");
}
$mysqli->close();
?>