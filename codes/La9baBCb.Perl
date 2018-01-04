#!/usr/bin/perl -w

my $genA = Genny->new( 16807, 2147483647, 4 );
my $genB = Genny->new( 48271, 2147483647, 8 );
$genA->seed( 591 ); 
$genB->seed( 393 );

#$genA->seed( 65 ); 
#$genB->seed( 8921 );

my $count = 0;
for( 1..5000000 ) {
	my $av = $genA->nextMatchingValue;
	my $bv = $genB->nextMatchingValue;

	my $a16= $av & 65535; 
	my $b16= $bv & 65535; 
	if( $a16 == $b16 )  {
		$count++;
	}
}
print "Part2=$count\n";
exit;

package Genny;

sub new {
	my( $class, $factor, $divide, $criteria ) = @_;

	return bless {
		factor=>$factor,
		divide=>$divide,
		criteria=>$criteria,
		value=>0 }, $class;
}

sub seed {
	my( $self, $value ) = @_;

	$self->{value} = $value;
}	

sub nextMatchingValue {
	my( $self ) = @_;

	# keep making values until it's a multiple of the criteria
	while( $self->nextValue % $self->{criteria} ) { ; }

	return $self->{value};
}

sub nextValue {
	my( $self ) = @_;

	$self->{value} = ( $self->{value} * $self->{factor} ) % $self->{divide};

	return $self->{value};
}