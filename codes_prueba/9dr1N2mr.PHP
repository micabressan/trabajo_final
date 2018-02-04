<?php
session_start();
include_once "conn.php";
$txuser=$_REQUEST['txuser'];
$txpass=$_REQUEST['txpass'];

if (trim($txuser)=="") {
	//echo "DATA USER BELUM DIISI";
	echo "<script>alert('Data User Belum Di Isi..!!');
    javascript:history.go(-1)</script>";
	include "index.php"; exit;
}
elseif (trim($txpass)=="") {
	//echo "DATA PASSWORD BELUM DIISI";
	echo "<script>alert('Data Password Belum Di Isi..!!');
    javascript:history.go(-1)</script>";
	include "index.php"; exit;
}

$query = mysql_query("select * from akun where user ='$txuser' and pwd='$txpass'");
while($row = mysql_fetch_array($query)){
$u=$row["user"];
$l=$row["level"];
$r=$row["nomorrw"];
$t=$row["nomorrt"];
}
//$ada_cek = mysql_num_rows($query);


if ($u==$txuser) 
{
    $SES_USER=$txuser;
	$SES_LEVEL=$l;
	$SES_RW=$r;
	$SES_RT=$t;
	//session_register("SES_USER");
	if(!isset($_SESSION['namauser'])) {
	$_SESSION['namauser'] = $SES_USER;
	$_SESSION['leveluser'] = $SES_LEVEL;
	$_SESSION['rw'] = $SES_RW;
	$_SESSION['rt'] = $SES_RT;
	}
	if ($l=="Super Admin")
	{
	header ("location: menu.php");
	exit;
	}
	if ($l=="RW")
	{
	header ("location: menu.php");
	exit;
	}
	if ($l=="RT")
	{
	header ("location: menu.php");
	exit;
	}
	
	
}
else 
{
    echo "<script>alert('Data User dan Password Tidak Cocok..!! (Account Belum Di Validasi)');
    javascript:history.go(-1)</script>";
    include "index.php"; 
    exit;
}
?>