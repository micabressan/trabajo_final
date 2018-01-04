	open(IN, "iptables -nxvL OUTPUT |");
	while(<IN>) {
		for($n = 0; $n < $PORT_MAX; $n++) {
			$out[$n] = 0 unless $out[$n];
			if(/ MONITORIX_OUT_$n /) {
				my (undef, $bytes) = split(' ', $_);
				$bytes = chomp($bytes);
				$out[$n] = $bytes;
			}
		}
	}
	close(IN);