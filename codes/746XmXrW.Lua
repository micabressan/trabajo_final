while true do
	local r1 = peripheral.wrap("BigReactors-Reactor_1")
	local mon = peripheral.wrap("monitor_3")
	mon.setTextScale(2)
	mon.clear()
	
	
	mon.setCursorPos(1,1)
	mon.setTextColor(colors.white)
	mon.write("Energy Level: ")
	mon.setTextColor(colors.blue)
	mon.write(math.floor(r1.getEnergyStored()))
	
	mon.setCursorPos(1,2)
	mon.setTextColor(colors.white)
	mon.write("Active: ")
	if r1.getActive(true) then
		mon.setTextColor(colors.lime)
		mon.write("Active")
	else
		mon.setBackgroundColor(colors.red)
		mon.setTextColor(colors.gray)
		mon.write("Inactive")
		mon.setBackgroundColor(colors.black)
		end
	
	sleep(1)
end