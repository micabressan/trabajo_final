#!/usr/bin/perl
use strict;
use warnings;
use feature qw(say);

#my @devices = (
	#"null",
	#"default",
	#"plughw:HDMI,3"
#);
my @devices = (
	"default"
);
my @rates = (
	"48000"
);
my @formats = (
	'S8',
	'U8',
	'S16_LE',
	'S16_BE',
	'U16_LE',
	'U16_BE',
	'S24_LE',
	'S24_BE',
	'U24_LE',
	'U24_BE',
	'S32_LE',
	'S32_BE',
	'U32_LE',
	'U32_BE',
	'FLOAT_LE',
	'FLOAT_BE',
	'FLOAT64_LE',
	'FLOAT64_BE',
	'IEC958_SUBFRAME_LE IEC958_SUBFRAME_BE',
	'MU_LAW',
	'A_LAW',
	'IMA_ADPCM',
	'MPEG GSM',
	'SPECIAL',
	'S24_3LE',
	'S24_3BE',
	'U24_3LE',
	'U24_3BE',
	'S20_3LE',
	'S20_3BE',
	'U20_3LE',
	'U20_3BE',
	'S18_3LE',
	'S18_3BE',
	'U18_3LE',
	'U18_3BE',
	'G723_24',
	'G723_24_1B',
	'G723_40',
	'G723_40_1B',
	'DSD_U8',
	'DSD_U16_LE'
);
foreach my $device (@devices) {
	say "device=$device";
	foreach my $rate (@rates) {
		say "\trate=$rate";
		foreach my $format (@formats) {
			say "\t\tformat='$format'";
			my $cmd = "aplay";
			$cmd .= " --duration=1";
			$cmd .= " --channels=2";
			$cmd .= " --dump-hw-params";
			$cmd .= " --device=$device";
			$cmd .= " --rate=$rate";
			$cmd .= " --format=$format";
			$cmd .= " /dev/zero";
			$cmd .= " 2>&1";
			my $data = `$cmd`;
			my @data = split(/\n/, $data);
			say "\t\t\t@data[0]";
			`sleep 2s`;
		}
	}
}