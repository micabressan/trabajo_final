#!/usr/bin/perl
# Генератор цифровых словарей
use strict;
use warnings;

open(F1, ">in+37.dat") or die "Shit: $!";


for ($a=10000000;$a<1000000000;$a=$a+37){


print(F1 "$a\n");
print "$a\n";
}

close(F1);