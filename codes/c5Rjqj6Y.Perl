#primitivna frekvencna analyza slov --- Daniel Lovasko, 2011

#nacitanie suboru text.txt do premennej $text
open(FH, 'text.txt');
$text = $text . $_ while(<FH>);


#rozdelenie textu na slova (algoritmus: oddelovac je skupina non-alphanumerickych znakov velka aspon jeden)
@slova = split( /\W+/, $text );


#pre kazde slovo zvacsi jeho pocet vyskytov
foreach $slovo (@slova)
{
	$counter{$slovo}++;
}


#vypis pocet slov a jednotlive slova spolu s ich frekvenciouo vyskytu
print "pocet slov " . (scalar (@slova)) . "\n";
while( my( $key, $value ) = each( %counter ) ) 
{
	printf "$key ===> %f\n", $value/scalar(@slova);
}