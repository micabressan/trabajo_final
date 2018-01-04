

request = game:GetService('HttpService'):GetAsync("http://www.hacker.org/coil/index.php?name=Trubisky&password=btjdwe2eg")
selx = 1
sely = 1
math.randomseed(tick())
folder = game.Workspace.storage
t = tostring
n=tonumber

function mysplit(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end
function rebuild(tables,remove)
local newtab = {}
local found = false
for i,v in pairs(tables) do
if v ~= remove then
	if found == false then
		newtab[i] = v
	else
		newtab[i-1] = v
	end
else found = true
end
end
return newtab
end

local d = tick()
tables = mysplit(request, "<")
newtab = {}
for i,v in pairs(tables) do
	if string.find(v, "FlashVars") then
			table.insert(newtab, v)
			
	end

	
end
local table3 = mysplit(newtab[1], '"')
local boardcords = ""
local x = ""
local y = ""
strings = table3[4]
spleet = mysplit(strings,"board")[2]
print(table3[4])
for i=1, string.len(spleet), 1 do
	if i~=1 then
		boardcords = boardcords..spleet:sub(i,i)
	end
end
spleet2=mysplit(strings,"&")[1]
for i=1, #spleet2, 1 do
	if i~= 1 and i ~= 2 then
		x = x..spleet2:sub(i,i)
	end
end
spleet2=mysplit(strings,"&")[2]
for i=1, #spleet2, 1 do
	if i~= 1 and i ~= 2 then
		y = y..spleet2:sub(i,i)
	end
end
print(boardcords)
print(x)
coordinates = {}

print(y)
print(tick() - d)
local r = 0
for i=1, tonumber(y), 1 do
	for a=1, tonumber(x), 1 do
		r = r + 1
		--[[local d = Instance.new('Part')
		d.Parent = folder
		d.Size = Vector3.new(2,1,2)
		d.CFrame = CFrame.new(0,0,0) + Vector3.new(2*a,0,2*i)
		d.Anchored = true
		d.Name = a..i--]]
		coordinates[t(a).."-"..t(i)] = {}
		coordinates[t(a).."-"..t(i)].selected = false
		coordinates[t(a).."-"..t(i)].filled = false
		coordinates[t(a).."-"..t(i)].x = a
		coordinates[t(a).."-"..t(i)].y = i
		coordinates[t(a).."-"..t(i)].turnpoint = false 
		if string.sub(boardcords,r,r) == "X" then
			--d.Color = Color3.fromRGB(255,0,0)
			coordinates[t(a).."-"..t(i)].filled = true
		end
		
	end
end
function updatemap(cords, mx, my)
folder:ClearAllChildren()

for i=1, tonumber(my), 1 do
	for a=1, tonumber(mx), 1 do
		--[[local d = Instance.new('Part')
		d.Parent = folder
		d.Size = Vector3.new(2,1,2)
		d.CFrame = CFrame.new(0,0,0) + Vector3.new(2*a,0,2*i)
		d.Anchored = true--]]
		if t(cords[t(a).."-"..t(i)].filled) == "true" then
			--d.Color = Color3.fromRGB(0,255,0)
		end
		if  t(cords[t(a).."-"..t(i)].selected) == "true" then
			--d.Color = Color3.fromRGB(255,0,0)
		end
		
		end
	end
end
logs = {}
function logstate(tables, num)
	local newtabz = {}
	for i=1, x, 1 do
		for a=1,y ,1 do
			newtabz[t(i).."-"..t(a)] = tables[t(i).."-"..t(a)]
			--print(t(i).."-"..t(a).." "..t(newtabz[t(i).."-"..t(a)].filled))
		end
	end
	logs[num] = newtabz
end
function state(num)
	return logs[num]
end
function options(coods, a, i)
local clone = coods
local directions = {-1,1,-1,1}
local avaliable = {}
	if clone[tostring(a + -1).."-"..tostring(i)] ~= nil and clone[tostring(a + -1).."-"..tostring(i)].filled ~= true then table.insert(avaliable, "l") end
	if clone[tostring(a + 1).."-"..tostring(i)] ~= nil and clone[tostring(a + 1).."-"..tostring(i)].filled ~= true then table.insert(avaliable, "r") end
	if clone[tostring(a).."-"..tostring(i + -1)] ~= nil and clone[tostring(a).."-"..tostring(i + -1)].filled ~= true then table.insert(avaliable, "u") end
	if clone[tostring(a).."-"..tostring(i +1)] ~= nil and clone[tostring(a).."-"..tostring(i + 1)].filled ~= true then table.insert(avaliable, "d") end
return avaliable
			--you have to finish fixing the values above for x1 and y2 then do a check return
end
function isdone(board)
	local done = true
	for i,v in pairs(board) do
		if t(v.filled) ~= "true" then
			done = false
		end
	end
	return done
end
function sortoptions()
	local options = {}
	for i=1, tonumber(y), 1 do
		for a=1, tonumber(x), 1 do
			local newtab = {}
			newtab.ecks = a
			newtab.why = i
			table.insert(options, newtab)
		end
	end
	return options
end
function moveoption(tables, option)
	local newtab = {}
	local solved = false
	for i,v in pairs(tables) do
		if solved ~= true then
			newtab[i+1] = v
		else
			newtab[i] = v
		end 
		if v == option then
			newtab[1] = v
			solved = true
		end
	end
	return newtab
end

function reshuffle(cords, opts)
	local movers = {}
	for i,v in pairs(opts) do
		if cords[t(v.ecks).."-"..t(v.why)].filled ~= true then
			table.insert(movers, v)
		end
	end
	if #movers == 1 then
		opts = moveoption(opts, movers[1])
			print("SHUFFLED")
	game:GetService('RunService').Stepped:Wait()
	end

	return opts
end
function ispossible(cords, mx, my)
	local result = true
	t = tostring
	local num = 0
	for i=1, tonumber(my), 1 do
	for a=1, tonumber(mx), 1 do
		if cords[t(a).."-"..t(i)].filled ~= true then
			local o = options(cords, a, i)
			if o == {} then --this section checks if there's any isolated tiles that are completely surronded; making it impossible
			result = false
			elseif #o == 1  then
				num = num + 1
			end
			--if #o == 1 then
			--	num = num + 1
			--end
		end
	end
	end

	
	--if num >= 2 then
	--	result = false
	--end
	for i=1, tonumber(mx), 1 do--establishes row scanning for fullness vertica;;y
		blocked=true
		for a=1, tonumber(my), 1 do
		if cords[t(i).."-"..t(a)].filled ~= true then
			blocked=false
		end
		end
		if blocked==true and i ~= 1 and i ~= maxx then
		hidden=false
		hidden1=false
			for ai=1, i-1, 1 do
				for aa=1, tonumber(my), 1 do
					--you just established if a row was blocked, this is the scanning on the left. (vertical rows)
					if cords[t(ai).."-"..t(aa)].filled ~= true then
						hidden = true
					end
				end
			end
			for ai=tonumber(mx), i+1, -1 do
				for aa=1, tonumber(my), 1 do
					--you just established if a row was blocked, this is the scanning on the right. (vertical rows)
					if cords[t(ai).."-"..t(aa)].filled ~= true then
						hidden1 = true
					end
				end
			end
			if hidden == true and hidden1 == true then
				result = false
			end
		end
	end
	
	--gap - below I'm doing the same as above but doing horizontal row scanning instead of vertical
	
	for i=1, tonumber(my), 1 do--establishes row scanning for fullness horizontally
		blocked=true
		for a=1, tonumber(mx), 1 do
		if cords[t(a).."-"..t(i)].filled ~= true then
			blocked=false
		end
		end
		if blocked==true and i ~= 1 and i ~= maxy then
		hidden=false
		hidden1=false
			for ai=1, i-1, 1 do
				if i-1 == 0 then break end
				for aa=1, tonumber(mx), 1 do
					--you just established if a row was blocked, this is the scanning on the left. (horizontal rows)
					if cords[t(aa).."-"..t(ai)].filled ~= true then
						hidden = true
					end
				end
			end
			for ai=tonumber(my), i+1, -1 do
				for aa=1, tonumber(mx), 1 do
					--you just established if a row was blocked, this is the scanning on the right. (horizontal rows)
					if cords[t(aa).."-"..t(ai)].filled ~= true then
						hidden1 = true
					end
				end
			end
			if hidden == true and hidden1 == true then
				result = false
			end
		end
	end
	return result
end



function restorestart(startx, starty)
r = 0
--print(startx)
--print(starty)
selx = startx 
sely = starty


for i=1, tonumber(y), 1 do
	--wait()
	for a=1, tonumber(x), 1 do
		r = r + 1
		--[[
		local d = Instance.new('Part')
		d.Parent = folder
		d.Size = Vector3.new(2,1,2)
		d.CFrame = CFrame.new(0,0,0) + Vector3.new(2*a,0,2*i)
		d.Anchored = true
		d.Name = a..i
		--]]
		coordinates[t(a).."-"..t(i)] = {}
		coordinates[t(a).."-"..t(i)].selected = false
		coordinates[t(a).."-"..t(i)].filled = false
		coordinates[t(a).."-"..t(i)].x = a
		coordinates[t(a).."-"..t(i)].y = i
		coordinates[t(a).."-"..t(i)].turnpoint = false
		if string.sub(boardcords,r,r) == "X" then
			--d.Color = Color3.fromRGB(255,0,0)
			coordinates[t(a).."-"..t(i)].filled = true
		end
		if i == starty and a == startx then
			--d.Color = Color3.fromRGB(255,0,0)
			coordinates[t(a).."-"..t(i)].selected = true
			
		end
		
	end
	
end

	
end









function revert(board, direction, x, y, sx, sy)
	--print(sx)
	--print(sy)
	tile = board[t(x).."-"..t(y)]
	board[t(x).."-"..t(y)].turnpoint = false
if direction == "d" then
why=0
while true do
why=why+1
if board[t(x).."-"..t(y + why)] ~= nil and t(board[t(x).."-"..t(y + why)].turnpoint) ~= "true" then
board[t(x).."-"..t(y + (why-1))].filled = false
board[t(x).."-"..t(y + (why-1))].selected = false
board[t(x).."-"..t(y+ why)].filled = true
board[t(x).."-"..t(y + why)].selected = true
selx = x
sely = y + why
else

if board[t(x).."-"..t(y+ why)] ~= nil then	
board[t(x).."-"..t(y + (why-1))].filled = false
board[t(x).."-"..t(y + (why-1))].selected = false
board[t(x).."-"..t(y+ why)].filled = true
board[t(x).."-"..t(y + why)].selected = true
selx = x
sely = y + why
else restorestart(sx, sy) end


break
end
end
elseif direction =="u" then
	
why=0
while true do
--print("-"...."-")
why=why-1
if board[t(x).."-"..t(y + why)] ~= nil and t(board[t(x).."-"..t(y + why)].turnpoint) ~= "true" then
--print(board[t(x).."-"..t(y + why)].filled)
board[t(x).."-"..t(y + (why+1))].filled = false
board[t(x).."-"..t(y + (why+1))].selected = false
board[t(x).."-"..t(y + why)].filled = true
board[t(x).."-"..t(y + why)].selected = true
selx = x
sely = y + why
else
--print(board[t(x).."-"..t(y + why)].filled)
if board[t(x).."-"..t(y + why)] ~= nil then
board[t(x).."-"..t(y + (why+1))].filled = false
board[t(x).."-"..t(y + (why+1))].selected = false
board[t(x).."-"..t(y + why)].filled = true
board[t(x).."-"..t(y + why)].selected = true
selx = x
sely = y + why
else  restorestart(sx, sy)  end
	--print("broke")
break
end
end

elseif direction =="l" then
why=0
while true do
why=why-1
if board[t(x + why).."-"..t(y)] ~= nil and board[t(x + why).."-"..t(y)].turnpoint ~= true then
board[t(x+ (why+1)).."-"..t(y)].filled = false
board[t(x + (why+1)).."-"..t(y)].selected = false
board[t(x + why).."-"..t(y)].filled = true
board[t(x + why).."-"..t(y)].selected = true
selx = x + why
sely = y 
else
	if board[t(x + why).."-"..t(y)] ~= nil then
	--print("broke")
	board[t(x+ (why+1)).."-"..t(y)].filled = false
board[t(x + (why+1)).."-"..t(y)].selected = false
board[t(x + why).."-"..t(y)].filled = true
board[t(x + why).."-"..t(y)].selected = true
selx = x + why
sely = y 
	else restorestart(sx, sy)  end
break
end
end
elseif direction == "r" then
why=0
while true do
why=why+1
if board[t(x + why).."-"..t(y)] ~= nil and board[t(x + why).."-"..t(y)].turnpoint ~= true then
board[t(x+ (why-1)).."-"..t(y)].filled = false
board[t(x + (why-1)).."-"..t(y)].selected = false
board[t(x + why).."-"..t(y)].filled = true
board[t(x + why).."-"..t(y)].selected = true
selx = x + why
sely = y
else
if board[t(x + why).."-"..t(y)] ~= nil then
board[t(x+ (why-1)).."-"..t(y)].filled = false
board[t(x + (why-1)).."-"..t(y)].selected = false
board[t(x + why).."-"..t(y)].filled = true
board[t(x + why).."-"..t(y)].selected = true
selx = x + why
sely = y
else restorestart(sx, sy)  end
break
end
end
end
return board
end






function opposite(dir)
	local dirs = {"u", "d", "r", "l"}
	local opposites = {"d", "u", "l", "r"}
	for i,v in pairs(dirs) do
		if v == dir then
			return opposites[i]
		end
	end
	
end













function move(board, direction, x, y)
tile = board[t(x).."-"..t(y)]
if direction == "d" then
why=0
while true do
why=why+1
if board[t(x).."-"..t(y + why)] ~= nil and board[t(x).."-"..t(y + why)].filled ~= true then
board[t(x).."-"..t(y + (why-1))].filled = true
board[t(x).."-"..t(y + (why-1))].selected = false
board[t(x).."-"..t(y+ why)].filled = true
board[t(x).."-"..t(y + why)].selected = true
selx = x
sely = y + why
else
	
break
end
end
elseif direction =="u" then
	
why=0
while true do
--print("-"...."-")
why=why-1
if board[t(x).."-"..t(y + why)] ~= nil and t(board[t(x).."-"..t(y + why)].filled) == "false" then
--print(board[t(x).."-"..t(y + why)].filled)
board[t(x).."-"..t(y + (why+1))].filled = true
board[t(x).."-"..t(y + (why+1))].selected = false
board[t(x).."-"..t(y + why)].filled = true
board[t(x).."-"..t(y + why)].selected = true
selx = x
sely = y + why
else
	--print("broke")
break
end
end

elseif direction =="l" then
why=0
while true do
why=why-1
if board[t(x + why).."-"..t(y)] ~= nil and board[t(x + why).."-"..t(y)].filled ~= true then
board[t(x+ (why+1)).."-"..t(y)].filled = true
board[t(x + (why+1)).."-"..t(y)].selected = false
board[t(x + why).."-"..t(y)].filled = true
board[t(x + why).."-"..t(y)].selected = true
selx = x + why
sely = y 
else
	--print("broke")
break
end
end
elseif direction == "r" then
why=0
while true do
why=why+1
if board[t(x + why).."-"..t(y)] ~= nil and board[t(x + why).."-"..t(y)].filled ~= true then
board[t(x+ (why-1)).."-"..t(y)].filled = true
board[t(x + (why-1)).."-"..t(y)].selected = false
board[t(x + why).."-"..t(y)].filled = true
board[t(x + why).."-"..t(y)].selected = true
selx = x + why
sely = y
else
break
end
end
end
return board
end
function solve()
	choseny= 0
	chosenx= 0
	indonee = false
	opps = sortoptions()
		while #opps ~= 0 do
			local tempcount = 0
			local v = opps[1]
--			rounds = rounds + 1
			crx = v.ecks
			cry = v.why
				stack = {}
				if coordinates[t(crx).."-"..t(cry)].filled ~= true then
				startopts = options(coordinates, crx, cry)
				for i,v in pairs(startopts) do
					--print("startop.."..v)
				end
				chosenx = crx
				choseny = cry
				selx = crx
				sely = cry
				stack[1] = {}
				stack[1].used = {}
				indexer = 1
				while true do
					--game:GetService('RunService').Stepped:Wait()
					--	print(selx)
					--	print(sely)
						opts = options(coordinates, selx, sely)
					
					--opts = options(coordinates, selx, sely)
					for i,v in pairs(stack[indexer].used) do
						opts = rebuild(opts, v)
						--print(v)
					end
					--left off here, you're having a problem parsing attempted options so it's skipping certain ones for some reason
					local check = t(ispossible(coordinates, x, y))
					if (#opts == 0) or check == "false"  then
						--if check=="false" then
						--	print("eliminated impossible")
						--	game:GetService('RunService').Stepped:Wait()
						--end
						if selx == crx and sely == cry then
						--	print("new tile")
							break
							
						else
						--print("reverted from last direction"..stack[indexer].last)
						--print(chosenx)
						--print(choseny)
						coordinates = revert(coordinates, opposite(stack[indexer].last), selx, sely, chosenx, choseny)
						table.insert(stack[indexer-1].used, stack[indexer].last)
						--print("DELETED "..stack[indexer].last)
						stack[indexer] = nil
						indexer = indexer - 1
						end
						
					else
						opps = reshuffle(coordinates, opps)
						chosdir = opts[math.random(#opts)]
						coordinates = move(coordinates, chosdir, selx, sely)
						coordinates[t(selx).."-"..t(sely)].turnpoint = true
						indexer = indexer + 1
						--print(chosdir)
						local templated = {}
						templated.last = chosdir
						templated.selx = selx
						templated.sely = sely
						templated.used = {}
						stack[indexer] = templated
					end
					updatemap(coordinates, x, y)
					if isdone(coordinates) == true then
						
						--print("start cords: "..chosenx.."-"..choseny)
						newtabb = {}
						for i=2, #stack, 1 do
							newtabb[i-1] = stack[i].last
							--print(stack[i].last)
						end
						
						isdonee = true
						
						break
						
					end
					
					
				end
				
						--code herre
				end	
				if isdonee == true then
					break
				end
			opps = rebuild(opps,v)
		end
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	return chosenx, choseny, newtabb
	
	
	
end
local start = tick()
startx, starty, moves = solve()
local finaltime = tick() - start
print(startx)
print(starty)
local finalstring = ""
for i=1, #moves, 1 do
	print(moves[i])
	finalstring = finalstring..(string.upper(moves[i]))
end
print(finalstring)
d = game:GetService('HttpService'):GetAsync("http://www.hacker.org/coil/index.php?name=Trubisky&password=boesge26&path="..finalstring.."&x="..(startx-1).."&y="..(starty-1))

print(d)
print("with efficiency: "..finaltime)