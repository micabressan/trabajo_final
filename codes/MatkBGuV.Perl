 open(my $FILE, $ARGV[0]);
        open($FILE, "<", "small.pdb")
            or die "Can't open < small.pdb: $!"; 

        my $input = <STDIN>;
        chomp $input;