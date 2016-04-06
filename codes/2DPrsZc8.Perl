my @array = ("<html>", "<h1>", "<p>");
my %hash;
print "test";
for($i=0;$i< @data;$i++) {
    if($hash{$data[$i]}){
       $hash{$data[$i]}++;
    }else{
        $hash{$data[$i]} = 1;
        }
}
foreach (keys %hash) {
    print " $_ occurs  $hash{$_} times \n";
}