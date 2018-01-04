number = gets.chomp.to_i
line_counter = 0

until number == 1
  
  print "#{number} "
  line_counter += 1
  if(line_counter == 10)
    line_counter = 0
    puts()
  end
  
  if number % 2 == 0 #even
    number = (number/2)
  else
    number = (number*3) + 1
  end
  
  if(number == 1)
    print "1"
  end
end