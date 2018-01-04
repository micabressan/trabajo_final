r = 7
s = 6
l = true
ll = true
while turtle.getFuelLevel() > 49 do
  while r > 0 do
    while s > 0 do
      turtle.dig()
      turtle.forward()
      s = s - 1
    end
    r = r - 1
    if l == true and r > 0 then
      turtle.turnLeft()
      turtle.dig()
	  turtle.forward()
      turtle.turnLeft()
    elseif l == false and r > 0 then
      turtle.turnRight()
      turtle.dig()
	  turtle.forward()
      turtle.turnRight()
    end
  l = not l
  s = 6
  end
  if ll == true then
    turtle.turnRight()
  else
    turtle.turnLeft()
  end
  ll = not ll
  turtle.digDown()
  turtle.down()
  r = 7
end
if turtle.getFuelLevel() <=49 then
  print("Nicht genug Treibstoff!")
end