#!/usr/bin/perl
use strict;

my $msg = "heorgeroigeriogjre\n[mobile]\n[signature]";
my $tag = "mobile";
my $mobile = '[' . $tag . ']';

if ($msg =~ s/\n?\Q$mobile\E$//) {
 print ("mobile yep");
} else {
 print("mobile no");
}

my $stag = "signature";
my $sig = '[' . $stag . ']';

if ($msg =~ s/\n?\Q$sig\E$//) {
 print ("sig yep");
} else {
 print("sig no");
}


#if ($msg =~ s/\n?\[\s*\Q$tag\E\s*\]//g) {
#    print ("YEP");
#} else {
#    print ("NOPE");
#}