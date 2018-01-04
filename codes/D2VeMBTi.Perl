#!/usr/bin/perl

use strict;
use warnings;
use Bio::SearchIO; 

my $in = new Bio::SearchIO(-format => 'blast', 
                           -file   => shift);
                           
while( my $result = $in->next_result ) {
   print $result->query_name, "\t", $result->algorithm, "\t", $result->algorithm_version, "\n";
}