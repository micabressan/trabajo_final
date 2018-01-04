x = 600851475143
i = 1
while i < x do
  x /= i if x % i == 0
  i += 2
end
puts x