my $file = $ARGV[0] or die "Usage: $0 <input>";
open(my $fh, '<', $file) or die "Unable to open '$file' for reading: $!";

read($fh, $raw, 16);
my $t;
my %conv = ('00' => 'T', '01' => 'C', '10' => 'A', '11' => 'G');
for my $template ("N", "V") {

    ($sig, $ver, $cnt, $reserved) = unpack($template.'4', $raw);
    if($sig==0x1A412743) {
        $t = $template;
        last;
    }
}

    for (1 .. $cnt) {
my $name;
        undef($raw);
        # Read size of record name
        read($fh, $raw, 1);
        my $size = unpack('C', $raw);
        read($fh, $name, $size);
        undef($raw);
        # Read and store offset
        read($fh, $raw, 4);
        $names{$name} = unpack($t, $raw);
    }
    
foreach my $name (keys %names) {
    
    my $offset = $names{$name};
    
    seek($fh, $offset, 0);
    read($fh, $dnasize, 4);
    $dnasize = unpack($t, $dnasize);
    read($fh, $nblocks, 4);
    $nblocks = unpack($t, $nblocks);
    
    for(1 .. $nblocks) {
        
        my ($starts, $sizes);
        read($fh, $starts, 4);
        read($fh, $sizes, 4);
        $starts = unpack($t, $starts);
        $sizes = unpack($t, $sizes);
        $nblock{$starts} = $sizes;
        
    }
    
    read($fh, $mblocks, 4);
    $mblocks = unpack($t, $mblocks);
    
    for(1 .. $mblocks) {
        
        my ($starts, $sizes);
        read($fh, $starts, 4);
        read($fh, $sizes, 4);
        $starts = unpack($t, $starts);
        $sizes = unpack($t, $sizes);
        $mblock{$starts} = $sizes;
        
    }
    
    read($fh, $reserved, 4); #reserved
    
    my $read = 0;
    while($read <= $dnasize) {
        
        $read++;
        read($fh, $chunk, 1);
        $chunk = unpack("B8", $chunk);
        $i = 0;
        while($i < length($chunk)) { #perl -le '@a=("01234567890" =~ m{\G(..|.$)}g);print for @a'
            
            my $sub = substr($chunk, $i, 2);
            $i += 2;
            $sequence .= $conv{$sub};
        }
        
    }
    
print $sequence;
    exit;
}