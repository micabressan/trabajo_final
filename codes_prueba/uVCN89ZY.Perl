#!perl -w
# Server2Server irc channel viewer (IRC.SPY)
# version: 2.0.1-stable-upd (irc.antichat.ru<->gw01.ru adapted)
# by motzmo (s7ick.org)

$| = 1;
use strict;
use Encode qw( from_to );
use IO::Socket;
use IO::Select;
my (%cfg,%out_irc,%color,@threads,@userz,$msg,$in_sock,$out_sock,$handle,$readin,$bold,$prop,$clr,$actionsay,$count);
%cfg = (
 OUT_SERVER => 'irc.antichat.ru',
 OUT_PORT => 6667,
 OUT_CHAN => '#antichat',
 OUT_NICK => 'antosha',
 OUT_IDENT => 'grisha',
 OUT_NAME => 'grihuil',
 OUT_ALTNICK => 'antosha['.int(rand(200)).']',
 OUT_CHARSET => 'CP1251',
 #
 IN_SERVER => 'irc.gw01.ru',
 IN_PORT => 6667,
 IN_CHAN => '#bcast.antichat',
 IN_NICK => '[nfo]',
 IN_IDENT => '0x00',
 IN_NAME => 'Informator.',
 IN_CHARSET => 'UTF-8',
 irc_gw_nickserv_possword => 'abcdefg',
 #
 PIDFILE => '.botpid'
);
####################################################################
####################################################################
open TMPFILE, ">".$cfg{PIDFILE};
print TMPFILE $$;
close TMPFILE;
in();out();
$bold = chr 2;
$prop = chr 31;
$clr = chr 3;
$actionsay = chr 1;
%color =
(
 'white'		=> $clr."00",
 'black'		=> $clr."01",
 'blue'			=> $clr."02",
 'green'		=> $clr."03",
 'red'			=> $clr."04",
 'bardoviy'		=> $clr."05",
 'violet'		=> $clr."06",
 'orange'		=> $clr."07",
 'yellow'		=> $clr."08",
 'salad'		=> $clr."09",
 'lightblue'    => $clr."10",
 'blueslight'   => $clr."11",
 'darkblue'		=> $clr."12",
 'rose'			=> $clr."13",
 'gray'			=> $clr."14",
 'graylight'    => $clr."15"
);
$readin = IO::Select->new;
$readin->add($in_sock);
$readin->add($out_sock);

while ()
{
 @threads = $readin->can_read;
 foreach (@threads)
 {
  if ($_ eq $in_sock)
  {
$msg = <$in_sock>;
#		print $msg."\r\n"; #### uncomment for debug
#pingponging
     if($msg =~ /^PING\s([^\r]+)/)
     {
      print $in_sock "PONG $1\r\n";
	  next;
     }
	  elsif ($msg =~ /^\:([^\s\#]+)\!([^\s]+)\@([^\s]+)\s(PRIVMSG|NOTICE)\s([^\s]+)\s\:(.+)\r$/)
      {
       %out_irc =
       (
        "nick" => $1,
        "user" => $2,
        "host" => $3,
        "msgt" => $4,
        "to" => $5,
        "msg" => $6
       );
     if($out_irc{'to'} =~ /^\#.*$/)
      {
       if($out_irc{'msg'} =~ /^\!(.+)/)
        {
	     chan_cmds($1);
        }
		next;
      }
	 }
#end of pingponging
    
   #if()
   #{
#		$in_sock->close;
#		$readin->remove($in_sock);
#	    sleep 8;
  #      in();
#		$readin->add($in_sock);
 #  }
  }
  if ($_ eq $out_sock)
  {
$msg = <$out_sock>;
#	print $msg."\r\n"; #### uncomment for debug
#pingponging
     if($msg =~ /^PING\s([^\r]+)/)
     {
      print $out_sock "PONG $1\r\n";
	  next;
     }
#end of pingponging
     elsif ($msg =~ /^\:([^\s\#]+)\!([^\s]+)\@([^\s]+)\s(PRIVMSG|NOTICE)\s([^\s]+)\s\:(.+)\r$/)
      {
	  ##### MAIN MESSAGES #####
       %out_irc =
       (
        "nick" => $1,
        "user" => $2,
        "host" => $3,
        "msgt" => $4,
        "to" => $5,
        "msg" => $6
       );
     if($out_irc{'to'} =~ /^\#.*$/)
      {
       if($out_irc{'msg'} =~ /^\!(.+)/)
        {
	     #chan_cmds
        }
	   if($out_irc{'msg'} =~ /^\Q$actionsay\EACTION/i)
	   {
       $out_irc{'msg'} =~ s/\Q$actionsay\EACTION//ig;
	   $out_irc{'msg'} =~ s/\Q$actionsay\E//g;
       print $in_sock "PRIVMSG ",$cfg{IN_CHAN}," :",$color{'blue'},"* ",$out_irc{'nick'},$color{'graylight'},$clr,$out_irc{'msg'},"\r\n" if $out_irc{'msgt'} eq "PRIVMSG";
       next;
       }
	   print $in_sock "PRIVMSG ",$cfg{IN_CHAN}," :",$color{'graylight'},"<",$color{'blue'},$out_irc{'nick'},$color{'graylight'},">",$clr,' ',$out_irc{'msg'},"\r\n" if $out_irc{'msgt'} eq "PRIVMSG";
       print $in_sock "PRIVMSG ",$cfg{IN_CHAN}," :",$color{'darkblue'},"-",$color{'rose'},$out_irc{'nick'},"/",$out_irc{'to'},$color{'darkblue'},"-",$clr,' ',$out_irc{'msg'},"\r\n" if $out_irc{'msgt'} eq "NOTICE";
	   next;
      }
     elsif(lc($out_irc{'to'}) eq lc($cfg{OUT_NICK}))
      {
       if($out_irc{'msg'} =~ /\001(VERSION|FINGER|PING .+)\001/)
        {
            print $in_sock "PRIVMSG ",$cfg{IN_CHAN}," :->> CTCP ",$1," from ",$out_irc{'nick'}," [",$out_irc{'user'},"\@",$out_irc{'host'},"]\r\n";
            ctcp_answ ($out_irc{'nick'},$1);
			next;
        }
       print $in_sock "PRIVMSG ",$cfg{IN_CHAN}," :",$bold,"PRIVATE: ",$bold,$color{'graylight'},"<",$color{'blue'},$out_irc{'nick'},$color{'graylight'},">",$clr,' ',$out_irc{'msg'},"\r\n" if $out_irc{'msgt'} eq "PRIVMSG";
       print $in_sock "PRIVMSG ",$cfg{IN_CHAN}," :",$color{'darkblue'},"-",$color{'rose'},$out_irc{'nick'},$color{'darkblue'},"-",$clr,' ',$out_irc{'msg'},"\r\n" if $out_irc{'msgt'} eq "NOTICE";
	   next;
      }
     }
     elsif($msg =~ /^\:([^\s\#]+)\!([^\s]+)\@([^\s]+)\s(JOIN|PART)\s(\:?\#[^\s\:]*)\s?(\:.*)?\r$/i)
     {
	 ##### JOINS/PARTS #####
       %out_irc =
       (
        "nick" => $1,
        "user" => $2,
        "host" => $3,
        "msgt" => lc($4),
	    "to" => $5,
	    "msg" => $6
       );
	   $out_irc{'to'} =~ s/\:// if $out_irc{'to'} =~ ":";
	   $out_irc{'msg'} =~ s/\:// if $out_irc{'msg'};
	   if($out_irc{'msgt'} eq "join")
	    {
		 print $in_sock "PRIVMSG ",$cfg{IN_CHAN}," :",$color{'green'},"* ",$bold,$out_irc{'nick'},$bold, " (",$out_irc{'user'},"\@",$out_irc{'host'},") has joined ",$cfg{OUT_CHAN},"\r\n";
		 #onjoin() if lc($out_irc{'nick'}) ne lc($cfg{OUT_NICK});
		 next;
	    }
	   if ($out_irc{'msgt'} eq "part")
	    {  
		 print $in_sock "PRIVMSG ",$cfg{IN_CHAN}," :",$color{'orange'},"* ",$out_irc{'nick'}," (",$out_irc{'user'},"\@",$out_irc{'host'},") has left ",$cfg{OUT_CHAN},"\r\n";
		 next;
        }
     }
     elsif ($msg =~ /^\:([^\s\#]+)\!([^\s]+)\@([^\s]+)\sNICK\s\:([^\s]+)\r$/)
     {
	 ##### NICK CHANGES #####
	   %out_irc =
       (
        "nick" => $1,
        "user" => $2,
        "host" => $3,
        "newnick" => $4
	   );
	   $cfg{OUT_NICK} = $out_irc{'newnick'} if $out_irc{'nick'} eq $cfg{OUT_NICK};
	   print $in_sock "PRIVMSG ",$cfg{IN_CHAN}," :",$color{'rose'},"*",$clr,' ',$out_irc{'nick'}," is now known as ",$out_irc{'newnick'},"\r\n" if $out_irc{'nick'} ne $cfg{OUT_NICK};
	   next;
	 }
	 elsif ($msg =~ /^\:([^\s\#]+)\!([^\s]+)\@([^\s]+)\sQUIT\s\:(.+)\r$/)
     {
	 ##### QUITS #####
	   %out_irc =
       (
        "nick" => $1,
        "user" => $2,
        "host" => $3,
        "quitmsg" => $4
	   );
	   print $in_sock "PRIVMSG ",$cfg{IN_CHAN}," :",$color{'orange'},"* ",$out_irc{'nick'}," has quit (Quit: ",$out_irc{'quitmsg'},")\r\n";
	   next;
	 }
	 elsif ($msg =~ /^\:([^\s\#]+)\!([^\s]+)\@([^\s]+)\sKICK\s(\#[^\s\:]*)\s([^\s\#]+)\s\:(.+)\r$/)
     {
	 ##### KICKS #####
	   %out_irc =
       (
        "nick" => $1,
        "chan" => $4,
        "target" => $5,
        "reason" => $6
	   );
	   print $in_sock "PRIVMSG ",$cfg{IN_CHAN}," :",$color{'red'},'* ',$out_irc{'nick'},' has kicked ',$out_irc{'target'},' from ',$out_irc{'chan'},' (',$out_irc{'reason'},')',$clr,"\r\n";
	   if($out_irc{'target'} eq $cfg{OUT_NICK}){
	   print $out_sock "JOIN ", $cfg{OUT_CHAN}, "\r\n";
	   print $in_sock "PRIVMSG ",$cfg{IN_CHAN}," :", $bold, "REJOIN...", $bold, "\r\n";
	   }
	   next;
	 }
	 elsif ($msg =~ /^\:([^\s\#]+)\!([^\s]+)\@([^\s]+)\sMODE\s(\#[^\s\:]*)\s([\+\-][^\s])\s?([^\s\#]*)\r$/)
     {
	 ###### MODE CHANGES ######
	   %out_irc =
       (
        "nick" => $1,
        "chan" => $4,
        "mode" => $5,
        "target" => $6
	   );
	   print $in_sock "PRIVMSG ",$cfg{IN_CHAN}," :",$color{'rose'},"*",$clr,' ',$out_irc{'nick'},' sets mode ',$out_irc{'mode'},' ',$out_irc{'chan'},' ',$out_irc{'target'},"\r\n";
	   next;
	 }
    
	#if()
	#{
	#	$out_sock->close;
	#	$readin->remove($out_sock);
	#    sleep 8;
     #   out();
	#	$readin->add($out_sock);
    #}
  }
 }
} # _END_ WHILE LOL
#########################################################//
##################SUBS###################################//
sub out
{
 $out_sock = new IO::Socket::INET
 (
  'PeerAddr' => $cfg{OUT_SERVER},
  'PeerPort' => $cfg{OUT_PORT},
  'Proto' => 'tcp',
  'Timeout' => 15
 );
 print $out_sock "NICK ", $cfg{OUT_NICK}, "\r\n";
 print $out_sock "USER ", $cfg{OUT_IDENT}, " ", $out_sock->sockhost, " ", $cfg{OUT_SERVER}, " :", $cfg{OUT_NAME}, "\r\n";
 while (<$out_sock>)
 {
  if($_ =~ /433/)
  {
    $cfg{OUT_NICK} = $cfg{OUT_ALTNICK};
    print $out_sock "NICK ", $cfg{OUT_NICK}, "\r\n";
    next;
  }
  elsif($_ =~ /^PING\s\:([^\r]+)/)
  {
    print $out_sock "PONG $1\r\n";
    last;
  }
  elsif($_ =~ /^\:.+?\s001\s([^\s\#]+)\s\:/)
  {
    last;
  }
 }
 print $out_sock "USER ", $cfg{OUT_IDENT}, " ", $out_sock->sockhost, " ", $cfg{OUT_SERVER}, " :", $cfg{OUT_NAME}, "\r\n";
 print $out_sock "UMODE2 +x\r\n";
 print $out_sock "JOIN ", $cfg{OUT_CHAN}, "\r\n";
} # _END_ SUB OUT
sub in
{
 $in_sock = new IO::Socket::INET
 (
  'PeerAddr' => $cfg{IN_SERVER},
  'PeerPort' => $cfg{IN_PORT},
  'Proto' => 'tcp',
  'Timeout' => 15
 );
 print $in_sock "NICK ", $cfg{IN_NICK}, "\r\n";
 print $in_sock "USER ", $cfg{IN_IDENT}, " ", $in_sock->sockhost, " ", $cfg{IN_SERVER}, " :", $cfg{IN_NAME}, "\r\n";
 while (<$in_sock>)
 {
 if($_ =~ /433/)
  {
    $cfg{IN_NICK} = $cfg{IN_ALTNICK};
    print $in_sock "NICK ", $cfg{IN_NICK}, "\r\n";
    next;
  }
  elsif($_ =~ /^PING\s\:([^\r]+)/)
  {
    print $in_sock "PONG $1\r\n";
    last;
  }
  elsif($_ =~ /^\:.+?\s001\s([^\s\#]+)\s\:/)
  {
    last;
  }
 }
 print $in_sock "USER ", $cfg{IN_IDENT}, " ", $in_sock->sockhost, " ", $cfg{IN_SERVER}, " :", $cfg{IN_NAME}, "\r\n";
 print $in_sock "NICKSERV IDENTIFY ", $cfg{irc_gw_nickserv_possword}, "\r\n"; ## :)
  print $in_sock "JOIN ", $cfg{IN_CHAN}, "\r\n";
} # _END_ SUB IN
sub ctcp_answ
{
 if($_[1] eq "VERSION")
 {
    print $out_sock "NOTICE ",$_[0]," :",chr 1,"VERSION ",'B.C.D. Community::IRC Client Engine',chr 1,"\r\n";
 }
 elsif($_[1] eq "FINGER")
 {
    print $out_sock "NOTICE ",$_[0]," :",chr 1,"FINGER ",'.!.',chr 1,"\r\n";

 }
 elsif($_[1] =~ /^PING (.+)/)
 {
    print $out_sock "NOTICE ",$_[0]," :",chr 1,"PING $1",chr 1,"\r\n";

 }
} # _END_ CTCPz
sub chan_cmds 
{
 if ($_[0] =~ /^whois\s+([^\s]+)\s*$/i)
 {
  print $out_sock "WHOIS ",$1,"\r\n";
  while(<$out_sock>)
  {
   s/[\r\n]//g;
   if($_ =~ /^\:[^\s]+\s(311|307|319|312|317|318)\s\Q$cfg{OUT_NICK}\E\s(.+)/)
   {
    print $in_sock "PRIVMSG ",$out_irc{'nick'}," :",$2,"\r\n";
	last if $1 == 318;
    next;
   }
   elsif($_ =~ /^PING\s([^\r]+)/)
   {
    print $out_sock "PONG $1\r\n";
   }
  }
 }
 elsif ($_[0] =~ /^list\s*$/i)
 {
  print $out_sock "WHO ",$cfg{OUT_CHAN},"\r\n";
  while(<$out_sock>)
  {
   s/[\r\n]//g;
   if($_ =~ /^\:[^\s]+\s352\s[^\s]+\s[^\s]+\s[^\s]+\s[^\s]+\s[^\s]+\s([^\s]+)\s/)
   {
    push @userz, $1;
   }
   elsif($_ =~ /^\:[^\s]+\s315\s/)
   {
    print $in_sock "PRIVMSG ",$out_irc{'nick'}," :";
    $count = 0;
    foreach (@userz)
	{
	 $count++;
	 print $in_sock $_," [] ";
	 if($count == 5)
	  {
		 $count = 0;
		 print $in_sock "\r\n";
		 print $in_sock "PRIVMSG ",$out_irc{'nick'}," :";
	  }
	}
    print $in_sock "\r\n";
	@userz = ();
	last;
   }
   elsif($_ =~ /^PING\s([^\r]+)/)
   {
    print $out_sock "PONG $1\r\n";
   }
  }
 }
 elsif($_[0] =~ /^say\s+(.+)/i)
 {
 my $messodj = $1;
 from_to( $messodj, $cfg{IN_CHARSET}, $cfg{OUT_CHARSET} );
 print $out_sock "PRIVMSG ",$cfg{OUT_CHAN}," :",$messodj,"\r\n";
 print $in_sock "PRIVMSG ",$cfg{IN_CHAN}," :",$color{'graylight'},"<",$color{'blue'},$cfg{OUT_NICK},$color{'graylight'},">",$clr,' ',$1,"\r\n";
 }
 elsif($_[0] =~ /^sayto\s+([^\s]+)\s+(.+)/i)
 {
 my $messodj = $2;
 from_to( $messodj, $cfg{IN_CHARSET}, $cfg{OUT_CHARSET} );
 print $out_sock "PRIVMSG ",$1," :",$messodj,"\r\n";
 print $in_sock "PRIVMSG ",$cfg{IN_CHAN}," :msg sent to ",$1,"\r\n";
 }
} # _END_ CMDS
unlink $cfg{PIDFILE};
# 2008, B.C.D. World Powered.