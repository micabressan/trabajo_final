s = peripheral.wrap("back")
s.clear()
 
osob="Osobny vlak"
 
s.setBackgroundColor(colors.white)
s.setTextColor(colors.black)
s.setTextScale(2)
s.setCursorPos(3,3)
s.write(osob)
 
s.setBackgroundColor(colors.white)
s.setTextColor(colors.black)
s.setTextScale(2)
s.setCursorPos(3,5)
s.write(osob)

s.setBackgroundColor(colors.white)
s.setTextColor(colors.black)
s.setTextScale(2)
s.setCursorPos(3,7)
s.write(nakl)

s.setBackgroundColor(colors.white)
s.setTextColor(colors.black)
s.setTextScale(2)
s.setCursorPos(3,9)
s.write("Ostatne")
 
function klik(kx,ky)
  if ky==3 and ( kx > 2 and kx < 18) then
    print("klik na osob")
    rs.setBundledOutput("bottom", colors.green)
    sleep(20)
    rs.setBundledOutput("bottom", 0)
    s.setBackgroundColor(colors.green)
  else
    s.setBackgroundColor(colors.white)
    end
    s.setCursorPos(3,3)
    s.write(osob)
  end
end
 
while true do
  local e,s,x,y = os.pullEvent("monitor_touch")
  klik(x,y)
  print(x..":"..y)
  sleep(0.1)
end