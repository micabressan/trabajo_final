#!/usr/bin/perl
use utf8;
use Term::ANSIColor;
#gerador de index
#Releve os erros
#parte inicial
print color("BOLD GREEN");
print ("
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Gerador de index by J(*)RD150N|
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
_______________________________
");
#Parte da criação da index
print color("blue");
print color("BOLD BLUE ")."[1] gerar index".color("blue"),"\n";
print color("BOLD YELLOW")."[2] ajuda".color("BOLD YELLOW"),"\n";
print color("BOLD WHITE  ")."[3] sobre".color("green"),"\n";
print color("BOLD CYAN")."\n[+] qual numero deseja?: ".color("reset");
my $indez = <STDIN>;
chomp $indez;

if($indez eq '1')
{
print color("BOLD YELLOW");
print q(

              vc selecionou o numero 1
              ent bora fazer a index!

);
print color("BOLD BLUE")."[+] Nome da sua html:
".color("reset");
$index=<STDIN>;
print color("reset");
print color("BOLD BLUE")."[+] Cor da fonte: ".color("reset");
$cor=<STDIN>;
print color("reset");

print color("BOLD BLUE")."[+] seu codnome: ".color("reset");
$Nick=<STDIN>;
print color("BOLD BLUE")."[+] salve: ".color("reset");
$greetz=<STDIN>;
print color("BOLD BLUE")."[+] alguma frase: ".color("reset");
$frase=<STDIN>;
print color("BOLD BLUE")."[+] Imagem : ".color("reset");
$imagem=<STDIN>;
print color("BOLD BLUE")."[+] musica : ".color("reset");
$musica=<STDIN>;
open(CREATE,">>$index");
print CREATE "
<html><head>
	<title>HACKED</title>
<script>alert('owned')</script>
	<style>
		body {
			color: $cor ;
			background: #000;
			text-align: center;
			font-family: Verdana;
			font-size: 19px;
		}
		h1 {
			margin: 3px;
			font-size: 45px;
		}
	</style>
</head>
<body><br>
<h1>HACKED</h1>
 
<small>by $Nick <br><br>
<img src=\"$imagem\"><br><br>
<center>$frase</center>salve:<marquee><br>
 $greetz <br></marquee>
<iframe src=\"https://www.youtube.com/embed/$musica?autoplay=true\" width=\"0\" height=\"0\" frameborder=\"0\"></iframe>
</small></body></html>
 
 
";
close(CREATE);
print "index terminada\n";
print "\n\n";
}
#Final da primeira parte
if($indez eq '2')
#Iniciando segunda parte
{ 
print  ("testand segunda parte")


}