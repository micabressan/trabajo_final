--[[
	Code to-do list:
		*Auto chest deposit
		*Auto torch placement for branches and better torch logic for tunnel
		*Rednet flags
		*Finish branch function
			*torch placement
			*more efficient logic
		*Improve efficiency
		*Various others
	Newest Features:
		*Main tunnel function
		*Ore priorities
]]--

-- Round to integers if within bounds 
function round(num, bounds)
	if(num > 0) then
		if(num + bounds >= math.ceil(num)) then
			return math.ceil(num)
		elseif(num - bounds <= math.floor(num)) then
			return math.floor(num)
		end
	elseif(num < 0) then
		if(num - bounds <= math.floor(num)) then
			return math.floor(num)
		elseif(num + bounds >= math.ceil(num)) then
			return math.ceil(num)
		end
	end
	return num
end

-- Test if 2 points are equal in 3D 
function testPointEquality(p1,p2)
	if(p1[2] == p2[2] and p1[3] == p2[3] and p1[4] == p2[4]) then
	return true
	else return false
	end
end

-- Obtain a table of 4 valid gps reference points 
function getGPSCoordinates(timeOut)
	local timeOut = timeOut or 2
	local computer = require("computer")
	local event = require("event")
	local timer = computer.uptime()
	local points = {}
	while(computer.uptime() - timer < timeOut*4 and #points<4) do
		--print("Timer: "..computer.uptime() - timer)
		
		--[[	Data i assumed to be meaningful! 
			This could be a huge problem, but will usually work if this 
			port is only used for gps, a fix should be inplemented
		]]--

		local eventType, recieverAddress, senderAddress, port, distance, x,y,z = event.pull(timeOut, "modem_message")
		if(distance ~= nil and x ~= nil and y ~= nil and z ~= nil) then
			local tmp = {distance, x,y,z}
			tmp = tonumberVector(tmp)
			local same = false
			for i=1, #points do
				if(testPointEquality(points[i], tmp)) then
					same = true
					--print("Same point!")
					break
				end
			end
			if(not same) then
				if(#points<3) then
					points[#points+1] = tmp
					--print("Point added:"..tostring(tmp[1]))
					--print(#points)
				else
					local normPlane = getPlane(points[1],points[2],points[3])
					--print(tostringVector(normPlane))
					if(isInPlane(tmp,points[1],normPlane)) then
						--print("Point in plane!")
					else
						--print("Point not in plane, adding point")
						points[#points+1] = tmp
						--print(#points)
					end
				end
			end
		else
			print("Nil event type")
		end
	end
	--print(#points)
	if(#points >3) then
		return points
	else 
		return nil
	end
end

-- Split a string into a table at occurrence of sep 
function split(inputstr, sep)
	if(inputstr == nil or inputstr == "") then
                return nil
        end
        if sep == nil then
                sep = ","
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end

-- Add two vectors
function addVector(p1,p2)
	--p1 + p2
	return {p1[1]+p2[1], p1[2]+p2[2], p1[3]+p2[3]}
end

-- Subtract two vectors
function subtractVector(p1,p2)
	--p1 - p2
	return {p1[1]-p2[1], p1[2]-p2[2], p1[3]-p2[3]}
end

-- Scale a vector
function scaleVector(p1, scalar)
	--p1 * scalar
	return {p1[1]*scalar, p1[2]*scalar, p1[3]*scalar}
end

-- Dot two vectors
function dotVector(p1,p2)
	return p1[1]*p2[1] + p1[2]*p2[2] + p1[3]*p2[3]
end

-- Cross two vectors
function crossVector(p1,p2)
	return {p1[2]*p2[3] - p1[3]*p2[2], p1[3]*p2[1] - p1[1]*p2[3], p1[1]*p2[2] - p1[2]*p2[1]}
end

-- Returns the magnitude of a vector
function magnitudeVector(p1)
	return math.sqrt(math.pow(p1[1], 2) + math.pow(p1[2], 2) + math.pow(p1[3], 2))
end

-- Normalize a vector
function normalizeVector(p1)
	return p1/magnitudeVector(p1)
end

-- Get a plane from 3 vectors
function getPlane(p1,p2,p3)
	--find the equation of the plane
	local p12 = subtractVector(p2,p1)
	local p13 = subtractVector(p3,p1)
	local plane = crossVector(p12,p13)
	return plane
end

-- Check if a vector is in a plane
function isInPlane(p1,p2,p3)
	local bounds= 0.000001
	--[[
		where:
		p1 is the point in question,
		p2 is a point known to exist on plane p3,
		and p3 is the plane in question
	]]--
	if(dotVector(subtractVector(p1,p2),p3) < bounds and dotVector(subtractVector(p1,p2),p3) > -bounds) then
		return true
	else
		return false
	end
end

-- Rotate a vector around the Z axis
function rotateVectorZAxis(p1,theta)
	return {p1[1]*math.cos(theta) - p1[2]*math.sin(theta), p1[1]*math.sin(theta) + p1[2]*math.cos(theta), p1[3]}
end

-- Rotate a vector around the X axis
function rotateVectorXAxis(p1,theta)
	return {p1[1], p1[2]*math.cos(theta) - p1[3]*math.sin(theta), p1[2]*math.sin(theta) + p1[3]*math.cos(theta)}
end

-- Rotate a vector around the Y axis
function rotateVectorYAxis(p1,theta)
	return {p1[1]*math.cos(theta) + p1[3]*math.sin(theta), p1[2], p1[3]*math.cos(theta) - p1[1]*math.sin(theta)}
end

-- Turn a vector into a string
function tostringVector(p1)
	return tostring(p1[1]) .. "," .. tostring(p1[2]) .. "," .. tostring(p1[3])
end

-- Turn a vector into a number
function tonumberVector(p1)
	local tmp = {}
	for i=1, #p1 do
		tmp[i] = tonumber(p1[i])
	end
	return tmp
end

-- Round each entry of a vector using the round() function above
function roundVector(p1)
	local bounds = 0.000001
	local tmp = {}
	--[[
	for i=1, #p1 do
		if(p1[i] < bounds and p1[i] > -bounds) then
			tmp[i] = 0
		else
			tmp[i] = p1[i]
		end
	end
	]]--
	for i=1, #p1 do
		tmp[i] = round(p1[i],bounds)
	end
	return tmp
end

-- Obtain the distance between two vectors
function distanceBetweenPoints(p1,p2)
	return math.sqrt(math.pow(p1[1]-p2[1],2) + math.pow(p1[2]-p2[2],2) + math.pow(p1[3]-p2[3],2))
end

-- 2D trilateration 
function findPossiblePoints2D(d1,p1,d2,p2)
	local distance = distanceBetweenPoints(p1,p2)
	local a = (math.pow(d1, 2) - math.pow(d2, 2) + math.pow(distance, 2)) / (2 * distance)
	--print(a)
	local intersect = addVector(p1,scaleVector(scaleVector(subtractVector(p2,p1), a), (1/distance)))
	--print(tostringVector(intersect))
	local h = math.sqrt(math.pow(d1, 2) - math.pow(a, 2))
	--print(h)
	local x_plus = intersect[1] + ((h*(p2[2]-p1[2]))/distance)
	local x_minus = intersect[1] - ((h*(p2[2]-p1[2]))/distance)
	local y_plus = intersect[2] + ((h*(p2[1]-p1[1]))/distance)
	local y_minus = intersect[2] - ((h*(p2[1]-p1[1]))/distance)
	return {x_plus,y_minus,0}, {x_minus,y_plus,0}
end

-- 3D trilateration
function findPossiblePoints3D(d1,p1,d2,p2,d3,p3)
	
	--print("Trilateration points: "..d1..","..tostringVector(p1)..";"..d2..","..tostringVector(p2)..";"..d3..","..tostringVector(p3))
	
	--offset vectors such that p1 is at 0,0,0
	local offset = scaleVector(p1, -1)
	--print("Offset: "..tostringVector(offset))
	local p1p = addVector(p1, offset)
	--print("p1p: "..tostringVector(p1p))
	local p2p = addVector(p2, offset)
	--print("p2p: "..tostringVector(p2p))
	local p3p = addVector(p3, offset)
	--print("p3p: "..tostringVector(p3p))
	
	--print("Offset vectors: "..tostringVector(p1p).."; "..tostringVector(p2p).."; "..tostringVector(p3p))


	--find the equation of the plane
	local plane = roundVector(getPlane(p1p,p2p,p3p))
	--print("Plane: "..tostringVector(plane))

	-- checked up to here --
	
	--rotate first about the y axis such that p2 is at z = 0
	local angle1
	if(p2p[1] ~= 0)then
		angle1 = math.atan(p2p[3]/p2p[1])
	elseif(p2p[3] > 0) then
		--	90 degrees
		angle1 = 1.57079633
	elseif(p2p[3] < 0) then
		--	-90 degrees
		angle1 = -1.57079633
	end
	--print("Angle1: "..angle1)
	local plane_ry = roundVector(rotateVectorYAxis(plane, angle1))
	--print("plane_ry: "..tostringVector(plane_ry))
	local p1p_ry = roundVector(rotateVectorYAxis(p1p, angle1))
	--print("p1p_ry: "..tostringVector(p1p_ry))
	local p2p_ry = roundVector(rotateVectorYAxis(p2p, angle1))
	--print("p2p_ry: "..tostringVector(p2p_ry))
	local p3p_ry = roundVector(rotateVectorYAxis(p3p, angle1))
	--print("p3p_ry: "..tostringVector(p3p_ry))
	
	--rotate second about the z axis such that p2 is at y = 0 and the line from p1 to p2 is at z=0 y=0, and is hence on the x axis
	local angle2
	if(p2p_ry[1] ~= 0)then
		angle2 = (-1) * math.atan(p2p_ry[2]/p2p_ry[1])
	elseif(p2p_ry[2] > 0) then
		--	-90 degrees
		angle2 = -1.57079633
	elseif(p2p_ry[2] < 0) then
		--	90 degrees
		angle2 = 1.57079633
	end
	--print("Angle2: "..angle2)
	local plane_ryz = roundVector(rotateVectorZAxis(plane_ry, angle2))
	--print("plane_ryz: "..tostringVector(plane_ryz))
	local p1p_ryz = roundVector(rotateVectorZAxis(p1p_ry, angle2))
	--print("p1p_ryz: "..tostringVector(p1p_ryz))
	local p2p_ryz = roundVector(rotateVectorZAxis(p2p_ry, angle2))
	--print("p2p_ryz: "..tostringVector(p2p_ryz))
	local p3p_ryz = roundVector(rotateVectorZAxis(p3p_ry, angle2))
	--print("p3p_ryz: "..tostringVector(p3p_ryz))
	
	--rotate plane about the x axis such that p3 is at z = 0
	local angle3
	if(p3p_ryz[2] ~= 0)then
		angle3 = (-1) * math.atan(p3p_ryz[3]/p3p_ryz[2])
	elseif(p3p_ry[3] > 0) then
		--	-90 degrees
		angle3 = -1.57079633
	elseif(p3p_ry[3] < 0) then
		--	90 degrees
		angle3 = 1.57079633
	end
	--print("Angle3: "..angle3)
	local plane_ryzx = roundVector(rotateVectorXAxis(plane_ryz, angle3))
	--print("plane_ryzx: "..tostringVector(plane_ryzx))
	local p1p_ryzx = roundVector(rotateVectorXAxis(p1p_ryz, angle3))
	--print("p1p_ryzx: "..tostringVector(p1p_ryzx))
	local p2p_ryzx = roundVector(rotateVectorXAxis(p2p_ryz, angle3))
	--print("p2p_ryzx : "..tostringVector(p2p_ryzx ))
	local p3p_ryzx = roundVector(rotateVectorXAxis(p3p_ryz, angle3))
	--print("p3p_ryzx : "..tostringVector(p3p_ryzx ))

	--at this point, p1 should be at 0,0,0; p2 x,0,0; and p3 should be at x,y,0
	
	--calculations for finding rotated, offset points	
	local xp_ryzx = (math.pow(d1,2) - math.pow(d2,2) + math.pow(p2p_ryzx[1],2))/(2*p2p_ryzx[1])
	local yp_ryzx = ((math.pow(d1,2) - math.pow(d3,2) + math.pow(p3p_ryzx[1],2) + math.pow(p3p_ryzx[2],2))/(2*p3p_ryzx[2])) - ((p3p_ryzx[1]/p3p_ryzx[2])*xp_ryzx)
	local z1p_ryzx = math.sqrt(math.pow(d1,2)-math.pow(xp_ryzx,2)-math.pow(yp_ryzx,2))
	local z2p_ryzx = (-1) * math.sqrt(math.pow(d1,2)-math.pow(xp_ryzx,2)-math.pow(yp_ryzx,2))
	
	--possible rotated, offset points
	local point1p_ryzx = {xp_ryzx, yp_ryzx, z1p_ryzx}
	local point2p_ryzx = {xp_ryzx, yp_ryzx, z2p_ryzx}
	
	--rotate back around the x axis
	plane_ryx = rotateVectorXAxis(plane_ryzx, (-1)*angle3)
	local point1p_ryz = rotateVectorXAxis(point1p_ryzx, (-1)*angle3)
	local point2p_ryz = rotateVectorXAxis(point2p_ryzx, (-1)*angle3)

	--rotate back around the z axis
	plane_ry = rotateVectorZAxis(plane_ryz, (-1)*angle2)
	local point1p_ry = rotateVectorZAxis(point1p_ryz, (-1)*angle2)
	local point2p_ry = rotateVectorZAxis(point2p_ryz, (-1)*angle2)

	--rotate back around the y axis
	plane = rotateVectorYAxis(plane_ry, (-1)*angle1)
	local point1p = rotateVectorYAxis(point1p_ry, (-1)*angle1)
	local point2p = rotateVectorYAxis(point2p_ry, (-1)*angle1)
	--print(tostringVector(plane))

	--remove offset
	local point1 = addVector(point1p, scaleVector(offset,-1))
	local point2 = addVector(point2p, scaleVector(offset,-1))
	
	--print("Possible points are either: "..tostringVector(point1).." or "..tostringVector(point2))
	return roundVector(point1), roundVector(point2)

end

-- Narrow trilaterations points
function narrow(p1,p2,d4,p4)
	local bounds = 0.00001
	local distance1 = distanceBetweenPoints(p1,p4)
	local error1 = distance1 - d4
	--print(error1)
	if(error1 < bounds and error1 > -bounds) then
		return p1
	end
	local distance2 = distanceBetweenPoints(p2,p4)
	local error2 = distance2 - d4
	--print(error2)
	if(error2 < bounds and error2 > -bounds) then
		return p2
	end
	print("Narrowing function could not obtain a meaningful answer")
	return nil
end

-- get gps coordinates 
function getLocation(timeout)
	local timeout = timeout or 2
	local coords = getGPSCoordinates(timeout)
	if(coords == nil) then
		print("Coordinate table could not be obtained")
		return nil
	end
	if(#coords < 4) then
		print("Insufficient points")
		return nil
	end
	local d1 = coords[1][1]
	local p1 = {coords[1][2],coords[1][3],coords[1][4]}
	local d2 = coords[2][1]
	local p2 = {coords[2][2],coords[2][3],coords[2][4]}
	local d3 = coords[3][1]
	local p3 = {coords[3][2],coords[3][3],coords[3][4]}
	local d4 = coords[4][1]
	local p4 = {coords[4][2],coords[4][3],coords[4][4]}
	local point1, point2 = findPossiblePoints3D(d1,p1,d2,p2,d3,p3)
	--print("Possible point 1: "..tostringVector(point1))
	--print("Possible point 2: "..tostringVector(point2))
	local location = narrow(point1,point2,d4,p4)
	if(location ~= nil) then
		--print(tostringVector(location))
		return location
	else
		print("Location could not be narrowed")
		return nil
	end
end




-- all code below must be ported --



-- Add elements to priorities list
function addList(name,mine,flag,drop,vein)
	local fileSystem = require("filesystem")
	local shell = require("shell")
	if(fileSystem.exists(shell.resolve("listed"))) then
		local xlist = io.open(shell.resolve("listed"), "r")
		local x = split(xlist.readLine())
		
		while(x[1] ~= nil) do
			if(name == x[1]) then
				return false
			end
			s = xlist.readLine()
			if(s ~= nil) then
				x = split(s)
			else
				break
			end
		end
		
		xlist.close()
		xlist = fs.open("listed","a")
	else
		xlist = fs.open("listed","w")
	end
	xlist.writeLine(name..","..mine..","..flag..","..drop..","..vein)
	xlist.close()
	return true
end

-- Get priorities list in file format as a list
function lstToTable()
	if(fs.exists("listed")) then
		ifile = fs.open("listed","r")
		xlist = {}
		x = split(ifile.readLine())
		while(x ~= nil and x ~= "") do
			table.insert(xlist, x)
			x = split(ifile.readLine())
		end
	else
		--      name,mine,flag,drop,vein
		xlist = {
			{'iron_ore','1','0','0','1'},
			{'coal_ore','1','0','0','1'},
			{'gold_ore','1','0','0','1'},
			{'lapis_ore','1','0','0','1'},
			{'redstone_ore','1','0','0','1'},
			{'lit_redstone_ore','1','0','0','1'},
			{'diamond_ore','1','0','0','1'},
			{'quartz_ore','1','0','0','1'},
			{'emerald_ore','1','0','0','1'}
			}
		for k,v in pairs(xlist) do
			addList(v[1],v[2],v[3],v[4],v[5])
		end
	end
	return xlist
end

-- Clear robot inventory according to priorities list
function clrInv(xtable)
	for i = 1, 16 do -- loop through the slots
		turtle.select(i)
		local x = turtle.getItemDetail(i)
		if(x ~= nil) then
			local istr = string.sub(x.name,string.find(x.name,":",0)+1)
			for key,value in pairs(xtable) do
				if(istr == value[1] and value[4] == "1") then
					turtle.drop()
				end
			end
		end
	end
	turtle.select(1)
end

-- Sort robot inventory
function sortInv()
	for i = 1, 16 do -- loop through the slots
		turtle.select(i)
		if(turtle.getItemDetail(i) ~= nil) then
			for c = i, 16 do
				if(turtle.getItemDetail(c) ~= nil) then
					if(turtle.compareTo(c)) then
						turtle.select(c)
						turtle.transferTo(i)
						turtle.select(i)
					end
				end
			end
		end
	end
	turtle.select(1)
end

-- Check for robot inventory space
function invSpace()
	for i = 1, 16 do
		turtle.select(i)
		local x = turtle.getItemDetail(i)
		if(x == nil or turtle.compare()) then
			turtle.select(1)
			return true
		end
	end
	turtle.select(1)
	return false
end

-- Check for sufficient fuel
function sufficientFuel(vector1,vector2,fuel,remainder)
	
	local distance = math.abs(vector1.x - vector2.x) + math.abs(vector1.y - vector2.y) + math.abs(vector1.z - vector2.z)
	if(fuel <= distance + remainder) then
		return false
	else
		return true
	end
end

-- Consume robot fuel (requires generator upgrade)
function consumeFuel(maxFuel) -- Optionally add more fuel types and prioritise fuel types
	local refuel = false
	for i = 1, 16 do -- loop through the slots
		turtle.select(i) -- change to the slot
		local x = turtle.getItemDetail(i)
		if(x ~= nil) then
			local istr = string.sub(x.name,string.find(x.name,":",0)+1)
			if(istr == "planks" or istr == "stick" or istr == "log") then
				turtle.refuel()
				refuel = true
			end
			if(turtle.getFuelLevel() < maxFuel and istr == "coal") then
				turtle.refuel(1)
				refuel = true
			end
		end
	end
	turtle.select(1)
	--print(turtle.getFuelLevel())
	return refuel
end

-- Place torch
function placeTorch(direction) -- Optionally add functionality to place torch when no torch can be placed
	local torch = false
	for i = 1, 16 do -- loop through the slots
		turtle.select(i) -- change to the slot
		local x = turtle.getItemDetail(i)
		if(x ~= nil) then
			local istr = string.sub(x.name,string.find(x.name,":",0)+1)
			if(istr == "torch") then
				if(direction == "up") then
					if(turtle.placeUp()) then
						torch = true
						turtle.select(1)
					end
				elseif(direction == "down")then
					if(turtle.placeDown()) then
						torch = true
						turtle.select(1)
					end
				else
					if(turtle.place()) then
						torch = true
						turtle.select(1)
					end
				end
			end
		end
	end
	turtle.select(1)
	return torch
end

-- Get robot heading
function getHeading()
	if(turtle.getFuelLevel() < 2) then
		if(not consumeFuel(400)) then
			error("Insufficient fuel")
		end
	end
	local start = vector.new(gps.locate())
	while(turtle.detect()) do
		turtle.dig()
	end
	turtle.forward()
	local current = vector.new(gps.locate())
	turtle.back()
	if(start.z - current.z > 0) then
		heading = 'N'
	elseif (start.z - current.z < 0) then
		heading = 'S'
	end
	if(start.x - current.x > 0) then
		heading = 'W'
	elseif (start.x - current.x < 0) then
		heading = 'E'
	end
		return heading
end

-- Set robot heading
function setHeading(heading,newHeading)
	 if(heading ~= 'N' and heading ~= 'n' and heading ~= 'E' and heading ~= 'e' and heading ~= 'S' and heading ~= 's' and heading ~= 'W' and heading ~= 'w') then
		if(turtle.getFuelLevel() < 2) then
			error("Insufficient fuel")
		end
                local start = vector.new(gps.locate())
                while(turtle.detect()) do
                        turtle.dig()
                end
                turtle.forward()
                local current = vector.new(gps.locate())
                turtle.back()
                if(start.z - current.z > 0) then
                        heading = 'N'
                elseif (start.z - current.z < 0) then
                        heading = 'S'
                end
                if(start.x - current.x > 0) then
                        heading = 'W'
                elseif (start.x - current.x < 0) then
                        heading = 'E'
                end
        end

	if(heading ~= newHeading) then
		if(newHeading == 'N' or newHeading == 'n') then
			if(heading == 'S' or heading == 's') then
				turtle.turnLeft()
				turtle.turnLeft()
			end
			if(heading == 'E' or heading == 'e') then
				turtle.turnLeft()
			end
			if(heading == 'W' or heading == 'w') then
				turtle.turnRight()
			end
		end
		if(newHeading == 'E' or newHeading == 'e') then
			if(heading == 'S' or heading == 's') then
				turtle.turnLeft()
			end
			if(heading == 'N' or heading == 'n') then
				turtle.turnRight()
			end
			if(heading == 'W' or heading == 'w') then
				turtle.turnRight()
				turtle.turnRight()
			end
		end
		if(newHeading == 'S' or newHeading == 's') then
			if(heading == 'N' or heading == 'n') then
				turtle.turnLeft()
				turtle.turnLeft()
			end
			if(heading == 'E' or heading == 'e') then
				turtle.turnRight()
			end
			if(heading == 'W' or heading == 'w') then
				turtle.turnLeft()
			end
		end
		if(newHeading == 'W' or newHeading == 'w') then
			if(heading == 'S' or heading == 's') then
				turtle.turnRight()
			end
			if(heading == 'E' or heading == 'e') then
				turtle.turnLeft()
				turtle.turnLeft()
			end
			if(heading == 'N' or heading == 'n') then
				turtle.turnLeft()
			end
		end
	end
end

-- Go to a specific location
function goToLocation(location,heading)
	if(heading ~= 'N' and heading ~= 'n' and heading ~= 'E' and heading ~= 'e' and heading ~= 'S' and heading ~= 's' and heading ~= 'W' and heading ~= 'w') then
		heading = getHeading()
	end
	
	local current = vector.new(gps.locate())
	if(location.x ~= current.x or location.y ~= current.y or location.z ~= current.z) then
		if(turtle.getFuelLevel() < 2) then
			error("Insufficient fuel")
		end
	end
	while(location.y ~= current.y) do
		if(location.y > current.y) then
			while(turtle.detectUp()) do
				turtle.digUp()
			end
			turtle.up()
		else
			while(turtle.detectDown()) do
				turtle.digDown()
			end
			turtle.down()
		end
		current = vector.new(gps.locate())
	end
	
	while(location.z ~= current.z) do
		if(location.z > current.z) then
			setHeading(heading,'S')
			heading = 'S'
		elseif(location.z < current.z) then
			setHeading(heading,'N')
			heading = 'N'
		end
		while(turtle.detect()) do
			turtle.dig()
		end
		turtle.forward()
		current = vector.new(gps.locate())
	end

	while(location.x ~= current.x) do
		if(location.x > current.x) then
			setHeading(heading,'E')
			heading = 'E'
		elseif(location.x < current.x) then
			setHeading(heading,'W')
			heading = 'W'
		end
		while(turtle.detect()) do
			turtle.dig()
		end
		turtle.forward()
		current = vector.new(gps.locate())
	end
	return heading
end

-- Decide whether to mine whole ore vein based on priorities list
function shouldMineWhole(istr,xlist) -- Optionally add functionality for flagging ores
	for key,value in pairs(xlist) do
		if(istr == value[1] and value[5] == "1") then
			return true
		end
	end
	return false
end

-- Mine entire ore vein
function mineVein(start,moves,back,xtable) -- This function needs work on flagging ore, also could be significantly more efficient
	--Establish current GPS location--
	local current = vector.new(gps.locate())
	--Check for sufficient fuel, if not, try to refuel, if refuel fails, function return false and 
	--recursion tree will collapse with turtle returning to where it started--
	if(not sufficientFuel(start,current,turtle.getFuelLevel(),5 + moves)) then
		if(not consumeFuel(400)) then
			return -2
		end
	end
	--Check for inventory space, if no inventory space, try to create some. if no space can be created, 
	--function return false and recursion tree will collapse, with turtle returning to where it started.
	if(not invSpace()) then
		sortInv()
		clrInv(xtable)
		if(not invSpace()) then
			return -1
		end
	end
	
	--Check above turtle for ores--
	local success,data = turtle.inspect()
	if(success) then
		local istr = string.sub(data.name,string.find(data.name,":",0)+1)
		--print(istr)
		if(shouldMineWhole(istr,xtable)) then
			turtle.dig()
			turtle.forward()
			mineVein(start,moves+1,false,xtable)
			turtle.back()
		end
	end
	if(moves == 0) then
		if(current.y == start.y + 1) then
			local success,data = turtle.inspectUp()
			if(success) then
				local istr = string.sub(data.name,string.find(data.name,":",0)+1)
				--print(istr)
				if(shouldMineWhole(istr,xtable)) then
					turtle.digUp()
					turtle.up()
					mineVein(start,moves+1,true,xtable)
					turtle.down()
				end
			end
		end
		if(current.y == start.y) then
			local success,data = turtle.inspectDown()
			if(success) then
				local istr = string.sub(data.name,string.find(data.name,":",0)+1)
				--print(istr)
				if(shouldMineWhole(istr,xtable)) then
					turtle.digDown()
					turtle.down()
					mineVein(start,moves+1,true,xtable)
					turtle.up()
				end
			end
		end
	end
	
	--will ensure turtle does not check sides on start.
	if(moves < 1) then
		return 1
	end
	turtle.turnLeft()
	local success,data = turtle.inspect()
	if(success) then
		local istr = string.sub(data.name,string.find(data.name,":",0)+1)
		--print(istr)
		if(shouldMineWhole(istr,xtable)) then
			turtle.dig()
			turtle.forward()
			mineVein(start,moves+1,false,xtable)
			turtle.back()
		end
	end
	if(back) then
		turtle.turnLeft()
		local success,data = turtle.inspect()
		if(success) then
			local istr = string.sub(data.name,string.find(data.name,":",0)+1)
			--print(istr)
			if(shouldMineWhole(istr,xtable)) then
				turtle.dig()
				turtle.forward()
				mineVein(start,moves+1,false,xtable)
				turtle.back()
			end
		end
		turtle.turnLeft()
		local success,data = turtle.inspect()
		if(success) then
			local istr = string.sub(data.name,string.find(data.name,":",0)+1)
			--print(istr)
			if(shouldMineWhole(istr,xtable)) then
				turtle.dig()
				turtle.forward()
				mineVein(start,moves+1,false,xtable)
				turtle.back()
			end
		end
		turtle.turnLeft()
		local success,data = turtle.inspectUp()
		if(success) then
			local istr = string.sub(data.name,string.find(data.name,":",0)+1)
			--print(istr)
			if(shouldMineWhole(istr,xtable)) then
				turtle.digUp()
				turtle.up()
				mineVein(start,moves+1,true,xtable)
				turtle.down()
			end
		end
		local success,data = turtle.inspectDown()
		if(success) then
			local istr = string.sub(data.name,string.find(data.name,":",0)+1)
			--print(istr)
			if(shouldMineWhole(istr,xtable)) then
				turtle.digDown()
				turtle.down()
				mineVein(start,moves+1,true,xtable)
				turtle.up()
			end
		end
	else
		turtle.turnRight()
		turtle.turnRight()
		local success,data = turtle.inspect()
		if(success) then
			local istr = string.sub(data.name,string.find(data.name,":",0)+1)
			--print(istr)
			if(shouldMineWhole(istr,xtable)) then
				turtle.dig()
				turtle.forward()
				mineVein(start,moves+1,false,xtable)
				turtle.back()
			end
		end
		turtle.turnLeft()
		local success,data = turtle.inspectUp()
		if(success) then
			local istr = string.sub(data.name,string.find(data.name,":",0)+1)
			--print(istr)
			if(shouldMineWhole(istr,xtable)) then
				turtle.digUp()
				turtle.up()
				mineVein(start,moves+1,true,xtable)
				turtle.down()
			end
		end
		local success,data = turtle.inspectDown()
		if(success) then
			local istr = string.sub(data.name,string.find(data.name,":",0)+1)
			--print(istr)
			if(shouldMineWhole(istr,xtable)) then
				turtle.digDown()
				turtle.down()
				mineVein(start,moves+1,true,xtable)
				turtle.up()
			end
		end
	end
	return 1
end

-- Mine branch
function mineBranch(branchStart,branchHeading,currentHeading,branchLimit,fuelRemainder,plist,torchLength) -- Still needs optimization and functions to replace repeated blocks
	-- Search for GPS signal --
	local current = vector.new(gps.locate())
	if(current.x == nil or current.y == nil or current.z == nil) then
		-- GPS signal could not be established --
		error("Could not establish GPS signal, please ensure GPS servers are running and try again")
	end
	-- GPS signal established --
	if(not sufficientFuel(current,branchStart,turtle.getFuelLevel(),fuelRemainder + 5)) then
		if(not consumeFuel(4000)) then
			error("Insufficient fuel!")
		end
	end
	if(currentHeading ~= 'N' and currentHeading ~= 'n' and currentHeading ~= 'E' and currentHeading ~= 'e' and currentHeading ~= 'S' and currentHeading ~= 's' and currentHeading ~= 'W' and currentHeading ~= 'w') then
		currentHeading = getHeading()
	end
	
	--print("Heading: ", currentHeading)
	
	if(branchStart.y ~= current.y) then
		-- If y level is not the same --
		currentHeading = goToLocation(vector.new(current.x,branchStart.y,current.z), currentHeading)
		current = vector.new(gps.locate())
	end
	-- Ensure z level is the same as starting y level --
	if(branchHeading == 'N' or branchHeading == 'n' or branchHeading == 'S' or branchHeading == 's') then
		if(branchStart.z ~= current.z) then
			-- If z level is not the same --
			currentHeading = goToLocation(vector.new(branchStart.x,current.y,current.z), currentHeading)
			current = vector.new(gps.locate())
		end
	end
	-- Ensure x level is the same as starting y level --
	if(branchHeading == 'E' or branchHeading == 'e' or branchHeading == 'W' or branchHeading == 'w') then
		if(branchStart.x ~= current.x) then
			-- If x level is not the same --
			currentHeading = goToLocation(vector.new(current.x,current.y,branchStart.z), currentHeading)
			current = vector.new(gps.locate())
		end
	end
    setHeading(currentHeading,branchHeading)
	currentHeading = branchHeading
	--[[
		Done
		0	: Not done, still mining
		1	: Is done, mining was successful
		-1	: Inventory full
		-2	: Insufficient fuel
	]]--
	done = 0
	while(done == 0) do
		current = vector.new(gps.locate())
		if(current.x == nil or current.y == nil or current.z == nil) then
			-- GPS signal could not be established --
			error("Could not establish GPS signal, please ensure GPS servers are running and try again")
		else
			-- Ensure distance from branchStart is less than branchLimit --
			-- Along the North/South line --
			if(branchHeading == 'N' or branchHeading == 'n' or branchHeading == 'S' or branchHeading == 's')then
				-- Check if distance from branchStart is within branchLimit --
				if(math.abs(branchStart.z - current.z)>=branchLimit) then
					-- Distance from branchStart is not within branchLimit --
					currentHeading = goToLocation(vector.new(branchStart.x,branchStart.y,current.z),currentHeading)
					currentHeading = goToLocation(vector.new(branchStart.x,branchStart.y,branchStart.z),currentHeading)
					done = 1
				else
					-- Distance from branchStart is within branchLimit --
					-- Check for sufficient fuel --
					if(sufficientFuel(current,branchStart,turtle.getFuelLevel(),fuelRemainder + 5)) then
						if(invSpace()) then
							if(current.y == branchStart.y) then
								turtle.turnLeft()
								mineVein(branchStart,0,false,plist)
								turtle.turnRight()
								turtle.turnRight()
								mineVein(branchStart,0,false,plist)
								turtle.turnLeft()
								while(turtle.detect()) do
									turtle.dig()
								end
								turtle.forward()
								turtle.turnLeft()
								mineVein(branchStart,0,false,plist)
								turtle.turnRight()
								turtle.turnRight()
								mineVein(branchStart,0,false,plist)
								turtle.turnLeft()
								while(turtle.detectUp()) do
									turtle.digUp()
								end
								turtle.up()
							elseif(current.y - 1 == branchStart.y) then
								turtle.turnLeft()
								mineVein(branchStart,0,false,plist)
								turtle.turnRight()
								turtle.turnRight()
								mineVein(branchStart,0,false,plist)
								turtle.turnLeft()
								while(turtle.detect()) do
									turtle.dig()
								end
								turtle.forward()
								turtle.turnLeft()
								mineVein(branchStart,0,false,plist)
								turtle.turnRight()
								turtle.turnRight()
								mineVein(branchStart,0,false,plist)
								turtle.turnLeft()
								while(turtle.detectDown()) do
									turtle.digDown()
								end
								turtle.down()
							else
								currentHeading = goToLocation(vector.new(current.x,branchStart.y,current.z),currentHeading)
							end
						else
							sortInv()
							clrInv(plist)
							if(not invSpace()) then
								currentHeading = goToLocation(vector.new(branchStart.x,branchStart.y,current.z),currentHeading)
								currentHeading = goToLocation(vector.new(branchStart.x,branchStart.y,branchStart.z),currentHeading)
								done = -1
							end
						end
					else
						if(not consumeFuel(4000)) then
							currentHeading = goToLocation(vector.new(branchStart.x,branchStart.y,current.z),currentHeading)
							currentHeading = goToLocation(vector.new(branchStart.x,branchStart.y,branchStart.z),currentHeading)
							done = -2
						end
					end
				end
			-- Along the East/West line --
			elseif(branchHeading == 'E' or branchHeading == 'e' or branchHeading == 'W' or branchHeading == 'w') then
				-- Check if distance from branchStart is within branchLimit --
				if(math.abs(branchStart.x - current.x)>=branchLimit) then
					-- Distance from branchStart is not within branchLimit --
					currentHeading = goToLocation(vector.new(current.x,branchStart.y,branchStart.z),currentHeading)
					currentHeading = goToLocation(vector.new(branchStart.x,branchStart.y,branchStart.z),currentHeading)
					done = 1
				else
					-- Distance from branchStart is within branchLimit --
					-- Check for sufficient fuel --
					if(sufficientFuel(current,branchStart,turtle.getFuelLevel(),fuelRemainder + 5)) then
						if(invSpace()) then
							if(current.y == branchStart.y) then
								turtle.turnLeft()
								mineVein(branchStart,0,false,plist)
								turtle.turnRight()
								turtle.turnRight()
								mineVein(branchStart,0,false,plist)
								turtle.turnLeft()
								while(turtle.detect()) do
									turtle.dig()
								end
								turtle.forward()
								turtle.turnLeft()
								mineVein(branchStart,0,false,plist)
								turtle.turnRight()
								turtle.turnRight()
								mineVein(branchStart,0,false,plist)
								turtle.turnLeft()
								while(turtle.detectUp()) do
									turtle.digUp()
								end
								turtle.up()
							elseif(current.y - 1 == branchStart.y) then
								turtle.turnLeft()
								mineVein(branchStart,0,false,plist)
								turtle.turnRight()
								turtle.turnRight()
								mineVein(branchStart,0,false,plist)
								turtle.turnLeft()
								while(turtle.detect()) do
									turtle.dig()
								end
								turtle.forward()
								turtle.turnLeft()
								mineVein(branchStart,0,false,plist)
								turtle.turnRight()
								turtle.turnRight()
								mineVein(branchStart,0,false,plist)
								turtle.turnLeft()
								while(turtle.detectDown()) do
									turtle.digDown()
								end
								turtle.down()
							else
								currentHeading = goToLocation(vector.new(current.x,branchStart.y,current.z),currentHeading)
							end
						else
							sortInv()
							clrInv(plist)
							if(not invSpace()) then
								currentHeading = goToLocation(vector.new(current.x,branchStart.y,branchStart.z),currentHeading)
								currentHeading = goToLocation(vector.new(branchStart.x,branchStart.y,branchStart.z),currentHeading)
								done = -1
							end
						end
					else
						if(not consumeFuel(4000)) then
							currentHeading = goToLocation(vector.new(current.x,branchStart.y,branchStart.z),currentHeading)
							currentHeading = goToLocation(vector.new(branchStart.x,branchStart.y,branchStart.z),currentHeading)
							done = -2
						end
					end
				end
			end
		end
	end
	return done
end

-- Mine tunnel
function mTunnel(tunnelStart, tunnelHeading, currentHeading, tunnelLength, fuelRemainder, plist, torchDistance, branchSpacing, branchLimit,branchTorchLength)
	-- Search for GPS signal --
	local current = vector.new(gps.locate())
	if(current.x == nil or current.y == nil or current.z == nil) then
		-- GPS signal could not be established --
		error("Could not establish GPS signal, please ensure GPS servers are running and try again")
	end
	-- GPS signal established --
	if(not sufficientFuel(current,tunnelStart,turtle.getFuelLevel(),fuelRemainder+10)) then
		if(not consumeFuel(4000)) then
			error("Insufficient fuel!")
		end
	end
	if(currentHeading ~= 'N' and currentHeading ~= 'n' and currentHeading ~= 'E' and currentHeading ~= 'e' and currentHeading ~= 'S' and currentHeading ~= 's' and currentHeading ~= 'W' and currentHeading ~= 'w') then
		currentHeading = getHeading()
	end
	
	print("Heading: ", currentHeading)
	
	-- Ensure y level is the same as starting y level --
	if(tunnelStart.y ~= current.y) then
		-- If y level is not the same --
		currentHeading = goToLocation(vector.new(current.x,tunnelStart.y,current.z), currentHeading)
		current = vector.new(gps.locate())
	end
	-- Ensure z level is the same as starting z level if on N/S axis --
	if(tunnelHeading == 'N' or tunnelHeading == 'n' or tunnelHeading == 'S' or tunnelHeading == 's') then
		if(tunnelStart.z ~= current.z) then
			-- If z level is not the same --
			currentHeading = goToLocation(vector.new(tunnelStart.x,current.y,current.z), currentHeading)
			setHeading(currentHeading,tunnelHeading)
			currentHeading = tunnelHeading
			turtle.back()
			current = vector.new(gps.locate())
		end
	end
	-- Ensure x level is the same as starting x level if on E/W axis --
	if(tunnelHeading == 'E' or tunnelHeading == 'e' or tunnelHeading == 'W' or tunnelHeading == 'w') then
		if(tunnelStart.x ~= current.x) then
			-- If x level is not the same --
			currentHeading = goToLocation(vector.new(current.x,current.y,tunnelStart.z), currentHeading)
			setHeading(currentHeading,tunnelHeading)
			currentHeading = tunnelHeading
			turtle.back()
			current = vector.new(gps.locate())
		end
	end
	if(currentHeading ~= tunnelHeading) then
		setHeading(currentHeading,tunnelHeading)
		currentHeading = tunnelHeading
	end
	--[[
		Done
		0	: Not done, still mining
		1	: Is done, mining was successful
		-1	: Inventory full
		-2	: Insufficient fuel
	]]--
	done = 0
	while(done == 0) do
		current = vector.new(gps.locate())
		if(current.x == nil or current.y == nil or current.z == nil) then
			-- GPS signal could not be established --
			error("Could not establish GPS signal, please ensure GPS servers are running and try again")
		else
			-- Ensure distance from tunnelStart is less than tunnelLength --
			-- Along the North/South line --
			if(tunnelHeading == 'N' or tunnelHeading == 'n' or tunnelHeading == 'S' or tunnelHeading == 's')then
				-- Check if distance from tunnelStart is within tunnelLength --
				if(math.abs(tunnelStart.z - current.z)>=tunnelLength) then
					-- Distance from tunnelStart is not within tunnelLength --
					currentHeading = goToLocation(vector.new(tunnelStart.x,tunnelStart.y,current.z),currentHeading)
					currentHeading = goToLocation(vector.new(tunnelStart.x,tunnelStart.y,tunnelStart.z),currentHeading)
					done = 1
				else
					-- Distance from tunnelStart is within tunnelLength --
					-- Check for sufficient fuel --
					if(sufficientFuel(current,tunnelStart,turtle.getFuelLevel(),fuelRemainder + 10)) then
						if(invSpace()) then
							term.clear()
							term.setCursorPos(1,1)
							print((tunnelStart.z - current.z)%branchSpacing)
							while(turtle.detect()) do
								turtle.dig()
							end
							turtle.forward()
							while(turtle.detectUp()) do
								turtle.digUp()
							end
							turtle.turnLeft()
							while(turtle.detect()) do
								turtle.dig()
							end
							turtle.forward()
							if(tunnelHeading == 'N' or tunnelHeading == 'n') then
								if((tunnelStart.z - current.z)%branchSpacing == branchSpacing - 1 and done == 0) then
									done = mineBranch(vector.new(gps.locate()),"w","w",branchLimit,fuelRemainder+5,plist,branchTorchLength)
									if(done == 1) then
										done = 0
									end
									turtle.turnLeft()
									turtle.turnLeft()
								end
							else
								if((tunnelStart.z - current.z)%branchSpacing == branchSpacing - 1 and done == 0) then
									done = mineBranch(vector.new(gps.locate()),"e","e",branchLimit,fuelRemainder+5,plist,branchTorchLength)
									if(done == 1) then
										done = 0
									end
									turtle.turnLeft()
									turtle.turnLeft()
								end
							end
							while(turtle.detectUp()) do
								turtle.digUp()
							end
							turtle.up()
							while(turtle.detectUp()) do
								turtle.digUp()
							end
							turtle.up()
							turtle.turnLeft()
							turtle.turnLeft()
							while(turtle.detect()) do
								turtle.dig()
							end
							turtle.forward()
							if((tunnelStart.z - current.z)%torchDistance - 1 == 0 and math.abs(tunnelStart.z - current.z) >= torchDistance - 1) then
								turtle.turnLeft()
								turtle.turnLeft()
								placeTorch()
								turtle.turnLeft()
								turtle.turnLeft()
							end
							while(turtle.detect()) do
								turtle.dig()
							end
							turtle.forward()
							while(turtle.detectDown()) do
								turtle.digDown()
							end
							turtle.down()
							if((tunnelStart.z - current.z)%torchDistance - 1 == 0 and math.abs(tunnelStart.z - current.z) >= torchDistance - 1) then
								placeTorch("up")
							end
							while(turtle.detectDown()) do
								turtle.digDown()
							end
							turtle.down()
							if(tunnelHeading == 'S' or tunnelHeading == 's') then
								if((tunnelStart.z - current.z)%branchSpacing == branchSpacing - 1 and done == 0) then
									done = mineBranch(vector.new(gps.locate()),"w","w",branchLimit,fuelRemainder+5,plist,branchTorchLength)
									if(done == 1) then
										done = 0
									end
									turtle.turnLeft()
									turtle.turnLeft()
								end
							else
								if((tunnelStart.z - current.z)%branchSpacing == branchSpacing - 1 and done == 0) then
									done = mineBranch(vector.new(gps.locate()),"e","e",branchLimit,fuelRemainder+5,plist,branchTorchLength)
									if(done == 1) then
										done = 0
									end
									turtle.turnLeft()
									turtle.turnLeft()
								end
							end
							turtle.back()
							turtle.turnLeft()
						else
							sortInv()
							clrInv(plist)
							if(not invSpace()) then
								currentHeading = goToLocation(vector.new(tunnelStart.x,tunnelStart.y,current.z),currentHeading)
								currentHeading = goToLocation(vector.new(tunnelStart.x,tunnelStart.y,tunnelStart.z),currentHeading)
								done = -1
							end
						end
					else
						if(not consumeFuel(4000)) then
							currentHeading = goToLocation(vector.new(tunnelStart.x,tunnelStart.y,current.z),currentHeading)
							currentHeading = goToLocation(vector.new(tunnelStart.x,tunnelStart.y,tunnelStart.z),currentHeading)
							done = -2
						end
					end
				end
			-- Along the East/West line --
			elseif(tunnelHeading == 'E' or tunnelHeading == 'e' or tunnelHeading == 'W' or tunnelHeading == 'w') then
				-- Check if distance from tunnelStart is within tunnelLength --
				if(math.abs(tunnelStart.x - current.x)>=tunnelLength) then
					-- Distance from tunnelStart is not within tunnelLength --
					currentHeading = goToLocation(vector.new(current.x,tunnelStart.y,tunnelStart.z),currentHeading)
					currentHeading = goToLocation(vector.new(tunnelStart.x,tunnelStart.y,tunnelStart.z),currentHeading)
					done = 1
				else
					-- Distance from tunnelStart is within tunnelLength --
					-- Check for sufficient fuel --
					if(sufficientFuel(current,tunnelStart,turtle.getFuelLevel(),fuelRemainder + 10)) then
						if(invSpace()) then
							while(turtle.detect()) do
								turtle.dig()
							end
							turtle.forward()
							while(turtle.detectUp()) do
								turtle.digUp()
							end
							turtle.turnLeft()
							while(turtle.detect()) do
								turtle.dig()
							end
							turtle.forward()
							if(tunnelHeading == 'E' or tunnelHeading == 'e') then
								if((tunnelStart.x - current.x)%branchSpacing == branchSpacing - 1 and done == 0) then
									done = mineBranch(vector.new(gps.locate()),"n","n",branchLimit,fuelRemainder+5,plist,branchTorchLength)
									if(done == 1) then
										done = 0
									end
									turtle.turnLeft()
									turtle.turnLeft()
								end
							else
								if((tunnelStart.x - current.x)%branchSpacing == branchSpacing - 1 and done == 0) then
									done = mineBranch(vector.new(gps.locate()),"s","s",branchLimit,fuelRemainder+5,plist,branchTorchLength)
									if(done == 1) then
										done = 0
									end
									turtle.turnLeft()
									turtle.turnLeft()
								end
							end
							while(turtle.detectUp()) do
								turtle.digUp()
							end
							turtle.up()
							while(turtle.detectUp()) do
								turtle.digUp()
							end
							turtle.up()
							turtle.turnLeft()
							turtle.turnLeft()
							while(turtle.detect()) do
								turtle.dig()
							end
							turtle.forward()
							if((tunnelStart.x - current.x)%torchDistance - 1 == 0 and math.abs(tunnelStart.x - current.x) >= torchDistance - 1) then
								turtle.turnLeft()
								turtle.turnLeft()
								placeTorch()
								turtle.turnLeft()
								turtle.turnLeft()
							end
							while(turtle.detect()) do
								turtle.dig()
							end
							turtle.forward()
							while(turtle.detectDown()) do
								turtle.digDown()
							end
							turtle.down()
							if((tunnelStart.x - current.x)%torchDistance - 1 == 0 and math.abs(tunnelStart.x - current.x) >= torchDistance - 1) then
								placeTorch("up")
							end
							while(turtle.detectDown()) do
								turtle.digDown()
							end
							turtle.down()
							if(tunnelHeading == 'W' or tunnelHeading == 'w') then
								if((tunnelStart.x - current.x)%branchSpacing == branchSpacing - 1 and done == 0) then
									done = mineBranch(vector.new(gps.locate()),"n","n",branchLimit,fuelRemainder+5,plist,branchTorchLength)
									if(done == 1) then
										done = 0
									end
									turtle.turnLeft()
									turtle.turnLeft()
								end
							else
								if((tunnelStart.x - current.x)%branchSpacing == branchSpacing - 1 and done == 0) then
									done = mineBranch(vector.new(gps.locate()),"s","s",branchLimit,fuelRemainder+5,plist,branchTorchLength)
									if(done == 1) then
										done = 0
									end
									turtle.turnLeft()
									turtle.turnLeft()
								end
							end
							turtle.back()
							turtle.turnLeft()
						else
							sortInv()
							clrInv(plist)
							if(not invSpace()) then
								currentHeading = goToLocation(vector.new(current.x,tunnelStart.y,tunnelStart.z),currentHeading)
								currentHeading = goToLocation(vector.new(tunnelStart.x,tunnelStart.y,tunnelStart.z),currentHeading)
								done = -1
							end
						end
					else
						if(not consumeFuel(4000)) then
							currentHeading = goToLocation(vector.new(current.x,tunnelStart.y,tunnelStart.z),currentHeading)
							currentHeading = goToLocation(vector.new(tunnelStart.x,tunnelStart.y,tunnelStart.z),currentHeading)
							done = -2
						end
					end
				end
			end
		end
	end
	return done
end




-- API requirements --
local term = require("term")
local component = require("component")
--local event = require("event")
--local fileSystem = require("filesystem")
--local shell = require("shell")







d = {['split']=split,['addList']=addlist,['lstToTable']=lstToTable,['clrInv']=clrInv,['sortInv']=sortInv,['invSpace']=invSpace,['sufficientFuel']=sufficientFuel,['consumeFuel']=consumeFuel,['getHeading']=getHeading,['setHeading']=setHeading,['goToLocation']=goToLocation,['shouldMineWhole']=shouldMineWhole,['mineVein']=mineVein}

for key,value in pairs(d) do
	print(key)
end
print("function to test? ")
local x = term.read()
print(x)

if(x == 'split') then
	print("Enter a string to split")
	local istr = term.read()
	print("Enter a delimiter")
	local lim = term.read()
	for k,v in split(istr,lim) do 
		write(v," ") 
	end
elseif(x == 'addList') then
	print("Enter name: ")
	local name = term.read()
	print("Enter mine: ")
	local mine = term.read()
	print("Enter flag: ")
	local flag = term.read()
	print("Enter drop: ")
	local drop = term.read()
	print("Enter vein: ")
	local vein = term.read()
	
	print(addList(name,mine,flag,drop,vein))
elseif(x == 'lstToTable') then
	print(lstToTable())
elseif(x == 'clrInv') then
	clrInv(lstToTable())
elseif(x == 'sortInv') then
	sortInv()
elseif(x == 'invSpace')then
	print(invSpace())
elseif(x == 'sufficientFuel') then
	print("Remainder: ")
	x = term.read()
	if(fs.exists("GPS_DATA")) then
		gpsData = fs.open("GPS_DATA","r")
		start = vector.new(tonumber(gpsData.readLine()),tonumber(gpsData.readLine()),tonumber(gpsData.readLine()))
	else
		print("No gps data")
	end
	local current = vector.new(gps.locate())
	print(sufficientFuel(current,start,turtle.getFuelLevel(),x))
elseif(x == 'consumeFuel') then
	print("Max fuel: ")
	maxFuel = tonumber(read())
	print(consumeFuel(maxFuel))
elseif(x == 'getHeading') then
	print(getHeading())
elseif(x == 'setHeading') then
	print("Current heading: ")
	heading = term.read()
	print("New heading: ")
	newHeading = term.read()
	setHeading(heading,newHeading)
elseif(x == 'goToLocation') then
	print("X: ")
	x = tonumber(read())
	print("Y: ")
	y = tonumber(read())
	print("Z: ")
	z = tonumber(read())
	print("Heading: ")
	heading = term.read()
	location = vector.new(x,y,z)
	print(goToLocation(location,heading))
elseif(x == "shouldMineWhole") then
	x = term.read()
	print(shouldMineWhole(x,lstToTable()))
elseif(x == 'mineVein') then
	if(fs.exists("GPS_DATA")) then
		gpsData = fs.open("GPS_DATA","r")
		start = vector.new(tonumber(gpsData.readLine()),tonumber(gpsData.readLine()),tonumber(gpsData.readLine()))
	else
		print("No gps data")
	end
	mineVein(start,0,false,lstToTable())
else
	print("No function registered")
end


--[[
print("Enter length: ")
c = tonumber(read())

if(fs.exists("GPS_DATA")) then
	gpsData = fs.open("GPS_DATA","r")
	local start = vector.new(tonumber(gpsData.readLine()),tonumber(gpsData.readLine()),tonumber(gpsData.readLine()))
	sHeading = gpsData.readLine()
	if(start.x == nil or start.y == nil or start.z == nil) then
		-- GPS_DATA Invalid --
        term.clear()
        term.setCursorPos(1,1)
        error("Invalid GPS information")
	else
		-- GPS_DATA Valid --
		term.clear()
        term.setCursorPos(1,1)
        print("GPS_DATA exists, start: (",start.x,",",start.y,",",start.z,")")
        print("Heading: ", sHeading)
		-- Search for GPS signal --
        local current = vector.new(gps.locate())
        if(current.x == nil or current.y == nil or current.z == nil) then
			-- GPS signal could not be established --
			error("Could not establish GPS signal, please ensure GPS servers are running and try again")
		else
			-- GPS signal established --
			print("GPS locate, current: (",current.x,",",current.y,",",current.z,")")
			plist = lstToTable()
			lst = {4,10,plist,0}
			print(mTunnel(start,sHeading,"",c,10,lstToTable(),4,4,4,0))
		end
	end
else
	-- GPS_DATA not found --
    term.clear()
    term.setCursorPos(1,1)
    error("File 'GPS_DATA' does not exist, please run program to initiate mining")
end

local term = require("term")
local component = require("component")
local event = require("event")

component.modem.open(3665)

print(tostringVector(getLocation()))



local term = require("term")
local component = require("component")
local event = require("event")
local fileSystem = require("filesystem")
local shell = require("shell")

local accessPoints = getAccessPoints()
local gps_port = 3665
local signal_strength = 400
local sleep = 0.001
local hostCoordinates = {}

component.modem.open(gps_port)

if(fileSystem.exists(shell.resolve("gpsHostData"))) then
	local file = io.open(shell.resolve("gpsHostData"), "r")
	local i = 0
	for line in io.lines(shell.resolve("gpsHostData")) do
		hostCoordinates[i] = split(line,",")
		hostCoordinates = tonumberVector({hostCoordinates[i][2],hostCoordinates[i][3],hostCoordinates[i][4]})
		print(line)
		i=i+1
	end
	file:close()
elseif(getLocation() ~= nil) then
	local location = getLocation()
	print(tostringVector(location))
	local file = io.open(shell.resolve("gpsHostData"), "a")
	local address = component.getPrimary("modem").address
	file:write(tostring(address)..","..tostringVector(location))
	print("File written")
	file:close()
	hostCoordinates = location
else
	local file = io.open(shell.resolve("gpsHostData"), "a")
	print("Location data could not be obtained, please enter in (x,y,z) coords of modem: ")
	local tmp = term.read()
	hostCoordinates = tonumberVector(split(tmp,","))
	local address = component.getPrimary("modem").address
	file:write(tostring(address)..","..tmp)
	print("File written")
	file:close()
end

print(hostCoordinates[1]..type(hostCoordinates[1]))
print(hostCoordinates[2]..type(hostCoordinates[2]))
print(hostCoordinates[3]..type(hostCoordinates[3]))


while true do
	component.modem.setStrength(signal_strength)
	component.modem.broadcast(gps_port, hostCoordinates[1], hostCoordinates[2],hostCoordinates[3])
	os.sleep(sleep)
end

]]--