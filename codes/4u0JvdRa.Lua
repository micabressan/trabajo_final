lightLevel = 0
distance = 0
runs = 0

function checkFuel()
	if turtle.getFuelLevel() <= 10 then
		turtle.select(16)
		if turtle.getItemCount() > 0 then
			turtle.refuel(1)
			turtle.select(1)
		-- elseif turtle.getItemCount < 1 then
		-- 	for i = 1, 13 do
		-- 		turtle.select(i)
		else
			print("Out of fuel! Terminating program.")
			error()
		end --if statement
	end --if statement
end --function

function torchCount()
	if lightLevel == 11 then
		turtle.select(15)
		if turtle.getItemCount() > 0 then
			turtle.turnLeft()
			turtle.dig()
			turtle.place()
			turtle.turnRight()
			turtle.select(1)
			lightLevel = 0
		else
			print("Out of torches! Terminating program.")
			lightLevel = 0
			error()
		end --if statement
	end --if statement
end --function

function digInFront()
	turtle.dig()
	turtle.forward()
	turtle.digUp()
end --function

function positionNextTunnelRight()
	turtle.turnRight()
	rightRuns = 0
	while rightRuns < 3
		turtle.dig()
		turtle.forward()
		turtle.digUp()
		rightRuns = rightRuns + 1
	end --while function
	turtle.turnRight()
end --function

function positionNextTunnelLeft()
	turtle.turnLeft()
	leftRuns = 0
	while leftRuns < 3
		turtle.dig()
		turtle.forward()
		turtle.digUp()
		leftRuns = leftRuns + 1
	end --while function
	turtle.turnLeft()
end --function

function checkInv()
	turtle.select (13)
	if turtle.getItemCount() > 0 then
		turtle.select(14)
		if turtle.getItemCount() > 0 then
			turtle.digDown()
			turtle.place()
			for i = 1, 13 do
				turtle.select(1)
				turtle.dropDown()
			end --while loop
			turtle.select(1)
		else
			print("Out of storage chests! Terminating program.")
			error()
		end --itemCount chest function
	end --inventory check function
end --function

--[[THIS IS WHERE THE MAIN PROGRAM STARTS]]--

-- Defines the length of the tunnels
print("How long should the tunnels be?")
length = tonumber(read())

-- Defines the number of tunnels
print("How many individual tunnels should be dug?")
count = tonumber(read())

-- Confirmation message
print("Now excavating the tunnels!")

while runs < count do
	checkFuel()
	torchCount()
	if distance < length then
		digInFront()
		distance = distance + 1
	else
		if runs % 2 == 0 then
			positionNextTunnelRight()
			runs = runs + 1
			distance = 0
		else
			positionNextTunnelLeft()
			runs = runs + 1
			distance = 0
		end --Check turn direction
	end --Digging tunnels
	checkInv()
	lightLevel = lightLevel + 1
end --Function

if runs % 2 == 0 then
	positionNextTunnelRight()
else
	positionNextTunnelLeft()
end --Check turn direction

print("The tunnels are complete!")