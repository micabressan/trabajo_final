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
        for (0..$num1)
        { 
                print "$name1";
        }
        print "\n";
} 
else 
{
        print "One of your inputs was undefined!\n";
}

=pod

  0 root@lemass:/home/digimer# /tmp/foo 

Input the number:8
Input the name:digimer
num1: [8], name1: [digimer]
The answer is: digimerdigimerdigimerdigimerdigimerdigimerdigimerdigimerdigimer

=cut