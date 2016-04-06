local m = peripheral.wrap("top")

function Modus()
 m.clear()
 m.setBackgroundColor(colors.lime)
 m.setCursorPos(1,2)
 m.write("Auf")
 m.setCursorPos(1,3)
 m.write("Zu")
 m.setBackgroundColor(colors.black)
end

function Eingabe()
event,side,x,y = os.pullEvent()
 if event == "monitor_touch" then
  if x == 1 and y == 2 then
   rs.setOutput("bottom", true)
   sleep(4)
   rs.setOutput("bottom", false)
  end
  if x == 2 and y == 2 then
   rs.setOutput("bottom", true)
   sleep(4)
   rs.setOutput("bottom", false)
  end
  if x == 3 and y == 2 then
   rs.setOutput("bottom", true)
   sleep(4)
   rs.setOutput("bottom", false)
  end
  if x == 1 and y == 3 then
   rs.setOutput("right", true)
   sleep(4)
   rs.setOutput("right", false)
  end
  if x == 2 and y == 3 then
  rs.setOutput("right", true)
  sleep(4)
  rs.setOutput("right", false)
  end
 end
end
while true do
 Modus()
 Eingabe()
end