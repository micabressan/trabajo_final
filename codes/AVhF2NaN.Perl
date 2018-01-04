# file Errors.pm

package Errors;
use Moo;

# attribute errors
has 'errors' => (
    is => 'ro',
    default => sub {
        []
    }
);

# method get total errors
sub totalErrors {
    my $self = shift;
    
    return scalar(@{$self->errors});
}

1;

# file Person.pm

package Person;
use Moo;
extends qw/Errors/;

sub getTotalErrors {
    my $self = shift;
    
    return $self->totalErrors;
}

1;

# file run.pl

#!/usr/bin/perl

use strict;
use warnings;
use lib './';
use Person;

my $person = Person->new;
print $person->getTotalErrors;