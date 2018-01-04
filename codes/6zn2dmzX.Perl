#!/usr/bin/perl
$a; $b; $c;
print "Reshenie ax**2 + bx + c = 0\n";
print "Vvedite a\n";
$a = <STDIN>;
print "Vvedite b\n";
$b = <STDIN>;
print "Vvedite c\n;
$c = <STDIN>;
if(a != 0 && b != 0 && c != 0) { 
	$d = $b*$b - 4*$a*$c;
	if ($d < 0) {
		print "Reshenia net\n";
	} else {
		if ($d > 0) {
			$x1 = ((-1*$b) + (sqrt($d))) / (2*$a);
 			$x2 = ((-1*$b) - (sqrt($d))) / (2*$a);
 			print "\n x1 = $x1";
 			print "\n x2 = $x2\n";
		} else {
 			$x1 = ((-1*$b) + (sqrt($d))) / (2*$a);
 			print "Edinstvennoe reshenie $x1"; 
		}
	}
}
if(a == 0 && b != 0 && c != 0) { ...}
if(a == 0 && b == 0 && c != 0) { print "Resheniya ne syshestvyet.";}
if(a == 0 && b != 0 && c == 0) { ...}
if(a != 0 && b == 0 && c != 0) { ...}
if(a != 0 && b == 0 && c == 0) { ...}
if(a != 0 && b != 0 && c == 0) { ...}
if(a == 0 && b == 0 && c == 0) { print "Reshenii beskonechno mnogo.";}