#!/usr/bin/perl
use strict;
use warnings;

use List::MoreUtils qw( apply );

sub groups_of {
   my $n = shift;
   return
      map { @_ >= $n ? [ splice(@_, 0, $n) ] : [ @_ ] }
         0 .. ($#_ + $n)/$n;
}

print
   join "\n",
      map { join "", map { "$_\n" } @$_ }
         groups_of 4,
            apply { chomp }
               <$fh>;