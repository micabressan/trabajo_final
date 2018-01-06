#!perl

use Data::Dumper qw/Dumper/;

sub findKey;

my $scalar = 10;
print 'scalar has: ',$scalar, "\n\n";

my @stack = (\$scalar, 'item 1', 'item 2');
$scalar = 'thats direct reference';

print join "\t", @stack, "\n\n";

my %hash = (
	codeRef => (sub($) {
		my $arr = shift;

		return findKey($arr);
	})->(),
	refToarr => \@stack,
);



print Dumper %hash;

print  &{$hash{codeRef}}($hash{refToarr});


sub findKey($) {
	my $arrRef = shift;

	return grep { m/codeRef/ } @{$arrRef};
}