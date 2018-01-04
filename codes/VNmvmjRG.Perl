my @headers = qw(DealID JTT ManualDeal DealDateTime UpdateDateTime InstName FirstSeqName Price Volume AggTraderID AggTraderName AggCompany InitTraderID);
printf "%s\t"x@headers."\n", @headers;
foreach my $trade (@{$self->pseudoJttDeals}) {
    printf "%s\t"x@headers."\n", map {$trade->{$_}} @headers;
}