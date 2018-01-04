#!/usr/bin/perl
#
use strict;
use warnings;
use utf8;

my $prod_bin = "/usr/bin/gedit";
my $user = "strorin";
my $timeout = 2;
my $command_prefix = "su $user -c 'export DISPLAY=:0.0 &&";

# exec product
system("$command_prefix $prod_bin 2> /dev/null &'");
sleep 1;
my $pid_str = `ps waux|grep "$prod_bin"|egrep -v "grep|bash"`;

# get pid
my ($pid) = ($pid_str =~ /$user\s+(\d+)/);
print "PID: $pid\n";

# get wid
my $prod_wids = `$command_prefix xdotool search --all --pid $pid'`; # shoud return two windows id
my $prod_wid;
foreach my $wid (split (/\n/, $prod_wids)) {
    next if (not defined $wid or $wid !~ /^\d+$/);

    # Get position
    my $prod_pos = `$command_prefix xdotool getwindowgeometry $wid'`;
    if ($prod_pos =~ /Geometry:\s+(\d+).(\d+)/) { # this is wrong window
        next if ($1 < 100 and $2 < 100);
    }
    $prod_wid = $wid;
}
print "WID: $prod_wid\n";

# Move to 0x0 position
system ("$command_prefix xdotool windowmove $prod_wid 0 0'");
# Set active
system ("$command_prefix xdotool windowactivate --sync $prod_wid'");


my $typed_text = <<endt;


########  #### ######## ########    ##     ## ##    ##     ######  ##     ## #### ##    ## ##    ##    
##     ##  ##     ##    ##          ###   ###  ##  ##     ##    ## ##     ##  ##  ###   ##  ##  ##     
##     ##  ##     ##    ##          #### ####   ####      ##       ##     ##  ##  ####  ##   ####      
########   ##     ##    ######      ## ### ##    ##        ######  #########  ##  ## ## ##    ##       
##     ##  ##     ##    ##          ##     ##    ##             ## ##     ##  ##  ##  ####    ##       
##     ##  ##     ##    ##          ##     ##    ##       ##    ## ##     ##  ##  ##   ###    ##       
########  ####    ##    ########    ##     ##    ##        ######  ##     ## #### ##    ##    ##       


		##     ## ######## ########    ###    ##             ###     ######   ######  
		###   ### ##          ##      ## ##   ##            ## ##   ##    ## ##    ## 
		#### #### ##          ##     ##   ##  ##           ##   ##  ##       ##       
		## ### ## ######      ##    ##     ## ##          ##     ##  ######   ######  
		##     ## ##          ##    ######### ##          #########       ##       ## 
		##     ## ##          ##    ##     ## ##          ##     ## ##    ## ##    ## 
		##     ## ########    ##    ##     ## ########    ##     ##  ######   ######  


endt

foreach my $line (split /\n/, $typed_text) {
    system ("$command_prefix xdotool key Return type \"$line\"'");
}

sleep 8;

# save file
system ("$command_prefix xdotool key --delay 250 alt+F4 Return'");
sleep 2;
my $doc_name = "test";
system ("$command_prefix xdotool type $doc_name'");
sleep 5;
system ("$command_prefix xdotool key --delay 250 Return'");

# close product after saving
sleep 2;
system ("$command_prefix xdotool key --delay 250 alt+F4'");




#open file 
my $text = `cat $doc_name`;
#delete file after getting text
system ("rm $doc_name");


if ("$text" == "$typed_text"){
    exit 0;
}
else {
    exit 1;
}