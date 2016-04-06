//contact: dragan.rakita@live.com
<!doctype html>
<head>
<title>mdb ban lista</title>
<style type="text/css">
body {
	background-color: #e1e1e1;
	width:80%;
	margin:0px auto;
}
</style><!-- your html stuff -->
</head>
<body>
<?php
//VARS
$ftp_ip=""; //Ovde stavite svoj ip od servera(bez porta) Pr: 193.104.68.46
$ftp_user=""; //Ovde stavite ftp_user koji mozete naci na gpanelu
$ftp_pass=""; //password odd ftp-a koji isto mozete naci na gpanelu
$ftp_log_path="cstrike/addons/amxmodx/configs/mdbBans/bans.cfg";
$temporary_file="bans.tmp";
//END VARS


$conn_id = ftp_connect($ftp_ip);
$login_result = ftp_login($conn_id, $ftp_user, $ftp_pass);

/*
if ((!$conn_id) || (!$login_result)) {
echo "<font color=\"#FF0000\">Could not retrieve ban list.</font>";
exit;
} else {
echo "<font color=\"#00FF00\">Retrieved ban list successfully.</font>\n";
echo "<br />\n";
echo "<br />\n";
}*/

// get the file
$local = fopen($temporary_file, "w");
$result = ftp_fget($conn_id, $local, $ftp_log_path, FTP_ASCII);

// close the FTP stream
ftp_close($conn_id);


$myFile = $temporary_file;
$fh = fopen($myFile, 'r');
$theData = fread($fh, filesize($myFile));
fclose($fh);

echo '<h1 style="color:#fff;margin:0px;padding:0px;font-size:50px;">mdb Ban lista</h1>';
echo "<table border=\"0\" cellpadding=\"3\" style=\"width: 100%;\">\n";
echo "<tr>\n";
echo "<td style=\"background-color: #333333; color: #FFFFFF; font-size: small;\">Igrac:</td>\n";
echo "<td style=\"background-color: #333333; color: #FFFFFF; font-size: small;\">Steam,Valve ili IP:</td>\n";
echo "<td style=\"background-color: #333333; color: #FFFFFF; font-size: small;\">mdbID ili cenzura:</td>\n";
echo "</tr>\n";


$file1 = $temporary_file;
$lines = file($file1);
$line_num = -1;
foreach($lines as $linenum => $line){
 $line_num++;
}
while($line_num > -1){
$line = $lines[$line_num];
$lista = explode(' -- ', $line);

$mdbCensure = '';
$valveSteamIp = '';
if(strpos($lista[0], ' 0.0 ') != FALSE){
   $valveSteamIp = str_replace('banid 0.0 ',' ',$lista[0]);
   $valveSteamIp = str_replace('addip 0.0 ',' ',$valveSteamIp);
   $lista[0] = 'Ban Ip-ID';
}
elseif(strpos($lista[0], ' ---- ') != FALSE){
   $mdbCensure = substr($lista[0],0,15);
   $lista[0] = 'Ban mdb';
}
else{
$i=2;
while($i && isset($lista[$i])){
if( preg_match('/m\d*-\d*-\d*/', $lista[$i])){
   $mdbCensure = $lista[$i];
} 
else if ( preg_match('/^STEAM_0:|^VALVE_0:/',$lista[$i]) || preg_match('/\d*.\d*.\d*/',$lista[$i])){
   $valveSteamIp = $lista[$i];
}

if ( strstr($lista[$i],'(cenzura)')){
   $mdbCensure= $lista[$i];
}
$i--;
}
}
echo "<tr>\n";
echo "<td style=\"background-color: #eee; color: #000000; font-size: small;\">";
echo $lista[0];
echo "</td>\n";

echo "<td style=\"background-color: #eee; color: #000000; font-size: small;\">";
//echo $steamid;
echo $valveSteamIp;
echo "</td>\n";

echo "<td style=\"background-color: #eee; color: #000000; font-size: small;\">";
echo $mdbCensure;
echo "</td>\n";

echo "</tr>\n";

$line_num--;
}
echo "</table>\n";
?>
<p style="text-align:center;font-size:12px;color:#a00;">Code by Dragan Rakita | email/msn: dragan.rakita@live.com </p>
</body>
</html>
<!-- rest of ur html here -->