package MyCheckerModule;

use strict;
use Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

$VERSION     = 1.00;
@ISA         = qw(Exporter);
@EXPORT      = ();
@EXPORT_OK   = qw(changeTileToChosen);
%EXPORT_TAGS = ( DEFAULT => [qw(&changeTileToChosen)]);

sub myFunction
{
	return (0);
}

1;