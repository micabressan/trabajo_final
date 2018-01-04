sub setup_is_action_bar {
  my $form                    = $::form;
  my $change_never            = $::instance_conf->get_is_changeable == 0;
  my $change_on_same_day_only = $::instance_conf->get_is_changeable == 2 && ($form->current_date(\%::myconfig) ne $form->{gldate});
+  my $payments_balanced       = ($::form->{oldtotalpaid} == 0);
+  my $has_storno              = ($::form->{storno} && $::form->{storno_id});