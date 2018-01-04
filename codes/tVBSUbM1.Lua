rednet.open("left")
  while true do
  local event, message, protocol = rednet.receive()
--Programs--  
  if message == "forward" then
    turtle.forward()
    end
  if message == "back" then
    turtle.back()
    end
  if message == "turnleft" then
    turtle.turnLeft()
    end
  if message == "turnright" then
    turtle.turnRight()
    end
  if message == "dig" then
    turtle.dig()
    end
  if message == "up" then
    turtle.up()
    end
  if message == "down" then
    turtle.down()
    end
  if message == "digdown" then
    turtle.digDown()
    end
  if message == "digup" then
    turtle.digUp()
    end
  if message == "pick" then
    turtle.suck()
    end
  if message == "drop" then
    turtle.drop()
    end
  if message == "place" then
    turtle.place()
    end
  end