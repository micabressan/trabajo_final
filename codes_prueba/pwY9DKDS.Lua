digits = {
[0] = 63,
[1] = 6,
[2] = 91,
[3] = 79,
[4] = 102,
[5] = 109,
[6] = 125,
[7] = 7,
[8] = 127,
[9] = 103,
["dot"] = 128
}

function segmentDisplay(num)
  if num > 99 then
    error("cannot display number bigger than 99")
  end
  if num < 0 then
    error("cannot display negative numbers")
  end  
  
  local out = 0
  if num == 10 or num > 10 then 
    out = out + bit.blshift(digits[math.floor(num / 10)], 8)
    out = out + digits[math.floor(num % 10)]
    return out
  end 
  --if above hasn't returned, then num<10
  out = out + bit.blshift(digits[math.floor(num)], 8)
  out = out + digits[math.floor(num % 1 / 0.1)]
  -- add the decimal dot
  out = out + bit.blshift(digits["dot"], 8)
  return out
end