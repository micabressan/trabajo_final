#!/usr/bin/perl
use strict;
use warnings;

sub make_file_chunker {
    my ($fh, $n) = @_;
    my $eof = 0;
    return sub {
       return if $eof;

       my @chunk;
       for (1..$n) { 
          defined( my $line = <$fh> )
             or last;

          chomp($line);
          push @chunk, $line;
       }

       return @chunk;
    };
}

my $iter = make_file_chunker($fh, 4);
while ( my @chunk = $iter->() ) {
   print(join("\n", @chunk) . "\n\n");
}