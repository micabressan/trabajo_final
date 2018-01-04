#!/usr/bin/perl

print "What is the length of the cube?";
chomp ($len = <>);
print "What is the width of the cube?";
chomp ($wid = <>);
print "What is the height of the cube?";
chomp ($height = <>);

$vol = $len*$wid*$height;

print "The volume is $vol \n";

open (MYFILE, '>>C:\Perl Test Scripts\data.txt');
print (MYFILE $vol);
close (MYFILE);