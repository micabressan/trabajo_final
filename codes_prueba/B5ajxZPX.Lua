
local map = {}
local sprites = {}
local gravity = {}

--CREDIT TO marumaru
function getColor ( mctag )
        if mctag == "&0" then
                return 32768
        elseif mctag == "&f" then
                return 1
        elseif mctag == "&e" then
                return 16
        elseif mctag == "&a" then
                return colors.lime
        elseif mctag == "&b" then
                return colors.lightBlue
        elseif mctag == "&c" then
                return colors.red
        elseif mctag == "&d" then
                return colors.pink
        elseif mctag == "&1" then
                return colors.blue
        elseif mctag == "&2" then
                return colors.green
        elseif mctag == "&3" then
                return colors.cyan
        elseif mctag == "&4" then
                return colors.red
        elseif mctag == "&5" then
                return colors.purple
        elseif mctag == "&6" then
                return colors.orange
        elseif mctag == "&7" then
                return colors.lightGray
        elseif mctag == "&8" then
                return colors.gray
        elseif mctag == "&9" then
                return colors.cyan
        else
                return 1
        end
end

-- CREIDT TO marumaru
function setPixel ( pix, piy, mcTag )
        oldx, oldy = term.getCursorPos()
        term.setCursorPos(pix,piy)
        term.setBackgroundColor(getColor(mcTag))
        write(" ")
        term.setBackgroundColor(getColor("&0"))
        term.setCursorPos(oldx,oldy)
end

function getLines(dir)
	if fs.exists(dir) then
		local lines = {}
		local cur = 1
		local file = fs.open(dir, "r")
		local line = file.readLine()
		while line ~= nil do
			lines[cur] = line
			line = file.readLine()
		end
		file.close()
		return lines
	else
		return nil
	end
end

function split(str, pat)
    local t = {}  -- NOTE: use {n = 0} in Lua-5.0
    if str ~= nil then
	   local fpat = "(.-)" .. pat
	   local last_end = 1
	   local s, e, cap = str:find(fpat, 1)
	   while s do
		  if s ~= 1 or cap ~= "" then
		 table.insert(t,cap)
		  end
		  last_end = e+1
		  s, e, cap = str:find(fpat, last_end)
	   end
	   if last_end <= #str then
		  cap = str:sub(last_end)
		  table.insert(t, cap)
	   end
	else
		print("##CGE ERROR failed to split ["..str.."] by:"..pat)
    end
    return t
end

function getTableSize(table)
	local cur = 0
	for i,v in ipairs(table) do
		cur = i
	end
	return cur
end

function addGravity(x, y, force)
	gravity[(#gravity)+1] = x..","..y..","..force
end

function removeGravity(grav)
	local splt = split(grav, ",")
	removeGravity(tonumber(splt[1]), tonumber(splt[2]), tonumber(splt[3]))
end

function removeGravity(x, y, force)
	local ngravity = {}
	local cur = 1
	for i,v in ipairs(gravity) do
		if v == x..","..y then else
			ngravity[cur] = v
			cur = cur + 1
		end
	end
end

function getGravityPoints()
	return gravity
end

function updateGravity(sprite, smart)
	local nsprite = {}
	local cur = 1
	local ok = true
	for j,k in ipairs(sprite) do
		local splt = split(v, ":")
		local x = splt[1]
		local y = splt[2]
		local type = splt[3]
		local name = splt[4]
		local maxani = splt[5]
		local curani = splt[6]
		local curv = splt[7]
		for i,v in ipairs(gravity) do
			local splt2 = split(v, ",")
			local px = tonumber(splt2[1])
			local py = tonumber(splt2[2])
			local force = tonumber(splt2[3])
			local distx = 0
			local disty = 0
			if px < x then distx = x - px else distx = px - x end
			if py < y then disty = y - py else disty = py - y end
			if (distx + disty)/2 <= force and ok then
				local xdif = 0
				local ydif = 0
				if px < x then xdif = -1 else xdif = 1 end
				if py < y then ydif = -1 else ydif = 1 end
				x = x + xdif
				y = y + ydif
			else
				if ok then else
					ok = false
				end
			end
		end
		nsprite[cur] = (x)..":"..(y)..":"..type..":"..name..":"..maxani..":"..curani..":"..curv
		cur = cur + 1
	end
	
	if checkCollision(nsprite, sprites) and smart then
		nsprite = sprite
	end
	
	if ok then else
		nsprite = sprite
	end
	return nsprite
end

function readMap(dir)
	local lines = getLines(dir)
	local map = nil
	if lines ~= nil then
		map = constructMap(lines)
	end
	return map
end

function readSprite(sx, sy, dir, name, maxani, colored)
	local plines = getLines(dir)
	local lines = {}
	local lcur = 1
	for i,v in ipairs(plines) do
		if colored then
			local nnline = string.gsub(v, "&", "")
			lines[lcur] = string.gsub(nnline, " ", "")
		else
			lines[lcur] = v
		end
		lcur = lcur + 1
	end
	local nsprite = {}
	local cur = 1
	if lines ~= nil then
		for i,v in ipairs(lines) do
			local y = i
			local line = v
			for x=1,string.len(line),1 do
				local type = string.sub(line, x, x)
				if colored then type = "&"..type end
				if type ~= " " then
					nsprite[cur] = (sx+x)..":"..(sy+y)..":"..type..":"..name..":"..maxani..":"..(1)..":".."0,0,0"
					cur = cur + 1
				end
			end
		end
	end
	return nsprite
end

function readAnimatedSprite(sx, sy, dirs, name, maxani, colored)
	local xtable = {}
	local ytable = {}
	local ttable = {}
	for i,v in ipairs(dirs) do
		local cur = 1
		local plines = getLines(v)
		local lines = {}
		local lcur = 1
		for i,v in ipairs(plines) do
			if colored then
				local nnline = string.gsub(v, "&", "")
				lines[lcur] = string.gsub(nnline, " ", "")
			else
				lines[lcur] = v
			end
			lcur = lcur + 1
		end
		if lines ~= nil then
			for j,k in ipairs(lines) do
				local y = j
				for x=1,#lines,1 do
					if xtable[cur] == nil then xtable[cur] = x+sx end
					if ytable[cur] == nil then ytable[cur] = y+sy end
					local type = string.sub(k, x, x)
					if colored then type = "&"..type end
					if ttable[cur] == nil then
						ttable[cur] = type
					else
						ttable[cur] = ttable[cur]..","..type
					end
				end
				cur = cur + 1
			end
		end
	end
	return createSprite(xtable, ytable, ttable, name, maxani)
end

function constructMap(mtable)
	local nmap = {}
	local cur = 1
	for i,v in ipairs(mtable) do
		local y = i
		local line = v
		for x=1,string.len(line),1 do
			local type = string.sub(line, x, x)
			nmap[cur] = x..":"..y..":"..type
			cur = cur + 1
		end
	end
	return nmap
end

function constructSprite(sx, sy, stable, name, maxani)
	if maxani == nil then maxani = 1 end
	local nsprite = {}
	local cur = 1
	for i,v in ipairs(stable) do
		local y = i
		local line = v
		for x=1,string.len(line),1 do
			local type = string.sub(line, x, x)
			if type ~= " " then
				nsprite[cur] = (sx+x)..":"..(sy+y)..":"..type..":"..name..":"..maxani..":"..(1)..":".."0,0,0"
				cur = cur + 1
			end
		end
	end
	return nsprite
end

function createSprite(xtable, ytable, ttable, name, maxani) 
	if maxani == nil then maxani = 1 end
	local sprite = nil
	local xsz = getTableSize(xtable)
	local ysz = getTableSize(ytable)
	local tsz = getTableSize(ttable)
	if xsz == ysz and xsz == tsz then
		local i = 1
		local cur = 1
		sprite = {}
		for i=1,xsz,1 do
			sprite[cur] = (xtable[i])..":"..(ytable[i])..":"..(ttable[i])..":"..name..":"..maxani..":"..(1)..":".."0,0,0"
			cur = cur + 1
		end
	end
	return sprite
end

function changeSprite(sprite, nsprite)
	if sprite ~= nsprite then
		local nsprites = sprites
		for i,v in ipairs(sprites) do
			if v == sprite then
				nsprites[i] = nsprite
			end
		end
		sprites = nsprites
	end
end

function getSpriteCode(sprite)
	local line = ""
	for i,v in ipairs(sprite) do
		if i == 1 then
			line = v
		else
			line = line.."#~#"..v
		end
	end
	return line
end

function readSpriteCode(code)
	local nsprite = {}
	local cur = 1
	local splt = split(code, "#~#")
	for i,v in ipairs(splt) do
		nsprite[cur] = v
		cur = cur + 1
	end
	return nsprite
end

function addSprite(sprite)
	local sz = getTableSize(sprites)
	sprites[sz+1] = sprite
end

function deleteSprite(sprite)
	local nsprites = {}
	for i,v in ipairs(sprites) do
		if v == sprite then else
			nsprites[i] = v
		end
	end
	sprites = nsprites
end

function getSprites()
	return sprites
end

function addSprites(nsprites)
	local sz = getTableSize(sprites)
	for i,v in ipairs(nsprites) do
		sprites[sz+1] = v
		sz = sz + 1
	end
end

function setSprites(nsprites)
	sprites = nsprites
end

function getMap()
	return map
end

function setMap(nmap)
	map = nmap
end

function setMapLoc(x, y, type)
	for i,v in ipairs(map) do
		local splt = split(v, ":")
		local cx = splt[1]
		local cy = splt[2]
		local ctype = splt[3]
		if cx == x and cy == y then
			map[i] = x..":"..y..":"..type
		end
	end
end

function getSpriteBounds(sprite)
	local upx = -1
	local upy = -1
	local downx = -1
	local downy = -1
	for i,v in ipairs(sprite) do
		local splt = split(v, ":")
		local x = splt[1]
		local y = splt[2]
		if upx == -1 then upx = x else
			if x > upx then upx = x end
		end
		if upy == -1 then upy = y else
			if y > upx then upy = y end
		end
		if downx == -1 then downx = x else
			if x > downx then downx = x end
		end
		if downy == -1 then downy = y else
			if y > downy then downy = y end
		end
	end
	return {upx, upy, downx, downy}
end

function flipSprite(sprite, flipx, flipy)
	local nsprite = {}
	local cur = 1
	local bounds = getSpriteBounds(sprite)
	for i,v in ipairs(sprite) do
		local splt = split(v, ":")
		local x = splt[1]
		local y = splt[2]
		local type = splt[3]
		local name = splt[4]
		local maxani = splt[5]
		local curani = splt[6]
		local curv = splt[7]
		
		if flipx and bounds[1] ~= -1 and bounds[3] ~= -1 then
			local difx = x-bounds[1]
			local difx2 = bounds[3]-bounds[1]
			local nx = difx2-difx
			x = nx+bounds[1]
		end
		if flipy and bounds[2] ~= -1 and bounds[4] ~= -1 then
			local dify = y-bounds[2]
			local dify2 = bounds[4]-bounds[2]
			local ny = dify2-dify
			y = ny+bounds[2]
		end
		nsprite[cur] = (x)..":"..(y)..":"..type..":"..name..":"..maxani..":"..curani..":"..curv
		cur = cur + 1
	end
	
	return nsprite
end

function getSprite(name)
	local csprite = nil
	for i,v in ipairs(sprites) do
		local sprite = v
		for j,k in ipairs(sprite) do
			local splt = split(k, ":")
			local cname = splt[4]
			if cname == name and csprite == nil then
				csprite = sprite
			end
		end
	end
	return csprite
end

function moveSprite(sprite, dirx, diry, smart)
	local bkup = sprite
	local nsprite = {}
	local cur = 1
	for i,v in ipairs(sprite) do
		local splt = split(v, ":")
		local x = splt[1]
		local y = splt[2]
		local type = splt[3]
		local name = splt[4]
		local maxani = splt[5]
		local curani = splt[6]
		local curv = splt[7]
		nsprite[cur] = (x+dirx)..":"..(y+diry)..":"..type..":"..name..":"..maxani..":"..curani..":"..curv
		cur = cur + 1
	end
	
	if smart then
		local checksprites = sprites
		for i,v in ipairs(sprites) do
			if v == sprites then else
				checksprites[i] = v
			end
		end
		if checkCollision(nsprite, checksprites) then
			nsprite = bkup
		end
	end
	
	return nsprite
end

function getCollision(sprite, sprites)
		for i,v in ipairs(sprites) do
		local cursprite = v
		if cursprite ~= sprite then
			for k,j in ipairs(cursprite) do
				local splt1 = split(j, ":")
				local cx = splt1[1]
				local cy = splt1[2]
				local tsplt = split(splt1[3], ",")
				local ctype = tsplt[tonumber(splt1[6])]
				
				for m,n in ipairs(sprite) do
					local splt2 = split(n, ":")
					local sx = splt2[1]
					local sy = splt2[2]
					local stsplt = split(splt2[3], ",")
					local stype = stsplt[tonumber(splt2[6])]
					if sx == cx and sy == cy then
						if ctype == " " or stype == " " then else
							return cursprite
						end
					end
				end
			end
		end
	end
	return nil
end

function checkCollision(sprite, sprites)
	for i,v in ipairs(sprites) do
		local cursprite = v
		if cursprite ~= sprite then
			for k,j in ipairs(cursprite) do
				local splt1 = split(j, ":")
				local cx = splt1[1]
				local cy = splt1[2]
				local tsplt = split(splt1[3], ",")
				local ctype = tsplt[tonumber(splt1[6])]
				
				for m,n in ipairs(sprite) do
					local splt2 = split(n, ":")
					local sx = splt2[1]
					local sy = splt2[2]
					local stsplt = split(splt2[3], ",")
					local stype = stsplt[tonumber(splt2[6])]
					if sx == cx and sy == cy then
						if ctype == " " or stype == " " then else
							return true
						end
					end
				end
			end
		end
	end
	return false
end

function setVelocity(sprite, dir, momentum)
	local nsprite = sprite
	local cur = 1
	for i,v in ipairs(sprite) do
		local splt = split(v, ":")
		local x = tonumber(splt[1])
		local y = tonumber(splt[2])
		local type = splt[3]
		local name = splt[4]
		local maxani = tonumber(splt[5])
		local curani = tonumber(splt[6])
		local curv = momentum
		for i,v in ipairs(dir) do
			curv = curv..","..v
		end
		nsprite[cur] = (x)..":"..(y)..":"..type..":"..name..":"..maxani..":"..curani..":"..curv
	end
	return nsprite
end

function getVelocity(sprite)
	local sz = getTableSize(sprite)
	local curv = nil
	if sz > 0 then
		local cplt = split(sprite[1], ":")
		if cplt ~= nil then
			curv = cplt[7]
		end
	end
	return curv
end

function updateVelocity(sprite, resistance, smart)
	local bkup = sprite
	local nsprite = {}
	local cur = 1
	for i,v in ipairs(sprite) do
		local splt = split(v, ":")
		local x = tonumber(splt[1])
		local y = tonumber(splt[2])
		local type = splt[3]
		local name = splt[4]
		local maxani = tonumber(splt[5])
		local curani = tonumber(splt[6])
		local curv = splt[7]
		local splt2 = split(curv, ",")
		local mom = tonumber(splt2[1])
		local res = 0
		local dir = {tonumber(splt2[2]), tonumber(splt2[3])}
		if mom > 0 then res = 1 end
		x = x + (res*dir[1])
		y = y + (res*dir[2])
		if mom > 0 then
			mom = mom - resistance
		end
		curv = mom..","..dir[1]..","..dir[2]
		nsprite[cur] = (x)..":"..(y)..":"..type..":"..name..":"..maxani..":"..curani..":"..curv
		cur = cur + 1
	end
	
	if smart then
		local checksprites = sprites
		for i,v in ipairs(sprites) do
			if v == sprite then else
				checksprites[i] = v
			end
		end
		if checkCollision(nsprite, checksprites) then
			nsprite = bkup
		end
	end
	if nsprite == {} or nsprite == nil then nsprite = bkup end
	return nsprite
end

function getCurAnimation(sprite)
	local sz = getTableSize(sprite)
	local curani = -1
	if sz > 0 then
		local cplt = split(sprite[1], ":")
		if cplt ~= nil then
			curani = splt[6]
		end
	end
	return curani
end

function animateSprite(sprite, forwards)
	local nsprite = sprite
	local cur = 1
	for i,v in ipairs(sprite) do
		local splt = split(v, ":")
		local x = tonumber(splt[1])
		local y = tonumber(splt[2])
		local type = splt[3]
		local name = splt[4]
		local maxani = tonumber(splt[5])
		local curani = tonumber(splt[6])
		local curv = splt[7]
		if forwards then 
			curani = curani + 1 
		else 
			curani = curani - 1
		end
		if curani > maxani then
			curani = 1
		elseif curani < 1 then
			curani = maxani
		end
		
		nsprite[cur] = (x)..":"..(y)..":"..type..":"..name..":"..maxani..":"..curani..":"..curv
		cur = cur + 1
	end
	return nsprite
end

function animateSprites(sprites, forwards)
	local nsprites = sprites
	local cur = 1
	for i,v in ipairs(sprites) do
		local nsprite = animateSprite(v, forwards)
		if nsprite ~= nil then
			nsprites[cur] = nsprite
			cur = cur + 1
		end
	end
	return nsprites
end



function setSpriteAnimationFrame(sprite, frame)
	local nsprite = sprite
	local cur = 1
	for i,v in ipairs(sprite) do
		local splt = split(v, ":")
		local x = tonumber(splt[1])
		local y = tonumber(splt[2])
		local type = splt[3]
		local name = splt[4]
		local maxani = tonumber(splt[5])
		local curv = splt[7]
		local curani = frame
		if curani > maxani then
			curani = 1
		elseif curani < 1 then
			curani = maxani
		end
		
		nsprite[cur] = (x)..":"..(y)..":"..type..":"..name..":"..maxani..":"..curani..":"..curv
		cur = cur + 1
	end
	return nsprite
end



function draw(offx, offy)
	local positions = {}
	local curp = 1
	for i,v in ipairs(map) do
		local splt = split(v, ":")
		local x = splt[1]
		local y = splt[2]
		local type = splt[3]
		local isok = true
		--for j, k in ipairs(positions) do
		--	local splt2 = split(k, ":")
		--	local cx = splt2[1]
		--	local cy = splt2[2]
		--	if cx == x and cy == y then
		--		isok = false
		--	end
		--end
		if isok then
			term.setCursorPos(offx+x, offy+y)
			term.write(type)
		end
	end
	for m,n in ipairs(sprites) do
		local sprite = n
		for j,k in ipairs(sprite) do
			local splt = split(k, ":")
			local x = splt[1]
			local y = splt[2]
			
			local tsplt = split(splt[3], ",")
			local curani = tonumber(splt[6])
			local type = tsplt[curani]
			local isok = true
--			for i, v in ipairs(positions) do
--				local splt2 = split(v, ":")
--				local cx = splt2[1]
--				local cy = splt2[2]
--				if cx == x and cy == y then
--					isok = false
--				end
--			end
			if isok and type ~= nil and type ~= " " then
				term.setCursorPos(offx+x, offy+y)
				term.write(type)
				positions[curp] = x..":"..y
				curp = curp + 1
			end
		end
	end
end

function colorDraw(offx, offy)
	local positions = {}
	local curp = 1
	for i,v in ipairs(map) do
		local splt = split(v, ":")
		local x = splt[1]
		local y = splt[2]
		local type = splt[3]
		local isok = true
		--for j, k in ipairs(positions) do
		--	local splt2 = split(k, ":")
		--	local cx = splt2[1]
		--	local cy = splt2[2]
		--	if cx == x and cy == y then
		--		isok = false
		--	end
		--end
		if isok then
			if string.sub(type, 1, 1) == "&" and string.len(type) > 1 then
				setPixel(offx+x, offy+y, type)
			else
				term.setCursorPos(offx+x, offy+y)
				term.write(type)
			end
		end
	end
	for m,n in ipairs(sprites) do
		local sprite = n
		for j,k in ipairs(sprite) do
			local splt = split(k, ":")
			local x = splt[1]
			local y = splt[2]
			
			local tsplt = split(splt[3], ",")
			local curani = tonumber(splt[6])
			local type = tsplt[curani]
			local isok = true
--			for i, v in ipairs(positions) do
--				local splt2 = split(v, ":")
--				local cx = splt2[1]
--				local cy = splt2[2]
--				if cx == x and cy == y then
--					isok = false
--				end
--			end
			if isok and type ~= nil and type ~= " " then
				if string.sub(type, 1, 1) == "&" and string.len(type) > 1 then
					setPixel(offx+x, offy+y, type)
				else
					term.setCursorPos(offx+x, offy+y)
					term.write(type)
					positions[curp] = x..":"..y
					curp = curp + 1
				end
			end
		end
	end
end