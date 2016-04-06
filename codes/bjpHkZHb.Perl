#!/bin/perl

use strict;
use warnings;

use open qw/:std :encoding(UTF-8)/;
use utf8;

use Data::Dump qw(dump);
use Getopt::Long qw(GetOptions);

Getopt::Long::Configure qw(gnu_getopt);

my($string, $p2f, $out_prefix);

$out_prefix = "Uni";

GetOptions(
	'print-to-file|p' => \$p2f, '<>' => \&out_prefix,
    'transcode-text|t' => \$string, '<>' => \&string,
	'font|f=s' => \&exclude,
	'use|u=s' => \&exclude,
	'help|h' => \&usage,
	) or die "Wrong arguements try $0 -h for help\n";


main();


sub string{

	$string = shift;

}


sub out_prefix{

    $out_prefix = shift;
    
}


sub exclude{

    my $number = @_;
    
    die "Wrong usage: Both font name and font map has been provided. Both can't be used in a single run.\n\n Try $0 -h for help\n" if ($number > 2);
        
    if ($number == 2){
    
        my ($function, $name) = @_;
        
        map_font($name) if ($function eq "font");
        restore_map($name) if ($function eq "use");
    }
}


sub main {
    
    my $output;
	
	die "Either font name or font map file should be provided for the program to function\n" unless (@_);
    
    my $temp = shift;
    my %font_map = %$temp;
	
    my $replacechar = join("|", map(quotemeta, sort { length $b <=> length $a } keys %font_map));
    
    if ($string){
	
        $output = transcode($string, \%font_map, $replacechar); 
		
		output($output);		
    
    }elsif (@ARGV){
    
		my ( %filehandles);
		
		
		foreach (@ARGV){
        
        	if ($_=~ /\*/){
        
            	my @file = <"$_">;
            
            	foreach (@file){
            
                	next if(! -f $_);
            
                	open my $fh, '<', $_ or die "Can't open $_: $!\n";
            
                	$filehandles{$fh} = $out_prefix.$_;
        
				}
        
        	}else {
    
            	my $file = <"$_">;
            
            	next if (! -f $_);
            
				open my $fh, '<', $_ or die "Can't open $_: $!\n";
            
            	$filehandles{$fh} = $out_prefix.$_;
        	}
    
    	}        
        
		foreach (keys %filehandles){
		
			my $fh = $_;
            
            while (<>) {
                
				local $/ = undef;
                $output = transcode($_, \%font_map, $replacechar);
				output($output, $filehandles{$fh});
            }
        }
    }
    
	exit 0;
    
}


	



sub transcode {

	my($transcode_text, $hashstore, $replacechar) = @_;
    
    my %font_map = %$hashstore;    
	
	$transcode_text =~ s/h;/u;/g;  		# Change as needed {added line due to error in the local files}
	$transcode_text =~ s/N(.)/$1N/g;		# Change as needed {added to compensate for the composite letters}
	$transcode_text =~ s/n(.)/$1n/g;           # Change as needed {added to compensate for the composite letters}   
	$transcode_text =~ s/($replacechar)/$font_map{$1}/g;
	
    return ($transcode_text);
}




sub output {

	my ($output, $filehandle) = @_;

    print "$output\n" unless ($p2f);	
    
	if ($p2f){
	
		if($filehandle){
	
			open my $final, '>:utf8', $filehandle;
			print $final "$output\n";
			close $final;
		
		}
		unless ($filehandle){
	
			open my $final, '>:utf8', $out_prefix;
			print $final "$output\n";
			close $final;
		}
	
	} 
    
    return;
}





sub map_font {
	
    my %map_font;
    my ($font) = shift;
    
    $font =~ s/ /_/;
	$font =~ s/(.*?)\.ttf/$1/;	

	my @oddhexes = qw/0B95 0B99 0B9A 0B9E 0B9F 0BA3 0BA4 0BA8 0BAA 0BAE 0BAF 0BB0 0BB2 0BB5 0BB3 0BB4 0BB1 0BA9/;
	my @missingletters = qw/0BC1 0BC2/;
	my @rest = qw/0B85 0B86 0B87 0B88 0B89 0B8A 0B8E 0B8F 0B90 0B92 0B93 0B83  0BBE  0BBF  0BC0  0BC6  0BC7  0BC8  0BCD  0B9C  0BB7  0BB8  0BB9 0BCB 0BCA 0BCC/;
	
	foreach (@oddhexes) {
		
		my $oddhex = $_;
		
        $_ = chr(hex($_));
	
		print "Press the key for $_   :";
		chomp (my $bole = <STDIN>);
	
		if ($bole eq "") {next};
		$map_font{$bole} = $_;
	
		foreach (@missingletters) {
	
			my $oddchar = chr(hex($oddhex)).chr(hex($_));
			
            print "Press the key for $oddchar   :";
			chomp (my $missingchar = <STDIN>);
			
            next if ($missingchar eq "");
			
            $map_font{$missingchar} = $oddchar;
		
        }
	}
	
	foreach (@rest) {
		
		$_ = chr(hex($_));
		
        print "Press the key for $_   :";
		chomp (my $misc = <STDIN>);
		
        next if ($misc eq "");
		$map_font{$misc} = $_;
	
    }
	
	print "\nAre there any extra letters in your font's keymap? (y/n): ";
	chomp(my $reply = lc(<STDIN>));
	
    if ($reply eq "y") {
    
        my ($i, $e, $extrachar, $addchar, $exkey, @s);

        print "\nEnter the number of extra characters: ";
        chomp($i = <STDIN>);

        for($e=1;$e<=$i;$e++){

            print "\nEnter the Unicode value of the extra letter(Separate by '.' if composite letter): ";
            chomp($extrachar = <STDIN>);
            
            if ($extrachar =~ m/\./) {

                @s = split /\./, $extrachar;
                $addchar = chr(hex($s[0])).chr(hex($s[1]));
            
            }else {
                
                $addchar = chr(hex($extrachar));
                
                }

            print "\nEnter the key for $addchar   :";
            chomp ($exkey = <STDIN>);
            
            $map_font{$exkey} = $addchar;
        
        }
    }
	
	open my $mapout, '>', $font or die "can't open file";
	print $mapout dump (\%map_font);
	close $mapout;
    
    print "The Font has been mapped and saved to $mapout\n";
    
    main(\%map_font);
    
}



sub restore_map {

    my %restore_map;
    
    my($hash_source) = shift;
	
	open my $in, '<', $hash_source or die "$hash_source can't be opened: $!";
	    
			local $/;
			%restore_map = %{ eval <$in> };
		
		
	close $in;
    
    main(\%restore_map);
}


sub usage {

    print "\nUsage: $0 [options] {file1.txt file2.txt..} \n\nExample: $0 -f TamilBible.ttf chapter.txt\n\nOptions:\n\t  -f --font <fontname.ttf> - used to pass font name\n\t  -u --use <source_file> use <source_file> to generate font map (The source file is the stored hash values of a previous mapping)\n\t  -t --transcode-text <text> transcodes typed text to Unicode as given in font map\n\t  -p --print-to-file <file-prefix> you can pass a string here to append to the input file name and write as the output file\n\t  -h --help - Prints help\n\nManual mapping of font is essential for using this program\n\n";
    exit 0;
}