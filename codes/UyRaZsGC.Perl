#!/usr/bin/perl
use strict;
use warnings;

use Net::PcapUtils;
use NetPacket::Ethernet qw(:strip);
use NetPacket::IP;
use NetPacket::TCP;
use HTML::TokeParser::Simple;
use Term::ANSIColor qw(:constants);
use Term::ANSIColor;
use HTML::LinkExtor;
use Getopt::Std;
use Encode qw(decode encode);
use Regexp::Common qw( net number );
use Socket;
use Time::HiRes qw(time);
use POSIX qw(strftime);

use vars qw/ $opt_h /;
getopts('h');

if ($opt_h) {
print q/
	   	   -h Usage.
			Catches HTTP iframes. [Prints all of them]
			Change Accept-Encoding of your browser to "."
			
			Remember to edit your sniffing interface at
			line 36. ( DEV => 'enp0s31f6' )
/;
exit(0);
}

$|=1;

# main packet capture loop
Net::PcapUtils::loop(\&process_pkt, Promisc => 0, FILTER => 'tcp', DEV => 'enp0s31f6', SNAPLEN => '1500');

use vars qw/ $ip $data $length $srcport $dstport $ipsrc $ipdst /;

sub process_pkt {
	
	my ($user, $hdr, $pkt) = @_;
	
	# decode TCP/IP packets
	my $ip = NetPacket::IP->decode(eth_strip($pkt));
	my $tcp = NetPacket::TCP->decode($ip->{data});
	
	# capture http traffic only.
	if (($tcp->{src_port} == 80) or ($tcp->{dest_port} == 80)) {
	
		my $dstport	= ($tcp->{dest_port});
		my $srcport	= ($tcp->{src_port});
		my $data	= ($tcp->{data});
		my $ipsrc	= ($ip->{src_ip});
		my $ipdst	= ($ip->{dest_ip});
		my $length	= ($ip->{len});

		$data =~ s/[\x01-\x08\x0B-\x1F\x7F-\x80]//gs;  # filter data so it doesn't mess up our terminal. (ansi escape codes do that)
		#$data =~ s/[\x00-\x08\x0B-\x1F\x7F-\xFF]//gs; # removes \n \t et cetera.
		#$data =~ s/[\x00-\x1F\x7F-\xFF]//gs;
		
		$data = decode("iso-8859-1", $data);
		iframe_check($data, $dstport, $srcport, $length, $ipsrc, $ipdst);
	}
}

# syntax highlight for html
sub source_check
{

my $html = $_[0];
my $ignore =0;

my $p = HTML::TokeParser::Simple->new(string => $html);

    while ( my $token = $p->get_token ) {
        if ( $token->is_start_tag ) {
            my $element = $token->[1];
            my @attrs = @{$token->[3]};
            # print Dumper( @attr ),qq(\n\n);                                   
            print qq(<),colored($element,'magenta');
            foreach my $attr ( @attrs ) {
                if ( $attr ne '/' && $attr ne 'script' ) {
                    print qq( ),colored($attr, 'cyan');
                    if ( defined (  $token->[2]{$attr} ) ) {
                        print qq(="),colored($token->[2]{$attr},'green'),qq(");
                    }
                } else {
                    print qq( $attr);
                }
            }
            print qq(>);

        } elsif ( $token->is_text ) {
            print colored($token->[1],'white');

        } elsif ( $token->is_end_tag ) {
            print qq(</),colored( $token->[1],'magenta'),qq(>);

        } elsif ( $token->is_comment ) {
            print colored( $token->[1],'white');

        } elsif ( $token->is_declaration ) {
            print colored( $token->[1],'bright_white');

        } else
        {
            #Everything excluding scripts falls here handle as appropriate      
            next unless $token->is_text;
            print $token->as_is;
        }
    }
}

# check for iframes.
sub iframe_check
{
my $data 	= $_[0];
my $dstport = $_[1];
my $srcport = $_[2];
my $length 	= $_[3];
my $ipsrc	= $_[4];
my $ipdst	= $_[5];

my $p = HTML::LinkExtor->new;

$p->parse($data);
my @p = $p->links;
	
	for (@p) {
		(my $t, my %attr) = @$_;
		my $u = "@$_";
		if($u =~ /^iframe/gi) {

			# The minimum TCP header size is 20 bytes and the minimum IPv4 header
			# size is 20 bytes. So a TCP/IPv4 packet containing 0 byte of data
			# would be at the minimum 40 bytes assuming you can actually send 0 byte
			# over TCP, which you can't. So, the minimum would be 41 bytes.

			if($dstport == 80 && $length >= 41) {

				print "\n", "-" x 238;
				print GREEN, $ipsrc, RESET, WHITE, ':', $srcport, RESET, ' --> ', RED, $ipdst, RESET, WHITE, ':', $dstport, RESET;
				print " BYTES: ", WHITE, $length, RESET, "\n\n";
				printer("$u", "bold white on_red");
				
				source_check($data);
				
				print "\n";
				ip_check($ipdst);
				print "-" x 238;
			}
			
			elsif($srcport == 80 && $length >= 41) {

				print "\n", "=" x 238;
				print RED, $ipsrc, RESET, WHITE, ":", $srcport, RESET, " =-> ", GREEN, $ipdst, RESET, WHITE, ":", $dstport, RESET;
				print " BYTES: ", WHITE, $length, RESET, "\n";
				print "\n", "=" x 238;
				printer("$u", "bold white on_red");
				
				source_check($data);

				print "\n";
				ip_check($ipsrc);
				print "=" x 238;
			}
			else {
			
				print "something went wrong", "\n";
			}
		}
	}
}

# use dig or host to resolve ip address/hostname.
sub ip_check
{

my $server_ip = $_[0];

use vars qw/ $server_ip $DIG $HOST $hostname /;

	if ( $server_ip !~ m/$RE{net}{IPv4}/ ){
		my $addr = (gethostbyname($server_ip))[4];
		sleep(2);
		my ($a,$b,$c,$d) = unpack('C4',$addr);
		print "$a.$b.$c.$d\n";
	}
	else {
	
		if ( $server_ip =~ m/$RE{net}{IPv4}/ ){
			open($DIG, "/usr/bin/dig $server_ip +short|") or die "cant open dig:$!\n";
			sleep(2);
	
			$hostname = <$DIG>;
			close($DIG) or die "cant close dig:$!\n";

			if (defined($hostname)) {
				$hostname =~ s/\n$//g;
		
				print "\n", "Server hosting the iframe : ";
				print "$server_ip \[$hostname\]\n";

			}
			else {
		
				print "\n", "Server hosting the iframe : ";
				print "$server_ip \[Couldn\'t resolve\]\n";
			}	
		}
	}
}
# prettify output
sub printer
{

my $u		= $_[0];	# url
my $uc		= $_[1];	# color for url
my $r		= $_[2];	# rule
my $rc		= $_[3];	# color for rule
my $desc	= $_[4];	# description of the rule
my $time	= get_time();	# time
my $count	= length($u);	# string length

	if ($count >= 204) {
		my $pad = (240);
		
		if (not defined($desc)) {
			$desc = "Found Iframe with the following src :";
		}
		print "\n", colored ("$desc", "white");
		print "\n", colored ("$u", "$uc");
		print GREEN, $time, RESET, "\n";
	}
	elsif ($count <= 203) {
		my $pad = (215 - $count);

		if (not defined($desc)) {
			$desc = "Found Iframe with the following src :";
		}
		print colored ("$desc", "white");
		print "\n", colored ("$u", "$uc");
		print GREEN, " " x $pad, $time, RESET, "\n\n";
	}
}

sub get_time
{
my $t = time;
my $date = strftime "%Y.%m.%d %H:%M:%S", localtime $t;
$date .= sprintf ".%03d", ($t-int($t))*1000;
}