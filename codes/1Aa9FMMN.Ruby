#your code, here
clubs = {
  driver: 200,
  four_wood: 180,
  five_wood: 170,
  two_iron: 170,
  three_iron: 160,
  four_iron: 150,
  five_iron: 140,
  six_iron: 130,
  seven_iron: 120,
  eight_iron: 110,
  nine_iron: 95,
  pitching_wedge: 80,
  sand_wedge: 20,
  putter: 0
}

#get player input and reject strings
input = nil
puts "Welcome to the Golf Club Advisor. How many yards do you need to go?"
print ">"
while input == nil || input == 0.0
  if input == 0.0
    puts "Please enter numerical distance."
  end
  input=gets.chomp.to_f
end

#Compare required distance to club options
pick_club = {}
clubs.each_pair do |club, value|
  distance = input - value.to_f
 if distance >= 0.0 #negative value means overshoot
   pick_club.store(club, value)
 end
end

#get club that will hit the closest
picked = pick_club.to_a[0]

#return answer
puts "Pick the #{picked[0].to_s.gsub(/[:,_]/," ")} to hit atleast #{picked[1]} yards."