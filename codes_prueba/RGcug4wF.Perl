#!/usr/bin/perl
#_____     __| _/____    _____   _/  |_  ____ ___  ___
#\__  \   / __ |\__  \  /     \  \   __\/    \\  \/  /
#/ __ \_/ /_/ | / __ \|  Y Y  \  |  | |   |  \>    < 
#(____  /\____ |(____  /__|_|  /  |__| |___|  /__/\_ \
#    \/      \/     \/      \/             \/      \/
# Fallaga Team / Giants ps 
# dont change my copyright :) because you will not be great coder madafak :*
#enjoyyy

use HTTP::Request;
use LWP::UserAgent;
use IO::Select;
use HTTP::Response;
use Term::ANSIColor;
print color('reset');
if ($^O =~ /MSWin32/) {system("cls"); }else { system("clear"); }
my $tnx ="
            .                                    .               
         `  y`                                  /: ``            
         `` /d:                     --        `sd` .             
          ```:sd+.              -oooy:      /yd+.``              
         `` `` .ymh-           /syyydo   `ommo`````.             
         `-:``  `oym/         `yyyyNm   `ddy/   `.:`             
         ./:-.`` `.+-         +ys+hMm    y/`  ``.-::             
          .ss+-``` `         . -smdMs    -` .`./oy/              
           :+oo/:. ``       /- `o/yMo    ```.:/oo/.              
            -+os+:..-    `/hs: -/ydM:   .-`-/ooo/`               
               -:-.`-.`  ohh-y +- +M`  --.`---`                  
               :/o+:-.+/ `yd:/`/.-so :s/.-/o+/.                  
                 -.o`  -+:-h/hsd/--:+/`  //..                    
                         ./yo+-/+yo-                             
                            .`y- `                               
  Coded by Adam Tnx          `N:`                                
      fb/adam.ag.750          s.`                                
                               `                                 
    
 \n\n
";

    print color('bold red');

print $tnx;
print color("red"), "Tnx Website Checker -- Run me Now  \n";
print "List : \n";
$list=<STDIN>;

open(tarrget,"<$list") or die "add list \n";
while(<tarrget>){
chomp($_);
$site = $_;
if($site !~ /http:\/\//) { $site = "http://$site/"; };
laweej();
}
system("PAUSE");

sub laweej($site){
$ua = LWP::UserAgent->new(keep_alive => 1);
$ua->agent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31");
$ua->timeout (15);

my $tnx = $ua->get("$site")->content;
if($tnx =~/wp-content\/themes\/|wp-content\/plugins\/|wordpress/) {
    print color('green');
    print "--WORDPRESS-- / $site \n";
    print color('reset');
open(save, '>>wordpress.txt');
    print save "$site\n";
	    close(save);
   

}

elsif($tnx =~/<script type=\"text\/javascript\" src=\"\/media\/system\/js\/mootools.js\"><\/script>|Joomla!|Joomla|joomla/) {
    print color('green');
    print "--JOOMLA--  / $site \n";
    print color('reset');
open(save, '>>joomla.txt');
    print save "$site\n";
    close(save);

    }
elsif($tnx =~/\/modules\/system\/system.menus.css|\/sites\/default\/files\/|<meta name=\"Generator\" content=\"Drupal 7/) {
    print color('green');
    print "--DRUPAL-- / $site \n";
    print color('reset');
open(save, '>>drupal.txt');
    print save "$site\n";
    close(save);
     

    }elsif($tnx =~/\/Prestashop|\/js\/jquery\/plugins\/|<meta name=\"Generator\" content=\"Prestashop/) {
    print ;
    print "--Prestashop-- / $site \n";
    print color('reset');
open(save, '>>Prestashop.txt');
    print save "$site\n";
    close(save);
    

    
}
}