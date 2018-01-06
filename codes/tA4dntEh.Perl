sub cmd_dice
{
    my ($chan, $nick, $arg) = @_;
    my ($count, $size, $bonus) = ( $arg =~ /^(\d+)d(\d+)([-+]\d+)?/ );
    $bonus = '+0' unless length $bonus;
    
    my $total = 0;
    $total = int(rand($size*$count))+1+$bonus;
    
    msg($chan, "The total is $total from rolling ${count}d$size$bonus\n");
}