#!/usr/bin/perl
use strict;
use warnings;

package Foo;
use Moose;
use Moose::Util::TypeConstraints;
use DDP;

sub TruncatedString {
    my $max = shift;

    my $type = subtype as 'Str', where { $_ <= $max };
    coerce $type, from 'Str', via { warn 'Coercing!'; substr($_, 0, $max); }; 

    # Works here
    return $type;
}

has 'name' => ( 'is' => 'ro', 'isa' => TruncatedString(10), 'coerce' => 1 );

package main;

my $foo = Foo->new('name' => '12345678901');

# Returns "12345678901", not "1234567890"
print $foo->name, qq{\n};