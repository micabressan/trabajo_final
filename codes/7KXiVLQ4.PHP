<?php
session_start();
$_SESSION["password"];
$servername = "localhost";
        $username = "root";
        $password = "";
        $database ="login";

        // Create connection
        $conn = mysqli_connect($servername, $username, $password, $database);
        // Check connection
        if (!$conn) {
            die("Connection failed: " . mysqli_connect_error());
        }
$_SESSION["username"]=$_POST["username"];
$password=$_POST["password"];
$user=$_SESSION["username"];
$sql = "Select password from `users` where username='$user'" ;
        $result = mysqli_query($conn,$sql);
        if (!$result) {
            printf("Error: %s\n", mysqli_error($conn));
            exit();
        }
        else
        $row = mysqli_fetch_array($result);
      // If result matched $myusername and $mypassword, table row must be 1 row
		echo $row[0];
      if(($password==$row[0])/*===true*/) {
          header ("Location: index1.php");
          exit();
      }
else{
	header ("Location: login.php");
}
?>