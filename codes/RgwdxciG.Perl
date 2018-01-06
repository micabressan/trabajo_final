#!/usr/bin/perl


foreach $i (1 .. 100) { 
  if ($i % 3 == 0) { print "Fizz"; $flag = 1;} 
  if ($i % 5 == 0) { print "Buzz"; $flag = 1;}
  if ($flag ==0 ) { print "$i"; }
  print "\n";
  $flag = 0;
}