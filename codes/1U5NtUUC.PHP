<?php
	
	$ip = $_SERVER['REMOTE_ADDR'];
	
	if($ip == "71.225.160.187")
	{
		echo "YES";
	}
	else
	{
		$message =  $ip;
		echo "NO";
		mail("jdbchamp@comcast.net", "Invalid login attempt for Integrity-Similar!", $message);
	}
	

?>