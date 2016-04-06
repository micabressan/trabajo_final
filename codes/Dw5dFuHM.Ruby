def add_comas (number)
	if number.between?(0, 999)  #If number less than 3 digits
		return number
		puts number
	elsif number.between?(1000, 9999) #
		puts number.to_s.insert(-4, ',')
	elsif number.between?(1000000, 9999999)
		one_commah = number.to_s.insert(-4, ',')
		puts one_commah.to_s.insert(-8, ',')
	elsif number.between?(1000000000,9999999999)
		one_commah = number.to_s.insert(-4, ',')
		two_commah = one_commah.to_s.insert(-8, ',')
		puts two_commah.to_s.insert(-12, ',')
	end
end