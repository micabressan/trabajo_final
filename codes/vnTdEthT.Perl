#!/usr/bin/perl

use strict;
use warnings;
use Time::HiRes qw(usleep nanosleep);


my $i=1;
my $lastline=0;

while (1) {
        open (LOGFILE, "log") || die "couldn't open the file!";

        $i=0;
        while (my $line = <LOGFILE>) {
                $i++;
                if ( $lastline < $i ) {
                        ## parse file
                        chomp($line);
                        if ( $line =~ m/killed/ ) {
                                $lastline=$i;
                                my @player= split(/[<>]/, $line);
                                print "Bzzzzztz $lastline $player[9] \n";
                        }
                }
        }
        close(LOGFILE);
usleep(50000);
}