<!doctype html>
<head>
<title>Advance Bans List</title>
 <?php
 
$ftp_ip="193.104.68.46"; // Zamenite svoj ip servera
$ftp_user="srv134530";   // zamenite sa svojim userom od FTPa
$ftp_pass="qOIb_aCuam";  // Zamenite sa svojim passwordom od FTPa
$ftp_log_path="cstrike/addons/amxmodx/data/advanced_bans.txt";
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
}
*/

// get the file
$local = fopen($temporary_file, "w");
$result = ftp_fget($conn_id, $local, $ftp_log_path, FTP_ASCII);

// close the FTP stream
ftp_close($conn_id);


$myFile = $temporary_file;
$fh = fopen($myFile, 'r');
$theData = fread($fh, filesize($myFile));
fclose($fh);


echo "<table border=\"0\" cellpadding=\"3\" style=\"width: 100%;\">\n";
echo "<tr>\n";
echo "<td style=\"background-color: #333333; color: #FFFFFF; font-size: small;\">Player name:</td>\n";
echo "<td style=\"background-color: #333333; color: #FFFFFF; font-size: small;\">Player SteamID:</td>\n";
echo "<td style=\"background-color: #333333; color: #FFFFFF; font-size: small;\">Reason for ban:</td>\n";
echo "<td style=\"background-color: #333333; color: #FFFFFF; font-size: small;\">Ban duration:</td>\n";
echo "<td style=\"background-color: #333333; color: #FFFFFF; font-size: small;\">Time of Unban:</td>\n";
echo "<td style=\"background-color: #333333; color: #FFFFFF; font-size: small;\">Admin name:</td>\n";
echo "</tr>\n";

function steam2friend($steam_id){
    $steam_id=strtolower($steam_id);
    if (substr($steam_id,0,7)=='steam_0') {
        $tmp=explode(':',$steam_id);
        if ((count($tmp)==3) && is_numeric($tmp[1]) && is_numeric($tmp[2])){
            return bcadd((($tmp[2]*2)+$tmp[1]),'76561197960265728');
        }else return false;
        }else{
            return false;
        }
    }


$file1 = $temporary_file;
$lines = file($file1);
$line_num = -1;
foreach($lines as $linenum => $line){
 $line_num++;
}
while($line_num > -1){

$line = $lines[$line_num];

list($steamidraw, $nickdurationtimeraw, $reason, $admin, $adminidraw) = explode('" "', $line);
$steamid = str_replace("\"", "", $steamidraw);
list($nick, $durationraw, $time) = explode('"', $nickdurationtimeraw);

$duration = str_replace(" ", "", $durationraw);
$adminidraw2 = str_replace("\"", "", $adminidraw);
$adminid = trim($adminidraw2);
$friendid = steam2friend($steamid);
$adminfriendid = steam2friend($adminid);

echo "<tr>\n";


echo "<td style=\"background-color: #eee; color: #000000; font-size: small;\">";
echo $nick;
echo "</td>\n";

echo "<td style=\"background-color: #eee; color: #000000; font-size: small;\">";
//echo $steamid;
echo "<a style=\"color: #0000FF;\" href=\"http://steamcommunity.com/profiles/";
echo $friendid;
echo "\" target=\"_blank\">";
echo $steamid;
echo "</a>";
echo "</td>\n";

echo "<td style=\"background-color: #eee; color: #000000; font-size: small;\">";
if($reason == "") {
	echo "No reason specified.";
}
else {
	echo $reason;
}
echo "</td>\n";

echo "<td style=\"background-color: #eee; color: #000000; font-size: small;\">";
if($duration == "0") {
	echo "Permanent";
}
elseif($duration == "1") {
	echo $duration;
	echo " minute";
}
else {
	echo $duration;
	echo " minutes";
}
echo "</td>\n";

echo "<td style=\"background-color: #eee; color: #000000; font-size: small;\">";
if($time == "Permanent Ban") {
	echo "Never";
}
else {
	echo $time;
}
echo "</td>\n";

echo "<td style=\"background-color: #eee; color: #000000; font-size: small;\">";
//echo $admin;
echo "<a style=\"color: #0000FF;\" href=\"http://steamcommunity.com/profiles/";
echo $adminfriendid;
echo "\" target=\"_blank\">";
echo $admin;
echo "</a>";
echo "</td>\n";

echo "</tr>\n";
$line_num--;
}
?>
</table>
</body>
</html>