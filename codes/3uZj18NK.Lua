local range = 1
local max = 20

function step()
  turtle.forward()
  turtle.placeDown()
  if ( turtle.getItemCount() == 0 ) then
    turtle.select(turtle.getSelectedSlot() + 1)
  end
  if (turtle.getFuelLevel() < 10) then
    local slot = turtle.getSelectedSlot()
    turtle.select(1)
    turtle.refuel()
    turtle.select(slot)
  end
end


while ( range < max ) do

  step()

  if ( range % 2 == 1 ) then
    turtle.turnLeft()
  else
    turtle.turnRigth()
  end

  for i = 1, range do
    step()
  end

  if ( range % 2 == 1 ) then
    turtle.turnLeft()
  else
    turtle.turnRigth()
  end

  for i = 1, range do
    step()
  end

  range = range + 1

  if ( range % 2 == 1 ) then
    turtle.turnLeft()
  else
    turtle.turnRigth()
  end

end