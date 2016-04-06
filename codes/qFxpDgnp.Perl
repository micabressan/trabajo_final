#!/usr/bin/perl

use strict;
use warnings;

print "\nInput the number:";
chomp ( my $num1 = <STDIN> );
print "Input the name:";
chomp ( my $name1 = <STDIN> );

print "num1: [$num1], name1: [$name1]\n";

if ((defined $num1) && (defined $name1))
{       
        print "The answer is: ";
        print "$num1 x $name1\n";
} 
else 
{
        print "One of your inputs was undefined!\n";
}