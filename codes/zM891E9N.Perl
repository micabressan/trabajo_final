#!/usr/bin/perl

use 5.010;
use strict;
use warnings;
use utf8;

# lista svih keyeva
my @ops = (
  "res",
  "map",
  "keys",
  "slice",
  "obj",
);

# JavaScript source code
my $code = "events[_0x14c0[1]][_0x14c0[3]](_0x14c0[2], _0x14c0[4], clone);";

$code =~ s/_0x14c0\[(\d+)\]/_0x14c0\["$ops[$1]"\]/g;

say $code;