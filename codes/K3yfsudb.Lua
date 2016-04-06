wSF=1
SFLP=10

function checkInv()
  if turtle.getItemCount(1)<4 then
    turtle.select(1)
    turtle.turnLeft()
    turtle.suck()
    turtle.turnRight()
  end
  if turtle.getItemCount(2)<4 then
    turtle.select(2)
    turtle.turnRight()
    turtle.suck()
    turtle.turnLeft()
    turtle.select(1)
  end
  if turtle.getFuelLevel()<30 then
    turtle.select(3)
    turtle.turnRight()
    turtle.turnRight()
    turtle.suck()
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.refuel(32)
    turtle.select(1)
  end
  if turtle.getItemCount(1)<4 then
    wSF=0
  end
  if turtle.getItemCount(2)<4 then
    wSF=0
  end
  if turtle.getFuelLevel()<30 then
    wSF=0
  end
end

for i=1, SFLP do
checkInv()
if wSF==1 then
  turtle.up()
  turtle.up()
  turtle.select(1)
  turtle.place()
  turtle.up()
  turtle.forward()
  turtle.turnLeft()
  turtle.place()
  turtle.turnRight()
  turtle.turnRight()
  turtle.place()
  turtle.up()
  turtle.placeDown()
  turtle.select(2)
  turtle.place()
  turtle.turnLeft()
  turtle.turnLeft()
  turtle.place()
  turtle.turnRight()
  turtle.back()
  turtle.place()
  turtle.down()
  turtle.down()
  turtle.down()
  turtle.down()
  redstone.setOutput("front", true)
  sleep(50)
end
redstone.setOutput("front", false)
os.sleep(1)
turtle.up()
turtle.up()
turtle.select(16)
turtle.suck()
turtle.select(15)
turtle.suck()


  turtle.turnRight()
  turtle.turnRight()
  turtle.drop()
  turtle.select(16)
  turtle.drop()
  turtle.turnLeft()
  turtle.turnLeft()

turtle.select(1)
turtle.down()
turtle.down()
end