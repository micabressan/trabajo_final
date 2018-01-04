#!/usr/bin/env perl

use Benchmark qw(:all) ;

timethese(10000, {
	'for' => sub {
		my $cnt;
		for (0..900) { $cnt = $cnt + 2; }
	},
	'foreach' => sub {
		my $cnt;
		foreach (0..900) { $cnt = $cnt + 2; }
	},
});