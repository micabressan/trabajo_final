capacitor_1 = peripheral.wrap("left")
modem = peripheral.wrap("right")
monitor = peripheral.wrap("monitor_3")

powerSourceName = "Generator"

powerPerCapacitor = 1000000
countCapacitor = 12

screenRefreshRate = 0.2

emitRsWhenBelow = 20
removeRsWhenAbove = 80
rsSignalSide = "bottom"

labelRed = 20 
labelOrange = 50 
labelGreen = 50

monitor.clear()

function drawLabel(text, x, y, color)

	monitor.setCursorPos(x, y)
	monitor.setTextColor(color)
	monitor.write(text)

end 

function monitorLoop()
	
	energyLevel = capacitor_1.getEnergyStored() * countCapacitor
	maxEnergyLevel = powerPerCapacitor * countCapacitor
	energyStoredPercent = (energyLevel / maxEnergyLevel) * 100
	
	colorLabel = colors.red
	
	if energyStoredPercent <= labelRed then
		colorLabel = colors.red
	elseif energyStoredPercent <= labelOrange then
		colorLabel = colors.orange
	elseif energyStoredPercent > labelGreen then	
		colorLabel = colors.green
	else
		colorLabel = colors.blue
	end 
			
	drawLabel(energyLevel .. "/" .. maxEnergyLevel .. "RF", 5, 5, colorLabel)

	if energyStoredPercent >= removeRsWhenAbove then
	
		rs.setOutput(rsSignalSide, false)
		
	end 
	
	if energyStoredPercent <= removeRsWhenAbove then
	
		rs.setOutput(rsSignalSide, true)
		
	end
	
	---------------------------------------------------------------------------
	
	labelString2 = ""
	
	for count = 2, (energyStoredPercent / 5), 1 do
	
		labelString2 = labelString2 .. "|"
	
	end 
		
	drawLabel(labelString2, 5,7,colors.blue)
	
end 

function drawAll()

	monitor.clear()
	
	monitorLoop()

end 


while true do 

	drawAll()

	sleep(screenRefreshRate)
	
end