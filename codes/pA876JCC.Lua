while true do
 if turtle.detect() then
  turtle.dig()
 end
 itemcount = turtle.getItemCount(16)
 if itemcount == 64 then
  for i=1,16 do
   turtle.select(i)
   turtle.drop()
  end
  turtle.select(1)
 end
end