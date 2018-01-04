ref = "minecraft:wheat_seeds"
local success, block = turtle.inspect()
if success then
	if block.name == "minecraft:wheat" and ref ~= "minecraft:wheat_seeds" then
		print("i must plant wheat")
		turtle.dig()
		planting(ref)
	end
end