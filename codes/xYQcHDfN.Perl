sub my_fork{
    my ($..., $...) = @_;
    
    my $pid = fork();
    
    if (!defined $pid){
        print 'Unable to fork';
    }
    elsif ($pid == 0){ #Child process
        my $command = '...';
        my @arguments = ('...', '...');
        unless (-e $command){ #Fallback
            $command = '...';
            @arguments = ('...', '...');
        }
        close(STDOUT);
        close(STDERR);
        exec $command, @arguments;
    }
    else{ #Parent process
        ...
    }
}