--https://youtu.be/UJ4t5Bn-n3c

-----PREFERENCES/VARIABLES-----
local pin = 4224
local maxtries = 3
local locktime = 60 --seconds
local waittotry = 3 --seconds
local redstoneSide = "right"
local monitorSide = "top"

local tries = 0
local input = ""
local keypad = {
--{num,xpos,ypos}
  {1,2,4},
  {2,7,4},
  {3,12,4},
  {4,2,6},
  {5,7,6},
  {6,12,6},
  {7,2,8},
  {8,7,8},
  {9,12,8},
  {0,7,10}
}

-----FUNCTIONS-----
function checkClick(t,x,y)
  for i,v in pairs(t) do
    num,cx,cy = unpack(v)
    if (x >= cx) and (x <= cx + 2) and (y == cy) then
	  return true,num
	end
  end
  return false
end

function numClick(num)
  monitor.setCursorPos((5 + (string.len(input) * 2)),2)
  input = input .. num
  monitor.write("*")
  if (string.len(input) == 4) then
    if (tostring(pin) == input) then
	  monAction("Access Granted")
	  doorOpen()
	  monReset(true)
	  input = ""
	  tries = 0
	else
	  input = ""
	  tries = tries + 1
	  if (tries >= maxtries) then
	    monReset()
		monitor.setBackgroundColor(colors.red)
		monAction("TERMINAL LOCKED")
		sleep(locktime)
		os.reboot()
	  end
	  monAction("Access Denied")
	  sleep(waittotry)
	  monReset(true)
	end
  end
end

function monAction(mess)
  monitor.setCursorPos(1,1)
  monitor.write(mess)
end

function monReset(isClear)
  if (isClear) then monitor.clearLine() end
  monitor.setCursorPos(5,2)
  monitor.write("_ _ _ _")
end

function doorOpen()
  redstone.setOutput(redstoneSide, true)
  sleep(3)
  redstone.setOutput(redstoneSide, false)
end

-----BEGIN MAIN-----
monitor = peripheral.wrap(monitorSide)
monitor.setTextScale(0.5)
w,h = monitor.getSize()
if (w > 15) or (h > 10) then 
  error("Monitor size is to big.")
  exit()
end
monReset()
monitor.setBackgroundColor(colors.red)
monitor.setTextColor(colors.black)

for i,v in pairs(keypad) do
  num,x,y = unpack(v)
  monitor.setCursorPos(x,y)
  monitor.write(" " .. num .. " ")
end

monitor.setBackgroundColor(colors.black)
monitor.setTextColor(colors.white)
while true do
  event,button,x,y = os.pullEvent("monitor_touch")
  validClick,num = checkClick(keypad,x,y)
  if (validClick) then
    numClick(num)
  end
end