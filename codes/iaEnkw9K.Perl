#!/usr/bin/perl

use strict;

print Dumper(['foo','bar']);

sub {
  use Data::Dumper;
};