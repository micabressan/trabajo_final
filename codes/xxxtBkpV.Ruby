class BasketController
  def add_to_basket
    item = Item.find_by_title(params[:item_title])

    basket = $basket

    basket.add_item(item)

    if basket.count_items > 10
      basket.error_messages.add("Слишком много товаров в корзине")
    end

    total = 0

    basket.items.each do |basket_item|
      total += basket_item.price
    end

    session[:basket_total] = total

    query = "INSERT INTO basket_items (basket_id, item_title, basket_type) VALUES '" +
            (:basket=>basket_id.to_s) +
            "', '" + params[:item_title] + "', 3)"

    results = ActiveRecord::Base.connection.execute(query)

    Basket.add_free_delivery(basket)

    return "<h1>Добавлен товар в корзину: #{@item.title}</h1>"

  end
end