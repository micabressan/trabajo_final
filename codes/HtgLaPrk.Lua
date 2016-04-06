os.pullEvent = os.pullEventRaw
m = peripheral.find("monitor")
if not m then
  os.shutdown()
end
-- Variables:
password = "8465"
input = ""

term.redirect(m)
while true do

term.setBackgroundColor(colors.gray)
term.clear()
term.setCursorPos(3,2)
term.setTextColor(colors.black)
term.setBackgroundColor(colors.lightGray)
write("123")
term.setCursorPos(3,3)
write("456")
term.setCursorPos(3,4)
write("789")
term.setCursorPos(4,5)
write("0")
term.setCursorPos(2,1)
term.setBackgroundColor(colors.black)
write("    ")
term.setBackgroundColor(colors.lightBlue)
write(" ")
term.setCursorPos(2,1)
term.setBackgroundColor(colors.black)
term.setTextColor(colors.lime)
for i=1,#input do
  write("*")
end
e,c,x,y = os.pullEvent("monitor_touch")
term.setBackgroundColor(colors.lightGray)
term.setTextColor(colors.lime)
term.setCursorPos(6,1)
if y == 2 then
  if x == 3 then
    input = input.."1"
    term.setCursorPos(3,2)
  end
  if x == 4 then
    input = input.."2"
    term.setCursorPos(4,2)
  end
  if x == 5 then
    input = input.."3"
    term.setCursorPos(5,2)
  end
end
if y == 3 then
  if x == 3 then
    input = input.."4"
    term.setCursorPos(3,3)
  end
  if x == 4 then
    input = input.."5"
    term.setCursorPos(4,3)
  end
  if x == 5 then
    input = input.."6"
    term.setCursorPos(5,3)
  end
end
if y == 4 then
  if x == 3 then
    input = input.."7"
    term.setCursorPos(3,4)
  end
  if x == 4 then
    input = input.."8"
    term.setCursorPos(4,4)
  end
  if x == 5 then
    input = input.."9"
    term.setCursorPos(5,4)
  end
end
if y == 5 and x == 4 then
  input = input.."0"
  term.setCursorPos(4,5)
end
write("#")
term.setCursorPos(2,1)
term.setBackgroundColor(colors.black)
sleep(0.3)
if #input == 4 then
  if input == "9269" then
    term.setBackgroundColor(colors.black)
    term.clear()
    return
  end
  if input == password then
    term.setCursorPos(5,1)
    term.setTextColor(colors.lime)
    term.setBackgroundColor(colors.black)
    write("*")
    term.setCursorPos(6,1)
    term.setBackgroundColor(colors.lime)
    write(" ")
    rs.setOutput('right',true)
    sleep(5)
    rs.setOutput('right',false)
    break
  else
    term.setCursorPos(5,1)
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.lime)
    write("*")
    term.setCursorPos(6,1)
    term.setBackgroundColor(colors.red)
    write(" ")
    break
  end
end

end
sleep(3)
os.reboot()