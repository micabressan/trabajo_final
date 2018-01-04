#!/usr/bin/perl -w
use strict;
use IO::Socket;

sub Wait {
	wait; # wait needed to keep <defunct> pids from building up
}

$SIG{CHLD} = \&Wait;

my $server = IO::Socket::INET->new(
	LocalPort 	=> 2234,	# set port
	Type 		=> SOCK_STREAM,
	Reuse 		=> 1,
	Listen 		=> 10) or die "$@\n";
my $client ;

while($client = $server->accept()) {
	select $client;
	print $client "HTTP/1.0 200 OK\r\n";
	print $client "Content-type: text/html\r\n\r\n";
	print $client '<title>Xai Syndicate</title><center><H1>Hacked By Con7ext</H1><BR><H2>Xai Syndicate</H2><embed src="https://www.youtube.com/v/8OVj9TbWeYo&autoplay=1&playlist=8OVj9TbWeYo" wmode="transparent" type="application/x-shockwave-flash" height="0" width="0"></embed>'; # set your html content
}
continue {
	close($client); #kills hangs
	kill CHLD => -$$;
}