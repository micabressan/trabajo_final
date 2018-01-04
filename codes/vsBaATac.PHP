<?php
error_reporting(0);
session_start();

if (empty($_SESSION['username']) AND empty($_SESSION['password'])){
	echo 'INI HALAMAN DEPAN, ANDA BELUM <a href="?modul=login">Login</a>';
}else{
	echo 'ANDA SUDAH LOGIN DENGAN username: <b>'.$_SESSION['username'].'</b> password: <b>'.$_SESSION['password'].'</b> <a href="?modul=logout">Logout</a>';
}
 
switch ($_GET['modul']){
	case "login":
		 echo '
		 <form name="login" action="ceksession.php" method="POST">
		 Username :
		 <input type="text" name="username">
		 Password :
		 <input type="text" name="password" >
		 <button type="submit">Login</button>
		 </form>';
	break;
 
	case 'logout':
		session_destroy();
		echo "<center>Anda telah sukses keluar sistem </center>";
		echo "<meta http-equiv='refresh' content='1;url=session.php'>";
 	break;
 
	default:
 		echo 'HALAMAN DEPAN <a href="?modul=login">Login</a>';
	break;
}
 
?>