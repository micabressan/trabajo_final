rednet.open("left")
local planting = 0
term.clear()
term.setCursorPos(1, 1)


while true do
 s, pass = rednet.receive()
 print("SenderID: "..s.." Password: "..pass)
 if pass == "1234" then
  rednet.send(s, "OK")
  planting = 1
  if planting == 1 then
   turtle.up()
   turtle.place()
   turtle.down()
   planting = 0
  end
 else
  rednet.send(s, "NOPE")
 end
end