#!/usr/bin/perl
 
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