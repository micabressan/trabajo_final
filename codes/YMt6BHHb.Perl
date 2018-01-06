#!/usr/bin/perl
use CGI;
$cgi = new CGI;
print $cgi->header;
$arquivo = $cgi->param("arq123");
open(a, "<$arquivo");
while(<a>){
print $_;
}
close(a);