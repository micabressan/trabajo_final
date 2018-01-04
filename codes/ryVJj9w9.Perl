#!/usr/bin/env perl

use strict;
use warnings;
# use locale;

use Encode;

my $fh;
opendir $fh, '.';
my @files = readdir $fh;

for my $file ( sort @files ) {
	my $l = length(decode('UTF-8', $file));
	print "$file - $l\n";
}