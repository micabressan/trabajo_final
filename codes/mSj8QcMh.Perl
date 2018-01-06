    #!/usr/bin/perl
    $extension = '.orig';
    LINE: while (<>) {
	if ($ARGV ne $oldargv) {
	    if ($extension !~ /\*/) {
		$backup = $ARGV . $extension;
	    }
	    else {
		($backup = $extension) =~ s/\*/$ARGV/g;
	    }
	    rename($ARGV, $backup);
	    open(ARGVOUT, ">$ARGV");
	    select(ARGVOUT);
	    $oldargv = $ARGV;
	}
	s/foo/bar/;
    }