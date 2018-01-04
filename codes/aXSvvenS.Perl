#!/usr/bin/perl

use Socket;

my $host = shift;
my $port = shift;

my $rc;
socket(SOCKET, PF_INET,SOCK_STREAM,(getprotobyname('tcp'))[2]);
do {
        $rc = connect(SOCKET, pack_sockaddr_in($port, inet_aton($host)));
        sleep(1) unless ($rc);
} while (!$rc);
close SOCKET;