my %records = $nvp->TransactionSearch( TransactionClass => 'refund' , StartDate => '2011-09-01T00:00:00');
my $r_count = 0;
foreach my $t_type (keys %records) {
   if ($t_type =~ /L_AMT/) {
      print $records{$t_type}."\n";
      $r_count++;
   }
}
print "Records found: $r_count\n";