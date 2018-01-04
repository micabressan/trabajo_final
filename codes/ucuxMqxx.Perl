#!/usr/bin/perl
use strict;
use warnings;
use feature qw( say );

{
   package Queue;
   sub new     { my $class = shift; bless([], $class) }
   sub enqueue { my $self = shift; push @$self, @_; }             # O(1), amortized
   sub dequeue { my $self = shift; @$self ? shift(@$self) : () }  # O(1)
}

{
   package Stack;
   sub new  { my $class = shift; bless([], $class) }
   sub push { my $self = shift; push @$self, @_; }           # O(1), amortized
   sub pop  { my $self = shift; @$self ? pop(@$self) : () }  # O(1)
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


# O(N) time. O(N) memory.
sub reverse_queue_using_array {
   my ($in_q) = @_;

   my $count = 0;
   my $tmp_q = Queue->new();
   while ( my ($item) = $in_q->dequeue() ) {
      ++$count;
      $tmp_q->enqueue($item);
   }

   my @array;
   for my $i (0..$count-1) {
      $array[$i] = $tmp_q->dequeue();
   }

   my $out_q = Queue->new();
   for (1..$count) {
      my $i = @array - $_;
      $out_q->enqueue($array[$i]);
   }

   return $out_q;
}


# O(N) time. O(N) memory.
sub reverse_queue_using_vector {
   my ($in_q) = @_;

   my @vector;
   while ( my ($item) = $in_q->dequeue() ) {
      $vector[@vector] = $item;
   }

   my $out_q = Queue->new();
   for (1..@vector) {
      my $i = @vector - $_;
      $out_q->enqueue($vector[$i]);
   }

   return $out_q;
}


# O(N^2) time, O(1) memory.
sub reverse_queue_using_nothing {
   my ($in_q) = @_;

   my $out_q = Queue->new();
   while (1) {
      my $tmp_q = Queue->new();

      my ($last) = $in_q->dequeue()
         or last;

      while ( my ($item) = $in_q->dequeue() ) {
         $tmp_q->enqueue($last);
         $last = $item;
      }

      $out_q->enqueue($last);
      $in_q = $tmp_q;
   }

   return $out_q;
}


for my $reverse_func_name (qw(
   reverse_queue_using_stack
   reverse_queue_using_array
   reverse_queue_using_vector
   reverse_queue_using_nothing
)) {
   my $reverse_func = \&$reverse_func_name;

   my $queue = Queue->new();
   $queue->enqueue($_) for qw( a b c );

   my $reversed_queue = $reverse_func->($queue);

   say join ' ', purge_queue($reversed_queue);
}