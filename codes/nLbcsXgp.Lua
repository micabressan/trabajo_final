os.loadAPI("sup")
os.loadAPI("bld")
 day = 1

 function planting(ref)
	if turtle.getItemCount() == 0 then
		sup.selectSlot(ref)
		turtle.place()
	else
		item = turtle.getItemDetail()
		if item.name == ref then
			turtle.place()
		else
			sup.selectSlot(ref)
			turtle.place()
		end
	end
end
	
function harvest(order,ref)
	if order == nil then
		local success, block = turtle.inspect()
		if success then
			if block.name == "minecraft:pumpkin" and block.name == "minecraft:melon_block" then
				turtle.dig()
				turtle.dig()
			elseif block.name == "minecraft:wheat" and block.metadata == 7 then
				turtle.dig()
				ref = "minecraft:wheat_seeds"
				planting(ref)
			elseif block.name == "minecraft:potatoes" and block.metadata == 7 then
				turtle.dig()
				ref = "minecraft:potato"
				planting(ref)
			elseif block.name == "minecraft:carrots" and block.metadata == 7 then
				turtle.dig()
				ref = "minecraft:carrot"
				planting(ref)
			else print("WTF THIS crap do on my farm?!")
			end
		end
	else
		local success, block = turtle.inspect()
		if success then
			if block.name == "minecraft:wheat" then
				--print("i must plant wheat")
				if ref ~= "minecraft:wheat_seeds" then
					turtle.dig()
					planting(ref)
				end
			elseif block.name == "minecraft:carrots" then
				if ref ~= "minecraft:carrot" then
					turtle.dig()
					planting(ref)
				end
			elseif block.name == "minecraft:potatoes" then
				if ref ~= "minecraft:potato" then
					turtle.dig()
					planting(ref)
				end
			end
		end
		planting(ref)
	end
end

function harvestFromLeft()
	turtle.turnLeft()
	harvest()
	turtle.turnRight()
end

function harvestFromRight()
	turtle.turnRight()
	harvest()
	turtle.turnLeft()
end

function harvestDouble(num,order)
	if num == 1 then
		ref = order[1]
	elseif num == 2 then
		ref = order[2]
	elseif num == 3 then
		ref = order[3]
	elseif num == 4 then
		ref = order[4]
	elseif num == 5 then
		ref = order[5]
	end
		
	turtle.turnLeft()
	harvest(order, ref)
	sup.turnAround()
	harvest(order, ref)
	turtle.turnLeft()
end
 
function farmRaw()
	for i = 1, 20, 1 do
		if i == 1 then
			turtle.forward()
		else
			harvestDouble(num,order)
			turtle.forward()
		end
	end
end

function rotate(j)
	if j == "left" then
		turtle.turnLeft()
		sup.move("forward", 4)
		turtle.turnLeft()
	else
		turtle.turnRight()
		sup.move("forward", 4)
		turtle.turnRight()
	end
end

function undock()
	for i = 1, 16, 1 do
		turtle.select(i)
		item = sup.getItemName()		
		if item == "minecraft:pumpkin" or item == "minecraft:melon_block" or item == "minecraft:wheat" 
		or item == "minecraft:carrot" or item == "minecraft:potato" or item == "minecraft:wheat_seeds" then
			turtle.drop()
		elseif item == "ComputerCraft:CC-TurtleAdvanced" then
			print("I think I'm pregnant.")
		end
	end
end

function checkTime(day)
	success, daylight = turtle.inspectUp()
	if success then
		if daylight.metadata < 7 then
			print("To late. I`m going to slee... Z-z-zz")
			repeat
			os.sleep(10)
			success, daylight = turtle.inspectUp()
			--print(daylight.metadata)
			until daylight.metadata > 6
			if day < 10 then			
				print("Day breaks. Beware, work!")
				day = day + 1
			elseif day >= 5 then
				print("It`s a ", day, " days without leave. But feeding well")
				day = day + 1
			elseif day >= 100 then
				print("So what, if not paid? But officially, and the work experience goes")
			end
		end
	end
end

function maintenance()
	turtle.forward()
	turtle.turnRight()
	turtle.forward()
	undock()
	checkTime(day)
	sup.turnAround()
	turtle.forward()
	turtle.turnLeft()
	turtle.forward()
	turtle.turnRight()
end

function start()
	sup.move("forward", 3)
	turtle.turnRight()
	sup.move("forward", 5)
end

function plantsRidges()
	sides = {"left", "right", "left", "right", "left"}
  for j = 1, #sides do
		num = j
		if j == 5 then
			farmRaw()
			turtle.turnLeft()
			sup.move("forward", 7)
			harvest()
			turtle.turnLeft()
		else
			farmRaw()
			rotate(sides[j])
		end
  end
end

function melonsRidges()
	for i = 0, 25, 1 do
		if i == 24 then
			harvestFromRight()
			turtle.forward()
		elseif i == 25 then
			harvest()
			turtle.turnRight()
			harvest()
			sup.turnAround()
		elseif i == 0 then
			turtle.forward()
		else
			harvestDouble()
			turtle.forward()
		end
	end
	
	for i = 0, 23, 1 do
		if i == 0 then
			turtle.forward()
		elseif i == 1 then
			harvestFromRight()
			turtle.forward()
		elseif i == 23 then
			harvestFromRight()		
		else
			harvestDouble()
			turtle.forward()
		end
	end
end

function farm()
	plantsRidges()
	melonsRidges()
	maintenance()	
	for i = 0, 5, 1 do
		if i == 4 then
			turtle.forward()
		elseif i == 0 then
			turtle.forward()
		elseif i == 5 then
		else
			harvestFromRight()
			turtle.forward()
		end
	end
	mode = 1
	farm()
end

function plant(answer)
	if answer == "1" then
		return "minecraft:wheat_seeds"
	elseif answer == "2" then
		return "minecraft:carrot"
	elseif answer == "3" then
		return "minecraft:potato"
	elseif answer == "0" then
		return nil
	end
end

-- mode 1 - сбор и посадка, mode 2 - посадка
function init()
	print("Should I sow a ridges?[yes/no]")
	answer1 = read()
	if answer1 == "yes" then
		mode = 2
		print("What should I plant on a ridges 1 and 2?")
		print("1 - Wheat, 2 - Carrots, 3 - Potatoes, 0 - Nothing")
		answer = read()
		order = {[1] = plant(answer)}
		print("What should I plant on a ridges 3 and 4?")
		print("1 - Wheat, 2 - Carrots, 3 - Potatoes, 0 - Nothing")
		answer = read()
		order[#order + 1] = plant(answer)
		print("What should I plant on a ridges 5 and 6?")
		print("1 - Wheat, 2 - Carrots, 3 - Potatoes, 0 - Nothing")
		answer = read()
		order[#order + 1] = plant(answer)
		print("What should I plant on a ridges 7 and 8?")
		print("1 - Wheat, 2 - Carrots, 3 - Potatoes, 0 - Nothing")
		answer = read()
		order[#order + 1] = plant(answer)
		print("What should I plant on a ridges 9 and 10?")
		print("1 - Wheat, 2 - Carrots, 3 - Potatoes, 0 - Nothing")
		answer = read()
		order[#order + 1] = plant(answer)
		--print("Got it.", order[1], order[2], order[3], order[4], order[5])
		start()
		farm()
	elseif answer1 == "no" then
		mode = 1
		start()
		farm()
	else init()
	end
end

init()