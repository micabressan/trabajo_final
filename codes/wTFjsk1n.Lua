rednet.open("")

while true do
event = os.pullEvent()
 if event == "redstone" or rs.getInput("") then
  rednet.broadcast("")

  sleep(2)

 end
end