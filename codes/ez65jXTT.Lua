local i, h
local fuel
while true do
h = 0
while h<10 do
i = 0
while i<19 do
turtle.dig()
turtle.forward()
i = i+1
end
i = 0
turtle.turnLeft()
turtle.forward()
turtle.forward()
turtle.turnLeft()
while i<19 do
turtle.dig()
turtle.forward()
i = i+1
end
turtle.turnRight()
turtle.forward()
turtle.forward()
turtle.turnRight()
h = h+1
os.sleep(10)
end
print("Field cleared")
turtle.turnLeft()
local j =1
repat
turtle.forward()
j = j+1
until j ==18
print("Posicio inical")
for g=1,16 do
turtle.select(g)
num = turtle.getItemCount(g)
if num>0 then
turtle.dropDown(num)
end
end
fuel = turtle.getFuelLevel()
if fuel <500 then
turtle.suckUp(5)
turtle.refuel(5)
end
end