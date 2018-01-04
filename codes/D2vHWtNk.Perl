#!/usr/bin/env perl
use Benchmark qw(:all) ;
timethese($count, {
	'for' => sub {
		my $cnt;
		for (0..90000000) { $cnt = $cnt + 2; }
	},
	'foreach' => sub {
		my $cnt;
		foreach (0..90000000) { $cnt = $cnt + 2; }
	},
});