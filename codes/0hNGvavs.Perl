#!/usr/bin/env perl

use 5.010;
use strict;
use warnings;
use DDP;

# skip the first line (header)
<STDIN>;

my %coeff;

while (<STDIN>) {
  chomp;
  my ($g1, $g2, $coeff) = split /\s+/;
  $coeff{$coeff}{$g1}++;
  $coeff{$coeff}{$g2}++;
}

while (my ($coeff, $k) = each %coeff) {
  my $count_total = 0;
  my $uniq_cnt = scalar keys %$k;
  $count_total += $k->{$_} for keys %$k;
  printf "%.2f\t%.2f\t%d\n", $coeff, $count_total / $uniq_cnt, $count_total;
}