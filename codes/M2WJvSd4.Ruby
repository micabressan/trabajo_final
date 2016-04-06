# Checks if a credit/debit card number is valid based on the Luhn Algorithm.
# Note that meeting the requirements of said algorithm does not necessarily mean the card number is active.
# https://en.wikipedia.org/wiki/Luhn_algorithm
# Written in Ruby
 
def isvalid?(cc_num)
  cc_num = cc_num.reverse.split("").map! {|x| x.to_i}
  checkdig = cc_num[0]
  cc_num.delete_at(0)
  odds = []
  sd_evens = []
  dd_evens = []
  total = 0
  dd_evs_spl = []
 
  cc_num.each_index { |x|
    if x % 2 == 1
      odds << cc_num[x]
    elsif cc_num[x] < 5
      sd_evens << cc_num[x]
    else
      dd_evens << cc_num[x]
    end
  }
 
  sd_evens.map! {|x| x * 2}
  dd_evens.map! {|x| (x * 2).to_s}
  dd_evens = dd_evens.join("").split("")
  dd_evens.map! {|x| x.to_i}
 
  odds.each {|x| total += x}
  sd_evens.each {|x| total += x}
  dd_evens.each {|x| total += x}
 
  check_dig = (total * 9) % 10
 
  if checkdig == check_dig
    puts "The number is valid."
  else
    puts "The number is invalid."
  end
 
end
 
puts "Ender a credit/debit card number."
ans = gets.chomp
 
isvalid?(ans)