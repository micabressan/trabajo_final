#!/usr/bin/perl -w
use warnings;
use strict;

print "Перечисляемый тип: \n";
print "enum <name> { <field1>,<field2>,<field3> };\n";
print "Задайте тип: \n";


my $line = <STDIN>;

my $typename;
my @fields;

my $name;

$line =~ s#enum #[ENUMTOKEN]#gs;
$line =~ s#{#[LEFT_TOKEN]#g; 
$line =~ s#}#[COMMA_TOKEN][RIGHT_TOKEN]#g;
$line =~ s#,#[COMMA_TOKEN]#g;
$line =~ s#;#[END_TOKEN]#;
$line =~ s# ##g;
if ($line =~ s/\[ENUMTOKEN\]([\w\d]+)\[LEFT_TOKEN\]/[ENUM_TOKEN][TYPE_TOKEN][LEFT_TOKEN]/) {

	$typename = $1;

};


while ($line =~ /([\w\d]+)\[COMMA_TOKEN\]/g){

	push @fields, $1;

}

$line =~ s/([\w\d]+)\[COMMA_TOKEN\]//g;

$line =~ s# ##g;
print $line, "\n";


if (!($line =~ "\[ENUM_TOKEN\]\[TYPE_TOKEN\]\[LEFT_TOKEN\]\[RIGHT_TOKEN\]\[END_TOKEN\]")){

	die "Wrong grammatics";

};


print "Правильный тип\n";

print $line, "\n";
print $typename, "\n";
print join ("\n", @fields);

print "\nЗадайте переменные: \n";
print "<type> <name1>, <name2>;\n";
my $vars = <STDIN>;

$vars =~ s#;#[COMMA_TOKEN][END_TOKEN]#;
$vars =~ s#,#[COMMA_TOKEN]#g;
$vars =~ s#$typename#[TYPE_TOKEN]#;

$vars =~ s/[\w\d]+\[COMMA_TOKEN\]//g;

$vars =~ s# ##g;

print $vars, "\n";

if (!($line =~ "\[TYPE_TOKEN\]\[END_TOKEN\]")){

	die "Wrong vars";

};


print "Correct \n";

=pod
my $conditions = scalar ( () = $string =~ /if *\(|case|while *\(|for *\(/g); # Подсчёт условных операторов
my $allops = scalar ( () = $string =~ /;/g) - (scalar ( () = $string =~ /for *\(/g) * 2) + $conditions; # Подсчёт всех операторов
print "Conditions: $conditions \nOperators: $allops \nJilb: ", $conditions/$allops, "\n"; # Подсчёт метрики Джилба
my $casecounter = 0;
my @lines = (split /\n/, $string);
foreach (@lines){
	if ($_ =~ /switch/){ $casecounter = 0; $_ = '}}'.$_; };
	if ($_ =~ /default/) { $_ = "{{"; for (my $i = 0; $i < $casecounter; $i++){ $_.='}' }; };
	if ($_ =~ /case/){ $casecounter++; $_.='{' };

};
$string = join "\n", @lines;
my $depth = 0;
my $maxdepth = 0;
foreach (split //, $string){	
	if ($_ eq '{'){ $depth++ };
	if ($_ eq '}'){ $depth-- };
	if ($depth > $maxdepth){ $maxdepth = $depth };
};
print "Depth: ", $maxdepth - 1, "\n";

=cut