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