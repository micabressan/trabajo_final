my %records = $nvp->TransactionSearch( TransactionClass => 'refund' , StartDate => '2011-09-01T00:00:00');
while ((my $key, my $value) = each(%records)) {
my @list = $key.":".$value;
@list = grep(/L_AMT/, @list);
        foreach (@list) {
                @list = grep(/-/, @list) ;
                foreach (@list){
                                print $_."\n";
                                my $count = $count++;
                                 }
        }
}