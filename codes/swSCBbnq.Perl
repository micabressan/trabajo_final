package Foo;

use strict;
use warnings;

sub new {
    my $self = {};
    return bless $self;
}

sub bar {
    my $self = shift;
    my $val = shift;
    if (defined($val)) {
        $self->{bar} = $val;
    } 
    else {
        $self->{bar};
    }
}

1;