open(my $cmd, "$command @command_args 2>&1|") or die $!;
while (<$cmd>) {
        print if $verbose;
        print $lf $_;
}
close($cmd);