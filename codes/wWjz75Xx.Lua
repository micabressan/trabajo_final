local position = 0 
local slot = 1

function fuel(limitLevelFuel,NbrCoal) -- 1 coal = 80 fuel unit / 1 fuel unit = 1 forward 

	lLF=tonumber(limitLevelFuel)

	NC=tonumber(NbrCoal)

	turtleNeedFuel = turtle.getFuelLevel()
	if turtleNeedFuel < lLF then
		turtle.select(16)  
		turtle.refuel(NC)
		turtle.select(slot)
	end
end

function moveUp(level)

	local minfuel= level+80
	mincoal= math.ceil((minfuel + 320)/80)

	fuel(minfuel,mincoal)
	
	for position = 1, level do 
		turtle.up()
	end
end

function uTurnLeft()
	turtle.turnLeft()
	turtle.forward()
	turtle.turnLeft()
end

function dropBlock4(NbrBlock)
	NB= tonumber(NbrBlock)

	for position = 1, NB do
		slotItem = turtle.getItemCount(slot)
		if slotItem > 0 then
			turtle.place()
		else
			while slotItem == 0 do
				slot = slot+1
				slotItem = turtle.getItemCount(slot)
			end
					
			turtle.select(slot)
			turtle.place()
					
		end
	end
end

function diagonalRight()
	turtle.turnRight()
	turtle.forward()
	turtle.turnLeft()
end

function moveDown(level)

	local minfuel= level+80
	mincoal= math.ceil((minfuel + 320)/80)

	fuel(minfuel,mincoal)
	
	for position = 1, level do 
		turtle.down()
	end
end

moveUp(6)

for position = 1,2 do -- stair
	for position = 1, 11 do
		fuel(160,5)
		turtle.forward()
	end

	turtle.turnLeft()

	for position = 1, 2 do
		fuel(160,5)
		turtle.forward()
	end

	fuel(160,5)

	dropBlock4(1)

	uTurnLeft()

	for position = 1, 2 do
		fuel(160,5)
		turtle.forward()
	end

	turtle.turnRight()

	for position = 1, 10 do
		fuel(160,5)
		turtle.forward()
	end
end

turtle.turnRight()

for position = 1,2 do
	for position = 1, 11 do
		fuel(160,5)
		turtle.forward()
	end

	turtle.turnLeft()

	for position = 1, 2 do
		fuel(160,5)
		turtle.forward()
	end

	fuel(160,5)

	dropBlock4(1)

	uTurnLeft()

	for position = 1, 2 do
		fuel(160,5)
		turtle.forward()
	end

	turtle.turnRight()

	for position = 1, 10 do
		fuel(160,5)
		turtle.forward()
	end
end

for position = 1,2 do -- centre + 1 triangleStair
	fuel(160,5)
	turtle.forward()
end

turtle.turnRight()

for position = 1,3 do
	fuel(160,5)
	turtle.forward()
end

turtle.turnLeft()

fuel(160,5)

dropBlock4(1)

for position = 1,2 do
	fuel(160,5)
	turtle.forward()
end

turtle.turnRight()

for position = 1,3 do
	fuel(160,5)
	turtle.forward()
end

turtle.turnLeft()

dropBlock4(1)

turtle.turnRight()

for position = 1,2 do
	fuel(160,5)
	turtle.forward()
end

turtle.turnLeft()

for position = 1,3 do
	fuel(160,5)
	turtle.forward()
end

uTurnLeft()

dropBlock4(1)

turtle.turnRight