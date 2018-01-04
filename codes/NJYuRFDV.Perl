#!/usr/bin/env perl

use strict;
use warnings;

use Crypt::PK::ECC;
use Crypt::RIPEMD160;
use Digest::SHA qw(sha256);
use String::CRC32;
use v5.14;

use bigint;
use integer;

sub key2wif()
{
    my $ver = shift;
    my $src = shift;
    my $sum = substr sha256(sha256($ver.$src)), 0, 4;
    return encode_base58(hex(unpack("H*","$ver$src$sum")));
}

sub pub2addr()
{
    my $pub = shift;
    my $hash= chr(0).Crypt::RIPEMD160->hash(sha256($pub));
    my $sum = substr sha256(sha256($hash)), 0, 4;
    my $dst = encode_base58(hex(unpack("H*","$hash$sum")));
    return '1'x(34-length($dst)) . $dst;
}

sub encode_base58()
{
    my $val = shift;
    my $dst = '';
    my @b58 = split '', "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";
    # 
    while( $val > 0 ){
    $dst = $b58[$val%58] . $dst;
    $val = int($val/58);
    }
    return $dst;
}

    my $pk = Crypt::PK::ECC->new();
    $pk->generate_key('secp256k1');

    my $pri = $pk->export_key_raw('private');
    my $pub = $pk->export_key_raw('public');
    print &pub2addr( $pub ).' '.&key2wif( chr(0x80), $pri )."\n";