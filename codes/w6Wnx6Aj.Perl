use Irssi;

 Irssi::signal_add_first 'send text', 'my_handler';
 
  sub my_handler {
      my ($text, $server, $win_item) = @_;
          my @text = split ' ', $text;
              #my $newtext = "";
              my $sign = "Ξ̃̃~\"¨";
                  #for my $i (0 .. $#text) {
                          #my $space = " " x ($i + ($i-1));
                                  #$newtext = join "", $newtext, $space, $text[$i];
                                      #}
                                          $text = join " ", $sign , $text, "ꙮ";
                                              Irssi::signal_continue($text, $server, $win_item);
                                              
                                               }