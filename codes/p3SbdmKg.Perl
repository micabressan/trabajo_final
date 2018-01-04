#------------------------------------------------------------------------------
sub lien_auto {
#------------------------------------------------------------------------------
# Recherche dans la désignation de l'article des renvois vers d'autres
# références de type 'VOIR 7100650123' ou 'Voir Indice A' et les transforme
# en lien direct vers cet article cible. Prend en argument la référence et la 
# désignation d'un article et renvoie la désignation modifiée.
#------------------------------------------------------------------------------
# $cgi       : Objet CGI
# $ar_ref    : Référence de l'article
# $ar_design : Désignation de l'article
#------------------------------------------------------------------------------ 
    my ( $cgi, $ar_ref, $ar_design, ) = @_;
#------------------------------------------------------------------------------
    my ($ar_ref_to_link) =
	$ar_design =~
	m/(?: VOIR|voir|Voir) .*? ([\d\s?]{10,} [a-zA-Z]?)/gxms;
    my ($indice_to_link) =
	$ar_design =~
	m/(?: VOIR|voir|Voir)? \s* (?: indice|Indice|INDICE|ind\.?|Ind\.?|IND\.?) .* ([a-zA-Z]{1})/gxms;

    return $ar_design if ! ( $ar_ref_to_link || $indice_to_link );

    if ( $indice_to_link ) {
	$ar_ref =~ s/[a-zA-Z]$//gxms;
	$ar_ref_to_link = $ar_ref. $indice_to_link;
    }

    my $ar_ref_to_link_clean = $ar_ref_to_link;
    $ar_ref_to_link_clean =~ s/\s//gxms;

    my $link_to_ar_ref =  $cgi->a( 
	{ -href => "article_main.pl?ar_ref=$ar_ref_to_link_clean",
	  -onclick => "window.opener.location=this;return false;", },
	$ar_ref_to_link_clean, );
    
    $ar_ref_to_link =~ s/\s/\\s/gxms;
    $indice_to_link =~ s/\s/\\s/gxms;
    $ar_design =~ s/$ar_ref_to_link/\ $link_to_ar_ref/gxms;
    $ar_design =~
	s/(?: indice|Indice|INDICE|ind|Ind|IND) .* $indice_to_link/$link_to_ar_ref/gxms
	if ( $indice_to_link );

    return $ar_design;
}
#------------------------------------------------------------------------------