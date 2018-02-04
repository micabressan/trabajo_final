--- fonts ---
surface.CreateFont( "InfoBox", {
	font = "Corleone", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 30,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "Kills", {
	font = "Corleone", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 20,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "Métier", {
	font = "Corleone", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 50,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "Serv", {
	font = "Corleone", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 128,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

--- Code Lua ---

local ScoreBoardDerma = nil
local layout = nil



function GAMEMODE:ScoreboardShow(self)
	
	if !IsValid(ScoreBoardDerma) then
		ScoreBoardDerma = vgui.Create("DFrame")
		ScoreBoardDerma:SetSize(1900, 1000)
		ScoreBoardDerma:SetPos(10, ScrH() - 1050)
		ScoreBoardDerma:SetTitle("")
		ScoreBoardDerma:SetDraggable(false)
		ScoreBoardDerma:ShowCloseButton(false)
		
		ScoreBoardDerma.Paint = function(self, w, h)

			local logo = vgui.Create( "DImage", ScoreBoardDerma )
			logo:SetPos( ScoreBoardDerma:GetWide() / 2 - 75, - 20 )
			logo:SetSize( 200, 200 )
			logo:SetImage( "tab/logo.png" )
		
			draw.RoundedBox(5, 0, 155, ScoreBoardDerma:GetWide(), 50, Color(50, 50, 50, 255))
			draw.RoundedBox(5, 0, 0, ScoreBoardDerma:GetWide(), 150, Color(235, 0, 0, 240))
			draw.RoundedBox(5, 0, 210, ScoreBoardDerma:GetWide(), ScoreBoardDerma:GetTall() - 0, Color(0, 0, 0, 240))

			draw.SimpleText("Nom", "InfoBox", layout:GetWide() - 1840, 170, Color(255,255,255,150))

			draw.SimpleText("Kill", "InfoBox", layout:GetWide() - 260, 170, Color(255,255,255,150), TEXT_ALIGN_RIGHT)
			draw.SimpleText("Morts", "InfoBox", layout:GetWide() - 180, 170, Color(255,255,255,150), TEXT_ALIGN_RIGHT)
			draw.SimpleText("Ping", "InfoBox", layout:GetWide() - 50, 170, Color(255,255,255,150), TEXT_ALIGN_RIGHT)
			draw.SimpleText("Rang", "InfoBox", layout:GetWide() - 1400, 170, Color(255,255,255,150))

			
		end

		local PlayerScrollPanel = vgui.Create("DScrollPanel", ScoreBoardDerma)
		PlayerScrollPanel:SetSize(ScoreBoardDerma:GetWide(), ScoreBoardDerma:GetTall())
		PlayerScrollPanel:SetPos(0, 210)

		layout = vgui.Create("DIconLayout", PlayerScrollPanel)
		layout:SetSize(PlayerScrollPanel:GetWide(), PlayerScrollPanel:GetTall())
		layout:SetPos(0, 0)
		layout:SetMouseInputEnabled(true)
		layout:SetSpaceY(5)
		layout:SetSpaceX(5)

	end
	if IsValid(ScoreBoardDerma) then
		layout:Clear()

		for k, v in pairs(player.GetAll()) do

			local PlayerPanel = layout:Add("DPanel")
			PlayerPanel:SetSize(layout:GetWide(), 50)
			PlayerPanel:SetPos(0,0)
			PlayerPanel:SetMouseInputEnabled(true)

			PlayerPanel.OnCursorEnterred = function(self)
				self.hover = true
			end

			PlayerPanel.OnCursorExited = function(self)
				self.hover = false
			end

			PlayerPanel.Paint = function(self, w, h)
				if self.hover then
					draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50, 255))
				else
					draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50, 200))
				end
					
					

					draw.SimpleText(v:GetName(), "InfoBox", layout:GetWide() - 1840, 12, Color(255, 255, 255, 150))
					draw.SimpleText(v:Frags(), "InfoBox", layout:GetWide() - 260, 12, Color(255, 255, 255 , 150), TEXT_ALIGN_RIGHT)
					draw.SimpleText(v:Deaths(), "InfoBox", layout:GetWide() - 180, 12, Color(255, 255, 255, 150), TEXT_ALIGN_RIGHT)
					draw.SimpleText(v:Ping() .. " ms", "InfoBox", layout:GetWide() - 50, 12, Color(255,255,255,150), TEXT_ALIGN_RIGHT)
					draw.SimpleText(v:GetUserGroup(), "InfoBox", layout:GetWide() - 1400, 12, Color(255,255,255,150))

					playeravatar = vgui.Create( "AvatarImage", PlayerPanel)
					playeravatar:SetSize(50,50)
					playeravatar:SetPlayer( v, 40)
					
			end

			local buttonid = vgui.Create("DButton", PlayerPanel)
			buttonid:SetSize(220,35)
			buttonid:SetPos(ScrW() / 2 + 375, 5)
			buttonid:SetText( v:SteamID() )
			buttonid:SetFont( "InfoBox" )
			buttonid:SetTextColor(Color(255, 255, 255, 255))
			buttonid:SetTooltip("Vous devez clicker pour copié le SteamID")
			buttonid.Paint = function(self, w, h)
				draw.RoundedBox(5, 0, 0, w, h, Color(0,0,0,255))
			end
			buttonid.DoClick = function()
				SetClipboardText( v:SteamID() )
				chat.AddText(" Vous avez copié le SteamID de " .. v:GetName())
			end



			local client = LocalPlayer()

			if (client:IsAdmin() or client:IsSuperAdmin() ) then
				local adminpanel = vgui.Create("DButton", PlayerPanel)
				adminpanel:SetSize(130,35)
				adminpanel:Center()
				adminpanel:SetTextColor(Color(255, 255, 255, 255))
				adminpanel:SetFont("InfoBox")
	
				adminpanel:SetText("Administration")

				adminpanel.Paint = function(self, w, h)
					draw.RoundedBox(5, 0, 0, w, h, Color(0,0,0,255))
				end
			



				adminpanel.DoClick = function()
					frameadmin = vgui.Create("DFrame")
					frameadmin:Center()
					frameadmin:SetSize(ScrW() / 2, ScrH() / 2)
					frameadmin:MakePopup()
					frameadmin:SetTitle("")
					frameadmin.Paint = function()
						draw.RoundedBox(5,0,0,frameadmin:GetWide(), frameadmin:GetTall(), Color(50,50,50,215))

					end

					local tpply = vgui.Create("DButton", frameadmin)
					tpply:SetSize(frameadmin:GetWide(), 50)
					tpply:SetPos(0, 150)
					tpply:SetText("Téléporter le joueur")
					tpply:SetTextColor(Color(255,255,255,255))
					tpply:SetFont("Métier")
					tpply.DoClick = function()
						RunConsoleCommand("ulx", "teleport", v:GetName() )
					end
					tpply.Paint = function(self, w, h)
						draw.RoundedBox(0,0,0,w,h,Color(255,0,0,255))
					end

					local spectate = vgui.Create("DButton", frameadmin)
					spectate:SetSize(frameadmin:GetWide(), 50)
					spectate:SetPos(0, 210)
					spectate:SetText("Spectate le joueur")
					spectate:SetTextColor(Color(255,255,255,255))
					spectate:SetFont("Métier")
					spectate.DoClick = function()
						RunConsoleCommand("ulx", "spectate", v:GetName() )
					end
					spectate.Paint = function(self, w, h)
						draw.RoundedBox(0,0,0,w,h,Color(255,0,0,255))
					end

					local freeze = vgui.Create("DButton", frameadmin)
					freeze:SetSize(frameadmin:GetWide(), 50)
					freeze:SetPos(0, 270)
					freeze:SetText("Freeze le joueur")
					freeze:SetTextColor(Color(255,255,255,255))
					freeze:SetFont("Métier")
					freeze.DoClick = function()
						RunConsoleCommand("ulx", "freeze", v:GetName() )
					end
					freeze.Paint = function(self, w, h)
						draw.RoundedBox(0,0,0,w,h,Color(255,0,0,255))
					end

					local unfreeze = vgui.Create("DButton", frameadmin)
					unfreeze:SetSize(frameadmin:GetWide(), 50)
					unfreeze:SetPos(0, 330)
					unfreeze:SetText("UnFreeze le joueur")
					unfreeze:SetTextColor(Color(255,255,255,255))
					unfreeze:SetFont("Métier")
					unfreeze.DoClick = function()
						RunConsoleCommand("ulx", "unfreeze", v:GetName() )
					end
					unfreeze.Paint = function(self, w, h)
						draw.RoundedBox(0,0,0,w,h,Color(255,0,0,255))
					end


					local plystats = vgui.Create("DButton", frameadmin)
					plystats:SetSize(frameadmin:GetWide(), 50)
					plystats:SetPos(0, 390)
					plystats:SetText("Stats du joueurs")
					plystats:SetTextColor(Color(255,255,255,255))
					plystats:SetFont("Métier")
					plystats.DoClick = function()
						local framestatadmin = vgui.Create("DFrame")
						framestatadmin:Center()
						framestatadmin:SetSize(ScrW() / 2 - 100, ScrH() / 2 - 75)
						framestatadmin:MakePopup()
						framestatadmin:SetTitle("")
						framestatadmin.Paint = function()
							draw.RoundedBox(6,0,0, framestatadmin:GetWide(), framestatadmin:GetTall(), Color(63,63,63,225))

							draw.SimpleText("Argent : " .. v.DarkRPVars.money .. " $", "InfoBox", 10, 10, Color(255,255,255,255))
						end
					end
					plystats.Paint = function(self, w, h)
						draw.RoundedBox(0,0,0,w,h,Color(255,0,0,255))
					end

				end

			end
		end

		ScoreBoardDerma:Show()
		ScoreBoardDerma:MakePopup()
		ScoreBoardDerma:SetKeyboardInputEnabled(false)
		ScoreBoardDerma:SetMouseInputEnabled(true)

	end
end

function GAMEMODE:ScoreboardHide(self)
	if IsValid(ScoreBoardDerma) then
		ScoreBoardDerma:Hide()
	end
end