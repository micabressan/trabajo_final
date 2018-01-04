package T;
use threads;
use threads::shared;
use Thread::Queue;
{
	use Object::InsideOut qw/:SHARED/;
	
	sub _init :Init {
		my ($self, $args) = @_;
	
		print "init $$self\n";
	}
	
	sub _destroy :Destroy {
		my ($self) = @_;
	
		print "destroy $$self\n"
	}
}

1;

package main;
use threads;

my $q = new Thread::Queue;

threads->create(\&producer)->detach();
threads->create(\&consumer)->join();

sub producer {
	while (1) {
		sleep (1);
	
		my $t =  new T;
		print "NEW $$t\n";
		$q->enqueue($t);		
	}
}

sub consumer {
	while (my $t = $q->dequeue()) {
		print "Got $$t\n";
		undef $t;
	}
}