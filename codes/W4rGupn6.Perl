#!/usr/bin/perl

use strict;
use warnings;

my $sum = 0.0;
my $sq_sum = 0.0;
my $val = 0.0;
my $n = 0;
while (1)
{
        $val = <>;
        chomp($val);
        if (lc($val) eq "q")
        {
                exit(0);
        }
        $sum += $val;
        $sq_sum += $val * $val;
        $n++;
        my $ex = $sum / $n;
        my $ex2 = $sq_sum / $n;
        my $sd = sqrt($ex2 - ($ex * $ex));
        print "Current SD: " . $sd . "\n";
}