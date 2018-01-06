sub color_right($) {
    # $0 = nick, $1 = text, $2 = mode
    $tempNick = $2 . $0;
        
	Irssi::command('^format pubmsg {pubmsgnick {pubnick '.$_[0].'$['.$sign.$longestNick.']tempNick}}$1');
	Irssi::command('^format pubmsg_channel {pubmsgnick {pubnick '.$_[0].'$['.$sign.$longestNick.']tempNick}}$1');
}