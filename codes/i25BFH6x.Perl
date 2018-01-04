#!/usr/bin/perl

use MP3::Info;
use Term::ANSIColor;
use strict;

print("[dir_name]> ");
my $dir = <>;

substr($dir, -1) = "";
chdir($dir) or die "Changing directory error\n";

my @files = glob($dir."*.mp3") or die "Directory does not exist\n";

#shift(@files);

foreach(@files)
{
	print color("bold red");
	print "FILE: ";
	print color('bold green');
	print $_."\n";
}
print color('reset');

print "[file_name]> ";
my $file = <>;
chomp($file);

my $fileinfo = new MP3::Info $file;

my ($name, $time, $genre) = ($fileinfo->title, $fileinfo->time,
							$fileinfo->genre);
my ($bitrate, $freq) = ($fileinfo->bitrate, $fileinfo->frequency);

my ($alb, $year, $artist) = ($fileinfo->album, $fileinfo->year,
							$fileinfo->artist);

print "-----------\n";
printf("Name: %s\n", $name) if $name ne ""; 
printf("Genre: %s\n", $genre) if $genre ne "";
printf("Artist: %s\n", $artist) if $artist ne "";
printf("Album: %s\n", $alb) if $alb ne "";
printf("Year: %s\n", $year) if $year ne "";

printf("Time: %s\n", $time) if $time ne "";
printf("Bitrate: %s kbps\n", $bitrate) if $bitrate ne "";
printf("Frequency: %s kHz\n", $freq) if $freq ne "";