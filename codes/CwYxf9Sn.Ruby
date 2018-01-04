class Item

  @price = 10

  def price
   return @price
  end

end

item = Item.new
p item.price