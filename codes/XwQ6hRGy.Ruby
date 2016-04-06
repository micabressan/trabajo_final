class ShoppingCart
    attr_accessor :id, :contents, :total
    def initialize
        @id = 0 
        @contents = []
        @total = 0
    end

    def add_item(item)
        @contents.push(item)

    end

    def calculate_total
        for item in @contents
            @total += item.price
        end
        @total
    end

end

class Item
    attr_accessor :id, :name, :price
    def initialize(id, name, price)
        @id = id
        @name = name
        @price = price
    end
end