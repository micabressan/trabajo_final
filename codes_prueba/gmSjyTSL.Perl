#!/usr/bin/perl -w
 
 @files = <*>;
 foreach $file (@files) {
   if($file =~ m/OUT.run\d{4}){
	   $newfile =~ s/(OUT.run\d{4})/$1.pdb;
	    rename($filename, $newfile) || print "Don't have permission to rename.<br><br>";
    }
   print $file . "\n";
 }