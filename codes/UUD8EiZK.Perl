#!perl -w 
use strict; 
use IO::File; 

our $SONG_FILE = 'c:\\\\temp\\nowplaying.txt'; 

Xchat::register("FooBar Spammer", "0.1"); 
Xchat::hook_command("spam", \&music_hook); 

sub music_hook 
{ 
my $fh = IO::File->new($SONG_FILE); 
die "Can't open $SONG_FILE" unless defined $fh; 
my $title = <$fh>; # read a line from the text file 
my $song = <$fh>; 
$fh->close(); 
chomp $title;
Xchat::command("say $title"); 
}