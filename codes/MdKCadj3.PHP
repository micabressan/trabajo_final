<?php
session_start();
require"db_connect.php";
//get the page id
if(isset($_GET['id'])is_numeric($_GET('id')))(
$id = $_GET('id');
}else{
die("Error!");
}
//Check to see if the id is a valid id
$idCheck = $db->query("SELECT * FROM forum_tabl WHERE forum_id = '$id'");
if($idCheck->num_rows !==1){
die("error");
}


?>