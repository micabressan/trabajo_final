#!/usr/local/bin/perl

use strict;
use warnings;

use DBI;

package DatabaseConnection;

my $dbh;

# Creating a new connection
sub connect {
	my $class = shift;
	my $self = {
		_databaseSourceName => shift,
		_username => shift,
		_password => shift,
	};

	# using RaiseError to handle errors and automatically dies instead of
	# writing "or die" explicitly in the code.
	my %attr = ( PrintError => 0, 
		RaiseError => 1 );
	
	$dbh = DBI->connect($self->{_databaseSourceName}, $self->{_username}, $self->{_password}, \%attr);

	bless $self, $class;
	return $self;	
}

# Generic command execution
sub execCommand {
	my $class = shift;
	
	# First parameter is the DBH
	# Second one is the SQL Command
	my $self = {_sqlCommand => shift };

	# Preparing SQL Query
	my $sth = $dbh->prepare($self->{_sqlCommand});

	# Executing and Finishing the Query
	$sth->execute();

	my $all_rows = $dbh->selectall_arrayref($sth);
	my @all_rows = @{ $all_rows };	# Dereference to create the array
	

	$sth->finish();
	
	return @all_rows;
}

# Create a table using provided parameters
sub createTable {
	my $class = shift;

	# Second one is the SQL Command
	my $self = {_tableName => shift,
		_parameters => shift };
	
	my $sth = $dbh->prepare("CREATE TABLE IF NOT EXISTS $self->{_tableName} ( $self->{_parameters} );");
	
	# Executing and Finishing the Query
	$sth->execute();
	$sth->finish();
	

	return $self;
}

# Dropping a table if exists
sub dropTable {
	my $class = shift;

	# Second one is the SQL Command
	my $self = { _tableName => shift };


	my $sth = $dbh->prepare("DROP TABLE IF EXISTS $self->{_tableName};");
	
	# Executing and Finishing the Query
	$sth->execute();
	$sth->finish();
	
	return $self;
}

# Inserting data into a table
# INSERT INTO table_name VALUES (value1, value2, ...);
sub insert {
	my $class = shift;
	
	my $self = { _tableName => shift,};
	
	my @values = @_;

	foreach (@values) {
		if (!$_) {
			$_ = "' '"; # If there is undef value
		} else {
			$_ = "'" . $_ . "'";
		}
	}
	
	# Constructing the values in appropriate form to be passed to the SQL query

	@values = join(", ",@values);
	#print @values, "\n\n";
	my $sth = $dbh->prepare("INSERT INTO $self->{_tableName} VALUES (@values);");
	
	# Executing and Finishing the Query
	$sth->execute();
	$sth->finish();
	
	return $self;
	
}

# Retrieve data from database
# SELECT * FROM table_name WHERE options;
sub retrieve {
	my $class = shift;

	my $self = {_tableName => shift,
			_conditions => shift};
	my $sth;
	if (!$self->{_conditions} ) {
		# Selecting all rows from a single table
		$sth = $dbh->prepare("SELECT * from $self->{_tableName}; ");
	} else {
		# Selecting specific rows based on the given conditions
		$sth = $dbh->prepare("SELECT * from $self->{_tableName} WHERE $self->{_conditions}; ");
	}
	

	# Executing and Finishing the Query
	$sth->execute();
	
	
	my $all_rows = $dbh->selectall_arrayref($sth);
	my @all_rows = @{ $all_rows };	# Dereference to create the array
	

	$sth->finish();

	return @all_rows;
		
}

	


# Disconnecting from MySQL database
sub disconnect {
	my $class = shift;
	my $self = { };
	$dbh->disconnect();
	
	return $self;
}


# Return list of available tables in the database
sub getTables {
	my $class = shift;
	my $self = { };
	
	return $dbh->tables();
}


1;