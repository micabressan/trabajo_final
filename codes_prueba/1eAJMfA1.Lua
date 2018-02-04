API = require("buttonAPI")
local event = require("event")
local computer = require("computer")
local term = require("term")
local component = require("component")
local gpu = component.gpu

local rs = component.redstone
local colors = require("colors")
local sides = require("sides")

function API.fillTable()
  API.setTable("OFF", n1, 35,43,36,38)  
  API.setTable("Quarry", n2, 5,16,3,7)
  API.setTable("Free Ram", n3, 2,11,36,38)
  API.setTable("Reboot", n4, 13,22,36,38)
  API.setTable("Edit", n5, 24, 33, 36, 38)
  API.setTable("Edit au", n6, 45, 54, 36, 38)
  API.screen()
end

function getClick()
  local _, _, x, y = event.pull(1,touch)
  if x == nil or y == nil then
    local h, w = gpu.getResolution()
    gpu.set(h, w, ".")
    gpu.set(h, w, " ")
  else 
    API.checkxy(x,y)
  end
end

function n1()
    API.flash("OFF",0.01)
    os.execute("shutdown")
end

function n2()
  API.toggleButton("Quarry")
  if buttonStatus == true then rs.setBundledOutput(sides.right,colors.white, 255)
  else rs.setBundledOutput(sides.right,colors.white, 0)
  end
end

function n3()
  API.flash("Free Ram",0.01)
  term.setCursor(1,39)
  term.write("Free Memory: "..computer.freeMemory().." bytes")
end

function n4()
  API.flash("Reboot",0.01)
  computer.shutdown(true)
end

function n5()
  API.flash("Edit",0.01)
  os.execute("edit 1")
  --os.sleep(1)
  --os.clear()
end
function n6()
  API.flash("Edit au",0.01)
  os.execute("edit /autorun.lua")
  os.sleep(1)
end

function QuarryStat()
  os.execute("clear")
  print("debug: color_ora="..colors.orange)
  if rs.getBundledInput(sides.right,colors.orange)>0 then 
  print("Quarry is working") else
  print("Quarry is not working")
  end
end

term.setCursorBlink(false)
gpu.setResolution(80, 40)
API.clear()
API.fillTable()
API.heading("Main control panel")
API.label(1,40,"Press Q to exit.")

local exflag=false
local event=require("event")
local function onKeyDown(_, address, char, code)
  if code==16 then
    exflag=true
  end
end
event.listen("key_down",onKeyDown)
while not exflag do
  getClick()
  --QuarryStat()
end
event.ignore("key_down",onKeyDown)
os.execute("clear")

--eof