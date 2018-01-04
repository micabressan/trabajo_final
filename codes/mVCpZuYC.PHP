<html>
<head>
<title>
./Zone-H Mass Notifier
</title>
<style>
body
{
background-image: url("http://www.hddesktopbackgrounds.us/backgrounds-images/1920x1080/qc9y7-backgrounds-374726006-1920x1080.jpg");


}
</style>
</head>
<body>
<!-- http://www.zone-h.org/archive/notifier=KkK1337 -->
<?php
echo "<center><div style='font-family:Comic Sans MS;color:lime;'><b>Coded by KkK1337</b></div></center>\n";
extract($_POST);
if(isset($valider))
{
echo "## Mass posting\n";
$fp=fopen("resource.txt","w"); 
fwrite($fp,$sites."\n");
fclose($fp);
$fileread=file("resource.txt");
for($i=0;$i<count($fileread);$i++)
{
//get the line of textarea
$ln[$i]=strtok($fileread[$i],"\n");
$init=curl_init("http://zone-h.org/notify/single");
$postdatas="defacer=".$notifiername."&domain1=".$ln[$i]."&hackmode=1&reason=1";
curl_setopt($init, CURLOPT_POST, true);
curl_setopt($init,CURLOPT_POSTFIELDS,$postdatas);
curl_setopt($init,CURLOPT_RETURNTRANSFER,true);
$exec=curl_exec($init);
curl_close($init);
if(preg_match("#ERROR#",$exec)==1)
{
echo $ln[$i]." ####### NO, error found in the response...\n";

}
else
{

echo $ln[$i]." ####### YES, no errors found in the response...\n";

}
}

}
else

{
echo "<center><form method='post' action=''><br />
<input type='text' name='notifiername' placeholder='Your defacer name' /><br />
<textarea name='sites' cols=35 rows=10></textarea><br />
<input type='submit' name='valider' /><br />
</form>
</center>
";
}





 

?>
</body>
</html>