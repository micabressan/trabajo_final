elevators = {
	--id, x, y, z, dim, int, x change, y change, z change, markerx, markery, markerz
	{13646, 1409.15, -1165.79, 23.8-1.5, 0, 0, -1, -8.2, 162.7+0.3, 1404.45, -1172.8, 187.14}
}	

local elevator = {}
local array = {}
local status = {}

function moveElevator (object, id, upOrDown)
	local uod 
	local stat, time
	local x, y, z
	local times = {["up"] = 5000, ["down"] = 1000}
	local upsndowns = {["up"] = "down", ["down"] = "up"}
	
	if upOrDown == "both" then 
		uod = status[object]
		time = 1000
	else
		uod = upsndowns[upOrDown]	
		time = times[uod]
	end
	
	if status[object] then 							
		if uod == "up" then 
			x, y, z = elevators[id][2], elevators[id][3], elevators[id][4]
			stat = "down"
		elseif uod == "down" then
			x, y, z = elevators[id][2] + elevators[id][7], elevators[id][3] + elevators[id][8], elevators[id][4] + elevators[id][9]
			stat = "up"
		end
	end	
	
	if status[object] ~= "moving" then 
		local stopX, stopY, stopZ = x, y, z
		setTimer (function () moveObject(object, 10000, x, y, z)   end, time, 1)
		setTimer (
			function ()
				if isElement (object) then 
					local vx, vy, vz = getElementPosition (object)
					if math.floor ( vx ) ==  math.floor ( stopX ) and math.floor ( vy )== math.floor ( stopY ) and math.floor ( vz ) == math.floor ( stopZ ) then
						status[object] = stat
						killTimer (sourceTimer)
					end	
				end	
			end, 
		500, 0) 
		status[object] = "moving"
		return true
	end	
	
	return false
end	

local function onColHit(hit, dim) 
	if hit and dim then 
		if isElement (hit) then 
			if hit:getType () == "player" then 
				if array[source] then 
					local id, object = array[source][1], array[source][2]
					moveElevator (object, id, "both")
				end
			end
		end
	end	
end 

local function onColLeave (hit, dim)
	if hit and dim then 
		if isElement (hit) then 
			if hit:getType () == "player" then 
				if array[source] then 
					local id, object = array[source][1], array[source][2]
					if status[object] == "up" then
						if #getElementsWithinColShape (source) <= 1  then 
							moveElevator (object, id, "down")
						end		
					end	
				end
			end
		end
	end	
end

local function moveMarker (plr, key, state, id, object)
	if status[object] == "down" then
		if moveElevator(object, tonumber (id), "up") then
			outputChatBox ("Elevator coming up", plr, 0, 255, 0)
		end	
	end	
end	

local function onMarkerHit  (hit, dim)
	if hit and dim then 
		if isElement (hit) then 
			if hit:getType() == "player" then 
				if array[source] then 
					local id, object = array[source][1], array[source][2]
					if bindKey (hit, "k", "down", moveMarker, id, object) then 
						outputChatBox ("Press 'k' to move the elevator up.", hit, 255, 255, 0)
					end	
				end
			end
		end
	end
end	

local function onMarkerLeave (hit, dim)
	if hit and dim then 
		if isElement (hit) then 
			if hit:getType() == "player" then 
				if array[source] then 
					unbindKey (hit, "k", "down", moveMarker)
				end
			end
		end
	end
end	

function elevator.init ()
	for i, v in ipairs (elevators) do
		local obj = createObject (v[1], v[2], v[3], v[4])
		local col = createColSphere (v[2], v[3], v[4], 2)
		local marker = createMarker (v[10], v[11], v[12] -1, "cylinder", 1.3, 0, 125, 255, 155)
		
		obj:setDimension(v[5])
		col:setDimension(v[5])
		obj:setInterior(v[6])
		col:setInterior(v[6])
		
		array[col] = {i, obj}
		array[marker] = {i, obj}
		
		attachElements (col, obj, 0, 0, 1.5)
		
		status[obj] = "down"
		
		addEventHandler ("onColShapeHit", col, onColHit)
		addEventHandler ("onColShapeLeave", col, onColLeave)
		addEventHandler ("onMarkerHit", marker, onMarkerHit)
		addEventHandler ("onMarkerLeave", marker, onMarkerLeave)
	end
end	
addEventHandler ("onResourceStart", resourceRoot, elevator.init)