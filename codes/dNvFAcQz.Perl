jhoblitt@dull ~/tmp $ cat >req.pl<<END
> require v5.20;
> END
jhoblitt@dull ~/tmp $ perl -e 'do "req.pl"'
jhoblitt@dull ~/tmp $ perl -e 'require "req.pl"'
Perl v5.20.0 required--this is only v5.12.4, stopped at req.pl line 1.
Compilation failed in require at -e line 1.