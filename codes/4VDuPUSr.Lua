function gohome()
      
                turtle.turnRight()
                for i = 1, 8 do
                                turtle.forward()
                end
  turtle.turnLeft()
end
function mainwall()
                for i = 1, 2 do
                        turtle.up()
                        turtle.select(2)
                        turtle.placeDown()
                        turtle.forward()
                        turtle.placeDown()
                        turtle.forward()
                        turtle.placeDown()
                        turtle.forward()
                        turtle.placeDown()
                        turtle.forward()
                        turtle.forward()
                        turtle.placeDown()
                        turtle.forward()
                        turtle.placeDown()
                        turtle.forward()
                        turtle.placeDown()
                        turtle.forward()
                        for j = 1, 8 do
                                turtle.back()
                        end
                end
              
                        turtle.up()
                        turtle.select(2)
                        turtle.placeDown()
                        turtle.forward()
                        turtle.placeDown()
                        turtle.forward()
                        turtle.placeDown()
                        turtle.forward()
                        turtle.placeDown()
                        turtle.forward()
                        turtle.placeDown()
                        turtle.forward()
                        turtle.placeDown()
                        turtle.forward()
                        turtle.placeDown()
                        turtle.forward()
                        turtle.placeDown()
                        turtle.forward()
                        for j = 1, 8 do
                               turtle.back()
                    
                                end
                       
 
end
 
function sidewall2()
                turtle.back()
                turtle.back()
                turtle.turnLeft()
                for i = 1, 6 do
                                turtle.forward()
                end
                turtle.turnRight()
                turtle.up()
                turtle.select(4)
               
                for j = 1, 5 do
                                turtle.placeDown()
                                turtle.forward()
                end
                turtle.back()
                turtle.turnRight()
                for k = 1, 7 do
                                turtle.forward()
                end
                turtle.turnRight()
               
                for j = 1, 5 do
                                turtle.placeDown()
                                turtle.forward()
                end
 
                turtle.turnRight()
                for j = 1, 7 do
                                turtle.forward()
                end
                turtle.up()
                turtle.turnRight()
end
 
function sidewall1()
       
                turtle.select(4)
        turtle.placeDown()
        turtle.forward()
        turtle.placeDown()
        turtle.forward()
        turtle.placeDown()
        turtle.forward()
        turtle.placeDown()
        turtle.forward()
        turtle.placeDown()
        turtle.turnRight()
        turtle.forward()
        turtle.placeDown()
        turtle.forward()
        turtle.placeDown()
        turtle.forward()
        turtle.placeDown()
        turtle.forward()
        turtle.placeDown()
        turtle.forward()
        turtle.placeDown()
        turtle.forward()
        turtle.placeDown()
        turtle.forward()
        turtle.placeDown()
        turtle.turnRight()
        turtle.forward()
        turtle.placeDown()
        turtle.forward()
        turtle.placeDown()
        turtle.forward()
        turtle.placeDown()
        turtle.forward()
        turtle.placeDown()
        turtle.forward()
                turtle.turnRight()
                                for j = 1, 7 do
                                                turtle.forward()
                                end
                turtle.up()
                turtle.turnRight()
end
 
function placerow()
                for i = 1, 8 do
                                turtle.select(1)
                                turtle.digDown()
                                turtle.placeDown()
                                turtle.forward()
                end
end
function turnaround()
                for i = 1, 8 do
                                turtle.back()
                end
                turtle.turnLeft()
                turtle.dig()
                turtle.forward()
                turtle.turnRight()
end
 
 
function floor()
    
               for i = 1, 6 do
                                placerow()
                                turnaround()
               end
                turtle.turnRight()
                for i = 1, 6 do
                        turtle.forward()
                end
                turtle.turnLeft()     
end
 
 
function clearrow()
                for i = 1, 8 do
                                turtle.dig()
                                turtle.forward()
                end
end
 
 
function cleararea()
                for i = 1, 6 do
   for i= 1, 8 do
                                 clearrow()
                                 turnaround()
                 end
                 gohome()
  turtle.digUp()
  turtle.up()
  end
  for i = 1, 6 do
   turtle.down()
  end
end
 
function equipmentarray()
                turtle.forward()
                turtle.turnLeft()
                turtle.forward()
                turtle.down()
                turtle.down()
                turtle.down()
                turtle.forward()
                turtle.forward()
                turtle.forward()
                turtle.forward()
                turtle.select(5)
                turtle.place()
                turtle.back()
                turtle.select(9)
                turtle.place()
                turtle.back()
                turtle.select(6)
                turtle.place()
                x = 10
                for i = 1, 5 do
                                turtle.turnRight()
                                turtle.forward()
                                turtle.turnLeft()
                                turtle.forward()
                                turtle.forward()
                                turtle.select(5)
                                turtle.place()
                                turtle.back()
                                turtle.select(x)
                                turtle.place()
                                turtle.back()
                                turtle.select(6)
                                turtle.place()
                                x = x + 1
                end
                -- get turtleiin position for side wall        
end
 
function makeceiling()
                turtle.select(16)
                turtle.turnRight()
                for i = 1, 8 do
                                turtle.placeDown()
                                turtle.forward()
                end
                turtle.back()
                turtle.turnLeft()
                turtle.forward()
                turtle.turnLeft()
 
                for i = 1, 8 do
                                turtle.placeDown()
                                turtle.forward()
                end
                                turtle.back()
                turtle.turnRight()
                turtle.forward()
                turtle.turnRight()
 
                for i = 1, 8 do
                                turtle.placeDown()
                                turtle.forward()
                end
                                turtle.back()
                turtle.turnLeft()
                turtle.forward()
                turtle.turnLeft()
 
                for i = 1, 8 do
                                turtle.placeDown()
                                turtle.forward()
                end
                turtle.back()
                turtle.turnRight()
                turtle.forward()
                turtle.turnRight()
 
                for i = 1, 8 do
                                turtle.placeDown()
                                turtle.forward()
                end
                                turtle.back()
                turtle.turnLeft()
                turtle.forward()
                turtle.turnLeft()
 
                for i = 1, 8 do
                                turtle.placeDown()
                                turtle.forward()
                end
                print("Ceiling..")
 
 
end
cleararea()
floor()
mainwall()
equipmentarray()
sidewall2()
sidewall1()
sidewall1()
makeceiling()
print("Union time..")