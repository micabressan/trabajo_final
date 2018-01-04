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

function chest()
 turtle.select(1)
 turtle.dropDown(turtle.getItemCount()-1)
 turtle.select(2)
 turtle.dropDown()
 turtle.select(1)
end

turtle.forward()
for i=1,width do
 line()
 changeLine()
end
turtle.back()

chest()