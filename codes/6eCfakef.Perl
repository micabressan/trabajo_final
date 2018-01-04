#!/usr/bin/perl

use warnings;
my $count;
my $record;
my $offset;
my $len;
my $poolno;
my $filecount;
my $line;
my $date ;

$len=306;
$offset=0;
$filecount=0;
$count=306;

&download( "012010","mbs","mbs_012010") ;

 &download( "022010","mbs","mbs_022010") ;

sub download
{

open(DAT, "c:\\extracted file\\$_[1]\\$_[2].txt");
while($count!= 0)
{
  $count= sysread(DAT,$record,$len,$offset);
  $record = substr $record, $offset, $len;
  $poolno = substr $record, 9, 6;

      if (-d "c:\\$_[0]\\$poolno")
     {
       #print "directory  exists\n";
       open (MYFILE, ">C:\\$_[0]\\$poolno\\$_[1].txt");
       print MYFILE $record;
       close (MYFILE);

     }
     else
     {
          mkdir("c:\\$_[0]\\$poolno\\", 0777) ;
          open (MYFILE, ">>C:\\$_[0]\\$poolno\\$_[1].txt");
	  print MYFILE $record;
	  close (MYFILE);
      }
    $offset = $len + $offset;
 }
 close DAT;
}