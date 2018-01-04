my $reconhecedor = LTasks::REN->new("apikey");
my @entidades = $reconhecedor->extract("A Maria foi passear em Londres.");
foreach my $entidade (@entidades) {
   print $entidade->text;
   print $entidade->type;
   foreach my $span ($entidade->spans) {
      print $span->begin;
      print $span->end;
   }
}