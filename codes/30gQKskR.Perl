#!/usr/bin/perl

use Net::Telnet;
use DBI;

$username = "";
$passwd = "";

$conn = new Net::Telnet(Timeout => 10,  
                	Dump_Log => 'DUMP_SH_VLAN.LOG',
	                Host => '10.240.225.249');
$conn -> open();

$conn -> waitfor( '/UserName:/' );
$conn -> print( $username );

$conn -> waitfor( '/PassWord:/' );
$conn -> print( $passwd );
$conn -> waitfor('/#/');

$match = "/Total Entries/";
@lines = $conn->cmd(String=>"sh vlan", 
			  Timeout => 4, 
			  Prompt => $match); 


$conn -> print( "logout" );


splice (@lines, 0 , 3);
splice (@lines, -3 , 3);

$l = @lines;
		for ($k=0; $k<$l; $k++)
		{
			print $lines[$k];
			print "+\n";
		}
print @lines;

my $dbh = DBI->connect("DBI:mysql:database=debian1;host=127.0.0.1",
"root", "reqiem21") || die $DBI::errstr;

$dbh->do("CREATE TABLE shvlanresult
(name VARCHAR(32), status VARCHAR(100))");

foreach $i (@lines) 
{
	@base = split(/:/,$i);
	$n = @base;
	foreach $j (@base) 
	{
		s/^\s+//;
		s/\s+$//;
	}
	if ($n == 3)
	{
		@temp = split(/\s{2,}/,$base[1]);
		$base[0] =~ s/\s+$//;
		$base[2] =~ s/\s+$//;
		$temp[1] =~ s/\s+$//;
		$temp[0] =~ s/\s+$//;
		$base[0] =~ s/^\s+//;
		$base[2] =~ s/^\s+//;
		$temp[1] =~ s/^\s+//;
		$temp[0] =~ s/^\s+//;
		$dbh -> do("INSERT INTO shvlanresult VALUES('$base[0]', '$temp[0]')");
		$dbh -> do("INSERT INTO shvlanresult VALUES('$temp[1]', '$base[2]')");
	}
	else
	{
		$base[1] =~ s/\s+$//;
		$base[0] =~ s/\s+$//;
		$base[1] =~ s/^\s+//;
		$base[0] =~ s/^\s+//;
		$#mas = 0;
		@f_temp = split(/,/,$base[1]);
		foreach $j (@f_temp)
		{
			@s_temp = split(/-/,$j);
			if ($s_temp[0]<$s_temp[1])
			{
				for ($k=$s_temp[0]; $k<=$s_temp[1]; $k++)
				{
					push @mas, $k;
				}
			}
			else
			{
				push @mas, $s_temp[0];
			}
		}
		$dbh -> do("INSERT INTO shvlanresult VALUES('$base[0]', '@mas')");
	}
}
$dbh->disconnect();