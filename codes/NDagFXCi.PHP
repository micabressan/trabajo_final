<?php
$spamm = 'http://www.stopforumspam.com/api?ip='.$_SERVER['REMOTE_ADDR'].'&f=json';
$uri = file_get_contents($spamm);
$obj = json_decode($uri);

if ($obj->ip->frequency > 0)
{
	header('Location: http://www.google.fr');

}
?>