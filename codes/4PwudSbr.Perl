#!/usr/bin/perl -W

$coredir = "~/kernel/";
$ENV{"PATH"} = "~/kernel/arm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin";
#$ENV{"PATH"} = $coredir . "/arm-2008q3/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin";
my ($date, $pidfile, $isrunning, $isdone, $commitfrom, $committo, $commitlog, $compilelog, $gitpull, $compile);
$pidfile = $coredir . "/update-compile.run";
$date = `date +"%m/%d/%Y %H:%M:%S"`;
$date =~ s/\n//g;

unless (-e $pidfile) {
$isrunning = `touch $pidfile`;
$compilelog = "";
$gitpull = `cd $coredir/linux-msm && git pull 2>&1`;

if ($gitpull =~ /.*Updating (.*)\.\.(.*).*/g) {
$commitfrom = $1;
$committo = $2;
$commitlog = `cd $coredir/linux-msm && git log $commitfrom..$committo 2>&1`;
print "Update found, compiling " . $commitfrom . " -> " . $committo . "...\n";
$compile = `cd $coredir && ./build.sh 2>&1`;
if ($compile =~ /Creating output directory (.*)/g) {
$compiledir = $1;
open (COMPLOG, ">>" . $compiledir . "/detail.log");
print COMPLOG "Date and time: " . $date . "\n\nGit pull output:\n" . $gitpull . "\nCommit Log:\n" . $commitlog;
close (COMPLOG);
}
else {
### Make emerg. log to document compile log even if we can not figure out where the OUTPUT_PATH is located.
open (COMPLOG, ">" . $coredir . "/compiled/ERR-lastcompile.log");
print COMPLOG "Date and time: " . $date . "\nThis log was generated specifically because the code could not extract the OUTPUT_PATH destination! Normally, a compile.log would have been generated in the proper folder.\n\nGit pull output:\n" . $gitpull . "\nCommit Log:\n" . $commitlog;
close (COMPLOG);
}
}
else {
print "No update required...\n";
$compile = "";
}
$isdone = `rm -f $pidfile`;

open (BUILDLOG, ">" . $coredir . "/compiled/update.log");
print BUILDLOG "Date and time: " . $date . "\n\nGit pull output:\n" . $gitpull . "\n\n" . $isrunning . "\n\n" . $isdone;
close (BUILDLOG);
}