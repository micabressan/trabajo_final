testpack.pm
------------

package testpack;

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw($test);
our $test = "haha";

1;

----------------------------------------------------------

test.pl
-------

use testpack;

print "\ntest - $test\n";
$test = "hehe";

system ("perl abc.pl");



------------------------------------------------------------

abc.pl
------

use testpack;

print "\nabc - $test \n";

-----------------------------------------------------------


perl test.pl