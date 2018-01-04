rednet.open("top")

while true do
senderID, message, distance = rednet.receive()
if message then

local file = fs.open("disk/users/"..tostring(senderID), "r")
if file then

local person = fs.open("disk/users/"..senderID, "r")
local personIs = person.readLine()
person.close()

rs.setOutput("right", true)
file.close()
sleep(0.1)
rs.setOutput("right", false)

if message == "satconnect" then
print(personIs, " connected through SAT")
end

if message == "update" then
local file = fs.open("disk/update", "r")
local text = file.readAll()
file.close()
rednet.send(senderID, text)
print(personIs, " got updated!")
end

if message == "ads" then
local file = fs.open("disk/ads", "r")
local text = file.readAll()
file.close()
rednet.send(senderID, text)
print(personIs, " got ads!")
end


if message == "chat" then
local file = fs.open("disk/chat", "r")
local text = file.readAll()
file.close()
rednet.send(senderID, text)
print(personIs, " updated his chat")
end

if message == "addchatt" then
--print(personIs, " wrote in chat!")
senderid, msg, dist = rednet.receive(2)
if (senderid == senderID) then
sen,ms,di = rednet.receive(2)
if sen == senderid then
senderid = ms

print(ms, " wrote in chat!")
end
local fileName = fs.open("disk/users/"..senderid, "r")

if fileName then
nameIs = fileName.readLine()
fileName.close()
else
nameIs = "Unregistred"
end

local file = fs.open("disk/chat", "a")
file.writeLine(nameIs..": "..msg)
file.close()
end
end



end


end
sleep(0.0001)
end