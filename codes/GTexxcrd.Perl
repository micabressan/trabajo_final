#!/usr/bin/perl

use common::sense;
use FindBin qw($Bin);

use Data::Dumper;
use LWP::UserAgent;
use JSON::XS;

my $ua = LWP::UserAgent->new();
my $root = 'http://localhost:8008/file';

my $param = shift;

if (-e $param) {
    open FILE, "$param";
    binmode FILE;
    my $file = join '', <FILE>;
    close FILE;
    
    $param =~ s/^.+\///;
    
    my $json = $ua->post($root, filename => $param, Content => $file)->decoded_content;
    print Dumper decode_json($json);
}
else {
    my $json = $ua->get("$root/$param")->decoded_content;
    print Dumper decode_json($json);
}