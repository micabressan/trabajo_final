#!/usr/bin/perl
use strict;
use Irssi;
use File::Copy;
use warnings;
use vars qw($VERSION %IRSSI $apikey $channel $botname $botaddr $tmp_dir $watch_dir $log_file $retry $leave_fail @AoH);

$VERSION = "1.6";
%IRSSI = (
    authors     => 'engywook - heavily modified by jctwda - modified by ScarS, dedlee',
    contact     => 'none',
    name        => 'tdl-totv',
    description => 'downloads files from bot announces',
    license     => 'free'
);

## General Notes
#  This script is designed to download .torrent files from the website and place them into a diretory.
#  It is up to you to configure your torrent client to watch that directory for new files and then begin downloading.
#  Below are the general settings that you need to edit, and then the autodl settings.  Each autodl setting can be
#  independently turned on and off as you desire using  /set totv_setting on/off   (more setting info below)
#  All autodownloading can be turned on or off by using   /set totv_dls on    or   /set totv_dls off
#
#  There is also a manual download function based on torrent ID number.  This can be used as a command:
#  /totv_dl <ID>   eg:   /totv_dl 25336    will download torrent # 25336
#
#  One common setting that is used for security, but has changed a few times is the $botaddr variable.  This
#  variable comes from doing a   /whois Titan   .  If the auto-dl stops working out of the blue, check to see if this
#  has changed from what is listed below.   At your own risk, you can also eliminate this setting by commenting out
#  the appropriate if line in the the getdata{} routine and uncommenting the line underneath it.  If you don't know what
#  this means, then you shouldn't be doing it.
#
#  Outside of basic perl and irssi installs, this script relies on wget for downloading the torrents.  Make sure it's installed.

## Edit in your API key, tmp_dir, and watch_dir
$apikey       = "replacethiswithyourapikey"; # your authkey variable retrieved from the rss link
$tmp_dir      = "/home/user/watch/temporary/"; # temp dir for torrent downloading before moving to watchdir
$watch_dir    = "/home/user/watch/totv/"; # your torrentclient watchdir
$log_file     = ""; # path to logfile if you want an output of what happened while retrieving the torrent
$retry        = 3; # number of times to retry to download the torrent
$leave_fail   = 0; # leave the .torrent file in the tmp_dir when it fails (use to read contents to find out why it fails)
                   # this will cause DUPE errors though (and if it does not it means the download failed)
$channel      = "#ToT-Announce";
$botname      = "Titan";
$botaddr      = "42\@Timberwolf.Rhea.titansof.tv";

@AoH = (
## Your individual AutoDL settings.  Options for every setting are listed below, followed by examples of how to use them.
## Every array must have a "setting" and at least one of "filter", "except", or "type"
#    Array style and options:
#    {
#        filter   => "",  # match what to download (case insensitive)
#        except   => "",  # match what to except from download match (case insensitive)
#	 type	  => "",  # season/episode
#	 contain  => "",  # container type: AVI|MKV|VOB|MPEG|MP4|ISO|WMV|TS|M4V|M2TS
#	 codec	  => "",  # codec: XviD|DivX|x264|x264\-Hi10p|h\.264|h264|mpeg2|VC\-1|VC1|WMV
#	 source   => "",  # source: R5|DVDScr|BRRip|CAM|TS|TELESYNC|TC|TELECINE|DSR|PDTV|HDTV|DVDRip|BDRip|DVDR|DVD|BluRay|Blu\-Ray|WEBRip|WEB\-DL|WEB|TVRip|HDDVD|HD\-DVD|Web\-Rip|DVD\-Rip
#        resol    => "",  # resolution: SD|Standard?Def.*|480i|480p|576p|720p|810p|1080p|1080i|PD|Portable Device
#	 origin   => "",  # torrent origin: None|Scene|P2P|Internal|User|Mixed
#        network  => "",  # network:  HBO|AMC|CBS|BBC\ One|NBC|ABS
#        uploader => "",  # uploader: timberwolf|someasshole|otherpunkbitch
#        setting  => ""   # setting used to enable/disable the filter with /set totv_setting ON/OFF
#    },
    { # download everything.  Good for debugging
        filter   => ".*",
	setting	=> "debug"
    },
    { # TV HD Scene All
	except	=> "internal|dubbed|flemish|swedish|german|dutch|nba|nhl|nfl|espn|ncaa|nrl|wlt|fairplay|motogp|wwe|iihf|btn|\\.pl\\.",
	type	=> "episode", 
	contain => "mkv",
	codec	=> "x264",
	source	=> "hdtv",
	resol	=> "720p|1080p",
	origin 	=> "scene",
        setting	=> "hdscene_all"
    },
    { # TV 480p x264 All DL
	except	=> "internal|dubbed|flemish|swedish|german|dutch|nba|nhl|nfl|espn|ncaa|nrl|wlt|fairplay|motogp|wwe|iihf|btn|\\.pl\\.",
	type	=> "episode", 
	contain => "mp4",
	codec	=> "x264",
	source	=> "hdtv|pdtv",
	resol	=> "480p",
	origin 	=> "scene",
        setting	=> "sdscene_all"
    },
    { # TV 720p Scene and P2P Select DL
	filter	=> "^(Castle|American.Odyssey|Mad.Men|Game.Of.Thrones)",
	except	=> "internal",
        type    => "episode",
        contain => "mkv",
        codec   => "x264",
	source	=> "hdtv",
	resol	=> "720p|1080p",
        origin  => "scene|p2p",
	setting	=> "hd_scene_p2p_select"
    },
    { # TV Everything Netflix
        type    => "episode",
        network => "Netflix",
	setting => "netflix_all"
    }
);

#DO NOT EDIT BELOW THIS LINE UNLESS YOU KNOW WHAT YOUR ARE DOING.

$watch_dir .= $watch_dir =~ '/$' ? '' : '/';
$tmp_dir .= $tmp_dir =~ '/$' ? '' : '/';

sub getdata {
    my ($server, $msg, $nick, $address, $target) = @_;
    my $clean = Irssi::strip_codes($msg);
    if (lc($target) eq lc($channel) && lc($nick) eq lc($botname) && lc($address) eq lc($botaddr) && Irssi::settings_get_bool('totv_dls')) {
#        if (lc($target) eq lc($channel) && lc($nick) eq lc($botname) && Irssi::settings_get_bool('totv_dls')) {
	if ($clean =~ /\[ (.*) \] \[(.*) \/ (.*) \/ (.*) \/ (.*) \/ (.*)\] \[ (.*) \] \[ (.*) \] \[ By: (.*) \] \[ (https?:\/\/titansof\.tv\/api\/torrents\/\d{5,}\/download) \]/i) {
            match($1, $2, $3, $4, $5, $6, $7, $8, $9, $10);
        }
    }
}

#   $1 season/episode to filter   $2 contain  $3 codec  $4 source  $5 resolution  $6 origin  $7 rlsname  $8 network  $9 uploader  $10 downloadlink
sub match {
    my ($torrent_season, $torrent_contain, $torrent_codec, $torrent_source, $torrent_resol, $torrent_origin, $torrent_rlsname, $torrent_network, $torrent_uploader, $torrent_link) = @_;
    for my $i ( 0 .. $#AoH ) {
        my ($filter, $except, $type, $contain, $codec, $source, $resol, $origin, $rlsname, $network, $uploader, $link, $setting) = "";
        for my $key (keys %{$AoH[$i]}) {
            if ($key eq "filter") {
                $filter = $AoH[$i]{$key};
            } elsif ($key eq "except") {
                $except = $AoH[$i]{$key};
            } elsif ($key eq "type") {
                $type = $AoH[$i]{$key};
            } elsif ($key eq "contain") {
                $contain = $AoH[$i]{$key};
            } elsif ($key eq "codec") {
                $codec = $AoH[$i]{$key};
            } elsif ($key eq "source") { 
                $source = $AoH[$i]{$key};
            } elsif ($key eq "resol") { 
                $resol = $AoH[$i]{$key};
            } elsif ($key eq "origin") { 
                $origin = $AoH[$i]{$key};
            } elsif ($key eq "network") { 
                $network = $AoH[$i]{$key};
            } elsif ($key eq "uploader") {
                $uploader = $AoH[$i]{$key};
            } elsif ($key eq "setting") {
                $setting = $AoH[$i]{$key};
            }
        }

        # skip null set
        next if (!($type || $except || $filter));

        # skip no setting arrays
        next if (!$setting);

        # skip disabled filters
        next if ($setting && !Irssi::settings_get_bool("totv_" . $setting));
        
        # torrent_season and type not match
        my $torrent_type;
        if ($torrent_season =~ qr/S0?(\d+)E0?(\d+)/i) { $torrent_type = "Episode"; } else { $torrent_type = "Season"; }
        next if ($type && $torrent_type !~ qr/$type/i);

        # torrent_rlsname match except
        next if ($except && $torrent_rlsname =~ qr/$except/i);

	# contain, codec, source, resol, origin, network, uploader
	next if ($contain && $torrent_contain !~ qr/$contain/i);
	next if ($codec && $torrent_codec !~ qr/$codec/i);
	next if ($source && $torrent_source !~ qr/$source/i);
	next if ($resol && $torrent_resol !~ qr/$resol/i);
        next if ($origin && $torrent_origin !~ qr/$origin/i);
	next if ($network && $torrent_network !~ qr/$network/i);

        # torrent_rlsname and filter not match
        next if ($filter && $torrent_rlsname !~ qr/$filter/i);

        # torrent release has an invalid name
        if ($torrent_rlsname =~ /[^A-Za-z0-9\)\(\s_.-]/) {
            print CRAP "ToTV WARNING: invalid char in release ($torrent_rlsname)";
            return;
        }

        my $msg = "[%G$torrent_type/$torrent_resol%n] %W$torrent_rlsname%n";
        download($torrent_rlsname . ".torrent", $torrent_link, $msg, $retry);
        last;
    }
}

sub download {
    my ($torrent, $torrent_link, $msg, $retry) = @_;
    if (-s $tmp_dir . $torrent || -s $watch_dir . $torrent) {
        print CRAP "ToTV DUPE: $msg";
    } else {
        my $opt_log = $log_file ? "-v --append-output='". $log_file . "'" : "-q";
        my $url = $opt_log . " --no-check-certificate -O '" . $tmp_dir . $torrent . "' '" . $torrent_link . "?apikey=" . $apikey . "'";
        system("wget $url &");
        Irssi::timeout_add_once(2000, 'download_check', \@_);
    }
}

sub download_check {
    my @args = @{$_[0]};
    my ($torrent, $torrent_link, $msg, $retry) = @args;
    my $tgrep;
    my $ret = system("ps x | grep wget | grep 'id=$torrent_link' | grep -v grep > /dev/null");

    if ($ret eq 0) {
       Irssi::timeout_add_once(2000, 'download_check', \@args);
       return;
    }

    $ret = 0;
    if (valid_torrent($tmp_dir . $torrent)) {
        $ret = move($tmp_dir . $torrent, $watch_dir . $torrent);
        if (!$ret) {
            print CRAP "ToTV MOVE FAIL: $msg";
            return;
        }
    }

    $msg = ($ret ? "DL: " : "FAIL: ") . $msg;
    print CRAP "ToTV " . $msg;

    if (!$ret) {
        if ($retry > 0) {
            $retry--;
            $args[3] = $retry;
            Irssi::timeout_add_once(10000, 'download_wrap', \@args);
        }
        unlink($tmp_dir . $torrent) if (!$leave_fail);
    }
}

sub download_wrap {
    my ($torrent_name, $torrent_link, $msg, $retry) = @{$_[0]};
    download($torrent_name, $torrent_link, $msg, $retry);
}

sub valid_torrent {
    my ($torrent) = @_;
    my ($fh, $buff);
    my $ret = 0;

    return 0 if (-z $torrent || !-r $torrent);

    open($fh, $torrent);
    read($fh, $buff, 11);
    close($fh) or die "$fh: $!";

    $ret = 1 if ($buff eq "d8:announce");

    return $ret;
}

for my $i ( 0 .. $#AoH ) {
    for my $key (keys %{$AoH[$i]}) {
        if ($key =~ /setting/ && $AoH[$i]{$key}) {
            Irssi::settings_add_bool($IRSSI{'name'}, "totv_" . $AoH[$i]{$key}, 1);
        }
    }
}

sub totv_dl {
	my ($data, $currentserver, $witem) = @_;
        my $msg = "[%GManual DL%n] Torrent No: %W$data%n";
        download($data . ".torrent", "https://titansof.tv/api/torrents/" . $data . "/download", $msg, $retry);
}

Irssi::command_bind("totv_dl", "totv_dl");
Irssi::settings_add_bool($IRSSI{'name'}, 'totv_dls', 1);
Irssi::signal_add("message public", \&getdata);