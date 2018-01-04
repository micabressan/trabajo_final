--[[CHARBON slot 14,
    TORCHES slot 15 et 16.]]

-- PLACER TORCHES TOUS LES 10 BLOCKS
    if distance == 10 then
      turtle.select(16)
      print("Placing tunnel torch...")
      turnAround()
      turtle.place()
      turnAround()
      distance = 0
      checkFuel()
    end --if
  end --for

-- REFUEL
function checkFuel()
  if turtle.getFuelLevel() <= 10 then
    turtle.select(14)
    turtle.refuel(1)
    turtle.select(1)
  end --if
end --checkFuel()