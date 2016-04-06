local robot = require("robot")

function column(height, dir)
  for c=0, height-1 do
        if dir == true then 
          robot.swingUp()
          robot.up()
        else 
          robot.swingDown()
          robot.down()
        end
  end
end

function slice(height, length, pos)
  for x=0, length-1 do
    if x%2 == 0 then
          column(height, pos)
        else
          column(height, not pos)
        end
        if x < (length-1) then
          robot.swing()
          robot.forward()
        end
  end
end

function room(height, length, width)
  for y=0, width-1 do
    if y%2 == 0 then
          slice(height, length, (length*y)%2 == 0)
          if y<(width-1) then
            robot.turnLeft()
            robot.swing()
            robot.forward()
            robot.turnLeft()
      end
        else
          slice(height, length, (length*y)%2 == 0)
          if y<(width-1) then
            robot.turnRight()
            robot.swing()
            robot.forward()
            robot.turnRight()
          end
        end
  end
end

function metro()
  room(6, 5, 5)
  
  robot.turnAround()
  for c=0, 5 do
    robot.down()
  end
  robot.forward()
  robot.turnRight()
  robot.swing()
  robot.forward()
  room(4, 2, 3)
  
  for c=0, 3 do
    robot.down()
  end
  robot.swing()
  robot.forward()
  robot.turnLeft()
  robot.swing()
  robot.forward()
  robot.turnAround()
  room(6, 5, 5)
  
  for c=0, 5 do
    robot.down()
  end
  robot.back()
  robot.turnRight()
  for c=0, 10 do
    robot.forward()
  end
  robot.turnLeft()
  robot.forward()
  robot.swing()
  robot.forward()
end

metro()