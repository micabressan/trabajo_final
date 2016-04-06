while true do

m = peripheral.wrap("top")
m.clear()
m.setTextScale(1)
m.clear()
term.clear()
term.setBackgroundColor(colors.black)
term.setCursorPos(1,1)
print("---------------------------")
print("          Friky OS         ")
print("---------------------------")

button1 = "false"
button2 = "false"

function Button1an()
term.setCursorPos(3,5)
term.setBackgroundColor(colors.green)
print("       ")
term.setCursorPos(3,6)
print("  Tor  ")
term.setCursorPos(3,7)
print("       ")
end

function Button1aus()
term.setCursorPos(3,5)
term.setBackgroundColor(colors.red)
print("       ")
term.setCursorPos(3,6)
print("  Tor  ")
term.setCursorPos(3,7)
print("       ")
end

function Button2an()
term.setCursorPos(18,5)
term.setBackgroundColor(colors.green)
print("       ")
term.setCursorPos(18,6)
print(" Licht ")
term.setCursorPos(18,7)
print("       ")
end

function Button2aus()
term.setCursorPos(18,5)
term.setBackgroundColor(colors.red)
print("       ")
term.setCursorPos(18,6)
print(" Licht ")
term.setCursorPos(18,7)
print("       ")
end

--function Button4an()
--term.setCursorPos(18,9)
--term.setBackgroundColor(colors.green)

function Button3()
term.setCursorPos(5,11)
term.setBackgroundColor(colors.yellow)
print("Reboot")
end

Button1aus()
Button2aus()
Button3()

term.setBackgroundColor(colors.black)



--Touchscreen
while true do
event,side,x,y = os.pullEvent()
if event == "monitor_touch" then
  if x >= 3 and y >= 5 and x <= 9 and y <= 7 then
    if button1 == "false" then
    rs.setOutput("left", true)
    button1 = "true"
    Button1an()
    elseif button1 == "true" then
    rs.setOutput("left", false)
    button1 = "false"
    Button1aus()
    end
    
  elseif x >= 18 and y >= 5 and x <= 25 and y <= 7 then
    if button2 == "false" then
    rs.setOutput("right", true)
    button2 = "true" 
    Button2an()
    elseif button2 == "true" then
    rs.setOutput("right", false)
    button2 = "false" 
    Button2aus()
    end
  elseif x >= 5 and y == 11 and x <= 11 then
    shell.run("reboot")
 end
    
end
end
end