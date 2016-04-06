 while true do
 
 if rs.getInput("left") then
      
  rs.setBundledOutput("back", 2)
  sleep(0.15)
  rs.setBundledOutput("back", 4)
  sleep(0.15)
  rs.setBundledOutput("back", 8)
  sleep(0.15)
  
  else 
    sleep(1)
 end
end