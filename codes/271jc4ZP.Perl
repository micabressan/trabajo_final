#!/usr/bin/perl
use Device::SerialPort qw( :PARAM :STAT 0.07 );
use warnings;
use strict;


my $port=Device::SerialPort->new("/dev/ttyS1");
$port->write(1);
$port->pulse_dtr_on(1000);