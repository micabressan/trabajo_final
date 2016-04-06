#!/usr/bin/perl -w
my $url='https://www.google.de';
use LWP::Simple;
use strict;
my $content= get $url;
open (DATEI,"+>testdatei.txt");
print DATEI $content;
$content=~ s/\<.*\>//g;
my %name1=($content);
my $anzahl=%name1;
print $anzahl;
close (DATEI);