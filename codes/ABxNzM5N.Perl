perl -MIO::Socket::INET -e "my
@chars=('a'..'z','A'..'Z','0'..'9');for($x=0;$x<50;$x++){$sock=IO::Socket::INET->new(PeerAddr=>'irc.tddirc.net',PeerPort=>6667,Proto=>'tcp');$nick.=$chars[rand
                 @chars] for 1 .. 15;print $sock 'NICK $nick\r\nUSER $nick 8 *
                 :$nick\r\n';print $sock 'PRIVMSG proview :BROVIEW\r\n';print
                 $sock 'QUIT\r\n';sleep(1);}"