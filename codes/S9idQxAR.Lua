-- Nametag Settings --
local Nametags = {
	showing = false;		-- don't touch this, it's already auto-enabled with onClientResourceStart (but if you change that you'll need to edit this variable)
	font = "default-bold";		-- nametag font
	shadow = true;			-- whether or not to make shadow of nametag's text (so that it can be seen in any environment)
	showHealthbar = true;	-- whether or not to show health bar and armor bar
	hpBarWidth = 100;		-- Max health bar width (132 because i think max nick length is 22 and dxGetTextWidth returns around 132 for that length) -- 122
	hpBarHeight = 13;		-- Health bar height
	scale = 1;				-- Font scale
	groupScale = 0.8;
	shadowRecThickness = 2;	-- Thickness of shadow around healthbar
	maxDistance = 10;		-- Distance at which nametag starts to fade out
	adaptToTeam = true;		-- Should player's nametag color be changed to team's if player has a team?	
	fadeOutGradient = 10;	-- Range of when player actually starts getting increased alpha of nametag
	name_groupDistance = 15;
};

local imgW = 41				-- Image width for wanted level icon
local imgH = 41				-- Image height for wanted level icon

function Nametags.render()	
	local bIgnoreDistance = false;
	-- Check if we're aiming at someone, if yes, force the nametag to be shown
	if localPlayer:getTargetStart() and localPlayer:getTargetEnd() and getKeyState("mouse2") then
		local sx, sy, sz = getPedTargetStart(localPlayer);
		local ex, ey, ez = getPedTargetEnd(localPlayer);
		bIgnoreDistance, _, _, _, hitElement = processLineOfSight(sx, sy, sz, ex, ey, ez, false, true, true, false, false, true, false, true, localPlayer, false, false);
		
		-- Check if it's a player or is it a vehicle with players
		if hitElement then		
			if hitElement:getType() == "ped" then
				targets[ hitElement ] = {}	
				targets[ hitElement ].plr = hitElement
				--targets[ hitElement ].team = getPlayerTeam( hitElement ) or nil
				--targets[ hitElement ].group = exports [ "(SAUR)Jobs" ]:getPlayerClan( hitElement ) or "[ None ] "				
			elseif hitElement:getType() == "vehicle" then				
				for _, v in pairs(getVehicleOccupants(hitElement)) do
					targets[ v ] = {}
					targets[ v ].plr = v;
					--targets[ v ].team = getPlayerTeam( v ) or nil
					--targets[ v ].group = exports [ "(SAUR)Jobs" ]:getPlayerClan( v ) or "[ None ] "					
				end
			end
		end
	end

	for i, player in pairs(getElementsByType("ped", root, true )) do	

		local x, y, z = getPedBonePosition(player, 8);
		local mx, my, mz = getCameraMatrix();
		local distance = getDistanceBetweenPoints3D(mx, my, mz, x, y, z);

		if getElementHealth( player ) > 0 then
			if ( distance <= 50 or isElement( targets[ player ].plr ) ) then
				if isLineOfSightClear( mx, my, mz, x, y, z, true, false, false, true, false, false, false, localPlayer ) then
					local additional_z = .5;
					local X, Y = getScreenFromWorldPosition(x, y, z + additional_z);

						if X and Y then
							--local text = Nametags.shadow and player:getName();							
							
							local r, g, b = 255,255,255				
							local alpha = 175;
							local font = "default-bold";
							
							--if targets[ player ].team then							
							--	r, g, b = targets[ player ].team:getColor()
							--else
							--	r, g, b = player:getNametagColor() or tocolor( 255,255,255)
							--end

							-- Should we fade out? --
							if distance >= Nametags.maxDistance and not bIgnoreDistance then
								local leftover = distance - Nametags.maxDistance;
								alpha = math.max(0, alpha - distance * ( leftover/ Nametags.fadeOutGradient ));		
							end
							-- Draw healthbar --
							if Nametags.showHealthbar then
								local fontHeight = dxGetFontHeight(Nametags.scale, font);
								local distanceScaling = distance * 1.5;
								-- If we are aiming from distance longer than fade distance then dont scale the rectangles --
								if (bIgnoreDistance and distance > Nametags.maxDistance) or (distance > Nametags.maxDistance + (distance - Nametags.maxDistance)) then
									distanceScaling = 0;
									distance = 0;
								end

								local multiplier = Nametags.hpBarWidth / getPedMaxHealth(player);
								local middleDistanceScale =  (  (X - Nametags.hpBarWidth / 2 + distanceScaling / 2 ) - (X - Nametags.hpBarWidth / 2)  ) / 2;
								local colorMultiplier = 255 / getPedMaxHealth(player);
								local armor = player:getArmor();
								local divider = (10-(player:getHealth()/getPedMaxHealth(player))*8);

								local recX = X - Nametags.hpBarWidth / 2 + middleDistanceScale;
								local recY = Y 
								local recWidth = math.max(player:getHealth() * multiplier - distanceScaling / divider, 1); -- distanceScaling / 10 makes it so low health doesnt 'decrease' when you get far away from player but it causes issue of full health getting out of healtbar, and distanceScaling / 2 makes it at full health to stay inside but on small health when you go away from player it looks like his health is lowering
								local recHeight = Nametags.hpBarHeight - distanceScaling / 20;
								local healthR, healthG, healthB, healthAlpha = tocolor( math.max( 255 - player:getHealth() * colorMultiplier, 0), math.max(0 + player:getHealth() * colorMultiplier, 0), 0, alpha )

								-- Dead issue fix --
								if player:getHealth() == 0 then
									recWidth = 0;
								end

								-- Fix when player has 200hp eventho his max is 100, and fixes other impossible cases, this is actually more of a safeguard that health bar never gets out of its 'prison'
								if recWidth > Nametags.hpBarWidth then
									recWidth = Nametags.hpBarWidth - Nametags.shadowRecThickness;
								end
								-- Health border
								dxDrawRectangle(recX - Nametags.shadowRecThickness, recY - Nametags.shadowRecThickness, Nametags.hpBarWidth + Nametags.shadowRecThickness * 2 - distanceScaling / 2, recHeight + Nametags.shadowRecThickness * 2, tocolor(0, 0, 0, alpha));
								-- Actual healthbar 
								dxDrawRectangle(recX, recY, recWidth, recHeight, healthR, healthG, healthB, healthAlpha );
								-- Draw smaller health bars
								local w = Nametags.hpBarWidth / 5 				
								dxDrawLine( recX + w, recY + ( recHeight / 2 ), recX + w, recY - ( recHeight / w ) ,tocolor( 0, 0, 0, alpha ) )
								local w2 = w + w
								dxDrawLine( recX + w2, recY + ( recHeight / 2 ), recX + w2, recY - ( recHeight / w2 ) ,tocolor( 0, 0, 0, alpha ) )
								local w3 = w2 + w
								dxDrawLine( recX + w3, recY + ( recHeight / 2 ), recX + w3, recY - ( recHeight / w3 ) ,tocolor( 0, 0, 0, alpha ) )
								local w4 = w3 + w
								dxDrawLine( recX + w4, recY + ( recHeight / 2 ), recX + w4, recY - ( recHeight / w4 ) ,tocolor( 0, 0, 0, alpha ) )

								-- armor bar	
								local armorR, armorG, armorB = 120, 120, 120
								local armorAlpha = math.max(0, ( armor + 150 ) - distance * ( ( distance - Nametags.maxDistance ) / Nametags.fadeOutGradient ));
								if ( armor > 0 ) then
									dxDrawRectangle(recX, recY, recWidth , recHeight, armor > 0 and tocolor(armorR, armorG, armorB, armorAlpha) or tocolor(0, 0, 0, alpha) );
								end
 
								dxDrawImage(recX - ( Nametags.hpBarWidth / 2 - 10), recY - 15, imgW, imgH, ":AntixNEWHUD/6.png", 0, 0, 0, tocolor(255, 255, 255, alpha * 1.3 ), false)		

								--	local wantedlvl = getPlayerWantedLevel( targets[ player ].plr )
								--if ( wantedlvl > 0 ) then								
									--dxDrawImage(recX - ( Nametags.hpBarWidth / 2 - 10), recY - 15, imgW, imgH, ":AntixNEWHUD/"..wantedlvl..".png", 0, 0, 0, tocolor(255, 255, 255, alpha * 1.3 ), false)		
								--end
								
								-- GROUP --						
								Y = Y - Nametags.name_groupDistance
								local groupName = "None"--targets[ player ].group-- targets[ player ].group
								gR, gG, gB = 255,255,255

								--if targets[ player ].group == targets[ localPlayer ].group then
								--	gR, gG, gB = 0,225,0
								--end
								dxDrawText( groupName, X - dxGetTextWidth(groupName, Nametags.groupScale, font), Y, X + dxGetTextWidth(groupName, Nametags.groupScale, font), Y, Nametags.shadow and tocolor(0, 0, 0, alpha) or tocolor(gR, gG, gB, alpha), Nametags.groupScale, font, "center", "top", false, false, false, Nametags.shadow and false or true);
								if Nametags.shadow then
									dxDrawText( groupName, X - dxGetTextWidth(groupName, Nametags.groupScale, font) - 1, Y - 1, X + dxGetTextWidth(groupName, Nametags.groupScale, font) - 1, Y - 1, tocolor(gR, gG, gB, alpha), Nametags.groupScale, font, "center", "top", false, false, false, true);
								end		
								
								-- NAME --
								Y = Y - Nametags.name_groupDistance	
								local playerName = "PLAYERNAME"
								dxDrawText( playerName, X - dxGetTextWidth(playerName, Nametags.scale, font), Y, X + dxGetTextWidth(playerName, Nametags.scale, font), Y, Nametags.shadow and tocolor(0, 0, 0, alpha) or tocolor(r, g, b, alpha), Nametags.scale, font, "center", "top", false, false, false, Nametags.shadow and false or true);
								if Nametags.shadow then
									dxDrawText( playerName, X - dxGetTextWidth(playerName, Nametags.scale, font) - 1, Y - 1, X + dxGetTextWidth(playerName, Nametags.scale, font) - 1, Y - 1, tocolor(r, g, b, alpha), Nametags.scale, font, "center", "top", false, false, false, true);							
								end									
							--[[
								Y = Y + 53
								X = X - 2
								text = "TITLE"
								dxDrawText( text, X - dxGetTextWidth(text, Nametags.scale, font), Y, X + dxGetTextWidth(text, Nametags.scale, font), Y, Nametags.shadow and tocolor(0, 0, 0, alpha) or tocolor(gR, gG, gB, alpha), Nametags.scale, font, "center", "top", false, false, false, Nametags.shadow and false or true);
								if Nametags.shadow then
									dxDrawText(text, X - dxGetTextWidth(text, Nametags.scale, font) - 1, Y - 1, X + dxGetTextWidth(text, Nametags.scale, font) - 1, Y - 1, tocolor(gR, gG, gB, alpha), Nametags.scale, font, "center", "top", false, false, false, true);
								end
								
								imgX = X - 10
								imgY = Y 																							
								dxDrawImage(imgX - dxGetTextWidth(text, Nametags.scale, font), imgY, 16, 16, ":AntixNEWHUD/icons/25.png", 0, 0, 0, tocolor(255, 255, 255, alpha * 1.3 ), false)	
								]]	
							end
						end								
					end 
				end
			end
		end
	end -- for loop
addEventHandler("onClientRender", root, Nametags.render)