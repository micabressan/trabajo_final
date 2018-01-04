task "uptime", group => "myserver", sub {

   my $connection = Rex::get_current_connection();
   say $connection->{"server"} . ": " . run("uptime");

};