sn, tablaup, err = turtle.inspectUp()
--print(textutils.serialize(tablaup))
if tablaup["name"]=="minecraft:diamond_ore" or tablaup["name"]=="minecraft:redstone_ore" or tablaup["name"]=="Thaumcraft:blockCustomOre" then
  x, y, z = gps.locate(5)
  rednet.broadcast("Ore Importante en X: "..x.." Y: "..y.." Z: "..z.."")
else
turtle.digUp()
end