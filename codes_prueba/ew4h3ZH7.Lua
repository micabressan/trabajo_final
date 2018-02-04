--os.pullEvent = os.pullEventRaw

function password()
 while true do
 term.clear()
 term.setCursorPos(1,1)
 print("Please Enter Password")
 input = read("*")
 if input == "LUCENDANIEL" then
  rs.setOutput("left",true)
  sleep(3)
  rs.setOutput("left",false)
  rs.setOutput("back",false)
 else
 print("Wrong password")
 
  end
 end
end

while true do
sleep(0)
local event = os.pullEvent()
if event == "redstone"
 then sleep(5)
 rs.setOutput("back",true)
 password()
 rs.setOutput("back",false)
 else
 rs.setOutput("back",false)
end
end