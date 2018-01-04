#!/usr/bin/env perl
use strict;
use warnings;
my @test;
my ($min, $max) = (15122421, 15123012);
open my $f, '<', 'test.txt' or die;
while (<$f>) {
  next if /^\s*$/;
  my $i = (split ',')[0];
  push @test, $_ if $min <= $i && $i <= $max;
}
close $f;
print for (@test);