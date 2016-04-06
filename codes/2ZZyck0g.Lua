term.clear()
term.setCursorPos(1, 1)

repeat
	print("Enter tunnel length (even digit): ")
	tunnellength = read()
until tunnellength % 2 == 0

term.clear()
term.setCursorPos(1, 1)

fueltype = 80
torchpos = 0

print("Place fuel in Slot 1")
print("Place cobblestone in Slot 2")
print("Place torches in Slot 3")
print("")
print("Begin mining?")
print("0=Cancel Program, Any Key=Yes")
beginmine = read()
if beginmine == "0" then
	os.reboot()
end

term.clear()
term.setCursorPos(1,1)
print("Tunneling " .. tunnellength .. " blocks, then returning.")
sleep(2)

function progress()
	term.setCursorPos(1,3)
	print("Progress: " .. torchpos .. " of " .. tunnellength)
end

function fuelcheck()
	if turtle.getFuelLevel()/fueltype < 0.26 then
		turtle.select(1)
		turtle.refuel(1)
	end
end

function dropcobble()
    local stackSize = turtle.getItemCount(2)
	stackSize = stackSize-1
	turtle.select(2)
	turtle.drop(stackSize)
end

function minewall(direction)
	fuelcheck()
	turtle.select(1)
	turtle.dig()
	digSequence()
	if direction == "right" then
		turtle.turnRight()
	else
		turtle.turnLeft()
	end
	digSequence()
	digSequence()
	if direction == "right" then
		turtle.turnLeft()
	else
		turtle.turnRight()
	end
	torchpos = torchpos + 1
	progress()
end

function digSequence()
	moveforward()
	turtle.digDown()
	turtle.digUp()
end

function minecycle()
	for z = 1, tunnellength/2 do
		minewall("right")
		minewall("left")
		placetorch()
	end
end

function placetorch()
	if torchpos % 6 == 0 then
		turtle.select(3)
		turtle.placeDown()
		dropcobble()
		fuelcheck()
		fullinventory()
		turtle.select(1)
	end
end

function moveforward()
	while not turtle.forward() do
		sleep(0.25)
		turtle.dig()
	end
end

function turtlehome()
	for y = 1, tunnellength do
		fuelcheck()
		moveforward()
	end
end

function fullinventory()
	local invcount = 0
	for c = 4, 16 do
		if turtle.getItemCount(c) > 0 then
		invcount = invcount+1
		end
	end
	if invcount > 12 then
		turtle.turnLeft()
		turtle.turnLeft()
		fuelcheck()
		for f = 1, torchpos+1 do
			moveforward()
			fuelcheck()
		end
		for d = 4, 16 do
			turtle.select(d)
			turtle.dropDown()
		end
		turtle.turnLeft()
		turtle.turnLeft()
		fuelcheck()
		for f = 1, torchpos+1 do
			moveforward()
			fuelcheck()
		end
		invcount = 0
	else
		invcount = 0
	end
end

function depositcomplete()
	for d = 1, 16 do
		turtle.select(d)
		turtle.drop()
	end
end

fuelcheck()
turtle.digUp()
turtle.up()
minecycle()
turtle.turnLeft()
turtle.turnLeft()
fuelcheck()
turtlehome()
turtle.down()
depositcomplete()
turtle.turnRight()
turtle.turnRight()
term.setCursorPos(1,5)
print("Mining Successful")
term.setCursorPos(1,7)