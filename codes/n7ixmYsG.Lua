--EpaNet Repeater 1.0
print("repeater active, don't touch")
rednet.open("bottom")
server = 44
while true do

local senderID, message, distance = rednet.receive()

if message == "addchatt" then
local csender,cmsg,cdist = rednet.receive(2)
if csender == senderID then
rednet.send(server, "addchatt")
sleep(0.2)
rednet.send(server, cmsg)
sleep(0.2)
rednet.send(server, csender)
print("repeated!")
end

elseif message == "connect" then
rednet.send(senderID, "yes")
rednet.send(server, "satconnect")
else 
rednet.send(server, message)
local sender,msg,dist = rednet.receive(2)
if sender == server then
rednet.send(senderID, msg)
--rednet.send(172, msg)
print("repeated")
end
end





sleep(0.01)
end