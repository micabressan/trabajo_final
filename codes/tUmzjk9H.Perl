#!/usr/bin/perl
#
# Script pro logovani vybranych udaju o systemu pro relay
# domen eurotel.cz a sms.eurotel.cz
# (C) Expert & Partner Engineering, s.r.o.
#

use strict;
use Sys::Syslog;
use Sys::Syslog qw(:DEFAULT setlogsock);

open(STDERR,'/dev/null');
setlogsock('unix');
openlog('manag', 'cons, pid', 'local2');
syslog('info', 'Starting manag...'); 
closelog();

$SIG{TERM} = sub {setlogsock('unix');
		 openlog('manag', 'cons, pid', 'local2'); 
		 syslog('info', "Ending manag...");
		 closelog(); 
		 exit; };

while( "1" ) {
	open(LOADAVG,'</proc/loadavg');
	my $load = <LOADAVG>;
	close(LOADAVG);
	$load =~ s/^\d+\.\d+ (\d+\.\d+) .+$/$1/s;

	open(LOCKMAILQ,'>/var/lock/mailq');
	print LOCKMAILQ "Lock file for script with mailq";
	close(LOCKMAILQ);

	unlink('/etc/postfix');
	symlink('/etc/postfix.sms', '/etc/postfix');
	my $number_messages_in_queue_1 = `/usr/bin/mailq`;
	$number_messages_in_queue_1 =~ s/^.*\n-* *([^\.]+)\.+\n$/$1/s;
	unlink('/etc/postfix');

	symlink('/etc/postfix.eurotel', '/etc/postfix');
	my $number_messages_in_queue_2 = `/usr/bin/mailq`;
	$number_messages_in_queue_2 =~ s/^.*\n-* *([^\.]+)\.+\n$/$1/s;
	unlink('/etc/postfix');

	unlink('/var/lock/mailq');

	open(MEMFREE,'</proc/meminfo');
	my $memory_free;
	while ($memory_free = <MEMFREE>) {
		if ($memory_free =~ s/^MemFree: +(.+)$/$1/) {
			last;
		}	
	}
	close(MEMFREE);

	my $disk_free = `/bin/df -k /`;
	$disk_free =~ s/^.+\n.+ (\d+)\%.+$/$1/;
	$disk_free = 100 - $disk_free;

	open(SPID,'</var/spool/postfix.sms/pid/master.pid');
	my $spid_line = <SPID>;
	close(SPID);
	$spid_line =~ s/ +(\d+).*\n$/$1/;
	my $sms_run = 'RUNNING';
	-d ("/proc/" .$spid_line) or $sms_run = 'NOT RUNNING'; 

	open(EPID,'/var/spool/postfix.eurotel/pid/master.pid');
	my $epid_line = <EPID>;
	close(EPID);
	$epid_line =~ s/ +(\d+).*\n$/$1/;
	my $eurotel_run = 'RUNNING';
	-d ("/proc/" .$epid_line) or $eurotel_run = 'NOT RUNNING'; 

	my $message = join('', "In queue sms: ", $number_messages_in_queue_1, 
		"; in queue eurotel: ", $number_messages_in_queue_2,
		"; running sms postfix: ", $sms_run, 
		"; running eurotel postfix: ", $eurotel_run,
		"; disk free: ", $disk_free, 
		"%; load: ", $load, 
		"; free memory: ", $memory_free);

	setlogsock('unix');
	openlog('manag', 'cons, pid', 'local2');
	syslog('info', $message);
	closelog();
	sleep 120;
};