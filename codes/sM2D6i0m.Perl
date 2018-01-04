#!/usr/bin/perl -w

use warnings;
use strict;
use WWW::Mechanize;
use Data::Dumper;

my $searchMatches = 0;
my $text;
my $textToSearch = $ARGV[0];
my $stories;

open (INFILE, "terms") or die $!;
my @terms;
while (<INFILE>) {
	chomp;
	push (@terms, $_);
}

my $mech = WWW::Mechanize->new();
$mech->get('http://lite.cnn.io/en');
my @links = $mech->links();
foreach my $link (@links) {
	if ($text = $link->text()) {
		unless ($text eq 'CNN' 
		     || $text =~ m/^Espa\xF1ol$/
		     || $text eq 'Listen'
		     || $text eq 'Listen to CNN (low-bandwidth usage)'
		     || $text eq 'Go to the full CNN experience'
			) {
			if (containsTerms(\@terms, $text)) {
				$searchMatches++;
			} else {
				print "$text\n";
			}	
			$stories++;
		}
	}
}

print "\n";
print @links . " total stories\n";
print "$searchMatches stories with your search text in the headline were not shown.\n";
print "\n";


##

sub containsTerms {
	my @terms = @{$_[0]};
	my $text = $_[1];
	foreach my $term (@terms) {
#		print "checking $term against $text\n";
		if ($text =~ m/$term/i) {
			return 'true';
		}
	}
	return;
}