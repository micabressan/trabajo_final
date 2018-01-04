local mon = peripheral.wrap("left")
mon.write("Hello")

local mX, mY = mon.getSize()
local welcome = "Welcome to"
mon.setCursorPos(math.floor(monX/2) - math.floor(#welcome/2), 2)
mon.write(welcome)