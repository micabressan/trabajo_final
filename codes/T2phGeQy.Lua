local capacitor_1 = peripheral.wrap("left")
local modem = peripheral.wrap("right")
local monitor = peripheral.wrap("monitor_3")

capacitorCount = 12
capacitorSize = 1000000

screenRefreshRate = 0.2

energyToEmitRedstone = 9600000
sideToEmitRedstone = "bottom"

------------------------------------------------------

RedstoneState = false 

function writePowerStorage()

	energyLevel1 = capacitor_1.getEnergyStored()
	energyMaxStorage = (capacitorCount) * (capacitorSize)
	energyStored = (energyLevel1) * (capacitorCount)
	energyStoredProcent = ((energyStored / energyMaxStorage) * 100)
	color = colors.red
	
	monitor.clear()
	
	if energyStoredProcent > 60 then 
		color = colors.green
	elseif energyStoredProcent < 40 then
		color = colors.red
	elseif energyStoredProcent < 60 then
		color = colors.orange
	end 
		
	-- Draw normal fuel level --
	monitor.setCursorPos(5, 9)
    monitor.setTextColor(color)
    monitor.write(string.format(energyStored) .. " / " .. string.format(energyMaxStorage) .. " RF")

	-- Draw procent fuel level -- 
	monitor.setCursorPos(13, 11)
	monitor.setTextColor(color)
	monitor.write(energyStoredProcent .. " %")
	
	-- Draw engine status -- 
	monitor.setCursorPos(6, 18)
	monitor.setTextColor(colors.white)
	if RedstoneState == false then
		monitor.write("Generator is offline")
	elseif RedstoneState == true then
		monitor.write("Generator is online")
	end 

	-- Draw progress bar -- 
	monitor.setCursorPos(6, 13)
	monitor.setTextColor(colors.green)
	test = "|"
	for a = 2, energyStoredProcent / 5 do 
		test = test .. "|" 
	end 	
	monitor.write(test)
	
end 

function redstoneControl()

	energy = (capacitor_1.getEnergyStored()) * (capacitorCount)

	if energy >= energyToEmitRedstone then
	
		rs.setOutput(sideToEmitRedstone, true)		
		RedstoneState = false 
	
	else
	
		rs.setOutput(sideToEmitRedstone, false)
		RedstoneState = true  
	
	end 

end 

function loop()
	
	redstoneControl()
	writePowerStorage()

	sleep(screenRefreshRate)
	
	loop()
	
end 

loop()