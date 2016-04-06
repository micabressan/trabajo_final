local x = 0

while true do
   x = rs.getAnalogInput("right")
   if x > 13 then
      rs.setOutput("bottom", true)
   else
      rs.setOutput("bottom", false)
   end
   sleep(1)
end