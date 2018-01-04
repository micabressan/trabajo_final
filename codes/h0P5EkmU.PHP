<?php 
	define('ISITSAFETORUN', TRUE); // not sure what this constant is for
	require "mydatabase.php"; //connect to this host
	$dbhandle = mysqli_connect( $hostname, $username, $password ) or die( "Unable to connect to MySQL");
	$drop = "DROP TABLE IF EXISTS sa23882";
	if (mysqli_query($dbhandle, $drop) === true) {
		echo 'Dropped';
	}
?>