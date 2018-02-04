function ligne()
  for i=1,4 do
    turtle.place()  
    turtle.back()  
  end
end
function newline()
  turtle.turnRight()
  turtle.forward()
  turtle.turnLeft()
  turtle.forward()
end
function advance()
  for i=1,3 do
    turtle.forward()
  end
end
ligne()
newline()
advance()
ligne()
newline()
advance()
line()