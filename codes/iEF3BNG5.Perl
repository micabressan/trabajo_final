#!/usr/bin/env perl
use threads;
use threads::shared;
use strict;
use warnings;

use LWP::UserAgent;

my $ua = LWP::UserAgent->new('keep_alive'=>1);
$ua->timeout(90);
$ua->agent('Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.130 Safari/537.36');

my $workers = 10;
my $verbose = 0;
my $count :shared;
my $bad :shared;
my $max : shared;
$max = 100000000;
$count = $bad = 0;

sub jamminontheone {
    my $v = shift;
    while ($count < $max) {
	    my $r = HTTP::Request->new(POST => "http://api.massrelevance.com/v1/polls.json?poll=15C&option=5M8");
            $r->header('Accept','*/*');
            $r->header('Accept-Language','en-US,en;q=0.8');
            $r->header('Referer','http://yahoo7.massrel.io/7-news/');
            $r->header('Origin','http://yahoo7.massrel.io');
            $r->header('Connection','keep-alive');
            $r->header('Content-length','0');

	    my $t = $ua->request($r);
	
	    if ($t->is_error || $t->content !~ /success/ ) {
	        $bad++;
	        print '#'.threads->tid().": Vote failed. (Votes: $count / Errors: $bad)\n" if ($v);
	    } else {
	        $count++;
	        print '#'.threads->tid().": Vote Successful. (Votes: $count / Errors: $bad)\n" if ($v);
	    }
    }
}

my @thr;
print "Launching $workers Workers...\n";
for (my $i = 0; $i < $workers; $i++) {
    $thr[$i] = threads->create('jamminontheone',$verbose);
}

sub format_bytes {
    my $b = shift;
    return (sprintf "%.2fMB",$b/(1024*1024));
}

my (@mem,$vsz,$rss);

my $start=time();

while (threads->list()) {
    sleep(10);
    if ($^O =~ /MSWin/i) {
        @mem = split(/^"|","|"\n"|"$/,`tasklist /FI "PID eq $$" /FO csv`);
    } else {
        ($vsz,$rss) = split(/\s+/,`ps --no-headers -o vsz,rss -p $$`);
    }
    my $runtime = (time() - $start);
    my @rtp = gmtime($runtime);
    if ($^O =~ /MSWin/i) {
        printf ("--Stats-- Votes: %d / Errors: %d / Workers: %d\n          Memory Usage: %s\n          Runtime: %d Days %d Hours %d Minutes %d Seconds\n          Votes per Second: %.5f / Attempts per Second: %.5f\n",$count,$bad,scalar(threads->list()),$mem[-2],@rtp[7,2,1,0],$count/$runtime,($count+$bad)/$runtime);
    } else {
        printf ("--Stats-- Votes: %d / Errors: %d / Workers: %d\n          Virt Mem: %s / RES Mem: %s\n          Runtime: %d Days %d Hours %d Minutes %d Seconds\n          Votes per Second: %.5f / Attempts per Second: %.5f\n",$count,$bad,scalar(threads->list()),format_bytes($vsz),format_bytes($rss),@rtp[7,2,1,0],$count/$runtime,($count+$bad)/$runtime);
    }
    foreach my $tt (@thr) {
        if ($tt->is_joinable()) {
            $tt->join();
            print "#".$tt->tid()." Worker Done.";
        }
    }
}
print "All $workers have finished.";
threads->exit();