use DBI;
use DBD::SQLite;
use strict;

my $record;
my $value = $ARGV[0];
my $table = $ARGV[1];
my $field = $ARGV[2] || $ARGV[1];

my $dbh = DBI->connect("dbi:SQLite:dbname=bin/Search.db","","") 
	or die "Couldn't connect to database: " . DBI->errstr;

my $sql = "SELECT Recno FROM ".$table." WHERE ".$field." LIKE '".$value."'";

my $sth = $dbh->prepare($sql)
	or die "Couldn't prepare statement: " . $dbh->errstr;
$sth->execute() 
	or die "Couldn't execute statement: " . $sth->errstr;

my @data;
while (@data = $sth->fetchrow_array()) {
my $sql2 = "SELECT FullText FROM Formatted WHERE Recno = '".$data[0]."'";
my $sth2 = $dbh->prepare($sql2)
	or die "Couldn't prepare statement: " . $dbh->errstr;
$sth2->execute() 
	or die "Couldn't execute statement: " . $sth->errstr;
my @data2;
while (@data2 = $sth2->fetchrow_array()) {
	$record = $data2[0];
	$record =~ s/`n/\n/g;
	print $record."\n"; }}