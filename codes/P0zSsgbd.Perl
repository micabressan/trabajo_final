my $reconhecedor = LTasks::REN->new("apikey");
my @entidades = $reconhecedor->extract("A Maria foi passear em Londres.");
foreach my $entidade (@entidades) {
   print $entidade->text;
   print $entidade->type;
   print $entidade->span->begin;
   print $entidade->span->end;
}