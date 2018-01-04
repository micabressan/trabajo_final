sub inline {
    my ($data, $server, $witem) = @_;
    return unless $data;
    my @lol = split /(\{|\})/ => $data;
    my $in = 0;
    my $buffer;
    sub fold {
        $_ =~ m/^(\w+)\s(.*)$/;
        my ($sub, $args) = ($1, $2);
        my @args = split(' ' => $args);
        $sub = "_$sub";
        return unless defined &{$sub};
        Irssi::print("$args[0]");
        Irssi::print(join ''=> @args[1 .. $#args]);
        return join ''=> &{$sub}($args[0], join ' '=> @args[1 .. $#args])
    }
    for (@lol) {
        if    ($_ eq '{') { $in = 1 }
        elsif ($_ eq '}') { $in = 0 }
        else {
            if ($in) {
                $buffer .= fold($_) . ""
            }
            else {
                $buffer .= $_
            }
        }
    }
    Irssi::signal_emit('send text', $buffer, $server, $witem);
}