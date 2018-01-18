use LWP::UserAgent;
system('clear');
system('cls');
system('color 5');
print qq(

Enter [CTRL+C] For Exit :0\n);
print qq(
Enter Usernames File :
> );
$usernames=<STDIN>;
chomp($usernames);
open (USERFILE, "<$usernames") || die "[-] Can't Found ($usernames) !";
@USERS = <USERFILE>;
close USERFILE;

system('clear');
system('cls');


print "\nUsernames: ($usernames)\n\n--------\nCracking Now !..\n";
######################

	foreach $username (@USERS) {
	chomp $username;
		#####################3
		$snapchat = LWP::UserAgent->new();
		$snapchat->default_header('Host' => 'app.snapchat.com');
		$snapchat->default_header('Accept-Locale' => 'ar_SA@calendar=gregorian');
		$snapchat->default_header('X-Snapchat-UUID' => '83EACD5E-6659-49E0-90C6-27855080E895');
		$snapchat->default_header('Accept-Encoding' => 'gzip');
		$snapchat->default_header('X-Snapchat-Client-Auth-Token' => 'v8:06BC10CB533052FED10E409A14DC095F:7BC7D40FFB149B4D6497E8AEA3DAC9CD4C44AE23D0C2E6057E95CBEE372E699A472D18A7A326A4EE2405B2A8A12D762012E503719C382AA3F29E3A5BDF4032A03BF6670B1144F72765F79F2B6474A3EFF8F1F63E057F540146FE9FB116B8C5A25639C7790FF7AEDF487728EA0827FEA36DA86902E918F031816C5451C0907393806CDC94DC0E70E5D02BD4A8470E86A858919AA2BC898B96369C28851B9C86B4CE126676A79D6137A1823D07E28605D6AE5C5C0DD37E31D197FB839E5CC4E6914FCE4A17A2F7C4D511DDABCE2666F0E7AFF95F6531BE578E0FADF223CB8D972653E9E6BD6A93751A');
		$snapchat->default_header('Accept' => 'application/json');
		$snapchat->default_header('Connection' => 'keep-alive');
		$snapchat->default_header('User-Agent' => 'Snapchat/10.23.10.3 (iPhone5,1; iOS 10.3.3; gzip)');
		$snapchat->default_header('Content-Type' => 'application/x-www-form-urlencoded');
		$snapchat->default_header('Content-Length' => '132');
		$response = $snapchat->post('https://app.snapchat.com/loq/suggest_username_v2',
			{ 
			req_token => '930aaf5000b122d86e1688ecfdaca374eae64d8d19f1ca8e39b41a14ddc51dfb',
			timestamp => '1515531147364',
			requested_username => $username
			}
			);
		$code = $response->status_line();
		if($code=~/200/){
			if($response->content=~/already taken!/){
				print "\n-----\nalready taken -> ($username)\n-----\n";
				sleep(13)
			}
			else
			{
				if($response->content=~/requested_username/){
					print "not taken -> ($username)\n";
				}
				else
				{
					if($response->content=~/requested_username/){
						print "Invalid account -> ($username)\n";
					}
					else
					{
						print $response->content();
						print "\n";
					}
				}
			}
		}
		else
		{
			print "\n-----\nSorry, your ip [Blocked]\nwait to bypass blocked !...\n-----\n";
			sleep(18);
		}
	}

########################################################