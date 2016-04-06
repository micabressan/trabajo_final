#!/usr/bin/perl
use strict;
use warnings;
use Device::SerialPort;
# set up vars
my $PORT = @ARGV[0];
# Just declare stuff
my $in;


$in = "";
# setup port object
my $ob = Device::SerialPort ->new ($PORT) || die "oops, cannot open port : $PORT - $!\n";
$ob->baudrate(115200);
$ob->parity("none");
$ob->databits(8);
$ob->stopbits(1);
$ob->write_settings;
# continuosly read from serial port
if($ARGV[1] == 0){
	while(1){
		$in = $ob->read(255);
		$in =~ s/ba//g;
		if($in ne ""){
			print $in;
		}
	}
}else{
	for(my $i = 0;$i < $ARGV[0];$i++){
		$in = $ob->read(255);
		$in =~ s/ba//g;
		if($in ne ""){
			print $in;
		}
	}
}