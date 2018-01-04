--Written by epa1337
--You can not steal this
--Because that makes you
--a bad person
term.setBackgroundColor(colors.white)
term.clear()
term.setCursorPos(1,1)
term.setTextColor(colors.black)


rednet.open("back")
local server1 = 44
local server = 0
local page = 0
--0 = home
--1 = epanet 
--2 = ads 

local signal = 0
local speed = 45
local version = 2

function ping()
rednet.broadcast("connect")
senderID, message, distance = rednet.receive(2)
if message == "yes" then
signal = 1
server = senderID
home()
menu()
else
signal = 0
home()
menu()
end
end 

function home()
term.setBackgroundColor(colors.white)
term.clear()
term.setBackgroundColor(colors.green)
term.setCursorPos(1,1)
term.setTextColor(colors.white)
term.write("E-Phone "..version.."                      ")
term.setCursorPos(20,1)
if signal == 1 then
term.write("Online!")
else
term.setCursorPos(19,1)
term.write("Offline!")
end
term.setBackgroundColor(colors.white)

end
function menu()
term.setCursorPos(1,20)
term.setBackgroundColor(colors.green)
term.setTextColor(colors.white)
term.write("Ads")
term.write("                                    ")
term.setCursorPos(23,20)
term.write("Home")
term.setCursorPos(6, 20)
term.write("Chat")
term.setCursorPos(12, 20)
term.write("EpaNet")
end
function sorry()
home()
term.setCursorPos(1, 3)
term.setTextColor(colors.red)
print("Sorry. You are connected to a repeater, you need to be near the EpaNet-building at this moment to do this. Thank you")
sleep(4)
os.reboot()

end


function ads()
home()
end

function epanet()
home()
menu()
term.setCursorPos(1, 3)
term.setBackgroundColor(colors.green)
term.setTextColor(colors.white)
print("Send Text")
print("Read Texts")
print("Empty Texts")
print("")
print("GPS")
print("")
print("Maps")
print("")
print("Update!")
end
local pingTime = 0
local untilPing = 100
function chat()
home()
rednet.send(server, "chat")
while true do 
senderID, message, distance = rednet.receive()
if senderID == server then
home()
term.setCursorPos(1, 20)
term.setBackgroundColor(colors.blue)
term.setTextColor(colors.white)
term.write("Write:                           ")
term.setCursorPos(1, 2)
term.write("Update              E-Chat    ")
term.setCursorPos(8, 2)
term.write("Home")
term.setCursorPos(1, 4)
term.setBackgroundColor(colors.white)
term.setTextColor(colors.green)
print(message)
end
local event, button, xPos, yPos = os.pullEvent("mouse_click")
if (xPos > 0 and xPos < 5) and (yPos > 19 and yPos < 21) then
term.setCursorPos(6,20)
term.setBackgroundColor(colors.blue)
term.setTextColor(colors.white)
term.write(":")
input = read()
term.setCursorPos(10, 20)
term.write("SENDING")
rednet.send(server, "addchatt")
sleep(0.5)
rednet.send(server, input)
sleep(1)
home()
chat()
end

if (xPos > 0 and xPos < 7) and (yPos > 1 and yPos < 3) then
chat()
end

if (xPos > 6 and xPos < 11) and (yPos > 1 and yPos < 3) then
ping()
home()
menu()
break
end



sleep(0.01)
end

end


function getAds()
rednet.send(server, "ads")
senderID, message, distance = rednet.receive(2)
if (senderID == server) then
term.setBackgroundColor(colors.white)
term.setTextColor(colors.red)
term.setCursorPos(1,3)
print(message)
else
os.reboot()
end
end


home()
menu()
ping()


while true do

local event, button, xPos, yPos = os.pullEvent("mouse_click")


if (xPos > 0 and xPos < 11) and (yPos > 2 and yPos < 4) then
home()
menu()
end

if page == 1 then
if (xPos > 0 and xPos < 7) and (yPos > 10 and yPos < 12) then
if server == server then
rednet.send(server, "update")
local sender,msg,dist = rednet.receive(2)
if sender == server then
local file = fs.open("startup", "w")
file.write(msg)
file.close()
home()
term.setCursorPos(1, 3)
term.setTextColor(colors.black)
print("Updated!")
sleep(2)
os.reboot()
end
else
sorry()
end
end


end--page1/epanet 

if (xPos > 0 and xPos < 4) and (yPos > 19 and yPos < 21) then
home()
getAds()
menu()
end

if (xPos > 22 and xPos < 30) and (yPos > 19 and yPos < 23) then
ping()
home()
menu()
end

if (xPos > 5 and xPos < 11) and (yPos > 19 and yPos < 23) then
if server == server then
chat()
else
sorry()
end
end

if (xPos > 11 and xPos < 18) and (yPos > 19 and yPos < 23) then

epanet()
end 



sleep(0.001)
end