--[[configTimeComboBox[1] = { -- +1 à chaque fois 
    title = "Ban (1 Heure)", -- Nom prédéfinis I-G
    time = 60,				-- Temps si ban en minutes
	action = "ban",			-- action (ban, kick, warn)
}]]--						-- ban pas besoin d'argumenter
							-- kick besoin argumentation
							-- warn besoin argumentation

local configTimeComboBox = {}

configTimeComboBox[1] = {
    title = "Ban (1 Heure)",
    time = 60,
	action = "ban",
}
configTimeComboBox[2] = {
    title = "Ban (5 Heure)",
    time = 300,
	action = "ban",
}
configTimeComboBox[3] = {
    title = "Ban Perm",
    time = 0,
	action = "ban",
}

configTimeComboBox[4] = {
    title = "Simple Kick", -- Obliger de mettre une raison
    time = 0,
	action = "kick",
}

configTimeComboBox[5] = {
    title = "Avertissement",  -- Obliger de mettre une raison
    time = 0,
	action = "warn",
}

function awarn_playerwarnmenu()
	local MenuFrame = vgui.Create( "DFrame" )
	MenuFrame:SetPos( ScrW() / 2 - 190, ScrH() / 2 - 85 )
	MenuFrame:SetSize( 380, 250 )
	MenuFrame:SetVisible( true )
	MenuFrame:SetDraggable( true )
	MenuFrame:ShowCloseButton( true )
	MenuFrame:MakePopup()
	 
	local MenuPanel = vgui.Create( "DPanel", MenuFrame )
	MenuPanel:SetPos( 5, 30 )
	MenuPanel:SetSize( 370, 250 )
	MenuPanel.Paint = function() -- Paint function
		surface.SetDrawColor( 50, 50, 50, 255 ) 
		surface.DrawRect( 0, 0, MenuPanel:GetWide(), MenuPanel:GetTall() ) -- Draw the rect
	end
	
	local HiddenLabel = vgui.Create( "DLabel", MenuPanel )
	HiddenLabel:SetPos( 0, 0 )
	HiddenLabel:SetColor( Color(255, 255, 255, 0) )
	HiddenLabel:SetFont( "AWarnFont1" )
	HiddenLabel:SetText( AWarn.activeplayer )
	HiddenLabel:SizeToContents()
	
	MenuFrame:SetTitle( AWarn.localizations[loc].cl21 .. " ::: " .. HiddenLabel:GetText() )
	
	local MenuPanelLabel1 = vgui.Create( "DLabel", MenuPanel )
	MenuPanelLabel1:SetPos( 5, 5 )
	MenuPanelLabel1:SetColor( Color(255, 255, 255, 255) )
	MenuPanelLabel1:SetFont( "AWarnFont1" )
	MenuPanelLabel1:SetText( AWarn.localizations[loc].cl22 )
	MenuPanelLabel1:SizeToContents()
	
	local MenuPanelLabel2 = vgui.Create( "DLabel", MenuPanel )
	MenuPanelLabel2:SetPos( 120, 5 )
	MenuPanelLabel2:SetColor( Color(255, 20, 20, 255) )
	MenuPanelLabel2:SetFont( "AWarnFont1" )
	MenuPanelLabel2:SetText( HiddenLabel:GetText() )
	MenuPanelLabel2:SizeToContents()
	
	local MenuPanelLabel3 = vgui.Create( "DLabel", MenuPanel )
	MenuPanelLabel3:SetPos( 5, 25 )
	MenuPanelLabel3:SetColor( Color(255, 255, 255, 255) )
	MenuPanelLabel3:SetFont( "AWarnFont1" )
	MenuPanelLabel3:SetText( AWarn.localizations[loc].cl8 .. ":" )
	MenuPanelLabel3:SizeToContents()
	
		local hl = vgui.Create( "DComboBox", MenuPanel)
	hl:SetPos( 5 , 70)
	hl:SetSize( 360, 20 )
for k,v in pairs(configTimeComboBox) do
        hl:AddChoice(v.title)
    hl.OnSelect = function(panel, id, value)
		choicecombobox = value
	action = configTimeComboBox[id].action
	time = configTimeComboBox[id].time
        chat.AddText("Vous avez choisi: "..value.." et la valeur time est de: "..time .. " minutes et l'action est :" .. action)
    end
end
	
	local MenuPanelTextEntry1 = vgui.Create( "DTextEntry", MenuPanel )
	MenuPanelTextEntry1:SetPos( 5, 95 )
	MenuPanelTextEntry1:SetMultiline( true )
	MenuPanelTextEntry1:SetSize( 360, 50 )
	
	local MenuPanelButton1 = vgui.Create( "DButton", MenuPanel )
	MenuPanelButton1:SetSize( 80, 30 )
	MenuPanelButton1:SetPos( 5, 150 )
	MenuPanelButton1:SetText( AWarn.localizations[loc].cl23 )
	MenuPanelButton1.DoClick = function( MenuPanelButton1 )
		
			if action == "ban" then
			awarn_sendwarning( HiddenLabel:GetText(), choicecombobox )
			timer.Simple(1, function() awarn_ban( HiddenLabel:GetText():SteamID64(), time, choicecombobox ) end )
			chat.AddText("mdr le ban passe") end 
			
			if action == "kick"
			then awarn_sendwarning( HiddenLabel:GetText(), MenuPanelTextEntry1:GetValue() ) 
			timer.Simple(1, function() awarn_kick( HiddenLabel:GetText():SteamID64(), MenuPanelTextEntry1:GetValue() ) end ) 
			chat.AddText("mdr le kick passe") 
			end 
			
			if action == "warn"
			then awarn_sendwarning( HiddenLabel:GetText(), MenuPanelTextEntry1:GetValue() )
			end 
		MenuFrame:Close()
	end
	
	local MenuPanelButton2 = vgui.Create( "DButton", MenuPanel )
	MenuPanelButton2:SetSize( 80, 30 )
	MenuPanelButton2:SetPos( 90, 150 )
	MenuPanelButton2:SetText( AWarn.localizations[loc].cl24 )
	MenuPanelButton2.DoClick = function( MenuPanelButton2 )
		MenuFrame:Close()
	end
end