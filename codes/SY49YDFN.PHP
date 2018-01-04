<?php 
$conn  = mysqli_connect('localhost' , 'root' , '542588' , 'abdelmadjid') ; 
$email = $_POST['email'] ; 
$password = $_POST['password'] ;
if (isset($_POST['ok'])) {
	$sql = "INSERT INTO users(email , password) VALUES ('$email', '$password')" ; 
	$result = mysqli_query($conn , $sql) ; 
	if ($result == TRUE) {
		echo "data inserted";
	}else{
		echo "data not inserted";
	}
}
 ?>
<!DOCTYPE html>
<html>
<head>
	<title>Registration page</title>
</head>
<body>
<form method="POST" action="">
	
	email <input type="text" name="email">
	password <input type="password" name="password">
	<input type="submit" name="ok" value="register">
</form>
</body>
</html>