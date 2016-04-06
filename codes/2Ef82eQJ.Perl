
my $i,$p;

chomp( $p = <>);

print "\n";

print substr( $p, 0 , $_)."\n" for( 1 .. length($p) );
print substr( $p, 0, -$_). "\n" for( 1 .. length($p)-1 );

print "\n";