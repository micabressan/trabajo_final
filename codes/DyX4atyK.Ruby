def map
  { "M" => 1000,
    "I" => 1,
    "L" => 50,
    "C" => 100,
    "X" => 10,
    "V" => 50,
    "D" => 500
  }
end
    
def to_arabic(roman)
  value = 0
  for i in 1..roman.length-1
    curr = roman[i]
    prev = roman[i-1]
  
    if(map[prev] < map[curr]) then
      value -= map[prev]
    else
      value += map[prev]
    end
    
  end
  value += map[roman[roman.length-1]]
  return value
end

to_arabic("MCMXCIX")