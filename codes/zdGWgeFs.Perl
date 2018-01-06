#! /usr/bin/perl
use warnings;

###Recup URL : 001###
if (exists $ARGV[0])
{
	$url = $ARGV[0];
}
else
{
	print "Quelle est l'url de la page a recuperer ? \n";
	$url = <STDIN>;
	chomp($url);
}
###Fin 001###

###Wget + ls dans fic txt : 002###
system "wget -q -r -nd $url";

system "ls > liste.txt";
open FIC1, "< liste.txt";
###Fin 002###

###Read FIC1 + test regex + enreg tab : 003###
$i = 0;
while ($ligne = <FIC1>)
{
	$ligne =~ /(.*\.jpg)/;
	$images[$i] = $1;
	$i = $i + 1;
}
print "@images \n";
###Fin 003###

###Parcours tab + convert : 004###
foreach $images (@images)
{
	system "convert $images -resize 800x600 resize_$images";
}
###Fin 004###