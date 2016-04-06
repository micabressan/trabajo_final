# console
my $order = SL::DB::Order->new
my $item1 = SL::DB::OrderItem->new
my $item2 = SL::DB::OrderItem->new

$order->add_items($item1)
pp $order->items    # leer

$order->items([$item1])
pp $order->items    # ein item

$order->add_items($item2)
pp $order->items    # zwei items