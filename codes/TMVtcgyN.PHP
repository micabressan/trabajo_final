<html>
<head>
	<!-- General meta information -->
	<title>Login Form for 16th day</title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta name="robots" content="index, follow" />
	<meta charset="utf-8" />
		
	<!-- Load Javascript -->
	<script type="text/javascript" src="./js/jquery.js"></script>
	<script type="text/javascript" src="./js/jquery.query-2.1.7.js"></script>
	<script type="text/javascript" src="./js/rainbows.js"></script>

	<!-- Load stylesheets -->
	<link type="text/css" rel="stylesheet" href="css/style.css" media="screen" />
	
<script>


	$(document).ready(function(){
 
	$("#submit1").hover(
	function() {
	$(this).animate({"opacity": "0"}, "slow");
	},
	function() {
	$(this).animate({"opacity": "1"}, "slow");
	});
 	});


</script>
	
</head>
<body>
<form action="home.php" method="POST">
	<div id="err_message">
		<?php
			if (isset($_GET["errid"])){
				if ($_GET["errid"]==1){
					echo "(*) Tai khoan khong chinh xac";
				}
			}
		?>
	</div>
	<div id="wrapper">
		<div id="wrappertop"></div>

		<div id="wrappermiddle">

			<h2>Login</h2>

			<div id="username_input">

				<div id="username_inputleft"></div>

				<div id="username_inputmiddle">
					<input type="text" name="username" id="url" value="E-mail address" onclick="this.value = ''">
					<img id="url_user" src="./images/mailicon.png" alt="">
				</div>

				<div id="username_inputright"></div>

			</div>

			<div id="password_input">

				<div id="password_inputleft"></div>

				<div id="password_inputmiddle">
					<input type="password" name="password" id="url" value="Password" onclick="this.value = ''">
					<img id="url_password" src="./images/passicon.png" alt="">
				</div>

				<div id="password_inputright"></div>

			</div>

			<div id="submit">
				
				<input type="image" src="./images/submit_hover.png" id="submit1" value="Sign In">
				<input type="image" src="./images/submit.png" id="submit2" value="Sign In">
				
			</div>


			<div id="links_left">

			<a href="fit.hanu.vn">Forgot your Password?</a>

			</div>

			<div id="links_right"><a href="#">Not a Member Yet?</a></div>

		</div>

		<div id="wrapperbottom"></div>
		
		<div id="powered">
		<p>Powered by HITA</a></p>
		</div>
	</div>
</form>
</body>
</html>