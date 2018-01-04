task "ls", group => "myserver", sub {
   my $connection = Rex::get_current_connection();

   for my $line (run("ls -l")) {
      say $connection->{"server"} . ": " . $line;
   }

};