local size = 0.4 --size 0.3 - default
local offsetx = 75 -- Def 150
local offsety = 75 -- Def 100

local l = peripheral.wrap("back")
local lol = l.canvas()

lol.clear()
-- Init
local box = {}
for i=-8,8,1 do
	box[i]={}
	for j=-8,8,1 do
		box[i][j] = lol.addText({offsetx+i*(size*20),offsety+j*(size*20)},"=",2555,size)
		box[i][j].setColor(255,255,255)
	end
end
local wel = "Welcome"
for i=1,string.len(wel),1 do
	box[-4+i][0].setText(string.sub(wel,i,i))
end

sleep(3)

local loooo = lol.addText({offsetx,offsety},"X",2555,size)
loooo.setColor(255,255,255)



local blink = 0
while true do
    for i=-8,8,1 do
        for j=-8,8,1 do
            box[i][j].setText(" ")
        end
    end
    for i,v in pairs(l.scan()) do
        if v.name:sub(v.name:len()-2) == "ore" or v.name == "minecraft:lava" then
            box[v.x][v.z].setText(tostring(v.y))
			local lmm = box[v.x][v.z]
            lmm.setColor(255,255,255)
            lmm.setAlpha(255)
            if v.name == "minecraft:coal_ore" then
                lmm.setColor(150,150,150)
            elseif v.name == "minecraft:iron_ore" then
                lmm.setColor(255,150,50)
            elseif v.name == "minecraft:lava" then
                lmm.setColor(150,75,0)
            elseif v.name == "minecraft:gold_ore" then
                lmm.setColor(255,255,0)
            elseif v.name == "minecraft:diamond_ore" then
                lmm.setColor(0,255,255)
            elseif v.name == "minecraft:redstone_ore" then
                lmm.setColor(255,0,0)
            elseif v.name == "minecraft:lapis_ore" then
                lmm.setColor(0,50,255)
            elseif v.name == "minecraft:emerald_ore" then
                lmm.setColor(0,255,0)
            end
            
        end
    end
    blink = blink + 1
    if blink == 2 then
        blink = 0
		loooo.setAlpha(0)
    elseif blink == 1 then
        loooo.setAlpha(255)
    end
    sleep(0.3)
end