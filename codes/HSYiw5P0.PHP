<?php
$connection = mysql_connect('localhost', 'admin', '') OR die('mysql_connect error:' . mysql_error());

if(isset($submit)) {
	$database = mysql_select_db('viip', $connection) OR die('mysql_select_db error:' . mysql_error()); 
	$insert = mysql_query("INSERT INTO users (usernames, passwords) VALUES ('$_POST[username]', '$_POST[password]')") OR die('mysql_query:' . mysql_error());
	$register_true = TRUE;
} else {
	echo "wtf";
}

mysql_close($connection);
?>


<form id="register" name="register" action="/test/register.php" method="post">
	<h2>Register</h2>
	
	<?php if(isset($register_true)) { echo "<p>Registration Successful</p>"; } ?>
	
	<p><label>Username<br /><input type="text" name="username" /></label></p>
	<p><label>Password<br /><input type="text" name="password" /></label></p>
	<p><input type="submit" name="submit" value="Create Account" /></p>
</form>