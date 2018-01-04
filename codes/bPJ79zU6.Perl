use strict;
use Irssi;
use Irssi::TextUI;
use vars qw($VERSION %IRSSI);

$VERSION = "0.1.0";
%IRSSI = (
    authors => 'Dave Woodfall',
        contact => 'dive @ #irssi irc.freenode.net',
            name => 'theme_tester',
                description => 'Provides a way to test formats in themes.',
                    license => 'Public domain',
                    );

                    sub runtest {
                    my ($args) = $_[0];
                    my ($section, $type) = split(/ /,$args);
                    my $theme = Irssi::current_theme();

                    eval { $theme->get_format($section, $type) };

                    if ( $@ )
                    {
                    Irssi::active_win()->print("%R" . $section . ", " . $type . " does not exist!");
                    return;
                    }

                    my $got_format = $theme->get_format($section, $type);
                    my $format = $theme->format_expand($got_format);

                    Irssi::active_win()->print($format);
                    }

                    Irssi::command_bind('theme', 'runtest', 'format');