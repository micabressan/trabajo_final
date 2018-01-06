package T;
use threads;
use threads::shared;

{
	use Object::InsideOut qw/:SHARED/;
	
	my $INSTANCE;
	
	sub inst {
		unless ($INSTANCE) {
			$INSTANCE = new T;
		}
		
		return $INSTANCE;
	}
	
	sub _init :Init { 
		my ($self) = @_; 
		my $tid = threads->tid;
		print "INIT $$self in $tid\n"; 
	}
	
	sub _destroy :Destroy { 
		my ($self) = @_; 
		my $tid = threads->tid;
		print "DESTROY $$self in $tid\n"; 
	}
}

package main;
use threads;

my $x = new T;
undef $x;

my @ths = map { threads->create(\&func) } 1..4;
map { $_->join } @ths;

sub func {
	my $x = T::inst;
	my $y = T::inst;
	sleep threads->tid;
}