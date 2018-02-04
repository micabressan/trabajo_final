ref = "minecraft:wheat_seeds"
local success, block = turtle.inspect()
if success then
	if block.name == "minecraft:wheat" then
		print("i must plant wheat")
		if ref ~= "minecraft:wheat_seeds" then 
			turtle.dig()
		end
		planting(ref)
	end
end