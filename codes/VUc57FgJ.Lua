local data = nil

local function find(item)
  for i=1,16 do
    turtle.select(i)
    data = turtle.getItemDetail()
    if data then
      if data.name == item then
        return true
      end
    end
  end
  --print("None found ya fucko")
  turtle.select(2)
  return false
end

---------------------------------------
---------         MAIN        ---------
---------------------------------------

while true do
  turtle.suckDown(64)
  if find("minecraft:log") then
    turtle.drop()
    turtle.dropDown()
  end
  turtle.suck(64)
  if find("minecraft:coal") then
    if turtle.getFuelLevel()<500 then
      --print("Fuck")
    end
    turtle.dropUp()
  end
  turtle.turnLeft()
  if find("minecraft:planks") == false then
    turtle.suckDown(16)
    turtle.craft(64)
  end
  find("minecraft:planks")
  turtle.drop()
  turtle.turnRight()
  os.sleep(30)
end