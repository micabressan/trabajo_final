#!/usr/bin/perl


use HTTP::Daemon;
use HTTP::Status;

my $daemon = HTTP::Daemon->new(
                LocalAddr => '0.0.0.0',
                LocalPort => '80');

while (my $client = $daemon->accept) {

        my $tcp_info = $client->sockopt(SOL_TCP, TCP_INFO);
  print unpack("I", $tcp_info); 

        while (my $request = $client->get_request) {
                if ($request->method eq 'GET') {
                        $client->send_file_response("file");
                }
        }
        $client->close;
        undef($client);
}
root@pc18:~/Téléchar