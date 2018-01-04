names = []
user_input = nil

while user_input != '' do
	user_input = gets.encode('UTF-8').chomp
	names << user_input	
end

for item in names do
	puts "С нами " + item
	sleep 1

	if (item == 'Элис')
		puts "Элис? А кто такая Элис?"
		sleep 1
		break
	end
end
puts "ла ла ла"