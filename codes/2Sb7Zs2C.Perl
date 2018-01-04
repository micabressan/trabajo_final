#!/usr/bin/env perl
# project6_Laura.Willson34.pl     Extracting Data from PDB Files
#
# Written By:                     Laura Willson
# Date Created:                   November 27th, 2017
# Usage:                          project6_Laura.Willson34.pl <small.pdb>
# Description:                    A user inputs certain commands into command line to receive data from small.pdb file.
#
#
#

use warnings;     # turn on warnings
use strict;  # behave!


open(my $FILE, $ARGV[0]);
open($FILE, "<", "small.pdb")
or die "Can't open < small.pdb: $!"; 

my @lines = ();
while (my $line = <$FILE>) {
    chomp $line;
    push @lines, $line;
}

close($FILE);

my $active = 1;
while ($active) {
        print "Hello! To access different commands, you must type one of the following:\n";            
        print "type 'atomfreq' to receive the frequency of atoms\n";
        print "or type 'resfreq' to receive the frequency of residues\n";
        print "or type 'reslength' with a residue name, a chain-id, and a residue sequence number to calculate the distance between every pair of residues and to display the maximum distance of those distances.\n";
        print "or type 'quit' to quit the program.\n";
        print "Command: ";
        my $input = <STDIN>;
        chomp $input;
        if ( $input eq 'atomfreq' ) {
    	        my %elements;
                foreach my $line (@lines) {
                        my @fields;
                        @fields = split(/\s+/, $line);

                        if($fields[0] eq 'ATOM') {
                              my $atom_name = $fields[11];
                              if ($elements{$atom_name}) {
                                  $elements{$atom_name} += 1;
                              } else {
                                  $elements{$atom_name} = 1;
                              }
                        }
                }
                foreach my $name (sort keys %elements) {
                        print "$name: $elements{$name}\n";
                }
        }


        if ( $input eq 'resfreq' ) {
                my %residues;
                foreach my $line (@lines) {
                        my @fields;
                        @fields = split(/\s+/, $line);

                        if ($fields[0] eq 'ATOM') { # to here
                               my $res_name = $fields[3];
                               if ($residues{$res_name}) {
                                   $residues{$res_name} += 1;
                               } else {
                                   $residues{$res_name} = 1;
                               }
                        }

                }
                foreach my $name (sort keys %residues){
                        print "$name: $residues{$name}\n";
                }
        }

        if ( $input =~ m/^reslength[\w\s]+/ ) {
                my @parameters = split(/\s+/, $input);
                my @x;
                my @y;
                my @z;
                my $count = 0;
                foreach my $line (@lines) {
                        my @fields;
                        @fields = split(/\s+/, $line);

                        if ( $fields[0] eq 'ATOM' && $fields[5] eq $parameters[3] ) {
                                $count = $count + 1;
                                push (@x, $fields[6]);
                                push (@y, $fields[7]);
                                push (@z, $fields[8]);
                        }
                }
                my $max_distance = 0;
                for(my $i = 0; $i < $count; $i++) {
                        for(my $j = $i + 1; $j < $count; $j++) {
                                my $distance = sqrt(($x[$i] - $x[$j])**2 + ($y[$i] - $y[$j])**2 + ($z[$i] - $z[$j])**2);
                                if($distance > $max_distance) {
                                        $max_distance = $distance;
                                }
                        }
                }
                print "$parameters[1] with sequence number $parameters[3] in chain $parameters[2] has length $max_distance angstroms.\n";
        }

        if ( $input eq 'quit' ) {

                print "Closing Program.\n";
                exit;
        }
}