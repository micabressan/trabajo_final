local component =require("component")
local computer =require("computer")
gpu=component.gpu
reac = component.br_reactor
turbine = component.br_turbine
local event =require("event")
local term =require("term")
local math =require("math")
term.setCursor(1,1)
term.clear()
function drawProgressBar(x,y,w,h,percent)
  gpu.setBackground(0x000000)
  gpu.fill(x,y,w,h," ")
  gpu.setBackground(0xffffff)
  gpu.setForeground(0xffffff)
  gpu.fill(x,y,w*percent,h," ")
end
function aff()
  term.setCursor(157,1)
  gpu.setForeground(0x800000)
  term.write("Exit")
  term.setCursor(1,1)
  if reac.getActive() then
    gpu.setForeground(0x008000)
    term.setCursor(12,1)
    term.write("online ")
  else
  term.setCursor(12,1)
  gpu.setForeground(0x800000)
  term.write("offline ")
  end
  term.setCursor(1,1)
  gpu.setForeground(0xFFFFFF)
  term.write("reacteur :")
  term.setCursor(20,1)
  term.write("temperature :")
  term.setCursor(33,1)
  gpu.setForeground(0x808000)
  term.write(reac.getFuelTemperature().."C ")
  --term.setForegound(0xffffff)
  --term.write("quantité d'energie stokée")
  drawProgressBar(1,3,160,3,turbine.getEnergyStored()/turbine.getEnergyCapacity())
  gpu.setBackground(0x000000)
  term.setCursor(1,2)
  term.write("Quantitée d'energie: ")
  term.setCursor(50,1)
  term.write("steam produit :")
  term.setCursor(65,1)
  term.write(reac.getHotFluidProductedLastTick())
  --term.write("test")
  
  
  
end
function onTouch(a,b,c,d)
  if c>=12 and c<=19 and d==1 then
    if reac.getActive() then
      reac.setActive(false)
    else
      reac.setActive(true)
      return true
    end
  end
  
  if c>=157 and c<=171 and d==1 then
   computer.pushSignal("stop")
   term.clear()
   return false
  end
end
local function onTimer(_,timer)
  aff()
  return true
end
event.listen("touch",onTouch)
local timer = event.timer(0.1,onTimer,math.huge)
event.pull("stop")
event.ignore("touch",onTouch)
event.cancel(timer)
term.clear()
gpu.setForeground(0xffffff)
gpu.setBackground(0x000000)