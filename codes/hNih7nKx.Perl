my @headers = qw(DealID JTT ManualDeal DealDateTime UpdateDateTime InstName FirstSeqName Price Volume AggTraderID AggTraderName AggCompany InitTraderID);
print join "\t", @headers, "\n";
foreach my $trade (@{$self->pseudoJttDeals}) {
    print join ("\t", map {$trade->{$_}} @headers), "\n";
}