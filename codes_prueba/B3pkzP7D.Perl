#!/usr/bin/perl

use warnings; 
use strict;

my (@filearray, 
	@sortarray,
	$line,
	$first, 
	$last);

chomp(@filearray = <STDIN>); 
@sortarray = sort(@filearray);

foreach $line (@sortarray) { 
	($last, $first) = split(/;/, $line);
	print "$first $last\n";
}