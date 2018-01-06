#!/usr/bin/perl
use strict;

my $number;
my @array = (1..100);

foreach my $number (@array) 
{

    if ( ( $number % 3 eq 0 ) && ( $number %5 eq 0 ) )
    {
        print 'FizzBuzz', "\n";
    }
    elsif ( $number % 3 eq 0 )
    {
        print 'Fizz', "\n";
    }
    elsif ( $number % 5 eq 0 )
    {
        print 'Buzz', "\n";
    }
    else 
    {
        print $number, "\n";
    }
}