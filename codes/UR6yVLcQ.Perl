# spotifylinks.pl
#
# Replaces annoying open.spotify.com/track/id links to spotify:track:id links
#
# Settings:
#
#    spotifyreplace: How to notify you that letters have been changed. Default
#                  is "<spo>text</spo>", where "text" is replaced with the
#                  message.
#
# Thanks to Fenne for a great idea.

use strict;
use Irssi;

our $VERSION = '1.01';
our %IRSSI = (
    authors	=> 'reltih',
    contact	=> 'jastrzebski@mail.ru',
    name	=> 'spotifylinks',
    description	=> 'Replaces Open.spotify.com/track/id links to spotify:track:id',
    license	=> 'Public Domain',
    url		=> 'https://github.com/bartoszjastrzebski',
    changed	=> '18 August 2015 21:37:00',
);

sub spotifytrack {
    my ($server, $data, $nick, $address) = @_;

    my ($target, $msg) = split / :/, $data, 2;

    return unless $msg =~ s{https://open.spotify.com/track/(\d+)[^\s]*}
                           {spotify:track:$1}g;

    Irssi::signal_emit('event privmsg', ($server, "$target :$msg", $nick, $address));

    Irssi::signal_stop();
}

Irssi::signal_add('event privmsg', 'spotifytrack');
Irssi::settings_add_str('misc', 'spotifyreplace', "<spo>text</spo>");