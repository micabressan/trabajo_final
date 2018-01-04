-- Nametag Settings --
local sx_, sy_ = guiGetScreenSize()
local sx, sy = sx_/1680, sy_/1050

local Nametags = {
    showing = false;        -- don't touch this, it's already auto-enabled with onClientResourceStart (but if you change that you'll need to edit this variable)
    font = "default";        -- nametag font
    shadow = false;            -- whether or not to make shadow of nametag's text (so that it can be seen in any environment)
    showHealthbar = true;    -- whether or not to show health bar and armor bar
    hpBarWidth = 100;        -- Max health bar width (132 because i think max nick length is 22 and dxGetTextWidth returns around 132 for that length) -- 122
    hpBarHeight = 13;        -- Health bar height
    scale = math.min ( 1, 1 * sy );                -- Font scale
    groupScale = math.min ( 0.8, 0.8 * sy );
    shadowRecThickness = 2;    -- Thickness of shadow around healthbar
    maxDistance = 10;        -- Distance at which nametag starts to fade out
    adaptToTeam = true;        -- Should player's nametag color be changed to team's if player has a team?    
    fadeOutGradient = 10;    -- Range of when player actually starts getting increased alpha of nametag
    name_groupDistance = 15;
};
local fontHeight = dxGetFontHeight(Nametags.scale, Nametags.font);

local imgW = 41				-- Image width for wanted level icon
local imgH = 41				-- Image height for wanted level icon

--function Player:GetNick() -- returns hexless nick
--	return self:getName():gsub("#%x%x%x%x%x%x", "");
--end

function getPedMaxHealth(ped)
    -- Output an error and stop executing the function if the argument is not valid
    assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"), "Bad argument @ 'getPedMaxHealth' [Expected ped/player at argument 1, got " .. tostring(ped) .. "]")
    -- Grab his player health stat.
    local stat = getPedStat(ped, 24)
    -- Do a linear interpolation to get how many health a ped can have.
    -- Assumes: 100 health = 569 stat, 200 health = 1000 stat.
    local maxhealth = 100 + (stat - 569) / 4.31
    -- Return the max health. Make sure it can't be below 1
    return math.max(1, maxhealth)
end

function dxDrawEmptyRectangle(startX, startY, endX, endY, color, width, postGUI)
	dxDrawLine ( startX, startY, startX+endX, startY, color, width, postGUI )
	dxDrawLine ( startX, startY, startX, startY+endY, color, width, postGUI )
	dxDrawLine ( startX, startY+endY, startX+endX, startY+endY,  color, width, postGUI )
	dxDrawLine ( startX+endX, startY, startX+endX, startY+endY, color, width, postGUI )
end

local targets = {};

function Nametags.render()	
	local bIgnoreDistance = false;
	-- Check if we're aiming at someone, if yes, force the nametag to be shown
	if getKeyState("mouse2") then
		if localPlayer:getTargetStart() and localPlayer:getTargetEnd() then
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
	end

	local mx, my, mz = getCameraMatrix();
	local additional_z = .5;
	for i, player in ipairs(getElementsByType("player", root, true )) do
		if getElementHealth( player ) > 0 and isElementOnScreen ( player ) then
			local x, y, z = getPedBonePosition(player, 8);
			local distance = getDistanceBetweenPoints3D(mx, my, mz, x, y, z);
			if ( distance <= 50 or ( targets[ player ] and isElement( targets[ player ].plr ) ) ) then
				if isLineOfSightClear( mx, my, mz, x, y, z, true, false, false, true, false, false, false, localPlayer ) then
					local X, Y = getScreenFromWorldPosition(x, y, z + additional_z);
					if X and Y then
						--local text = Nametags.shadow and player:getName();							
						local r, g, b = 255, 255, 255
						local alpha = 175
						-- Draw healthbar --
						if Nametags.showHealthbar then
							-- Should we fade out? --
							if distance >= Nametags.maxDistance and not bIgnoreDistance then
								local leftover = distance - Nametags.maxDistance;
								alpha = math.max(0, alpha - distance * ( leftover / Nametags.fadeOutGradient ));		
							end

							local distanceScaling = distance * 1.5;
							-- If we are aiming from distance longer than fade distance then dont scale the rectangles --
							if (bIgnoreDistance and distance > Nametags.maxDistance) or (distance > Nametags.maxDistance + (distance - Nametags.maxDistance)) then
								distanceScaling = 0;
								distance = 0;
							end

							local HP = player:getHealth ( )
							local maxHP = getPedMaxHealth(player)
							local multiplier = Nametags.hpBarWidth / maxHP;
							local middleDistanceScale =  (  (X - Nametags.hpBarWidth / 2 + distanceScaling / 2 ) - (X - Nametags.hpBarWidth / 2)  ) / 2;
							local colorMultiplier = 255 / maxHP;
							local armor = player:getArmor();
							local divider = (10-(HP/maxHP)*8);

							local recX = X - Nametags.hpBarWidth / 2 + middleDistanceScale;
							local recY = Y
							local recWidth = math.max(HP * multiplier - distanceScaling / divider, 1); -- distanceScaling / 10 makes it so low health doesnt 'decrease' when you get far away from player but it causes issue of full health getting out of healtbar, and distanceScaling / 2 makes it at full health to stay inside but on small health when you go away from player it looks like his health is lowering
							local recHeight = Nametags.hpBarHeight - distanceScaling / 20;
							local healthColor = tocolor( math.max( 255 - HP * colorMultiplier, 0), math.max(0 + HP * colorMultiplier, 0), 0, alpha )

							-- Dead issue fix --
							if HP == 0 then
								recWidth = 0;
							end

							-- Fix when player has 200hp eventho his max is 100, and fixes other impossible cases, this is actually more of a safeguard that health bar never gets out of its 'prison'
							if recWidth > Nametags.hpBarWidth then
								recWidth = Nametags.hpBarWidth - Nametags.shadowRecThickness;
							end
							-- Health border
							dxDrawRectangle(recX - Nametags.shadowRecThickness, recY - Nametags.shadowRecThickness, Nametags.hpBarWidth + Nametags.shadowRecThickness * 2 - distanceScaling / 2, recHeight + Nametags.shadowRecThickness * 2, tocolor(0, 0, 0, alpha));
							-- Actual healthbar 
							dxDrawRectangle(recX, recY, recWidth, recHeight, healthColor );
							
							-- Draw smaller health bars ( NOT WORKING PROPERLY YET )
							--local w = Nametags.hpBarWidth / 5
							--local halfRectHeight = ( recHeight / 2 )
							--local lineColor = tocolor( 0, 0, 0, alpha )
							--dxDrawLine( recX + w, recY + halfRectHeight, recX + w, recY - ( recHeight / w ), lineColor )
							--local w2 = w + w
							--dxDrawLine( recX + w2, recY + halfRectHeight, recX + w2, recY - ( recHeight / w2 ), lineColor )
							--local w3 = w2 + w
							--dxDrawLine( recX + w3, recY + halfRectHeight, recX + w3, recY - ( recHeight / w3 ), lineColor )
							--local w4 = w3 + w
							--dxDrawLine( recX + w4, recY + halfRectHeight, recX + w4, recY - ( recHeight / w4 ), lineColor )
					
							-- armor bar
							local armorR, armorG, armorB = 120, 120, 120
							local armorAlpha = math.max(0, ( armor + 150 ) - distance * ( ( distance - Nametags.maxDistance ) / Nametags.fadeOutGradient ));
							if ( armor > 0 ) then
								dxDrawRectangle(recX, recY, recWidth , recHeight, armor > 0 and tocolor(armorR, armorG, armorB, armorAlpha) or tocolor(0, 0, 0, alpha) );
							end

							-- Wanted Level icon 
							local wantedLvl = exports [ "(SAUR)PoliceDatabase" ]:getPlayerWanted( player ) or 0							
							if ( targets [ player ] and targets [ player ].wantedLvl ~= wantedLvl ) then
								targets [ player ].wantedLvl = wantedLvl
							end
							if  ( wantedLvl > 0 ) then
								if ( exports [ "(SAUR)PoliceDatabase" ]:getPlayerStatus( player ) == "violent" ) then
									dxDrawImage(recX - ( Nametags.hpBarWidth / 2 - 10), recY - 15, imgW, imgH, wantedLvl..".png", 0, 0, 0, tocolor(255, 0, 0, alpha * 1.3 ), false)
								else
									dxDrawImage(recX - ( Nametags.hpBarWidth / 2 - 10), recY - 15, imgW, imgH, wantedLvl..".png", 0, 0, 0, tocolor(255, 255, 255, alpha * 1.3 ), false)
								end
							end
							
							-- Name color based on team
							local team = getPlayerTeam( player ) or nil
							if ( targets [ player ] and targets [ player ].team ~= team ) then
								targets [ player ].team = team
							end
							if isElement( team ) then
								r, g, b = targets [ player ].team:getColor()
							else
								r, g, b = player:getNametagColor()
							end
							

							-- GROUP --						
							Y = Y - Nametags.name_groupDistance
							local groupName = exports [ "(SAUR)Jobs" ]:getPlayerClan( player ) or "None"
							gR, gG, gB = 255, 255, 255
							
							if ( targets [ player ] and targets [ player ].groupName ~= groupName ) then
								targets [ player ].groupWidth = dxGetTextWidth(groupName, Nametags.groupScale, Nametags.font)
								targets [ player ].groupName = groupName
							end							
							if targets[ player ].groupName == exports [ "(SAUR)Jobs" ]:getPlayerClan( localPlayer ) then
								gR, gG, gB = 0,225,0
							end														
							local groupWidth = ( targets [ player ] and targets [ player ].groupWidth or 0 )
							dxDrawText( groupName, X - groupWidth, Y, X + groupWidth, Y, Nametags.shadow and tocolor(0, 0, 0, alpha) or tocolor(gR, gG, gB, alpha), Nametags.groupScale, Nametags.font, "center", "top", false, false, false, Nametags.shadow and false or true);
							if Nametags.shadow then
								dxDrawText( groupName, X - groupWidth - 1, Y - 1, X + groupWidth - 1, Y - 1, tocolor(gR, gG, gB, alpha), Nametags.groupScale, Nametags.font, "center", "top", false, false, false, true);
							end

							-- NAME --
							Y = Y - Nametags.name_groupDistance	
							local playerName = ""
							if ( targets [ player ] and targets [ player ].playerName ~= playerName ) then
								targets [ player ].nameWidth = dxGetTextWidth(playerName, Nametags.scale, Nametags.font)
								targets [ player ].playerName = playerName
							end
							local nameWidth = ( targets [ player ] and targets [ player ].nameWidth or 0 )
							dxDrawText( playerName, X - nameWidth, Y, X + nameWidth, Y, Nametags.shadow and tocolor(0, 0, 0, alpha) or tocolor(r, g, b, alpha), Nametags.scale, Nametags.font, "center", "top", false, false, false, Nametags.shadow and false or true);
							if Nametags.shadow then
								dxDrawText( playerName, X - nameWidth - 1, Y - 1, X + nameWidth - 1, Y - 1, tocolor(r, g, b, alpha), Nametags.scale, Nametags.font, "center", "top", false, false, false, true);							
							end									
							--[[
							Y = Y + 53
							X = X - 2
							text = "TITLE"
							dxDrawText( text, X - dxGetTextWidth(text, Nametags.scale, Nametags.font), Y, X + dxGetTextWidth(text, Nametags.scale, Nametags.font), Y, Nametags.shadow and tocolor(0, 0, 0, alpha) or tocolor(gR, gG, gB, alpha), Nametags.scale, Nametags.font, "center", "top", false, false, false, Nametags.shadow and false or true);
							if Nametags.shadow then
								dxDrawText(text, X - dxGetTextWidth(text, Nametags.scale, Nametags.font) - 1, Y - 1, X + dxGetTextWidth(text, Nametags.scale, Nametags.font) - 1, Y - 1, tocolor(gR, gG, gB, alpha), Nametags.scale, Nametags.font, "center", "top", false, false, false, true);
								end
								
								imgX = X - 10
								imgY = Y 																							
								dxDrawImage(imgX - dxGetTextWidth(text, Nametags.scale, Nametags.font), imgY, 16, 16, ":AntixNEWHUD/icons/25.png", 0, 0, 0, tocolor(255, 255, 255, alpha * 1.3 ), false)	
							end
							]]
						end
					end								
				end 
			end
		end
	end
end


function Nametags:isShowing()
	return Nametags.showing;
end


function Nametags:setShowing(bShowing)
	if bShowing then
		if not Nametags:isShowing() then

		end
	else
		if Nametags:isShowing() then
			removeEventHandler("onClientRender", root, Nametags.render);
			Nametags.showing = false;
		end
	end
end


addEventHandler("onClientRender", root, Nametags.render)
Nametags.showing = true;

function testRender()
	dxDrawText(  endTick - startTick , 595, 644, 1224, 711, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, false, false)
	dxDrawText("" , 595, 711, 1224, 778, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, false, false)
	dxDrawText( "", 595, 778, 1224, 845, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, false, false)
	dxDrawText( "", 595, 849, 1224, 916, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, false, false)
end
--addEventHandler("onClientRender", root, testRender )			
			
--[[
addEventHandler("onClientResourceStart", resourceRoot,
	function()
		
		-- Disable nametags for everyone --
		for _, player in pairs(getElementsByType("ped")) do
			player:setNametagShowing(false);
		end

		Nametags:setShowing(true);

	end
);

addEventHandler("onClientPlayerJoin", root,
	function()
		source:setNametagShowing(false);
	end
);
]]