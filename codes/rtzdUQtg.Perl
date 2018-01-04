#!/usr/bin/perl 
# *** Brazilians Hackers Team ***
# Skype: BrazilObscure

use HTTP::Request;
use LWP::Simple;
use LWP::UserAgent;
#use Win32::Console::ANSI; #caso estiver no windows desmarque #
use IO::Socket::INET;
use Term::ANSIColor;


if ($^O =~ /MSWin32/) {system("cls"); system("color A");
}else { system("clear"); }
print "\n\n";
print"          ";
print colored("      --=[ EXPLOIT SCAN 2018 ]=--      ",'on_red');
print"\n";
print"         ";
print colored("--=[ *** Brazilians Hackers Team *** ]=--",'on_yellow');
print"\n\n";

print color("bold yellow"), "\n";
print color 'reset';
print color("bold yellow"),"[1] Scan Wordpress";
print color("bold yellow"), "\n";
print color 'reset';
print color("bold yellow"),"[2] Scan Joomla";
print color("bold yellow"), "\n";
print color 'reset';
print color("bold yellow"),"[3] Scan Shells ";
print color("bold yellow"), "\n";
print color 'reset';
print color("bold yellow"),"[4] Scan Jdownloads Joomla";
print color("bold yellow"), "\n";
print color 'reset';
print color("bold yellow"),"[5] Scan Jce Joomla";
print color("bold yellow"), "\n";
print color 'reset';
print color("bold yellow"),"[6] Bing Reverse ";
print color("bold yellow"), "\n";
print color 'reset';
print color("bold yellow"),"[7] Lista De Sites Por IP ";
print color("bold yellow"), "\n";
print color 'reset';
print color("bold yellow"),"[8] Sair \n";
print color("bold yellow"), "\n";
print color 'reset';
print color("bold Green"),"Escolha A Opcao --> ";
$name=<STDIN>;
chomp $name;




if ($name=~ "1")
{
print color("bold red")," Lista De Sites --> ";
$opn=<STDIN>;
chomp $opn;

$a7a= "/xmlrpc.php";
chomp $a7a;


$mohmed="XML-RPC";
chomp($mohmed);


$vulnn=" Wordpress Encontrado";
chomp($vulnn);



}
else {

if ($name=~ "2")
{
print color("bold red")," Lista De Sites --> ";
$opn=<STDIN>;
chomp $opn;

$a7a= "/components/com_content/metadata.xml";
chomp $a7a;


$mohmed="</metadata>";
chomp($mohmed);


$vulnn=" Joomla Encontrado";
chomp($vulnn);



}
else {

if ($name=~ "3")
{
print color("bold red")," Lista De Sites --> ";
$opn=<STDIN>;
chomp $opn;

$a7a= "";
chomp $a7a;


$mohmed="WSO";
chomp($mohmed);


$vulnn=" Shell Encontrada";
chomp($vulnn);


}
else {
if ($name=~ "4")
{
print color("bold red")," Lista De Sites --> ";
$opn=<STDIN>;
chomp $opn;

$a7a= "/index.php?option=com_jdownloads&Itemid=0&view=upload";
chomp $a7a;


$mohmed="mceToggleEditor";
chomp($mohmed);


$vulnn=" Jdownload Encontrado";
chomp($vulnn);


}
else {


if ($name=~ "5")
{
print color("bold red")," Lista De Sites --> ";
$opn=<STDIN>;
chomp $opn;

$a7a= "/index.php?option=com_jce&task=plugin&plugin=imgmanager&file=imgmanager&method=form";
chomp $a7a;


$mohmed="No function call specified!";
chomp($mohmed);


$vulnn=" Jce Encontrado";
chomp($vulnn);





}
else {

if ($name=~ "6")
{



if($^O =~ /Win/){
 
   system("cls");
   system("color a");
   system("title Get Sites by : ip");
 
}else{
 
   system("clear");
}
print color 'reset';
print color("bold Red"), "\nDigite IP : ";
my $host = <>;
chomp($host);
my $ua = LWP::UserAgent->new(agent => 'Mozilla/5.0 (Windows; U; Windows NT 5.1; fr; rv:1.9.1) Gecko/20090624 Firefox/3.5');
my $zz = $ua->post('http://domains.yougetsignal.com/domains.php',
{
        remoteAddress => $host,
}
);
 
my $resulta = $zz->content;
while ($resulta =~ m/\[([^\]]*)\]/g)
{
        $zeb = $1;
        $zeb =~ m/\"(.*?)\", \"?\"/g;
open(a, ">>$host.txt");
print a "http://$1/\n";
close(a);
}
print "\nResultado $host.txt";
exit



}
else {

if ($name=~ "7")
{
print color("bold red")," Lista De Sites --> ";
$opn=<STDIN>;
chomp $opn;

open(tarrget,"$opn") or die "$!";
while(<tarrget>){
chomp($_);
$target = $_;
close(FILE);
 

foreach $hostname ($target) {
   chomp($hostname);
   if($hostname) {
      $ip = gethostbyname($hostname);
      if($ip) {
        
		print "\n" , $hostname."==>".inet_ntoa($ip);
		
		open (TEXT, '>>list Ip.txt');
print TEXT "\n" , "".inet_ntoa($ip);
undef $ip;
close (TEXT);
        
      } else {

        printf "%sn\n" , $hostname.":0.0.0.0";
        undef $ip;
      }
   }
}
}

exit
}
else {
if ($name=~ "8")
{

exit



}
else {

print color("bold red")," {*} Goodbye {*} ";
exit
}
}
}
}
}
}
}
}



















































open(tarrget,"$opn") or die "$!";
while(<tarrget>){
chomp($_);
$target = $_;
if($target !~ /http:\/\//)
{
$target = "$target";
}

$website = $target.$a7a;
 $vuln2 =$vulnn;

$req=HTTP::Request->new(GET=>$website);
$ua=LWP::UserAgent->new();
$ua->timeout(30);
$response=$ua->request($req);
if($response->content=~ $mohmed )

 {
 print color 'reset';
 $Messageee  ="$vulnn";
print color("bold Green"), "";
open (TEXT, '>>Encontrado.txt');
print TEXT "$target$vuln2\n";
close (TEXT);
}
else {

print color 'reset';
$Messageee = " Falhou ";
print color("bold red"), "";

}
print "[+] $target => $Messageee\n";
}