class Item

  def price
    @price = 10
  end

  def price=(price_value)
    @price = price_value
  end

  def another_method
    @price
  end

end

item = Item.new
p item.another_method