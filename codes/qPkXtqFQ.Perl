#!/usr/bin/perl

use strict;
use warnings;

my $timeout = shift @ARGV;                                                   
$timeout *= 60;
my $pid = fork();
die($!) if not defined $pid;
if($pid == 0) {
   exec(@ARGV);
   exit $?;
}
else {
   $SIG{ALRM} = sub { die("Sterben... du sollst!"); };
   alarm($timeout);
   waitpid($pid, 0);
   kill -9, $pid;
}