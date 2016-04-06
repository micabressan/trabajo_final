#!/usr/bin/perl

 ~ c0d3d by Kro0oz ~ 

use LWP::UserAgent;
use HTTP::Request::Common qw(GET);
$ag = LWP::UserAgent->new();
$ag->agent("Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801");
$ag->timeout(10);

chomp(my $dork = $ARGV[0]);
system "Title searching = $*******************************";
for ($i = 1; $i <= 10000; $i+=10){
$url = "http://www.bing.com/************************************************&filt=all&first=$i&FORM=PERE";
$resp = $ag->request(HTTP::Request->new(GET => $url));
$rrs = $resp->content;

while($rrs =~ m/<a href=\"?http:\/\/(.*?)\//g){
$link = $1;
if ( $link !~ /overture|msn|live|bing|yahoo|duckduckgo|google|yahoo|microsof/){
if ($link !~ /^http:/){$link = 'http://' . "$link" . '/';}
if($link !~ /\"|\?|\=|index\.php/){
print "\n\t $link";
push(@resul,$link);}} }

while($rrs =~ m/<a href=\"?http:\/\/(.*?[\/].*?)\//g){
$link = $1;
if ( $link !~ /overture|msn|live|bing|yahoo|duckduckgo|google|yahoo|microsof/){
if ($link !~ /^http:/){$link = 'http://' . "$link" . '/';}
if($link !~ /\"|\?|\=|index\.php/){
print "\n\t $link";
push(@resul,$link);}} }

if ($rrs !~ m/class=\"sb_pagN\"/g){
$total = $#resul+1;
open(TXTS,"<targets.txt"); chomp(@ar = <TXTS>); close(TXTS); push(@resul,@ar);
open (TXT,">targets.txt");
foreach(@resul){$c{$_}++;next if $c{$_} > 1;print TXT "$_\n";push(@arq,$_);}
close(TXT);
$arq=$#arq+1;
print "\n\n Total Result $total , total in file $arq\n"; exit; }
}