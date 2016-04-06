<?php
error_reporting(-1);

function setDBConn($servername = 'localhost', $username = 'root', $password = 'root', $database = 'ecommercedbtest'){
	$DBConn = mysqli_connect($servername, $username, $password, $database);
	
	if(mysqli_connect_errno()){
		raiseIssue('Failed to connect to the database' . mysqli_connect_error());
	}
	return $DBConn;
}

//rest of the php code