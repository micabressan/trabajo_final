package Test;
use threads;
use threads::shared;
use Time::HiRes;
{
	use Object::InsideOut qw/:SHARED/;
	
	sub _init :Init {
		my ($self, $arg) = @_;
		
		print Time::HiRes::time() . " INIT ($$self)\n";
	} 

	sub _destroy :Destroy {
	 	my ($self) = @_;

	 	print Time::HiRes::time() . " DESTROY ($$self)\n";
	 }
}

1;

use threads;
use threads::shared;
use Thread::Queue;

my $q = new Thread::Queue;

threads->create(\&consumer)->detach;
while (1) {
	sleep 3;
	add();
}

sub add {
	$q->enqueue(new Test); 
}

sub consumer {
	while (my $o = $q->dequeue) {
		print Time::HiRes::time() . ": got $$o\n";
		undef $o;
	}
}