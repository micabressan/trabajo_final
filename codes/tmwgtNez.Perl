  1 # code for part 3
  2
  3 print "Please type the file path\n";
  4
  5 $i  np <>;
  6 #get user input of file path
  7
  8 $pathv = $inp;
  9 #sets filepath
 10
 11
 12 $FILE=$pathv;
 13 open (FILE);
 14 @p3arr = <FILE>;
 15 close (FILE);
 16 #opens the file and puts each line into an array
 17
 18
 19 $count = @p3arr;
 20
 21 #sets a counter to the number of items in the array
 22
 23 for ($i = 0; $i <= $count; $i++) {
 24     $_ = @p3arr[$i];
 25     print $_;
 26     if (/^[ACGT]+$/) {
 27         print $_ + " valid\n";
 28     }
 29     else {
 30         print $_ + " invalid\n";
 31     }
 32 }
 33 #for ($i = 0 ; $i <= $count ; $i++) {
 34 #    if (@p3arr[$i] eq /^[ACGT]+$/) {
 35 #        print @p3arr[$i];
 36 #    }
 37 #    else {
 38 #        print "Invalid String\n";
 39 #    }
 40 #}