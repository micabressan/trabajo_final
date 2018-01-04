monitor = peripheral.wrap("right")
reaktor = peripheral.wrap("BigReactors-Reactor_237")
ec1 = peripheral.wrap("tile_thermalexpansion_cell_resonant_name_7")
ec2 = peripheral.wrap("tile_thermalexpansion_cell_resonant_name_8")
ec3 = peripheral.wrap("tile_thermalexpansion_cell_resonant_name_9")
ec4 = peripheral.wrap("tile_thermalexpansion_cell_resonant_name_10")
ec5 = peripheral.wrap("tile_thermalexpansion_cell_resonant_name_11")
ec6 = peripheral.wrap("tile_thermalexpansion_cell_resonant_name_12")
local mes = 10000000
local ecmes = 80000000
rns = 0
rns2 = 0
alarm = false
while true do
  term.setTextColor(colors.cyan)
  term.write("      REAKTOR      ")
  print(" ")
  term.setTextColor(colors.white)
  es = reaktor.getEnergyStored()
  esp = es/mes*100
  elevel = esp
  esp = tostring(esp)
  esp = string.sub(esp,1,4)
  term.write("Reaktor Energie: ")
  term.setTextColor(colors.yellow)
  print(esp.."% ("..es.." RF)")
  term.setTextColor(colors.white)
  ro = reaktor.getActive()
  raco = redstone.getInput("left")
  if ro==false then
    term.write("Reaktor Aktiviert: ")
    term.setTextColor(colors.red)
    print("Nein")
    term.setTextColor(colors.white)
  else
    term.write("Reaktor Aktiviert: ")
    term.setTextColor(colors.green)
    print("Ja")
    term.setTextColor(colors.white)
  end
  term.write("Automatische An/Ausschaltung: ")
  term.setTextColor(colors.yellow)
  if raco == true then
    print("Ja")
  else
    print("Nein")
  end
  term.setTextColor(colors.white)
  term.write("Control Rods: ")
  term.setTextColor(colors.orange)
  print(esp.."%")
  reaktor.setAllControlRodLevels(elevel)
  term.setTextColor(colors.white)
  eprod = reaktor.getEnergyProducedLastTick()
  term.write("Energieproduktion: ")
  term.setTextColor(colors.yellow)
  print(eprod.." RF/t")
  term.setTextColor(colors.white)
  if elevel > 80 and redstone.getInput("left") == true then
    reaktor.setActive(false)
  elseif elevel < 20 and redstone.getInput("left") == true then
    reaktor.setActive(true)
  end
  if rns == 0 then
    el1 = ec1.getEnergyStored()
    el2 = ec2.getEnergyStored()
    el3 = ec3.getEnergyStored()
    el4 = ec4.getEnergyStored()
    el5 = ec5.getEnergyStored()
    el6 = ec6.getEnergyStored()
    
  end
  rns = rns+1
  if rns == 10 then rns = 0 end
  e1l = el1/ecmes*100
  e2l = el2/ecmes*100
  e3l = el3/ecmes*100
  e4l = el4/ecmes*100
  e5l = el5/ecmes*100
  e6l = el6/ecmes*100
  
  e1 = tostring(e1l)
  e2 = tostring(e2l)
  e3 = tostring(e3l)
  e4 = tostring(e4l)
  e5 = tostring(e5l)
  e6 = tostring(e6l)
  
  e1 = string.sub(e1,1,4)
  e2 = string.sub(e2,1,4)
  e3 = string.sub(e3,1,4)
  e4 = string.sub(e4,1,4)
  e5 = string.sub(e5,1,4)
  e6 = string.sub(e6,1,4)
  
  
  print(" ")
  term.setTextColor(colors.cyan)
  term.write("      ENERGIEZELLEN      ")
  print(" ")
  term.setTextColor(colors.white)
  print("Energiezelle 1: "..e1.."% ("..el1.." RF)")
  print("Energiezelle 2: "..e2.."% ("..el2.." RF)")
  print("Energiezelle 3: "..e3.."% ("..el3.." RF)")
  print("Energiezelle 4: "..e4.."% ("..el4.." RF)")
  print("Energiezelle 5: "..e5.."% ("..el5.." RF)")
  print("Energiezelle 6: "..e6.."% ("..el6.." RF)")
  
  if e1l < 10 and e2l < 10 and e3l < 10 and e4l < 10 and e5l < 10 and e6l < 10 then
    if alarm == false then
      redstone.setOutput("bottom",true)
    end
    term.setTextColor(colors.red)
    print("Warnung: Energielevel von allen Zellen unter 10%!")
    term.setTextColor(colors.white)
    os.sleep(1)
    redstone.setOutput("bottom",false)
    rns2 = rns2+1
    alarm = true
  else
    alarm = false
  end
  if rns2 == 15 then
    alarm = false
  end
  os.sleep(1)
  term.clear()
  term.setCursorPos(1,1)
end