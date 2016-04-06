print("anzahl gaenge: ")
local g = read()
print("laenge der gaenge")
local l = read()

function run()
  while (turtle.detect()==false) do
    turtle.attack()
    turtle.forward()
  end
end
function dig()
  while turtle.detect() do
    turtle.dig()
    os.sleep(0.25)
  end
  turtle.forward()
  while turtle.detectUp() do
    turtle.digUp()
    os.sleep(0.5)
  end
end
function emptyinf()
  for i=1,16 do
    turtle.select(i)
    turtle.dropDown()
  end
  turtle.select(1)
end
function turn()
  turtle.turnLeft()
  turtle.turnLeft()
end
function refuel()
  turtle.suckUp()
  turtle.refuel()
end
for ag=1,g do
run()
for i=1,3 do
  dig()
end
turtle.turnLeft()
for al=1,l do
  dig()
end
turn()
run()
turtle.turnRight()
run()
emptyinf()
refuel()
turn()
end