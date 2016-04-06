#!/usr/bin/perl

use v5.16;
use warnings;

use DB_File;
use Getopt::Long;
use Pod::Usage;
use List::MoreUtils qw(zip);
use Text::CSV;
use Path::Tiny qw(path);
use Sereal::Encoder qw(encode_sereal);
use Sereal::Decoder qw(decode_sereal);
use Data::Printer;
use Data::Dumper;

=head1 NAME

hk.pl

=head1 SYNOPSIS

hk.pl <hashes...>

=head1 OPTIONS

 --db_file=<db>     Database file (default:~/.hk.db)
 --help             Print help
 --ingest=<dir>     Ingest hashkeeper set in specified directory           
 --verbose          Verbose output

=cut

my %opts = ( db_file => "$ENV{HOME}/.hk.db");

GetOptions(\%opts,
    'db_file=s',
    'ingest=s',
    'help',
    'verbose',
) or pod2usage(3); 

pod2usage(0) if $opts{help};

my %db;

if($opts{ingest}) {
    path($opts{db_file})->remove if path($opts{db_file})->exists;

    my $btree = DB_File::BTREEINFO->new;
    $btree->{cachesize} = 1024**3;

    tie %db,'DB_File',$opts{db_file},O_CREAT|O_RDWR,0666,$btree or die "Error: Could not tie $opts{db_file}:$!";
    my $in_dir = path($opts{ingest});
    die "Error: $in_dir is not a directory" unless $in_dir->is_dir;
    my $hke = ($in_dir->children(qr/\.hke$/))[0];
    die "Error: No hke file found in $in_dir" unless $hke;

    my @hsh = $in_dir->children(qr/\.hsh$/);
    die "Error: No hsh files found in $in_dir" unless @hsh;

    say STDERR "Info: Ingesting $hke" if $opts{verbose};
    open my $hke_fh,"<",$hke or die "Error: Could not open $hke:$!";

    my $csv = Text::CSV->new({binary => 1});
    my $cols = $csv->getline($hke_fh);
    $csv->column_names(@$cols);
    while(my $rec = $csv->getline_hr($hke_fh)) {
        $db{"hashset:$rec->{hashset_id}"} = encode_sereal($rec);
    }

    close $hke_fh;

    foreach my $hash_set (@hsh) {
        say STDERR "Info: Ingesting $hash_set" if $opts{verbose};
        my $count = 0;
        open my $hsh_fh,"<",$hash_set or die "Error: Could not open $hash_set: $!";

        my $size = -s $hash_set;

        $cols = $csv->getline($hsh_fh);
        $csv->column_names(@$cols);

        while(my $rec = $csv->getline_hr($hsh_fh)) {
            if($opts{verbose}) {
                $count++;
                if($count % 1000 == 0) {
                    my $percent = tell($hsh_fh) / $size * 100;
                    printf STDERR "$count (%.2f%%)\r",$percent;
                }
            }
            my $hash = $rec->{hash};
            my $hs_id = $rec->{hashset_id};
            warn "Warning: No hash for record" . p $rec and next unless $hash;
            $hash = dehexlify($hash);

            my $sets = exists $db{"hash:$hash"} ?  decode_sereal($db{"hash:$hash"}) : []; 
            push @{$sets},$hs_id;
            $db{"hash:$hash"} = encode_sereal($sets);
        }

        print "\n" if $opts{verbose};
        
        close $hsh_fh;
    }
} else { 
    pod2usage(2) unless @ARGV;
}

untie %db;

sub dehexlify {
    my $hex = shift;
    return pack 'H*',$hex;
}

sub hexlify {
    my $bytes = shift;
    return (unpack 'H*',$bytes)[0];
}