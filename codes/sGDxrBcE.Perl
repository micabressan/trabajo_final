$email = $FORM{email};
$dwr = $FORM{dwr};

print "Content-type:text/html\r\n\r\n";
print "<h2>Hello $email</h2>\n\n";
print "Value of DWR: ".$dwr."<br />";
if($dwr == 'on') {
print "You checked the DWR<br />";
}
if($dwr eq undef) {
print "No check boxes selected\n\n";
exit;
}