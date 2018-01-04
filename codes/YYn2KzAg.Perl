#!/usr/bin/perl -w

use warnings;
use strict;
use WWW::Mechanize;
use Data::Dumper;

my $searchText;
my $text;
my $textToSearch = $ARGV[0];
my $stories;

my $mech = WWW::Mechanize->new();
$mech->get('http://lite.cnn.io/en');
my @links = $mech->links();
foreach my $link (@links) {
        if ($text = $link->text()) {
                if ($text =~ /$textToSearch/gi) {
                        $searchText++;
                }
                unless ($text eq 'CNN'
                     || $text eq 'Español'
                     || $text eq 'Listen'
                     || $text eq 'Listen to CNN (low-bandwidth usage)'
                     || $text eq 'Go to the full CNN experience'
                        ) {
                        $stories++;
#                       print "$text\n";
                }
        }
}
print @links . " total stories\n";
print "$searchText stories with \"$textToSearch\" in the headline.\n";
print "\n";