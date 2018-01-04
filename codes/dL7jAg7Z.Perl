#!/usr/bin/perl
use strict;
use warnings;
use feature qw( say );

# The implementation of these don't matter;
# if the problem can be solved using only the methods provided by these classes,
# the problem can be solved using any implementation of these classes.

{
   package Queue;
   sub new     { my $class = shift; bless([], $class) }
   sub enqueue { my $self = shift; push @$self, @_; }
   sub dequeue { my $self = shift; @$self ? shift(@$self) : () }
}

{
   package Stack;
   sub new  { my $class = shift; bless([], $class) }
   sub push { my $self = shift; push @$self, @_; }
   sub pop  { my $self = shift; @$self ? pop(@$self) : () }
}

{
   package Array; # Fixed-size array.
   use Carp qw( croak );
   sub new  { my ($class, $size) = @_; bless([ (undef) x $size ], $class) }
   sub size { my $self = shift; 0+@$self }
   sub get  { my ($self, $i) = @_; croak "!" if $i<0 || $i>=@$self; $self->[$i] }
   sub set  { my ($self, $i, $item) = @_; croak "!" if $i<0 || $i>=@$self; $self->[$i] = $item; }
}

{
   package Vector; # Extendable array.
   use Carp qw( croak );
   sub new    { my $class = shift; bless([], $class) }
   sub size   { my $self = shift; 0+@$self }
   sub get    { my ($self, $i) = @_; croak "!" if $i<0; $self->[$i] }
   sub set    { my ($self, $i, $item) = @_; croak "!" if $i<0; $self->[$i] = $item; }
   sub append { my ($self, $item) = @_; push @$self, $item; }
}

{
   package Dictionary;
   use Carp qw( croak );
   sub new    { my $class = shift; bless({}, $class) }
   sub get    { my ($self, $k) = @_; croak "!" if !exists($self->{$k}); $self->{$k} }
   sub set    { my ($self, $k, $item) = @_; $self->{$k} = $item; }
   sub exists { my ($self, $k) = @_; exists($self->{$k}) }
   sub delete { my ($self, $k) = @_; croak "!" if !exists($self->{$k}); delete($self->{$k}) }
}


sub purge_queue {
   my ($q) = @_;

   my @vals;
   while ( my ($item) = $q->dequeue() ) {
      push @vals, $item;
   }

   return @vals;
}


# O(N) time. O(1) memory.
sub reverse_queue_using_stack {
   my ($in_q) = @_;

   my $stack = Stack->new();
   while ( my ($item) = $in_q->dequeue() ) {
      $stack->push($item);
   }

   my $out_q = Queue->new();
   while ( my ($item) = $stack->pop() ) {
      $out_q->enqueue($item);
   }

   return $out_q;
}


# O(N) time. O(1) memory.
sub reverse_queue_using_dict {
   my ($in_q) = @_;

   my $dict = Dictionary->new();
   my $i = 0;
   while ( my ($item) = $in_q->dequeue() ) {
      $dict->set($i++, $item);
   }

   my $out_q = Queue->new();
   while ($i--) {
      $out_q->enqueue($dict->delete($i));
   }

   return $out_q;
}


# O(N) time. O(N) memory.
sub reverse_queue_using_array {
   my ($in_q) = @_;

   my $count = 0;
   my $tmp_q = Queue->new();
   while ( my ($item) = $in_q->dequeue() ) {
      ++$count;
      $tmp_q->enqueue($item);
   }

   my $array = Array->new($count);
   for my $i (0..$count-1) {
      $array->set($i, $tmp_q->dequeue());
   }

   my $out_q = Queue->new();
   for (1..$count) {
      my $i = $array->size() - $_;
      $out_q->enqueue($array->get($i));
   }

   return $out_q;
}


# O(N) time. O(N) memory.
sub reverse_queue_using_vector {
   my ($in_q) = @_;

   my $vector = Vector->new();
   while ( my ($item) = $in_q->dequeue() ) {
      $vector->append($item);
   }

   my $out_q = Queue->new();
   for (1..$vector->size()) {
      my $i = $vector->size() - $_;
      $out_q->enqueue($vector->get($i));
   }

   return $out_q;
}


# O(N^2) time. O(1) memory.
sub reverse_queue_using_queue {
   my ($in_q) = @_;

   my $out_q = Queue->new();
   while (1) {
      my $tmp_q = Queue->new();

      my ($tail) = $in_q->dequeue()
         or last;

      while ( my ($item) = $in_q->dequeue() ) {
         $tmp_q->enqueue($tail);
         $tail = $item;
      }

      $out_q->enqueue($tail);
      $in_q = $tmp_q;
   }

   return $out_q;
}


for my $reverse_func_name (qw(
   reverse_queue_using_stack
   reverse_queue_using_dict
   reverse_queue_using_array
   reverse_queue_using_vector
   reverse_queue_using_queue
)) {
   my $reverse_func = \&$reverse_func_name;

   my $queue = Queue->new();
   $queue->enqueue($_) for 'a'..'j';

   my $reversed_queue = $reverse_func->($queue);

   say sprintf "%-27s %s", "$reverse_func_name:", join ' ', purge_queue($reversed_queue);
}

__END__
reverse_queue_using_stack    # O(N) time.   O(1) memory.
reverse_queue_using_dict     # O(N) time.   O(1) memory.
reverse_queue_using_array    # O(N) time.   O(N) memory.
reverse_queue_using_vector   # O(N) time.   O(N) memory.
reverse_queue_using_queue    # O(N^2) time. O(1) memory.