length = 12
width = 2

next = "right"

function line()
 for i=1,length do
  turtle.digDown()
  turtle.placeDown()
  turtle.forward()
 end
end

function changeLine()
 turtle.digDown()
 turtle.placeDown()
 turtle.turnRight()
 turtle.forward()
 turtle.turnRight()
end

turtle.forward()
for i=1,width do
 line()
 changeLine()
end
turtle.back()