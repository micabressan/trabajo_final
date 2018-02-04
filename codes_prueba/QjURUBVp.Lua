function detectDevice(DeviceName)
  DeviceSide="nix"
   for a,b in pairs(redstone.getSides()) do
      if peripheral.getType(b)==DeviceName then
         DeviceSide = b
         break
      end
   end
   return(DeviceSide)
end
kiste = peripheral.wrap(detectDevice("chest"))
 
function sortChest()
   for a = 1,16 do
      if turtle.getItemCount(a) > 0 then
         turtle.select(a)
         turtle.dropDown()
      end
   end
   y=0
 
 --  for x=1,kiste.getInventorySize() do
--      item = kiste.getStackInSlot(x)
--      if item then
--         if item.display_name == "Turbine Housing" then
--            kiste.pushItem("up",x,64)
--         end
--         if item.display_name == "Turbine Rotor Bearing" then
--            kiste.pushItem("up",x,1,8)
--         end
--         if item.display_name == "Turbine Rotor Shaft" then
--            kiste.pushItem("up",x,25,9)
--         end
--         if item.display_name == "Turbine Rotor Blade" then
--            if y==0 then
--               y=10
--            end
--         kiste.pushItem("up",x,64,y)
--         y=11
--         end
--         if item.display_name == "Turbine Fluid Port" then
--         kiste.pushItem("up",x,2,12)
--         end
--         if item.display_name == "Turbine Controller" then
--         kiste.pushItem("up",x,1,13)
--         end
--         if item.display_name == "Turbine Power Port" then
--         kiste.pushItem("up",x,2,14)
--         end
--         if item.display_name == "Enderium Block" then
--         kiste.pushItem("up",x,37,15)
--         end
--      end
--   end
--turtle.select(1)
--end
 
function getInventory()
   anzahlHousing = 0
   anzahlBearing = 0
   anzahlShaft = 0
   anzahlBlade = 0
   anzahlFluid = 0
   anzahlController = 0
   anzahlPower = 0
   anzahlEnderium = 0
   for x=1,16 do
      turtleItem=turtle.getItemDetail(x)
      if turtleItem then
         if turtleItem.damage == 0 and turtleItem.name == "BigReactors:BRTurbinePart" then
            anzahlHousing = anzahlHousing + turtle.getItemCount(x)
         elseif turtleItem.damage == 4 and turtleItem.name == "BigReactors:BRTurbinePart" then
            anzahlBearing = anzahlBearing + turtle.getItemCount(x)
         elseif turtleItem.damage == 0 and turtleItem.name == "BigReactors:BRTurbineRotorPart" then
            anzahlShaft = anzahlShaft + turtle.getItemCount(x)
         elseif turtleItem.damage == 1 and turtleItem.name == "BigReactors:BRTurbineRotorPart" then
            anzahlBlade = anzahlBlade + turtle.getItemCount(x)
         elseif turtleItem.damage == 3 and turtleItem.name == "BigReactors:BRTurbinePart" then
            anzahlFluid = anzahlFluid + turtle.getItemCount(x)
         elseif turtleItem.damage == 1 and turtleItem.name == "BigReactors:BRTurbinePart" then
            anzahlController = anzahlController + turtle.getItemCount(x)
         elseif turtleItem.damage == 2 and turtleItem.name == "BigReactors:BRTurbinePart" then
            anzahlPower = anzahlPower + turtle.getItemCount(x)
         elseif turtleItem.damage == 12 and turtleItem.name == "ThermalFoundation:Storage" then
            anzahlEnderium = anzahlEnderium + turtle.getItemCount(x)
         end
      end
   end
   if anzahlHousing ~= 444 then
      print(anzahlHousing, " von 444 Housing")
   end
   if anzahlBearing ~= 1 then
      print(anzahlBearing, " von 1 Bearing")
   end
   if anzahlShaft ~= 25 then
      print(anzahlShaft, " von 25 Shaft")
   
   end
   if anzahlBlade ~= 80 then
      print(anzahlBlade, " von 80 Blade")
   end
   if anzahlFluid ~= 2 then
      print(anzahlFluid, " von 2 Fluid")
   end
   if anzahlController ~= 1 then
      print(anzahlController, " von 1 Controller")
   end
   if anzahlPower ~= 2 then
      print(anzahlPower, " von 2 Power")
   end
   if anzahlEnderium ~= 37 then
      print(anzahlEnderium, " von 37 Enderium")
   end
   if anzahlHousing ==444 and anzahlBearing ==1 and anzahlShaft ==25 and anzahlBlade == 80 and anzahlFluid ==2 and anzahlController == 1 and anzahlPower ==2 and anzahlEnderium == 37 then
      print("true")
      return true
   else
      print("false")
      return false
     
   end
end
 
function abfrage()
   if getInventory() == false then
      print("weitermachen? j drücken")
      print("Abbrechen     n drücken")
      auswahl = io.read()
   else
      beginn = 1
      return beginn
   end
   
   if auswahl == "j" then
      beginn = 1
   elseif auswahl == "n" then
      beginn = 0
   else
      print("wie bitte?")
      abfrage()
   end
   return beginn
end
 
 
function base()
   for x=1,5 do
      turtle.placeDown()
      turtle.forward()
   end
   turtle.placeDown()
   turtle.turnRight()
   turtle.forward()
   turtle.turnRight()
   for x=1,4 do
      turtle.placeDown()
      turtle.forward()
   end
   turtle.placeDown()
   turtle.turnLeft()
   turtle.forward()
   turtle.turnLeft()  
   turtle.placeDown()
   turtle.forward()
   turtle.placeDown()
   turtle.forward()
   turtle.select(8)
   turtle.placeDown()  
   turtle.select(1)
   turtle.forward()
   turtle.placeDown()
   turtle.forward()
   turtle.placeDown()
 
   turtle.turnRight()
   turtle.forward()
   turtle.turnRight()
   for x=1,4 do
      turtle.placeDown()
      turtle.forward()
   end
   turtle.placeDown()
   turtle.turnLeft()
   turtle.forward()
   turtle.turnLeft()
   for x=1,4 do
      turtle.placeDown()
      turtle.forward()
   end
   turtle.placeDown()
end
 
function ring()
   turtle.up()
   turtle.turnLeft()
   for x=1,4 do
      turtle.placeDown()
      turtle.forward()
   end
   turtle.placeDown()
   turtle.turnLeft()
   for x=1,4 do
      turtle.placeDown()
      turtle.forward()
   end
   turtle.placeDown()
   turtle.turnLeft()
   for x=1,4 do
      turtle.placeDown()
      turtle.forward()
   end
   turtle.placeDown()
   turtle.turnLeft()
   for x=1,4 do
      turtle.placeDown()
      turtle.forward()
   end
   
   if turtle.getItemCount(1) < 20 then
      for x=2,7 do
         turtle.select(x)
         turtle.transferTo(1)
      end
   turtle.select(1)
   end
end
 
function shaft()
   turtle.turnLeft()
   turtle.forward()
   turtle.forward()
   turtle.turnLeft()
   turtle.forward()
   turtle.forward()
   for x=1,25 do
      turtle.down()
   end
   for x=1,20 do
      subShaft()
      if turtle.getItemCount(10) < 8 then
         turtle.select(11)
         turtle.transferTo(10)
         turtle.select(10)
      end
   end
   
   for x=1,5 do
      turtle.select(9) --shaft  
      turtle.up()
      turtle.placeDown()
      enderium()
   end
   
end
function subShaft()
   turtle.select(10)
   turtle.place()
   turtle.turnLeft()
   turtle.place()
   turtle.turnLeft()
   turtle.place()
   turtle.turnLeft()
   turtle.place()
   turtle.up()
   turtle.select(9)
   turtle.placeDown()
   turtle.turnLeft()
end
   
 
function enderium() --funktioniert noch nicht (baut krum)
   turtle.forward()
   turtle.select(15)
   turtle.placeDown()
   turtle.turnLeft() turtle.forward()
   turtle.placeDown()
   turtle.turnLeft() turtle.forward()
   turtle.placeDown()
   turtle.forward()
   turtle.placeDown()
   turtle.turnLeft() turtle.forward()
   turtle.placeDown()
   turtle.forward()
   turtle.placeDown()
   turtle.turnLeft() turtle.forward()
   turtle.placeDown()
   turtle.forward()
   turtle.placeDown()
   turtle.turnLeft() turtle.forward()
   turtle.turnRight()
   turtle.back()
end
 
function deckel()
turtle.up()
turtle.select(13)
turtle.placeDown()
 
turtle.back()
turtle.select(1)
turtle.placeDown()
turtle.turnLeft()
turtle.forward()
turtle.select(14)
turtle.placeDown()
 
 
turtle.turnRight()
turtle.forward()
turtle.select(1)
turtle.placeDown()
turtle.forward()
turtle.select(14)
turtle.placeDown()
 
 
turtle.turnRight()
turtle.forward()
turtle.select(1)
turtle.placeDown()
 
 
turtle.forward()
turtle.select(12)
turtle.placeDown()
turtle.turnRight()
turtle.forward()
turtle.select(1)
turtle.placeDown()
 
turtle.forward()
turtle.select(12)
turtle.placeDown()
 
 
turtle.forward()
turtle.select(1)
turtle.placeDown()
turtle.turnRight()
 
for x=1,3 do
turtle.forward()
turtle.placeDown()
end
turtle.turnRight()
for x=1,4 do
turtle.forward()
turtle.placeDown()
end
turtle.turnRight()
for x=1,4 do
turtle.forward()
turtle.placeDown()
end
turtle.turnRight()
for x=1,4 do
turtle.forward()
turtle.placeDown()
end
turtle.turnRight()
 
end
 
 
 
   
sortChest()
if abfrage() == 1 then
   print("alles ok")
   base()
for x=1,25 do
   ring()
end
shaft()
deckel()
else
   print(abfrage())
end
--20000
--12 = fluid
--13=controler
--14=power