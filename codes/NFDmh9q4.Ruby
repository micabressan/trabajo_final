class BasketController
  def add_to_basket
    # Не надежно искать объект по неуникальному значению
    item = Item.find_by_title(params[:item_title])
    # Лучше так:
    # @item = Item.find(params[:item_id])

    # Не очень хорошая идея хранить в глобальной переменной корзину
    # одного пользователя
    basket = $basket
    # Лучше так, если есть модель:
    # @basket = Basket.find_by user_id: current_user.id
    # Если корзины не существует, нужно ее создать
    # !@basket ? @basket = Basket.create(user_id: current_user.id)

    # Почему бы не добавлять item прямо в basket.items?
    basket.add_item(item)
    # basket.items.push(item)

    # Выдается ошибка, но валидации нет. Какой смысл?
    # вместо .count_items можно было бы использовать basket.items.length
    if basket.count_items > 10
      basket.error_messages.add("Слишком много товаров в корзине")
    end

    # Подсчет я бы вынес в модель, в метод total
    total = 0

    basket.items.each do |basket_item|
      total += basket_item.price
    end

    session[:basket_total] = total
    # session[:basket_total] = @basket.total

    # Есть же ActiveRecord
    query = "INSERT INTO basket_items (basket_id, item_title, basket_type) VALUES '" +
            (:basket=>basket_id.to_s) +
            "', '" + params[:item_title] + "', 3)"

    results = ActiveRecord::Base.connection.execute(query)
    # @basket.save

    Basket.add_free_delivery(basket)
    
    return "<h1>Добавлен товар в корзину: #{@item.title}</h1>"
    # Можно сделать так:
    # @basket.save ? { redirect_to @basket, notice: 'Товар добавлен в корзину' }

  end
end