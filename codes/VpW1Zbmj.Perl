#!/usr/bin/perl

 use List::Util qw(sum);
 
 open (HeightWeight, '>HeightWeight.txt');
 
 print 'Is she a fatty? Y/N  ';
 chomp ($Fatty = <>);
 
 print 'How are the tits? (1-10) ';
 chomp ($BigTits  = <>);
 
 print 'How is the ass? (1-10) ';
 chomp ($BigAss = <>);
 
 print 'How is the face? (1-10) ';
 chomp ($CuteFace = <>);
 
if ($Fatty eq "Y") 
{
	$Score = 7;
}	
else
{
	$Score = 10;
}

@Score= ($Score, $BigTits, $BigAss, $CuteFace);
$Score = sum(@Score)/4;

print "She's a $Score dude\n";
 
close (HeightWeight);
exit;