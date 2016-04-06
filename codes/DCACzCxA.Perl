#!/usr/bin/perl
use strict;
use warnings;

my $firstnames = 'test.txt';
open(my $datafile, '<', $firstnames) or die "could not open the file $!";
#open(my $newfile, '>', 'gender.txt');

while(my $row = <$datafile>){
	print "test\n";
	chomp $row;
	print "$row\n";
}

close $datafile;
#close $newfile;