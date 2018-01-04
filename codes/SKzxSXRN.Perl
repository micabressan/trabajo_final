[devdas@tin2 ~]$ cat /tmp/testpack.pm
#!/usr/bin/perl

use strict;
use warnings;

package testpack;

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw($test);
our $test = "haha";

1;

[devdas@tin2 ~]$ cat /tmp/t1.pl
#!/usr/bin/perl

use strict;
use warnings;

use lib '/tmp';

use testpack;

print "test is $test\n";
print "Resetting test\n";
$test = 'foo';
print "test is $test\n";

[devdas@tin2 ~]$ cat /tmp/t2.pl
#!/usr/bin/perl

use strict;
use warnings;

BEGIN {
use lib '/tmp';
require 't1.pl';
}

print "test is now $test\n";

[devdas@tin2 ~]$ perl /tmp/t2.pl
test is haha
Resetting test
test is foo
test is now foo