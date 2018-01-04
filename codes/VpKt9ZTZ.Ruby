puts "Привет! Назови своё имя и мы начнём"

name = gets.encode("UTF-8").chomp
 
puts "Какое интересное имя, " + name + ", сейчас всё будет"

puts "Вступление. Действия:

1.Выбор1
2.Выбор2"

choice = gets.chomp

if choice == "1"
	puts "Выполнено Выбор1.Действия:
	1.Выбор1.5
	2.Выбор1.7"

	choice = gets.chomp
	
	if choice == "1"
		puts "Выполнено 1.5. Действия"
	elsif choice == "2"
		puts "Выполнено 1.7. Действия"

	end	
    
if
	choice == "2"
	puts "Выполнено. Действие
	1.Выбор 2.5
	2.Выбор 2.7"
 
else
end

    choice = gets.chomp

	
	if choice == "1"
		puts "Выполнено 2.5. Действия"
	elsif choice == "2"
		puts "Выполнено 2.7. Действия"
	
end
end