#!/usr/bin/perl

use File::Find;
use strict;
my $country;

sub getCountry{
        my $name = shift;
        chomp($name);
        my $dir ='/home/alok/countries/';
        find(\&txtsearch, $dir);
        sub txtsearch {
           if(-f $_) {
               open my $file, "<", $_ or do {
                   warn qq(Unable to open "$File::Find::name": $!); #c
+hecks permissions
                   return;
               };

               while(<$file>) {
                   if (/\Q$name\E/) {
                       my $cname = "$File::Find::name"; #prints locati
+on of file
                       my @chunks = split '/', $cname;
                       $country = $chunks[4];
                       print "$country\n";
                       return ; #stops searching once found
                   }
              }
           }
        }
}

getCountry("NY");
getCountry("London");