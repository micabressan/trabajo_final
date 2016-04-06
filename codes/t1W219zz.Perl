#!perl
## Author:: vkwasinski at gmail
### Parse a FileZila Xml Dump and solve the base64 passwords
############################################################

use Tie::File 	 qw | tie |;
use MIME::Base64 qw | decode_base64 |;
use Data::Dumper qw | Dumper |;
use utf8;

my $filename = defined $ARGV[0]? $ARGV[0]: undef;
die 'Missing [filename] param... aborting!'."\n"  if not defined $filename;

my @xmlFile = ();
tie @xmlFile, 'Tie::File', $filename  or die 'Could not open '.$filename.' ... aborting due to '.$!." \n";
local $/;

map {
    m{"base64">([\w!"#\$\%\&'()*+,./:;<=>?@\\^_`{|}~-]+)</}i  if defined;
    my $base64decoded = decode_base64($1)  if defined $1;
    s{"base64">[\w!"#\$\%\&'()*+,./:;<=>?@\\^_`{|}~-]+</}{"base64">$base64decoded</}i
 } @xmlFile;

print 'Done!'."\n";

__DATA__

node example:

 <Server>
    <Host>someHost</Host>
    <Port>21</Port>
    <Protocol>0</Protocol>
    <Type>0</Type>
    <User>someuser</User>
    <Pass encoding="base64">ckBmQDNs</Pass>
    <Logontype>1</Logontype>
    <TimezoneOffset>0</TimezoneOffset>
    <PasvMode>MODE_DEFAULT</PasvMode>
    <MaximumMultipleConnections>0</MaximumMultipleConnections>
    <EncodingType>Auto</EncodingType>
    <BypassProxy>0</BypassProxy>
    <Name>WhateverName</Name>
    <Comments />
    <LocalDir />
    <RemoteDir />
    <SyncBrowsing>0</SyncBrowsing>
</Server>