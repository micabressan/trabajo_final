#! /usr/bin/perl
use strict;
use warnings;
binmode STDOUT, ':utf8';
my ($input, @sorted, $letter_u);

open( my $in, '<:utf8', $ARGV[0]) or die "cannot open '$ARGV[0]': $!";
my @lst=<$in>;
close ($in);

$letter_u = "\x{0578}\x{0582}";
foreach (@lst) {
s/$letter_u/♢/
}

sub trans {

$input = shift;
$input =~ tr[\n\x{0561}\x{0562}\x{0563}\x{0564}\x{0565}\x{0566}\x{0567}\x{0568}\x{0569}\x{056A}\x{056B}\x{056C}\x{056D}\x{056E}
\x{056F}\x{0570}\x{0571}\x{0572}\x{0573}\x{0574}\x{0575}\x{0576}\x{0577}\x{0578}][\x0F-\x27]; #letters [ayb] - [o] mapped
$input =~ tr[\x{0579}\x{057A}\x{057B}\x{057C}\x{057D}\x{057E}\x{057F}\x{0580}\x{0581}][\x28-\x31]; #next letters, up to [tiwn]
$input =~ tr[♢\x{0583}\x{0584}\x{0587}\x{0585}\x{0586}][\x32-\x37]; #last letters mapped

return $input;
}

@sorted = sort {
trans( $a ) cmp trans( $b )
}
@lst;

foreach (@sorted) {
s/♢/$letter_u/
}
print @sorted;