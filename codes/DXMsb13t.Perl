#!/usr/bin/perl

use strict;
use warnings;

my %words;
my @words_list;
my %poop_reachable;

while (<>) {
    chomp $_;
    next if length($_) != 4;

    $_ = lc $_;

    push @words_list, $_;
    for my $i (0..3) {
        my $w = $_;
        substr $w, $i, 1, '.';
        push @{ $words{$w} }, $_;
    }
}

$poop_reachable{poop} = 1;
my %done;

my @q = qw(.oop p.op po.p poo.);

while (my $word = shift @q) {
    next if $done{$word};
    $done{$word} = 1;
    for my $next_word (@{ $words{$word} }) {
        $poop_reachable{$next_word} = 1;
        for my $i (0..3) {
            my $w = $next_word;
            substr $w, $i, 1, '.';
            next if $done{$w};
            push @q, $w;
        }
    }
}

for my $w (@words_list) {
    print "$w\n" if !$poop_reachable{$w};
}