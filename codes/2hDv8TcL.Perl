    open(WRITEME, '|-', "/usr/local/bin/texpretty -w 180 -s ./texprettySettings.txt") or die "Couldn't fork: $!\n";
    print WRITEME "$data";    
    close(WRITEME);