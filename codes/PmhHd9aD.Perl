sub auth{
	my $val=shift;
	my @tt2=(63006, 9570, 49216, 45888, 9822, 23121, 59830, 51114, 54831, 4189, 580, 5203, 42174, 59972, 55457, 59009, 59347, 64456, 8673, 52710, 49975, 2006, 62677, 3463, 17754, 5357);
	my @sLog=split(/\-/,$val);
	if((@sLog!=2)or(length($sLog[0])!=8)or(length($sLog[1])!=8)){return $val;}
	my $local4=int("2".substr($sLog[0],2,6)) % ((13-int(substr($sLog[0],7,1)))-1);
	return(($sLog[0]."-".sprintf("%.4x", ($tt2[($local4*2)])^hex(substr($sLog[1],0,4)))).sprintf("%.4x", ($tt2[($local4*2)+1])^hex(substr($sLog[1],4,4))))
}