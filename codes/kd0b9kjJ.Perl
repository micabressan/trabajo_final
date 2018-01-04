#!/usr/bin/perl
 
 open (HeightWeight, '>HeightWeight.txt');
 
 print 'Is she a fatty? Y/N  ';
 chomp ($Fatty = <>);
 
 print 'Big tits? Y/N  ';
 chomp ($BigTits  = <>);
 
 print 'Big ass? Y/N  ';
 chomp ($BigAss = <>);
 
 print 'Cute face? Y/N  ';
 chomp ($CuteFace = <>);
 
if ($Fatty eq "Y") 
{
	$Score = 7;
}	
else
{
	$Score = 10;
}

if ($BigTits eq "N")
{
	$Score = $Score - 1;
}

if ($BigAss eq "N")
{
	$Score = $Score - 1;
}

if ($CuteFace eq "N")
{
	$Score = $Score - 1;
}

print "She's a $Score dude\n";
 
close (HeightWeight);
exit;