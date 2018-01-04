local side = "left"
local password = "mark04"
local opentime = 4

while true do 
term.clear()
term.setCursorPos(1,1)
write("password?: ")
local input = read("*")

 if input == password then
 term.clear()
 term.setCursorPos(1,1)
 print("Da bin ich mir nicht sicher") 
 rs.setOutput(side, true)
 sleep(opentime)
 rs.setOutput(side, false)
 os.shutdown()
 else 
 term.clear()
 term.setCursorPos(1,1)
 print("verpiss dich")
  sleep(2)
 os.shutdown()
 
  end
 end