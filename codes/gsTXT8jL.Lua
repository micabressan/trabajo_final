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

function dropBlock3(NbrBlock)-- modifier par rapport a sphere lua 3

	NB= tonumber(NbrBlock)

	for position = 1, NB do
		slotItem = turtle.getItemCount(slot)
		if slotItem > 0 then
			turtle.placeUp()
		else
			while slotItem == 0 do
				slot = slot+1
				slotItem = turtle.getItemCount(slot)
			end
					
			turtle.select(slot)
			turtle.placeUp()
					
		end
		
		if position ~= NB then 
			turtle.forward()
		end
	end
end

function uTurnRight()
	turtle.turnRight()
	turtle.forward()
	turtle.turnRight()
end

function uTurnLeft()
	turtle.turnLeft()
	turtle.forward()
	turtle.turnLeft()
end

function diagonalRight()
	turtle.turnRight()
	turtle.forward()
	turtle.turnLeft()
end

function rectangle2(largeur,longeur) -- besoin des function dropBlock3 uTurnRight uTurnLeft fuel

	local compteur = largeur
	local longeur2 = longeur
	
	local minfuel= (compteur*largeur)+1
	mincoal= math.ceil((minfuel + 320)/80)
	
	if compteur % 2 == 0 then
		fuel(minfuel,mincoal)
		for position = 1,(compteur/2) do
			dropBlock3(longeur2)
			uTurnRight()
			dropBlock3(longeur2)
			if position ~= (compteur/2) then 
				uTurnLeft()
			end
			if position == (compteur/2) then 
				uTurnLeft()
			end	
		end
	else
		fuel(minfuel,mincoal)
		dropBlock3(longeur2)
		uTurnRight()
		for position = 1,((compteur-1)/2) do
			dropBlock3(longeur2)
			uTurnLeft()
			dropBlock3(longeur2)
			if position ~= ((compteur-1)/2) then
				uTurnRight()
			end
			if position == ((compteur-1)/2) then
				turtle.turnRight()
				turtle.turnRight()
			end
		end
	end
end

function moveUp(level)

	local minfuel= level+80
	mincoal= math.ceil((minfuel + 400)/80)

	fuel(minfuel,mincoal)
	
	for position = 1, level do 
		turtle.up()
	end
end

function moveDown(level)

	local minfuel= level+80
	mincoal= math.ceil((minfuel + 320)/80)

	fuel(minfuel,mincoal)
	
	for position = 1, level do 
		turtle.down()
	end
end

moveUp(50)

for position = 1,4 do
	
	fuel(100,5)
	
	turtle.down()

	dropBlock3(7)

	fuel(100,5)

	uTurnRight()

	dropBlock3(7)

	fuel(100,5)

	uTurnLeft()

	dropBlock3(6)

	fuel(100,5)

	uTurnRight()
	
	dropBlock3(6)
	
	fuel(100,5)
	
	uTurnLeft()

	dropBlock3(5)

	fuel(100,5)

	uTurnRight()
	
	turtle.forward()

	dropBlock3(4)

	fuel(100,5)

	uTurnRight()
	
	fuel(100,5)

	dropBlock3(2)
	
	turtle.back()
	turtle.turnLeft()
	
	for position = 1,6 do
		fuel(160,5)
		turtle.forward()
	end

	turtle.turnRight()
end

for position = 1,2 do

	
	fuel(100,5)
	
	turtle.down()

	dropBlock3(6)

	fuel(100,5)

	uTurnRight()

	dropBlock3(6)

	fuel(100,5)

	uTurnLeft()

	dropBlock3(5)

	fuel(100,5)

	uTurnRight()

	dropBlock3(5)

	fuel(100,5)

	uTurnLeft()

	dropBlock3(4)

	fuel(100,5)

	uTurnRight()

	turtle.forward()
	turtle.forward()

	dropBlock3(2)

	turtle.turnRight()
	
	for position = 1,5 do
		fuel(160,5)
		turtle.forward()
	end

	turtle.turnRight()
end

for position= 1,2 do

	
	fuel(100,5)
	
	turtle.down()

	dropBlock3(5)

	fuel(100,5)

	uTurnRight()

	dropBlock3(5)

	fuel(100,5)

	uTurnLeft()

	dropBlock3(4)

	fuel(100,5)

	uTurnRight()
	
	dropBlock3(4)
	
	fuel(100,5)
	
	uTurnLeft()

	dropBlock3(2)

	fuel(100,5)
	
	turtle.back()
	turtle.turnLeft()
	
	for position = 1,4 do
		fuel(160,5)
		turtle.forward()
	end

	turtle.turnRight()
end

for position= 1,1 do
	
	fuel(100,5)
	
	turtle.down()

	dropBlock3(4)

	fuel(100,5)

	uTurnRight()
	
	dropBlock3(4)
	
	fuel(100,5)
	
	uTurnLeft()

	dropBlock3(3)

	fuel(100,5)

	uTurnRight()
	
	turtle.forward()

	dropBlock3(2)

	fuel(100,5)
	
	turtle.back()
	turtle.turnLeft()
	
	for position = 1,3 do
		fuel(160,5)
		turtle.forward()
	end

	turtle.turnRight()
end

for position= 1,1 do
	
	fuel(100,5)
	
	turtle.down()

	dropBlock3(3)

	fuel(100,5)

	uTurnRight()
	
	dropBlock3(3)
	
	fuel(100,5)

	dropBlock3(2)

	fuel(100,5)
	
	turtle.back()
	turtle.turnLeft()
	
	for position = 1,2 do
		fuel(160,5)
		turtle.forward()
	end

	turtle.turnRight()
end

for position= 1,1 do
	
	fuel(100,5)
	
	turtle.down()

	dropBlock3(1)

end

moveDown(39)