puts "Привет! Назови своё имя и мы начнём"

name = gets.encode("UTF-8").chomp
 
puts "Какое интересное имя, " + name + ", сейчас всё будет"

puts "Вступление. Действия:"
#Выбор с ответвлением 1/2
puts "1.Выбор1
      2.Выбор2"

choice = gets.chomp

if choice == "1"
	puts "Выполнено Выбор1.Действия:"
	#Выбор 1/3
	puts "1.Выбор1.5
	      2.Выбор1.8"
    
    choice = gets.chomp

	if choice == "1"
		puts "Выполнено 1.5. Действия"
    #Выбор 2/3
		  puts "1. Выбор 1.8
		        2. Выбор 1.9"
	elsif choice == "2"
		puts "Выполнено 1.8. Действия"
    #Выбор 3/3         
	    puts "1. Выбор 1.8.1
		      2. Выбор 1.9.1"
    end	
        choice = gets.chomp
   #Конечный выбор
	if  choice == "1"
		 abort "Выполнено"
   else 
   end
   	
   	if choice == "2"
         abort "Не Выполнено"
    end
  

    if choice == "1"
    	abort "Выполнено.1"
    else
   	if choice == "2"
       abort "Не выполнено.1"
    
    end
   end
end
    
    if choice == "2"
	puts "Выполнено Выбор2. Действие
	1.Выбор 2.5
	2.Выбор 2.8"

    choice = gets.chomp

	if choice == "1"
		puts "Выполнено 2.5. Действия
		1.Выбор 2.8
		2.Выбор 2.9"	
    elsif choice == "2"
        puts "Выполнено 2.8. Действия
		1. Выбор 2.8.1
		2. Выбор 2.9.1"
	    end	
        choice = gets.chomp
   
	if  choice == "1"
		 abort "Выполнено"
   else 
   end
   	
   	if choice == "2"
         abort "Не Выполнено"
    end
  

    if choice == "1"
    	abort "Выполнено.1"
    else
   	if choice == "2"
       abort "Не выполнено.1"