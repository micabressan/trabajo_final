#!/usr/bin/perl
 
use Sys::Hostname;
use FileHandle;
 
$host = hostname;
$mailfrom = "server.name\@company.com";
$mailto = "your.name\@company.com,colleague.name\@company.com";
$threshold = 90;
 
# Do not change anything below this line
@check=`df -k`;
foreach (@check) {
	if (m/(\d+\%)/ and $1 >=$threshold) {
		push @New,$_;
	}
}
 
if (@New) {
	$mail = new FileHandle; 
	$mail->open("| /usr/sbin/sendmail -t") || die "Cannot open: $!";
	$mail->print("From: $mailfrom\n");
	$mail->print("To: $mailto\n");
	$mail->print("Subject: Disk space usage is above $threshold% on $host!\n\n");
	$mail->print("We have detected that the following partitions are almost full:\n\n", @New, "\n");
	$mail->close();
}