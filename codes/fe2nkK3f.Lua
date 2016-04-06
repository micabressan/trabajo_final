
term.setCursorPos(9,4)
print("-=Lumber turtle 3000=-")
term.setCursorPos(9,6)
print("Press ANY key to start")

function keypress()
  local e1, k1 = os.pullEvent("key")
  if k1 == 28 then
   term.setCursorPos(14,9)
   print("Lumber away!")
   return true 
  end
end


function s1()
  while true do
    turtle.suck()
    turtle.select(1)
    turtle.transferTo(2)
    break
  end
end

sleep()


keypress()
os.sleep(2)


while true do
  if turtle.getSelectedSlot() < 5 then
    turtle.refuel()
  end
  term.setCursorPos(6,4)
  turtle.inspect()
  turtle.inspectDown()
  local return1, id1 = turtle.inspect()
  local return2, id2 = turtle.inspectDown()
  if id1.name == "minecraft:sapling" then
    print(id2.name)
    turtle.turnRight()
    turtle.forward()
    turtle.turnLeft()
    turtle.forward()
    turtle.forward()
    turtle.turnLeft()
    turtle.forward()
    turtle.turnRight()
  elseif id2.name == "minecraft:cobblestone" then
    turtle.turnRight()
    turtle.forward()
  elseif id2.name == "minecraft:stone" then
    turtle.turnLeft()
    turtle.forward()
  elseif id1.name == "minecraft:log" then
    for i=1,10 do
      turtle.dig()
      turtle.digUp()
      turtle.up()
      turtle.select(1)
      turtle.transferTo(2, 1)
      turtle.select(1)
    end
    for i=1,20 do
      os.sleep(0.5)
      turtle.down()
    end
  elseif id2.name == "minecraft:planks" and return1 == false then
    turtle.select(5)
    turtle.place()
  elseif id2.name == "minecraft:wool" then
    term.clear()
    term.setCursorPos(4,2)
    for i=2, 4 do
      turtle.select(i)
      turtle.drop()
    end
    print("Currently sleeping. (1m timer)")
    for i=2, 12 do
      os.sleep(5)
      term.setCursorPos(6,i)
    end   
    turtle.turnRight()
    turtle.select(1)
    term.clear()
  elseif return1 == false then
    turtle.forward()
  else
    turtle.dig() 
  end
end