function isMouseInPosition ( x, y, width, height )
    if ( not isCursorShowing ( ) ) then
        return false
    end
 
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
    end
end

local x,y = guiGetScreenSize ()

addEventHandler ("onClientResourceStart", getRootElement(),
	function ()
		animat = 500
		showCursor (true)
		guiSetInputEnabled (true)
	end
)

addEventHandler ("onClientRender", root,
	function ()
		if (animat >= 0) then
			animat = animat - 8
		end
	end
)

function main ()
	dxDrawRectangle (493, 284-animat, 380, 20, tocolor (255, 113, 3, 155)) 
	dxDrawRectangle (493, 304-animat, 380, 180, tocolor (255, 255, 255, 155))
	
	if isMouseInPosition (515, 433, 150, 35) then
		dxDrawRectangle (515, 433-animat, 150, 35, tocolor (255, 113, 3, 215))
	else
		dxDrawRectangle (515, 433-animat, 150, 35, tocolor (255, 113, 3, 155))
	end
	
	if isMouseInPosition (701, 433, 150, 35) then
		dxDrawRectangle (701, 433-animat, 150, 35, tocolor (255, 113, 3, 215))
	else
		dxDrawRectangle (701, 433-animat, 150, 35, tocolor (255, 113, 3, 155))
	end
	
	dxDrawText ("Login", 565, 437.5-animat, x, y, tocolor (255, 255, 255, 155), 1.5, "arial")
	dxDrawText ("Play As Guest", 718, 437.5-animat, x, y, tocolor (255, 255, 255, 155), 1.5, "arial")
	 
    createEditBox( "1", 0.397, (330.24-animat)/768, 0.20, 0.04, true, "", false, 25, "arial", false, 0, {255, 255, 255, 155}, true, {255, 113, 3, 155}, 1.5, true, 30, true, "Username", {255, 255, 255, 155}, true, 1.5, "arial", true, true, {255, 255, 255, 155}, false  )
    createEditBox( "2", 0.397, 0.49, 0.20, 0.04, true, "", true, 25, "arial", false, 0, {255, 255, 255, 155}, true, {255, 113, 3, 155}, 1.5, true, 30, true, "Password", {255, 255, 255, 155}, true, 1.5, "arial", true, true, {255, 255, 255, 155}, false  )
 
	--Vertical holders:
	dxDrawLine (500, -70-animat, 500, 284-animat, tocolor (255, 113, 3, 155), 15)
	dxDrawLine (865, -70-animat, 865, 284-animat, tocolor (255, 113, 3, 155), 15)
end
addEventHandler ("onClientRender", getRootElement(), main)