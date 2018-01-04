#!/usr/bin/env perl

use strict;
use warnings;

use Encode;

for my $i ("\x{00C0}", "\x{0041}\x{0300}") {
	for my $j ('a', 'b') {
		open my $fh, '>', encode('UTF-8', "$i$j");
	}
}