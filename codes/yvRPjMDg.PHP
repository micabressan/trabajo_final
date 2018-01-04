<?php
$username="username";
$password="password";
$database="your_database";

$field_name=$_POST['name'];
$field2_email=$_POST['email'];
$field3_phonenumber=$_POST['phonenumber'];

mysql_connect(localhost,$username,$password);
@mysql_select_db($database) or die( "Unable to select database");

$query = "INSERT INTO Subscriptions VALUES
($field_name,$field_email,$field_phonenumber)";

mysql_query($query);

mysql_close();
?>