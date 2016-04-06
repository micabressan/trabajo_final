#!/usr/bin/perl

use strict;
use warnings;

print "\nInput the number:";
chomp ( my $num1 = <STDIN> );
print "Input the name:";
chomp ( my $name1 = <STDIN> );

$num1  = "" if not defined $num1;
$name1 = "" if not defined $name1;

print "num1: [$num1], name1: [$name1]\n";

if (($num1 !~ /\D/) && ($name1 ne ""))
{       
        print "The answer is: ";
        print " $name1" x $num1;
        print "\n";
} 
else 
{
        print "Your input appears to be malformed. The number must be a digit only and the name can not be blank.\n";
}

=pod
  0 root@lemass:/home/digimer# /tmp/foo 

Input the number:4
Input the name:hello
num1: [4], name1: [hello]
The answer is:  hello hello hello hello
=cut