#!/usr/bin/perl

use strict;
use warnings;

use File::Path qw(make_path);
use IO::Handle;

my $usage = 'log NAME';
my $name = shift or die "usage: $usage\n";

my $fh;
my $next_time = 0;

while (<STDIN>) {
    write_line(time, $_);
}

sub write_line {
    my ($now, $line) = @_;

    my $fh = get_fh($now);
    print $fh '[' . scalar gmtime($now) . " GMT] $line";
}

sub get_fh {
    my ($now) = @_;

    if ($now >= $next_time) {
        my ($sec, $min, $hour, $mday, $mon, $year) = gmtime($now);

        $year = $year + 1900;
        $mon = sprintf("%02d", $mon+1);
        $mday = sprintf("%02d", $mday);
        
        make_path("log/$year$mon/$mday");
        open($fh, '>>', "log/$year$mon/$mday/$name.log")
            or die "can't write log/$year$mon/$mday/$name.log: $!";
        $fh->autoflush(1);

        $next_time = ($now % 86400) + 86400;
    }

    return $fh;
}