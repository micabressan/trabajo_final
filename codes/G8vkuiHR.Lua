local direction = "up"

local function suck()
  if direction == "up" then
    turtle.suckDown(1)
  else
    turtle.suckUp(1)
  end
end

local function drop(side)
  turtle.select(11)
  if side == "up" then
    turtle.dropUp()
  elseif side == "down" then
    turtle.dropDown()
  else
    for i=1,16 do
	  turtle.select(i)
      turtle.drop()
	end
  end
end

local function fillCraft()
  for i=1,3 do
    turtle.select(i)
    suck()
  end
  for i=5,7 do
    turtle.select(i)
    suck()
  end
  for i=9,11 do
    turtle.select(i)
    suck()
  end
end

while true do
  fillCraft()
  if turtle.craft(1) == false then
    drop("forward")
    if direction == "up" then
	  direction = "down"
	else
	  direction = "up"
	end
  else
    drop(direction)
  end
  
end