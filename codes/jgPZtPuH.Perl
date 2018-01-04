package ACD::Schema::Result::WorkScopeMaterial;
use Moose;
use MooseX::NonMoose;
extends 'ACD::Schema::Result';
use Method::Signatures::Simple;
use CLASS;
use List::Util qw/max min/;
use ACD::Model::InventoryFaker;
use feature ':5.10';

CLASS->table('WorkScopeMaterials');

CLASS->add_columns(
   work_order_id => {
      data_type => 'int',
      is_numeric => 1,
   },
   id => {
      data_type => 'int',
      is_numeric => 1,
   },
   is_customer_furnished => { # Added by SDA 05/26/2011
      data_type => 'bit',
      size => 1,
      is_numeric => 1,
   },
   is_in_stock => {
      data_type => 'bit',
      size => 1,
      is_numeric => 1,
      is_nullable => 1,
   },
   description => {
      data_type => 'varchar',
      size => 23,
      is_nullable => 1,
   },
   is_order => {
      data_type => 'bit',
      size => 1,
      is_numeric => 1,
      is_nullable => 1,
   },
   part_id => {
      data_type => 'varchar',
      size => 25, # Changed from 20 to 25 by SDA 05/22/2011
      is_nullable => 1,
   },
   quantity => {
      data_type => 'int',
      is_numeric => 1,
      is_nullable => 1,
   },
   quantity_to_order => {
      data_type => 'int',
      is_numeric => 1,
      default    => 0,
   },
   quantity_to_pull => {
      data_type  => 'int',
      is_numeric => 1,
      default    => 0,
   },
   work_order_id => {
      data_type => 'int',
      is_numeric => 1,
   },
   work_scope_id => {
      data_type => 'int',
      is_numeric => 1,
   },
   # bin => {
      # data_type => 'varchar',
      # size => 4,
      # capitalization => 'upper_case', # Added by SDA
      # is_nullable => 1,
   # },
   # box => {
      # data_type => 'int',
      # is_nullable => 1,
   # },
);

CLASS->set_primary_key(qw{work_order_id work_scope_id id}); # Primary Key - wo#!dash#!seq# ex: 44429!1!1

CLASS->belongs_to(work_order => 'ACD::Schema::Result::WorkOrder', 'work_order_id');

CLASS->belongs_to(work_scope => 'ACD::Schema::Result::WorkScope', {
   'foreign.work_order_id' => 'self.work_order_id',
   'foreign.id'            => 'self.work_scope_id'
});

CLASS->filter_column(
   part_id => {
      filter_to_storage => sub { uc $_[1] },
   }
);

CLASS->filter_column(
   description => {
      filter_to_storage => sub { uc $_[1] },
   }
);

my $boolean_fields = {
   is_order => 1,
   is_in_stock => 1,
};

has original_quantity => (
   isa => 'Int',
   is  => 'rw',
);

around qw(new inflate_result) => sub {
   my $orig = shift;
   my $self = shift;

   $self = $self->$orig(@_);
   $self->quantity(0) unless $self->quantity;
   $self->original_quantity($self->quantity);

   return $self;
};

around qw{new update}, sub {
   my $orig = shift;
   my $self = shift;
   my $args = $_[0];

   foreach my $field (keys %{$args}) {
      if ($boolean_fields->{$field}) {
         $args->{$field} += 0;
      }
   }

   $self->$orig(@_);
};


around insert => sub {
   my $orig = shift;
   my $self = shift;

   my $guard = $self->result_source->schema->txn_scope_guard;

   my $max = $self->siblings->search(undef,{
      order_by => { -desc => 'id' },
      rows     => 1,
   })->single;

   $self->id( $max ? $max->id + 1 : 1 );

   # Never pull more than is on hand
   my $to_pull =  min $self->quantity, $self->inventory_part->quantity_on_hand;
   $self->quantity_to_pull($to_pull);

   $self->quantity_to_order($to_pull - $self->quantity);

   $self->$orig(@_);

   $self->work_scope->update();
   $self->inventory_part->update_inventory_part_quantity($self->quantity);

   $guard->commit;

   return $self;
};

around delete => sub {
   my $orig = shift;
   my $self = shift;

   my $guard = $self->result_source->schema->txn_scope_guard;
  
   $self->$orig(@_);

   $self->work_scope->update();
   $self->inventory_part->update_inventory_part_quantity(-$self->quantity);

   $guard->commit;

   return $self;

};


has inventory_part => (
   is => 'ro',
   lazy_build => 1,
);

method _build_inventory_part {
   ACD::Model::InventoryFaker->new(
      schema       => $self->result_source->storage->schema,
      inventory_id => $self->part_id,
      quantity     => $self->quantity,
      is_in_stock  => $self->is_in_stock,
      is_order     => $self->is_order,
      description  => $self->description,
   );
}

has siblings => (
   is => 'ro',
   lazy_build => 1,
);

method _build_siblings {
   $self->result_source->resultset->search({
      work_order_id => $self->work_order_id,
      work_scope_id => $self->work_scope_id,
   });
}

method TO_JSON {
   my $is_in_stock = $self->is_in_stock;
   my $is_order = $self->is_order;
   my $part = $self->inventory_part;
   return {
      map({ $_ => $self->$_ // undef } qw{
         is_customer_furnished
         part_id
         quantity quantity_to_order quantity_to_pull
         work_order_id work_scope_id
      }),
      is_in_stock            => $part->is_in_stock || 0,
      bin                    => $part->bin || '', #unless $self->bin,
      box                    => $part->box || '', #unless $self->box,
      description            => $part->oem_description || '',
      adr_description        => $part->adr_description || '',
      is_order               => $part->is_order || 0,
      faker_code             => $part->inventory_type,
      work_scope_material_id => $self->id,
      pk                     => $self->work_order_id . q{!} . $self->work_scope_id . q{!} . $self->id,
   };
}

no Moose;
CLASS->meta->make_immutable( inline_constructor => 0 );

1;