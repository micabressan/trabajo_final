package ACD::Schema::Result;

use parent DBIx::Class::Core;
use strict;
use warnings;

use DateTime;

__PACKAGE__->load_components(qw{
   MTSI::DateTime
   TimeStamp
   FilterColumn
   Helper::Row::NumifyGet
   Helper::Row::ToJSON
   Nullify
   InflateColumn::Capitalize
});

sub get_timestamp {
   return DateTime->now->set_time_zone('America/Chicago')->truncate(to => 'day')
}

1;