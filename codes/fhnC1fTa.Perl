#!/usr/bin/perl -w

my $lastquot = '';
while(<>) {
	$quot = /<(.*)> (.*)/;
	$quot = $1;
	$line = $2;
	if($lastquot ne $quot) {
		print "»\n" if($lastquot);
		print "$quot: «";
		$lastquot = $quot;
	} else {
		print "\n";
	}

	$line =~ s/a'/à/g;
	$line =~ s/e'/è/g;
	$line =~ s/i'/ì/g;
	$line =~ s/o'/ò/g;
	$line =~ s/u'/ù/g;
	$line =~ s/\.\.\./…/g;
	print $line;
}
print "»\n";