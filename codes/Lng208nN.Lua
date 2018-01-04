--dxDrawText ( input[1], invWindow[1], invWindow[1], invWindow[2], invWindow[3], tocolor(255, 255, 255), 1, panelFont )
-- 2-3 bal felső 3-4 jobb alsó

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--
local sx, sy = guiGetScreenSize()
local dxScale = sx/1280
local invWindow = {0.35, 0.4}
local panelFont = dxCreateFont ( "Roboto.ttf", 14 )
--local loginSound = playSound("music.mp3", true)
local input = {"ANYÁDTEGECIGUI", ""}
local inputPointer = false
showCursor(true)
 
addEventHandler("onClientClick", root,
function(button, state)
	local cX, cY = getCursorPosition() 
	if (button == "left") then
		if (state == "down") then 
			if (cX > (invWindow[1] + 0.050)) and (cX < (invWindow[1] + 0.050) + 0.180) and (cY > (invWindow[2] + 0.07)) and (cY < (invWindow[2] + 0.07) + sy*0.040) then
				dxDrawRectangle(sx*(invWindow[1] + 0.050), sy*(invWindow[2] + 0.07), sx*0.180, sy*0.040)
				--dxDrawText( input[1], (invWindow[1] + 0.050), (invWindow[1] + 0.050) + 0.180, (invWindow[2] + 0.07), (invWindow[2] + 0.07) + sy*0.040 )    
				--dxDrawText ( input[1], sx*(invWindow[1] + 0.050), sx*(invWindow[2] + 0.07), sy*(invWindow[1] + 0.050) + 0.180, sx*(invWindow[2] + 0.07) + 0.040, tocolor(255, 255, 255), 1, panelFont )
			end
		end
	end 
end
)



addEventHandler("onClientRender", root,
function()

   --dxDrawRectangle ( sx*invWindow[1], sy*invWindow[2], sx*0.3, sy*0.5, tocolor ( 0, 0, 0, 200 ) )
   dxDrawRectangle ( sx*(invWindow[1] + 0.050), sy*(invWindow[2] + 0.07), sx*0.180, sy*0.040, tocolor ( 0, 0, 0, 100 ) )
   --dxDrawRectangle ( sx*(invWindow[1] + 0.050), sy*(invWindow[2] + 0.160), sx*0.180, sy*0.040, tocolor ( 0, 0, 0, 100 ) )
   --dxDrawRectangle ( sx*invWindow[1], sy*invWindow[2], sx*0.3, sy*0.030, tocolor ( 0, 0, 0, 200 ) )
   --dxDrawRectangle ( sx*invWindow[1], sy*(invWindow[2] + 0.470), sx*0.3, sy*0.030, tocolor ( 0, 0, 0, 200 ) )
   --dxDrawRectangle ( sx*(invWindow[1] + 0.050), sy*(invWindow[2] + 0.230), sx*0.090, sy*0.040, tocolor ( 140, 214, 122, 150 ) )
   --dxDrawRectangle ( sx*(invWindow[1] + 0.160), sy*(invWindow[2] + 0.230), sx*0.090, sy*0.040, tocolor ( 204, 46, 46, 150 ) )
   
   --dxDrawText ( "CubeMTA v2", 570, 410, 300, 350, tocolor(59,123,226), dxScale*1, panelFont )
   --dxDrawText ( "Felhasználónév", 560, 440, 300, 350, tocolor(255, 255, 255), 1, panelFont )
   --dxDrawText ( "Jelszó", 600, 540, 300, 350, tocolor(255, 255, 255), 1, panelFont )
   --dxDrawText ( "Belépés", 535, 653, 300, 350, tocolor(255, 255, 255), 1, panelFont )
   ---dxDrawText ( "Regisztráció", 655, 653, 300, 350, tocolor(255, 255, 255), 1, panelFont )
   ---dxDrawText ( "www.cubemta.us", 570, 895, 300, 350, tocolor(59, 123, 226), 1, panelFont )
   
   --dxDrawImage ( sx/2.1 - 50, 700, 150, 170, 'Cube.png', angle, 0, -120 )
   
   --setSoundVolume(loginSound, 1)

   --dxDrawRectangle ( sx*invWindow[1], sy*invWindow[2], sx*0.3, sy*0.5, tocolor ( 0, 0, 0, 200 ) ) 
	dxDrawText ( input[1], sx*(invWindow[1] + 0.050), sx*(invWindow[2] + 0.07), sy*(invWindow[1] + 0.050) + 0.180, sy*(invWindow[2] + 0.07) + 0.040, tocolor(255, 255, 255), 1, panelFont )





end
)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------