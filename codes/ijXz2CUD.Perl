sub cmd_dice
{
    my ($chan, $nick, $arg) = @_;
    my ($count, $size, $bonus) = ( $arg =~ /^(\d+)d(\d+)([-+]\d+)?/ );
    
    my $total = 0;
    
    $total += int(rand($size)) + 1 for 0..$count-1;
    $total += $bonus;
    
    msg($chan, "The total is $total from rolling ${count}d$size$bonus\n");
}