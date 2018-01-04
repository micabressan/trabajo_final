repeat
os.queueEvent("e")
os.pullEvent()  
until rs.testBundledInput("back",colors.white) == true
repeat
os.queueEvent("e1")
os.pullEvent()
until (rs.testBundledInput("back", colors.red) == true) or (rs.testBundledInput("back", colors.yellow) == true)or (rs.testBundledInput("back", colors.green) == true) or (rs.testBundledInput("back", colors.blue) == true)
if rs.testBundledInput("back",colors.red) == true then
 
  sleep(1.5)
  repeat
  until (rs.testBundledInput("back", colors.red) == true) or (rs.testBundledInput("back", colors.yellow) == true)or (rs.testBundledInput("back", colors.green) == true) or (rs.testBundledInput("back", colors.blue) == true)
  os.queueEvent("e2")
  os.pullEvent()
  if rs.testBundledInput("back", colors.yellow) == true then
  
    sleep(1.5)
    repeat
    until (rs.testBundledInput("back", colors.red) == true) or (rs.testBundledInput("back", colors.yellow) == true)or (rs.testBundledInput("back", colors.green) == true) or (rs.testBundledInput("back", colors.blue) == true)
    os.queueEvent("e3")
    os.pullEvent()  
    if rs.testBundledInput("back", colors.green) == true then
    
      sleep(1.5)
      repeat
      until (rs.testBundledInput("back", colors.red) == true) or (rs.testBundledInput("back", colors.yellow) == true)or (rs.testBundledInput("back", colors.green) == true) or (rs.testBundledInput("back", colors.blue) == true)
      os.queueEvent("e4")
      os.pullEvent()
      if rs.testBundledInput("back", colors.blue) == true then
      rs.setOutput("front", true)
      sleep(5)
      rs.setOutput("front", false)
      else
      --fail
      end
    
    else
    --fail
    end         
   
  else
  --fail
  end
else
--fail
end