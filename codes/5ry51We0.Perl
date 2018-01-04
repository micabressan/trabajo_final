$dbh->do("COPY footable (foo,bar) FROM STDIN");
for (0..$#ar) {
   $rc = $dbh->pg_putcopydata( join("\t",@{$ar}[0..1]) . "\n");  
}
$dbh->pg_putcopyend();