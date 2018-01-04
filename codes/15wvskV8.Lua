-- Coded by Kutak Roland

local x,y,z = -2663, 616, 14 local a,b,c = -2666.3369140625,584.5595703125,13.453125 local alpha = 150 local r = 225 local kor = createMarker(a,b,c, "cylinder", 1, 255, 255, 255, alpha) local id = 515
				


addEventHandler("onClientMarkerHit", kor, function() fadeCamera(false) setElementData(localPlayer, "showHUD", false) setElementData(localPlayer, "showScore", false) setElementData(localPlayer, "showRadar", false) showChat(false)
	setTimer(function()
		fadeCamera(true)
		setCameraMatrix(-2661.7163085938, 612.65228271484, 15.781800270081, -2661.51171875, 613.60882568359, 15.574014663696,0,70)
		local level = math.random(1, 50)
		setElementDimension(localPlayer, level)	
		local vehicle = createVehicle(id, -2657.80078125, 623.26171875,14.453125, 0, 0, 30)
		setElementDimension(vehicle, level)			
		rotTimer = setTimer(function() r = r + 0.5 setElementRotation(vehicle,0,0,r) end, 50, 0)
	end, 3000, 1)
end)	

function switching()
	if id == 515 then
		if getKeyState("arrow_r") == true then
			if isElement(vehicle) then destroyElement(vehicle) end
			id = 514
			iprint(id)
			createVehicle(id, -2657.80078125, 623.26171875,14.453125, 0, 0, r)
		elseif getKeyState("arrow_l") == true then
			if isElement(vehicle) then destroyElement(vehicle) end
			id = 403
			iprint(id)
			createVehicle(id, -2657.80078125, 623.26171875,14.453125, 0, 0, r)
		end
	end
end							


function close(b,s)
	if b == "backspace" and s then
		fadeCamera(false)
		setTimer(function()
			setElementData(localPlayer, "showHUD", true)
			setElementData(localPlayer, "showScore", true)
			setElementData(localPlayer, "showRadar", true)
			setCameraTarget(localPlayer)
			showChat(true)
			fadeCamera(true)
			exports["kInfobox"]:createClientBox("Elhagytad a járműkereskedést!", "warning")
			if isElement(vehicle) then destroyElement(vehicle) end
			setElementPosition(localPlayer, a-5,b+2,c+2)
		end, 3000, 1)
		removeEventHandler("onClientKey", root, close)
		setElementDimension(localPlayer, 0)
	end
end
addEventHandler("onClientKey", root, close)
addEventHandler("onClientKey", root, switching)