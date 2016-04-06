while true do
  turtle.select(1)
  turtle.suckDown()
  a, block = turtle.inspect()
  if block.name == "Botania:livingrock" then
    turtle.dig()
    turtle.forward()
    block = turtle.inspect()
  elseif block.name == "minecraft:dirt" then
   turtle.select(1)
   for i=1,7 do
    turtle.back()
    turtle.place()
   end
   turtle.select(2)
   turtle.dropDown()
  end
  os.sleep(2)
end