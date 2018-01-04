os.pullEvent = os.pullEventRaw -- makes it so no one can terminate the program
pass = "s00ubway" -- replace "norway240" with your password
while true do
 term.clear()
 term.setCursorPos(12,5)
 print("Please Enter The Password")
 term.setCursorPos(12,6)
 input = read("*")
 if input == pass then
 rs.setOutput("left",true) -- replace "left" with the side the door is connected tonumber(
 term.setCursorPos(12,7)
 print("Correct")
 sleep(2)
 rs.setOutput("left",false) -- once again replace "left with the side the door is connected to
 else
 term.setCursorPos(12,7)
 print("WRONG PASSWORD")
 sleep(2)
 end
end