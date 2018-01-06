sub read_user_input {
  print "Are you sure? [Y/n]: ";
  my $answer = <STDIN>;
  return $answer;
}
print "User's answer: ", read_user_input(), "\n";


sub read_user_input_async {
  my $callback = shift;

  my $iow;
  $iow = AE::io(
    *STDIN,
    0,
    sub {
      # user provided some input, therefore
      # *STDIN is ready for reading; let's try
      # to read something from this fd
      my $answer;
      my $num_read = sysread(STDIN, $answer, 3);
      
      # it's time to invoke callback function
      # with result
      $callback->($answer);
    }
  }
}

read_user_input_async(sub { print "User's answer: " , $_[0], "\n" });