#!perl
print "Introduce la cadena: ";
$cadena = <STDIN>;

while ($i<=length($cadena)-2)
{
	D2B(substr($cadena,$i,1));	
	$i+=1;
}
print "\n";
system("PAUSE");
exit(0);

sub D2B ($letra)
{
	$numero = ord(shift);
	my $resultado;
	
	while($numero >= 1)
	{
     	    $resultado = $resultado . $numero % 2;
    	    $numero = $numero  /  2;
	}

	$resultado = reverse($resultado);
	print "$resultado ";

	return 0;
}