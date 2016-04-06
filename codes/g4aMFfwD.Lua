local range = 1
local max = 20

function step()
  if (turtle.getFuelLevel() < 10) then
    local slot = turtle.getSelectedSlot()
    turtle.select(1)
    turtle.refuel(1)
    turtle.select(slot)
  end
  turtle.forward()
  turtle.placeDown()
  if ( turtle.getItemCount() == 0 ) then
    turtle.select(turtle.getSelectedSlot() + 1)
  end
end

turtle.select(2)

while ( range < max ) do

  step()

  if ( range % 2 == 1 ) then
    turtle.turnLeft()
  else
    turtle.turnRight()
  end

  for i = 1, range do
    step()
  end

  if ( range % 2 == 1 ) then
    turtle.turnLeft()
  else
    turtle.turnRight()
  end

  for i = 1, range do
    step()
  end

  range = range + 1

  if ( range % 2 == 1 ) then
    turtle.turnLeft()
  else
    turtle.turnRight()
  end

end