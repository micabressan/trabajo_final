#Find the longest common taxonomy prefix
sub longest_common_prefix(@) {
    my $prefix = shift;
    for (@_) { chop $prefix while (! /^\Q$prefix\E/i); }
    return $prefix;
}