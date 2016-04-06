xSize, ySize = term.getSize()
menu = 1
saved = false

increments = {0,0,0,0,0,0,0}
perclick = {1,1,1,1,1,1,1}
persecond = {0,0,0,0,0,0,0}

upgrades = {
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
}

woodupgradecosts = {
	{40, 160, 400, 800, 1600, 4000, 0, 0, 0, 0},
	{160, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
}
stoneupgradecosts = {
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{160, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
}

function menus()
	term.setBackgroundColor(colors.gray)
	term.setTextColor(colors.black)
	print(" Wood  Stone  Coal  Iron  Redstone  Gold  Diamond  ")
	if menu == 1 then
		term.setCursorPos(1,1)
		term.setBackgroundColor(colors.black)
		term.setTextColor(colors.yellow)
		write(" Wood ")
		
		paintutils.drawBox(2,2,13,9,colors.brown)
		paintutils.drawFilledBox(3,3,12,8,colors.yellow)
		paintutils.drawBox(5,4,10,7,colors.orange)
		term.setBackgroundColor(colors.black)
		term.setTextColor(colors.white)
		
		term.setCursorPos(15,2)
		print("Total wood: "..increments[1])
		term.setCursorPos(15,3)
		print("Wood per click (WPC): "..perclick[1])
		term.setCursorPos(15,4)
		print("Wood per second (WPS): "..persecond[1])
		term.setCursorPos(15,5)
		print("Owned Upgrades:")
		term.setCursorPos(15,6)
		print("1:"..upgrades[1][1]..", 2:"..upgrades[1][2]..", 3:"..upgrades[1][3]..", 4:"..upgrades[1][4]..", 5:"..upgrades[1][5]..",")
		term.setCursorPos(15,7)
		print("6:"..upgrades[1][6]..", 7:"..upgrades[1][7]..", 8:"..upgrades[1][8]..", 9:"..upgrades[1][9]..", 10:"..upgrades[1][10])
		
		term.setCursorPos(1,10)
		print("1:Crafting Bench|WPC +1    |"..woodupgradecosts[1][1].." Wood")
		print("2:Wood Shovel   |WPS +1    |"..woodupgradecosts[1][2].." Wood")
		print("3:Wood Sword    |WPS +10   |"..woodupgradecosts[1][3].." Wood")
		print("4:Wood Hoe      |WPS +20   |"..woodupgradecosts[1][4].." Wood")
		print("5:Wood Axe      |WPC +10   |"..woodupgradecosts[1][5].." Wood")
		print("6:Wood Pickaxe  |WPS +40   |"..woodupgradecosts[1][6].." Wood")
		print("New upgrade coming soon!")
		print("New upgrade coming soon!")
		print("New upgrade coming soon!")
		write("New upgrade coming soon!")
		
	elseif menu == 2 then
		term.setCursorPos(7,1)
		term.setBackgroundColor(colors.black)
		term.setTextColor(colors.yellow)
		write(" Stone ")
		
		if upgrades[1][6] > 0 then
			paintutils.drawFilledBox(2,2,13,9,colors.gray)
			paintutils.drawLine(4,2,5,2,colors.lightGray)
			paintutils.drawLine(9,2,11,2,colors.lightGray)
			paintutils.drawLine(6,3,7,3,colors.lightGray)
			paintutils.drawLine(11,3,12,3,colors.lightGray)
			paintutils.drawLine(2,4,5,4,colors.lightGray)
			paintutils.drawLine(8,5,12,5,colors.lightGray)
			paintutils.drawLine(4,6,7,6,colors.lightGray)
			paintutils.drawLine(3,7,4,7,colors.lightGray)
			paintutils.drawLine(10,7,13,7,colors.lightGray)
			paintutils.drawLine(5,8,10,8,colors.lightGray)
			paintutils.drawLine(2,9,4,9,colors.lightGray)
			
			term.setBackgroundColor(colors.black)
			term.setTextColor(colors.white)
			term.setCursorPos(15,2)
			print("Total stone: "..increments[2])
			term.setCursorPos(15,3)
			print("Stone per click (SPC): "..perclick[2])
			term.setCursorPos(15,4)
			print("Stone per second (SPS): "..persecond[2])
			term.setCursorPos(15,5)
			print("Owned Upgrades:")
			term.setCursorPos(15,6)
			print("1:"..upgrades[2][1]..", 2:"..upgrades[2][2]..", 3:"..upgrades[2][3]..", 4:"..upgrades[2][4]..", 5:"..upgrades[2][5]..",")
			term.setCursorPos(15,7)
			print("6:"..upgrades[2][6]..", 7:"..upgrades[2][7]..", 8:"..upgrades[2][8]..", 9:"..upgrades[2][9]..", 10:"..upgrades[2][10])
			
			term.setCursorPos(1,10)
			print("1:Stone Shovel  |SPC +5    |"..stoneupgradecosts[2][1].." Stone, "..woodupgradecosts[2][1].." Wood")
			print("New upgrade coming soon!")
			print("New upgrade coming soon!")
			print("New upgrade coming soon!")
			print("New upgrade coming soon!")
			print("New upgrade coming soon!")
			print("New upgrade coming soon!")
			print("New upgrade coming soon!")
			print("New upgrade coming soon!")
			write("New upgrade coming soon!")
			
		else
			term.setBackgroundColor(colors.black)
			term.setTextColor(colors.white)
			term.setCursorPos(1,2)
			print("You must have at least 1 Wood Pickaxe to start mining stone.")
		end
	elseif menu == 3 then
		term.setCursorPos(14,1)
		term.setBackgroundColor(colors.black)
		term.setTextColor(colors.yellow)
		write(" Coal ")
		
		term.setBackgroundColor(colors.black)
		term.setTextColor(colors.white)
		term.setCursorPos(1,2)
		print("This feature is coming soon!")
	elseif menu == 4 then
		term.setCursorPos(20,1)
		term.setBackgroundColor(colors.black)
		term.setTextColor(colors.yellow)
		write(" Iron ")
		
		term.setBackgroundColor(colors.black)
		term.setTextColor(colors.white)
		term.setCursorPos(1,2)
		print("This feature is coming soon!")
	elseif menu == 5 then
		term.setCursorPos(26,1)
		term.setBackgroundColor(colors.black)
		term.setTextColor(colors.yellow)
		write(" Redstone ")
		
		term.setBackgroundColor(colors.black)
		term.setTextColor(colors.white)
		term.setCursorPos(1,2)
		print("This feature is coming soon!")
	elseif menu == 6 then
		term.setCursorPos(36,1)
		term.setBackgroundColor(colors.black)
		term.setTextColor(colors.yellow)
		write(" Gold ")
		
		term.setBackgroundColor(colors.black)
		term.setTextColor(colors.white)
		term.setCursorPos(1,2)
		print("This feature is coming soon!")
	elseif menu == 7 then
		term.setCursorPos(42,1)
		term.setBackgroundColor(colors.black)
		term.setTextColor(colors.yellow)
		write(" Diamond  ")
		
		term.setBackgroundColor(colors.black)
		term.setTextColor(colors.white)
		term.setCursorPos(1,2)
		print("This feature is coming soon!")
	end
end

function savedata()
	savefile = fs.open("mcclickergame/savefile","w")
	for s = 1, 7 do
		savefile.writeLine(increments[s])
		savefile.writeLine(perclick[s])
		savefile.writeLine(persecond[s])
		
		for u = 1,10 do
			savefile.writeLine(upgrades[s][u])
			savefile.writeLine(woodupgradecosts[s][u])
			savefile.writeLine(stoneupgradecosts[s][u])
		end
	end
	savefile.close()
	saved = true
end

function deletedata()
	term.setCursorPos(37, 8)
	print("This will reset")
	term.setCursorPos(15, 9)
	print("  everything. Click again to confirm.")
	event, button, xPos, yPos = os.pullEvent("mouse_click")
	if button == 1 and xPos >= 15 and xPos <= 30 and yPos == 8 then
		fs.delete("mcclickergame/savefile")
		menu = 1
		increments = {0,0,0,0,0,0,0}
		perclick = {1,1,1,1,1,1,1}
		persecond = {0,0,0,0,0,0,0}
		
		upgrades = {
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
		}
		
		woodupgradecosts = {
			{40, 160, 400, 800, 1600, 4000, 0, 0, 0, 0},
			{160, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
		}
		stoneupgradecosts = {
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{160, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
		}
		savedata()
		saved = false
	end
end

if term.isColor() and xSize == 51 and ySize == 19 then
	if fs.exists("mcclickergame/savefile") then
		openfile = fs.open("mcclickergame/savefile","r")
		for s = 1, 7 do
			increments[s] = math.floor(openfile.readLine())
			perclick[s] = math.floor(openfile.readLine())
			persecond[s] = math.floor(openfile.readLine())
			
			for u = 1,10 do
				upgrades[s][u] = math.floor(openfile.readLine())
				woodupgradecosts[s][u] = math.floor(openfile.readLine())
				stoneupgradecosts[s][u] = math.floor(openfile.readLine())
			end
		end
		openfile.close()
	end
	
	incrementtimer = os.startTimer(1)
	savetimer = os.startTimer(30)
	
	while true do
		term.clear()
		term.setCursorPos(1,1)
		menus()
		term.setBackgroundColor(colors.black)
		term.setTextColor(colors.white)
		term.setCursorPos(15, 8)
		print("Delete Save Data")
		term.setCursorPos(15, 9)
		print("Exit")
		
		if saved then
			term.setCursorPos(41,9)
			write("Game saved!")
		end
		
		event, button, xPos, yPos = os.pullEvent()
		if event == "mouse_click" and button == 1 then
			if xPos >= 1 and xPos <= 6 and yPos == 1 then
				menu = 1
			elseif xPos >= 7 and xPos <= 13 and yPos == 1 then
				menu = 2
			elseif xPos >= 14 and xPos <= 19 and yPos == 1 then
				menu = 3
			elseif xPos >= 20 and xPos <= 25 and yPos == 1 then
				menu = 4
			elseif xPos >= 26 and xPos <= 35 and yPos == 1 then
				menu = 5
			elseif xPos >= 36 and xPos <= 41 and yPos == 1 then
				menu = 6
			elseif xPos >= 42 and xPos <= 51 and yPos == 1 then
				menu = 7
				
			elseif xPos >= 2 and xPos <= 13 and yPos >= 2 and yPos <= 9
			and (menu == 1 or (menu == 2 and upgrades[1][6] > 0)) then
				increments[menu] = increments[menu] + perclick[menu]
			elseif xPos >= 15 and xPos <= 30 and yPos == 8 and fs.exists("mcclickergame/savefile") then
				os.cancelTimer(incrementtimer)
				os.cancelTimer(savetimer)
				deletedata()
				incrementtimer = os.startTimer(1)
				savetimer = os.startTimer(60)
			elseif xPos >= 15 and xPos <= 18 and yPos == 9 then
				break
				
			elseif yPos >= 10 and yPos <= 19 then
				if increments[1] >= woodupgradecosts[menu][yPos-9] and increments[2] >= stoneupgradecosts[menu][yPos-9]then
					upgrades[menu][yPos-9] = upgrades[menu][yPos-9] + 1
					increments[1] = increments[1] - woodupgradecosts[menu][yPos-9]
					increments[2] = increments[2] - stoneupgradecosts[menu][yPos-9]
					woodupgradecosts[menu][yPos-9] = math.ceil(woodupgradecosts[menu][yPos-9] * 1.3)
					stoneupgradecosts[menu][yPos-9] = math.ceil(stoneupgradecosts[menu][yPos-9] * 1.3)
					perclick[1] = 1 + (1 * upgrades[1][1]) + (10 * upgrades[1][5])
					perclick[2] = 1 + (5 * upgrades[2][1])
					persecond[1] = (1 * upgrades[1][2]) + (10 * upgrades[1][3]) + (20 * upgrades[1][4]) + (40 * upgrades[1][6])
					
					for u = 7, 10 do
						upgrades[1][u] = 0
						woodupgradecosts[1][u] = 0
					end
					for u = 2, 10 do
						upgrades[2][u] = 0
						stoneupgradecosts[2][u] = 0
					end
				end
			end
		elseif event == "timer" and button == incrementtimer then
			for i = 1, #increments do
				increments[i] = increments[i] + persecond[i]
			end
			incrementtimer = os.startTimer(1)
			saved = false
		elseif event == "timer" and button == savetimer then
			savedata()
			savetimer = os.startTimer(30)
		end
	end
	
	term.clear()
	term.setCursorPos(1,1)
else
	print("This game is not supported on the device you are using. It is only supported on an advanced computer at full screen size. If you are using an advanced computer, close any other programs and tabs you have open and make sure the game can use the full screen size. It may also be possible that your version of ComputerCraft is outdated.")
end