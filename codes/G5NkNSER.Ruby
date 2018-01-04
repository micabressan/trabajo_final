bot.listen do |message|
 menu_book = [
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Germany book', callback_data: 'germany_book'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'USA book', callback_data: 'usa_book'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Japan book', callback_data: 'japan_book')
    ]
    markup2 = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: menu_book)
 menu_germany = [
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'First book', callback_data: 'first_book'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Second book', callback_data: 'second_book'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: '3 book', callback_data: '3_book')
    ]
    markup3 = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: menu_germany)

  case message
  when Telegram::Bot::Types::CallbackQuery
    # Here you can handle your callbacks from inline buttons
    if message.data == 'book'
 
      bot.api.send_message(chat_id: message.from.id, text: 'Choose you book:', reply_markup: markup2)


       elsif message.data == 'germany_book'
        bot.api.send_message(chat_id: message.from.id, text: 'Choose you book:', reply_markup: markup3)
       elsif message.data == 'usa_book'
        bot.api.send_message(chat_id: message.from.id, text: 'Choose you book:', reply_markup: markup4 )
      
      end

 


  when Telegram::Bot::Types::Message
    main_menu = [
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Book', callback_data: 'book'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Sound', callback_data: 'sound'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Cinema', callback_data: 'cinema')
    ]
    markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: main_menu)
    bot.api.send_message(chat_id: message.chat.id, text: 'Make a choice', reply_markup: markup)




  end
end


end