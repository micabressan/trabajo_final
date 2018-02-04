-- Sline Turtles API v-0.11
-- All rights reserved by Sline Tech

local currentSlot = 3

-- Inventory functions.

function checkFuel() -- Coal at 1 slot needed.
	if turtle.getFuelLevel() < 1 then
		turtle.select(1)
		turtle.refuel(1)
	end
end

function checkSides(notTurnBack)
	if not turtle.detect() then
		return "front"
	end
	if not turtle.detectDown() then
		return "bottom"
	end
	if not turtle.detectUp() then
		return "top"
	end
	turtle.turnLeft()
	if not turtle.detect() then
		if not notTurnBack then
			turtle.turnRight()
		end
		return "left"
	end
	turtle.turnRight()
	turtle.turnRight()
	if not turtle.detect() then
		if not notTurnBack then
			turtle.turnLeft()
		end
		return "right"
	end
	turtle.turnRight()
	if not turtle.detect() then
		if not notTurnBack then
			turtle.turnLeft()
			turtle.turnLeft()
		end
		return "back"
	end
	return 0
end

function drop()
	local side = checkSides(true)
	
	if side == "front" then
		turtle.drop()
	elseif side == "back" then
		turtle.drop()
		turtle.turnLeft()
		turtle.turnLeft()
	elseif side == "bottom" then
		turtle.dropDown()
	elseif side == "top" then
		turtle.dropUp()
	elseif side == "left" then
		turtle.drop()
		turtle.turnRight()
	elseif side == "right" then
		turtle.drop()
		turtle.turnLeft()
	elseif side == 0 then	
		print("drop() error: no place for drop")
		return 0
	end
end

function reload(side) -- EnderChest at 2 slot needed.
	side = side or "front"
	local freeSpace = 14
	
	if turtle.detect() then
		print("reload() error: no place for putting enderchest")
		return 0
	end
	turtle.select(2)
	if side == "front" then
		turtle.place()
	elseif side == "top" then
		turtle.placeUp()
	elseif side == "bottom" then
		turtle.placeDown()
	end
	
	for i = 3, 16 do
		if turtle.getItemCount() < 1 then
			freeSpace = 17 - i
			break
		end
	end
	turtle.select(17 - freeSpace)
	for i = 1, freeSpace do
		if side == "front" then
			turtle.suck()
		elseif side == "top" then
			turtle.suckUp()
		elseif side == "bottom" then
			turtle.suckDown()
		end
	end
	
	turtle.select(2)
	if side == "front" then
		turtle.dig()
	elseif side == "top" then
		turtle.digUp()
	elseif side == "bottom" then
		turtle.digDown()
	end
	turtle.select(17 - freeSpace)
	currentSlot = 17 - freeSpace
end

-- Build functions.

function line(length, direction, replaceMode, numOfPlacings)
	direction = direction or "back"
	numOfPlacings = numOfPlacings or 1
	
	for i = 1, length do
		checkFuel()
		-- Checking free space in inventory.
		turtle.select(currentSlot)
		if turtle.getItemCount(currentSlot) < 1 then
			if turtle.getSelectedSlot() == 16 then
				if direction == "back" and not replaceMode then
					turtle.turnLeft()
					turtle.turnLeft()
					reload()
					turtle.turnLeft()
					turtle.turnLeft()
				elseif direction == "up" and not replaceMode then
					reload("top")
				elseif direction == "down" and not replaceMode then
					reload("bottom")
				elseif replaceMode then
					for i = 3, 16 do
						turtle.select(i)
						drop()
					end
					local freeSide = checkSides(true)
					if freeSide == "front" then
						reload("front")
					elseif freeSide == "top" then
						reload("top")
					elseif freeSide == "bottom" then
						reload("bottom")
					elseif freeSide == "left" then
						reload("front")
						turtle.turnRight()
					elseif freeSide == "right" then
						reload("front")
						turtle.turnLeft()
					elseif freeSide == "back" then
						reload("top")
						turtle.turnLeft()
						turtle.turnLeft()
					elseif freeSide == 0 then
						print("line() error: can't reload")
						return
					end
				end
			else
				currentSlot = currentSlot + 1
				turtle.select(currentSlot)
			end
		end
		-- Moving and building.
		if direction == "back" then
			if replaceMode then
				turtle.turnLeft()
				turtle.turnLeft()
				while turtle.detect() do
					turtle.dig()
				end
				turtle.turnLeft()
				turtle.turnLeft()
			end
			turtle.back()
			for i = 0, numOfPlacings do
				if numOfPlacings > 1 then
					sleep(0.2)
				end
				turtle.place()
			end
		elseif direction == "up" then
			if replaceMode then
				while turtle.detectUp() do
					turtle.digUp()
				end
			end
			for i = 0, numOfPlacings do
				if numOfPlacings > 1 then
					sleep(0.2)
				end
				turtle.placeDown()
			end
			turtle.up()
		elseif direction == "down" then
			if replaceMode then
				while turtle.detectDown() do
					turtle.digDown()
				end
			end
			turtle.placeUp()
			turtle.down()
		end
	end
end

-- Simpler moving funcs.

function up(length)
	lenght = length or 1 
	for i = 1, length do
		turtle.up()
	end
end

function down(length)
	lenght = length or 1 
	for i = 1, length do
		turtle.down()
	end
end

function back(length)
	lenght = length or 1 
	for i = 1, length do
		turtle.back()
	end
end

function fwrd(length)
	lenght = length or 1 
	for i = 1, length do
		turtle.foward()
	end
end

function left(length)
	lenght = length or 1 
	for i = 1, length do
		turtle.turnLeft()
	end
end

function right(length)
	lenght = length or 1 
	for i = 1, length do
		turtle.turnRight()
	end
end