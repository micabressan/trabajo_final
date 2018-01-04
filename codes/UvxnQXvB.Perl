#!/usr/bin/perl
use strict;
use warnings;
$|=1; # make output unbuffered
print "GOT: $_" while (<STDIN>);