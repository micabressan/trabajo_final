-- собираем тростник
function move(n)
 local i
 if n<0 then
  n=-n
  for i=1,n do
   while not turtle.back() do
    print("There is a something on my way!")
        sleep(4)
    turtle.turnLeft()
    turtle.turnLeft()
     while not turtle.forward() do
       print("There is a something on my way!")
        sleep(4)
     while turtle.detect() do
        turtle.dig()
     end
       turtle.attack()
     end
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.forward()
    end
  end
 else
  for i=1,n do
   while not turtle.forward() do
     print("There is a something on my way!")
--        sleep(4)
     if turtle.detect() then
        turtle.dig()
     else
       turtle.attack()
     end
   end
  end
 end
end

function refuelMe()
  for i4 = 1, 15 do
      if turtle.getItemCount(16)>63 then
       break
      end
      turtle.select(i4)
      if turtle.compareTo(16) then
        turtle.transferTo(16, 64)
      end
  end
  turtle.select(16)
  while turtle.getFuelLevel()<30 do
    turtle.refuel(1)
  end
  turtle.select(1)
end

function placeDown()
  if not turtle.detectDown() then
    if slot<16 and turtle.getItemCount(slot)<1 then
     slot=slot+1
    elseif slot>15 then
     slot=1
    end
  turtle.select(slot)
  turtle.placeDown()
  end
end

function movePlaceDown(n)
 local i
 for i=1,n do
--  placeDown()
 move(1)
 refuelMe()
 turtle.suckUp()
 turtle.suckDown()
 end
end

function placeAll()
for i3=1, 4 do
 movePlaceDown(3)
 turtle.turnLeft()
 movePlaceDown(1)
 turtle.turnLeft()
 
 movePlaceDown(3)
 turtle.turnRight()
 movePlaceDown(1)
 turtle.turnRight()
 
 movePlaceDown(3)
 turtle.turnLeft()
 movePlaceDown(1)
 turtle.turnLeft()
 
 movePlaceDown(3)
 turtle.turnRight()
 movePlaceDown(1)
 turtle.turnRight()
 
 movePlaceDown(4)
 turtle.turnRight()
 
 end
 --addseeds()
 --slot=1
end

function floor()
  slot=1
  turtle.select(slot)
  move(1)
  placeAll()
  turtle.back()
end

function couplefloor()
 while turtle.detect() do 
  floor()
  for i=1,4
   turtle.down()
  end
  floor()
  for i=1,4
   turtle.up()
  end
 end
end

--programma
slot=1
print("  *Label: ",os.getComputerLabel())
print("  *'Cane Farmer' prog. is active!")
print("fuel in slot 16, blocks in any")
refuelMe()
print("  *Fuel Level:",turtle.getFuelLevel())
print("press enter to continue,,")
read()
--if turtle.getItemCount(1)<1 then
-- print("I need a block in slot 1!")
if turtle.getFuelLevel()<30 then
 print("Not enough fuel!")
else
 while true do
   coupleflour()
 end
end