<?php
session_start();
?>
<html>
<head>
<meta charset="utf-8">
<title>BloodSeeker</title>
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">

<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="css/animate.css" rel="stylesheet" />
<link href="css/style.css" rel="stylesheet">
<link href="color/default.css" rel="stylesheet">
<link href="css/login.php" rel="stylesheet">

</head>
	
	<section id="intro1" class="intro1">
		<div class="slogan">
			<form action="check.php" method="post">
				<div class="login-card">
					<h1>Login</h1><br>
				  <form>
					<input type="text" name="username"id="url" placeholder="Username" >
					<input type="password" name="password"id="url" placeholder="Password" >
					<input type="submit" name="login" class="login login-submit" value="Login" onclick="submit">
				  </form>

				  <div class="login-help">
					<a href="register.html">Register</a> • <a href="forgot.html">Forgot Password</a>
				  </div>
				</div>
		
	</section>
	

	
</body>
</html>