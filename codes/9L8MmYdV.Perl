#!/usr/local/bin/perl
use DatabaseConnection;


use strict;

use Data::Dumper;

package main;


# MySQL database configuration
my $dsn = "DBI:mysql:perl_training";
my $username = "mamagdy";
my $password = "";

# DatabaseConnection object
my $dbc = DatabaseConnection->connect($dsn, $username, $password);

my $logfile = 'database-insertion-log.txt';
open(my $logfileHandle, '>', $logfile) or die "Could not open file '$logfile' $!";

my $fileCount = 0;
foreach my $fp (glob("logfiles/*.txt")) {
	
	open (my $fh, "<", $fp) or die "Cannot read/open $fp";
	my $mid;
	my $bid;
	while (my $row = <$fh>) {
		# Removing the newline at the end of each line
		chomp($row);
		$row =~ s/true/1/g;	
		$row =~ s/false/0/g;

		my %parameters = split /[,=]/, $row; 	# Splitting into hash
		#print Dumper(\%parameters);
		
		# Builds: id, cd, ct, tt, mid, p, i, s, g, r, w, e, a ,q, c, o
		# Machines: id, m, np, ms
		
		# check if the machine does not exits
		# if so, add it to the table of Machines
		my @result = $dbc->retrieve('Machines', "m = '$parameters{'m'}'");
		
		if (!@result) {
			$dbc->insert('Machines', "" , $parameters{'m'}, $parameters{'np'}, $parameters{'ms'});
			@result = $dbc->retrieve('Machines', "m = '$parameters{'m'}'");
			$mid += 1;
		}
		
		$mid = $result[0][0];
		
		# Considering only builds from the first n files and discarding the rest (for testing purposes)
		if ($fileCount < 10000) {
			# Checking if all the necessary fields are there
			if (!$parameters{'cd'} || !$parameters{'ct'} ) {
				# If the current date or the current time does not exist
				print $logfileHandle "Warning: Missing cd and/or ct fields.";			
			}

			if (!$mid) {
				# If no machine is assigned to the current build
				print $logfileHandle "Warning: Missing m field.";	
			}
			# Inserting into the Builds table
			$dbc->insert('Builds', "", $parameters{'cd'}, $parameters{'ct'}, $parameters{'tt'},
					$mid, $parameters{'p'}, $parameters{'i'},,$parameters{'s'},
					$parameters{'g'}, $parameters{'r'}, $parameters{'w'},
					$parameters{'e'}, $parameters{'a'}, $parameters{'q'},
					$parameters{'c'}, $parameters{'o'});

		}

	}	

	close $fh or die "Cannot close $fp";
	$fileCount += 1;
}	

close $logfileHandle;
# Disconnecting ..
$dbc->disconnect();