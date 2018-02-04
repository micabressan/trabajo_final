    my $output;
    my $ok = 1;
    try {
        $output = `$self->{command}`;
    } catch {
        print "motherfucking $?\n";
        $ok = 0;
    };
    return if (!$ok || !$output);