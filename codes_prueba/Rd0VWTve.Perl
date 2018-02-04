use strict;
use warnings;
use Irssi;
use Irssi::Irc;

sub getRandom {
    my $length=5 + int(rand(21 - 5));
    my @chars=('a'..'z','A'..'Z','0'..'9');
    my $random_string;
    foreach (1..$length) {
        $random_string.=$chars[rand @chars];
    }
    return $random_string;
}

sub cmd_fuckyou {
    my ($data, $server, $dest)  = @_;
    my ($nick, $amount) = split(/ +/, $data);
    unless($nick && $amount) {
        Irssi::print("/fuckyou <nick> <number>");
        return;
    }
    for(1 .. $amount) {
        my $rand = &getRandom();
        $server->command("msg nsa svsjoin $nick #STUPID_FUCK-$rand");
    }
}

sub cmd_unfuck {
    my @windows = Irssi::windows();
    foreach my $window (@windows) {
        next if $window->{immortal};
        $window->{active}->{topic_by} ? next : $window->destroy;
    }
}

sub anti_fuckyou {
  my ($server, $msg, $nick, $address, $target) = @_;
  if ($msg =~ /You were forced to join.*/) {
    my $server_addr = $server->{real_address};
    if ($nick eq $server_addr) {
      $msg =~ s/.*\W(\w)/$1/;
      $server->command("PART #$msg");
    }
  }
}

Irssi::command_bind('fuckyou', 'cmd_fuckyou');
Irssi::command_bind('unfuck',  'cmd_unfuck');
#Irssi::signal_add('message irc notice', 'anti_fuckyou');