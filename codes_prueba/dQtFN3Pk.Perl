#Does not save ACL...

my $stateFile = $ARGV[0];
 print "$stateFile\n" ;

open(STATE_IN, "<$stateFile");

foreach $line (<STATE_IN>)
{
  chomp($line);

  my ($inode, $size, $permissions, $uid, $gid, $file) = split(':', $line, 6);
#print "$file\n";
  if( ! -f "$file" || -f "$file" )
  {
#    print "Megvan $file";
    #add inode / size check here if desired
    chmod(oct($permissions), $file);
#    print "PARANCS:$file, $permissions\n";
    chown($uid, $gid, $file);
  }
}

close(STATE_IN);