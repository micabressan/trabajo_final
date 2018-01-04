my @headers = qw(DealID JTT ManualDeal DealDateTime UpdateDateTime InstName FirstSeqName Price Volume AggTraderID AggTraderName AggCompany InitTraderID);
printf "\t"x@headers."\n", @headers;
foreach my $trade (@{$self->pseudoJttDeals}) {
    printf "\t"x@headers."\n", map {$trade->{$_}} @headers;
}