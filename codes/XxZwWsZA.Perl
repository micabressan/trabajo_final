use strict;
use warnings;
#use Irssi;
use vars qw($VERSION %IRSSI);

$VERSION = 'PLACEHOLDER';
%IRSSI = (
    authors     => 'PLACEHOLDER',
    contact     => 'PLACEHOLDER',
    name        => 'PLACEHOLDER',
    description => 'PLACEHOLDER',
    license     => '',
    url         => '',
    changed     => 'PLACEHOLDER'
    );

my @pids = ();

use POSIX ":sys_wait_h"; #WNOHANG

#sub dezombify{
#    return !waitpid $_, WNOHANG;
#}

sub REAPER{
    my $kid;
    #Reap ALL zombies:
    #QUESTION: Will this interfere with other perl scripts or normal irssi?
    while (($kid = waitpid(-1, &WNOHANG)) > 0){
        ...
    }
    $SIG{CHLD} = \&REAPER;
}

sub sig_message_private{
    my ($server, $msg, $nick, $address, $target) = @_;
    
    my $ppid = $$;
    
    #Reap KNOWN zombies:
    #QUESTION: Would this be a better approach?
    ###foreach my $pid (@pids){
    ###    my $status = waitpid $pid, WNOHANG;
    ###    if ($status){
    ###        pop @pids; #Safe to do in foreach?
    ###    }
    ###}
    ##@pids = grep {&dezombify($_)} @pids;
    #@pids = grep { sub{ return !waitpid $_, WNOHANG; }->($_) } @pids;
    
    my $pid = fork();
    
    if (!defined $pid) {
        print 'Unable to fork';
    }
    elsif ($pid == 0){ #Child process
        close(STDOUT);
        close(STDERR);
        my $command = "";
        my @arguments = ();
	
        $command = '/foo/bar';
        @arguments = ('-baz', 'qux');
        unless (-e $command && -x $command){ #Fallback
            $command = '/bin/sleep';
            @arguments = ('2');
        }
        
        exec $command, @arguments;
    }
    else{ #Parent process
        #QUESTION: Should this be done before fork, after fork, or here (in parent)?
        #$SIG{CHLD} = 'IGNORE';
        $SIG{CHLD} = \&REAPER;
        
        #Push child to $pids:
        #if ($kid == -1){
        #    print $prompt_string . 'Unable to wait for ' . $pid;
        #}
        #elsif ($kid > 0){
        #    push @pids, $pid;
        #}
    }
}

Irssi::signal_add('message private', 'sig_message_private');