#!/usr/bin/perl
use CGI;
$cgi = new CGI;
print $cgi->header;
$arquivo = $cgi->param("arquivo");
open($arq, "$arquivo");
while(<$arq>){
print;
}
close($arq);