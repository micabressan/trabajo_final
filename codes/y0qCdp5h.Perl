package T;
use threads;
use threads::shared;
{
	use Object::InsideOut qw/:NOT_SHARED/;
}

package C;
{
	use Object::InsideOut qw/T/;
}

package main;
use threads;

threads->create(\&func)->join;

sub func {
	my $x = new C;
}