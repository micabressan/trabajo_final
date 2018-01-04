while(true)
 if(turtle.getFuelLevel() < 100)
  turtle.select(16)
  turtle.refuel()
 end
 
 turtle.select(1)

 turtle.up()
 turtle.dig()
 turtle.down()
 turtle.dig()

 turtle.suck()

 turtle.forward()
end