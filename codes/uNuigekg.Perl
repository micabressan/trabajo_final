jhoblitt@dull ~/tmp $ perl -e 'require v5.20'
Perl v5.20.0 required--this is only v5.12.4, stopped at -e line 1.
jhoblitt@dull ~/tmp $ perl -e '$foo="v5.20"; eval "require $foo"'
jhoblitt@dull ~/tmp $