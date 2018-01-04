#!/usr/bin/env perl

### Author : Joshua S. Day (haxmeister)
### purpose : A hypothetical anonymous data reporting tool

use strict;
use warnings;
use JSON;


my %hardware = get_hardware_info();
my %kernel = get_kernel_info();

my %report = ('kernel' => \%kernel, 'hardware' => \%hardware);

my $json = JSON->new->allow_nonref;
my $json_pretty = $json->pretty->encode(\%report);
print $json_pretty;

## returns a hash structure with relevent info from /proc/cpuinfo
## as well as /proc/meminfo with the cpu flags in an array
sub get_hardware_info{
		# pulling relevent information from /proc/cpuinfo
		
		my $cpu_file = '/proc/cpuinfo';
		my %hash;
		my %cpu_hash;
		my %mem_hash;
		my @cpu_flags;
		if (open(my $fh, '<:encoding(UTF-8)', $cpu_file)) {
			while (my $row = <$fh>) {
				chomp $row;
				if ($row){
					my ($key, $value) = split /\s*:\s*/, $row;
					if (($key eq 'cpu MHz'   ) or 
					    ($key eq 'model name') or 
					    ($key eq 'cpu cores' )) {	
							$cpu_hash{$key}=$value;	
						}
					elsif ($key eq 'flags'){
						my (@cpu_flags)= split / /, $value;
						$cpu_hash{$key}= \@cpu_flags;
						}
					else{next}	
					}
				}
			close $fh;
			} 
		else {warn "Could not open file ' $cpu_file' $!";}
		
		# pulling relevent info from /proc/meminfo
		my $mem_file = '/proc/meminfo';
		if (open(my $fh, '<:encoding(UTF-8)', $mem_file)) {
			while (my $row = <$fh>) {
				chomp $row;
				if ($row){
					my ($key, $value) = split /\s*:\s*/, $row;
					if (($key eq 'MemTotal'     ) or 
					    ($key eq 'MemFree'      ) or 
					    ($key eq 'MemAvailable' )or
					    ($key eq 'SwapTotal'    ) or
					    ($key eq 'SwapFree'     )) {	
						$mem_hash{$key}=$value;	
						}
					}
				}
			close $fh;
			} 
		else {warn "Could not open file ' $mem_file' $!";}		
		%hash = ('cpu' => \%cpu_hash, 'memory' => \%mem_hash);
		return %hash;
		}# end get_hardware_info sub
		
## returns a hash with relevant info from /proc/sys/kernel
## also checks /boot to see what kernels are present there
sub get_kernel_info{
	my $directory = '/proc/sys/kernel';
	my $boot_dir = '/boot';
	my @kernel_list;
	my %hash;
	
	# pulling relevant info from /proc/sys/kernel
	opendir (DIR, $directory) or die $!;
	foreach my $file ( readdir(DIR) ) {
		next unless (-f "$directory/$file"); #only want files
		if (($file eq 'ostype') or
			($file eq 'osrelease') or
			($file eq 'version')){
				if (open(my $fh, '<:encoding(UTF-8)', "$directory/$file")) {
					my $row = <$fh>;
					chomp $row;
					my $key = $file;
					my $value = $row;
					$hash{$key} = $row;
					close $fh;
					}
				else {warn "could not open file '$file' $!";
					}
				}
		}
	closedir(DIR);
	
	# pulling list of kernels in /boot	
	opendir (DIR, $boot_dir) or die $!;
	foreach my $file ( readdir(DIR) ){	
		next unless (-f "$boot_dir/$file"); #only want files
		chomp $file;
		if ($file =~ m/^kernel/){
			push @kernel_list, $file;
			}
		}
	$hash{'available kernels'} = \@kernel_list;	
	closedir(DIR);
	return %hash
	} # end get_kernel_info sub