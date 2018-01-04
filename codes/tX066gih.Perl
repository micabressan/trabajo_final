#!/usr/bin/perl

my $message = $ARGV[0];
my $message_type = $ARGV[1];

my $serial_port_to_use = "COM1";


($second, $minute, $hour, $dayOfMonth, $month, $yearOffset, $dayOfWeek, $dayOfYear, $daylightSavings) = localtime();
if(length($minute) < 2){
	$minute = "0" . $minute;
}
my $theTime = "$hour:$minute";



#BETABRITE VARIABLES



	my $NUL            = "\0\0\0\0\0\0";       # NUL - Sending 6 nulls for wake up sign and set baud neg.
	my $SOH            = "\x01";               # SOH - Start of header
	my $TYPE           = "Z";                       # Type Code - Z = All signs. See Protocol doc for more info
	my $SIGN_ADDR      = "00";                      # Sign Address - 00 = broadcast, 01 = sign address 1, etc
	my $STX            = "\x02";               # STX - Start of Text character
	# Theise are other useful variables
	my $ETX            = "\x03";            # End of TeXt
	my $ESC            = "\x1b";            # Escape character
	my $EOT            = "\004";            # End of transmission
	# We group some of the variables above to make life easy.
	# This leaves us 2 type of init strings we can add to the front of our frame.
	my $INIT="$NUL$SOH$TYPE$SIGN_ADDR$STX";         # Most used.
	my $INIT_NOSTX="$NUL$SOH$TYPE$SIGN_ADDR";               # Used for nested messages.
	###
	my $WRITE ="A"; # Write TEXT file
	###
	my $LABEL = "A"; #File A
	###
	my $DPOS=" "; # Leave as a space for BetaBrite one line sign
	###
	my $ROTATE ="A"; # Message travels right to left.
	my $COMPRESSED ="t"; # Skinny letters that rotate as above
	my $HOLD ="b"; # Message remains stationary.
	my $FLASH ="c"; # Message remains stationary and flashes

	### COLORS
	my $RED = chr(28) . "1";
	my $GREEN = chr(28) . "2";
	my $YELLOW = chr(28) . "3";
	my $RED_DIM = chr(28) . "4";
	my $GREEN_DIM = chr(28) . "5";
	my $YELLOW_DIM = chr(28) . "6";
	my $ORANGE = chr(28) . "7";
	my $YELLOW_LIGHT = chr(28) . "8";
	my $RAINBOW = chr(28) . "9";
	my $RAINBOW_MOVING = chr(28) . "A";
	my $RAINBOW_FADE = chr(28) . "B";
	my $RAINBOW_CYCLE = chr(28) . "C";

	###

$message =~ s/\[G\]/$GREEN/gi;
$message =~ s/\[GD\]/$GREEN_DIM/gi;
$message =~ s/\[R\]/$RED/gi;
$message =~ s/\[RD\]/$RED_DIM/gi;
$message =~ s/\[Y\]/$YELLOW/gi;
$message =~ s/\[YD\]/$YELLOW_DIM/gi;
$message =~ s/\[YL\]/$YELLOW_LIGHT/gi;
$message =~ s/\[O\]/$ORANGE/gi;
$message =~ s/\[R1\]/$RAINBOW/gi;
$message =~ s/\[R2\]/$RAINBOW_MOVING/gi;
$message =~ s/\[R3\]/$RAINBOW_FADE/gi;
$message =~ s/\[R4\]/$RAINBOW_CYCLE/gi;

$message =~ s/\[T\]/$theTime/gi;





	open(BETABRITE, ">" . $serial_port_to_use);
	#set a message


####THIS RESETS THE SIGN MEMORY:
####print BETABRITE "$NUL" . "$SOH" . "$TYPE" . "$SIGN_ADDR" .  "$STX" . "E\$" . "$EOT";

####THIS MAKES THE SIGN BEEP:
####print BETABRITE "$NUL" . "$SOH" . "$TYPE" . "$SIGN_ADDR" .  "$STX" . "E(0" . "$EOT";

####Puts up a message

my $MODE = $ROTATE;
if($message_type eq "f"){
	$MODE = $FLASH;
}
if($message_type eq "h"){
	$MODE = $HOLD;
}


print BETABRITE "$INIT" . "AA" . "$ESC" . "$DPOS" . "$MODE" . "$GREEN" . "$message" . "$EOT";





	close(BETABRITE);
#print "Message has been sent to board: " . $message . "\n";