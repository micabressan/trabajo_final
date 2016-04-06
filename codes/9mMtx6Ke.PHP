<?php

	function my_log($mysqli, $text)
	{
		$mysqli->select_db("bms");
		$query_value = "INSERT INTO `log` ( `id` , `user_id` , `time` , `tekst` ) VALUES ('', '".$_SESSION['user_id']."', '".time()."', '".$text."');";
		$mysqli->query($query_value);
	}

?>