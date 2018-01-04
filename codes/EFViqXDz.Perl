#!/usr/bin/perl -w
use strict;
use IO::Socket;

sub Wait {
	wait; # wait needed to keep <defunct> pids from building up
}

$SIG{CHLD} = \&Wait;

my $server = IO::Socket::INET->new(
	LocalPort 	=> 1337,	# set port
	Type 		=> SOCK_STREAM,
	Reuse 		=> 1,
	Listen 		=> 10) or die "$@\n";
my $client ;

while($client = $server->accept()) {
	select $client;
	print $client "HTTP/1.0 200 OK\r\n";
	print $client "Content-type: text/html\r\n\r\n";
	print $client '<CENTER><H1>Hacked By LolzSec</H1></CENTER><BR><CENTER><H2>Indonesian Freedom Security</H2></CENTER><embed src="https://www.youtube.com/v/Odum0r9gxA8&autoplay=1&playlist=Odum0r9gxA8" wmode="transparent" type="application/x-shockwave-flash" height="0" width="0"></embed>'; # set your html content
}
continue {
	close($client); #kills hangs
	kill CHLD => -$$;
}