--Startup For Screen Color And BackGround--
rednet.open("back")
term.setCursorPos(1,1)
term.setBackgroundColor(colors.white)
term.setTextColor(colors.black)
term.clear()
--List Of Commands--
print("Turtle Command  SetUp")
print("Use W To Move Forward")
print("Use S To Move Back")
print("Use A To Turn Left")
print("Use D To Turn Right")
print("Use R To Move Up")
print("Use F To Move Down")
print("use Q To Dig Front Of Turtle")
print("Use O To Dig Up")
print("Use L To Dig Down")
print("Use P To PickItem")
print("Use I To DropItem")
print("Use U To PlaceItem")

--Alternative Info--
--For Use It Change The Id From Turtle--
-- Programs For Wireless--
while true do
  local event, character, protocol =os.pullEvent()
    if character == "w" then
      rednet.send(442, "forward")
      end
    if character == "s" then
      rednet.send(442, "back")
      end
    if character == "a" then
      rednet.send(442, "turnleft")
      end
    if character == "d" then
    rednet.send(442, "turnright")
    end
    if character == "q" then
      rednet.send(442, "dig")
    end
    if character == "r" then
      rednet.send(442, "up")
      end
    if character == "f" then
      rednet.send(442, "down")
      end
    if character == "o" then
      rednet.send(442, "digup")
      end
    if character == "l" then
      rednet.send(442, "digdown")
      end
    if character == "p" then
      rednet.send(442, "pick")
      end
    if character == "i" then
      rednet.send(442, "drop")
      end
    if character == "u" then
      rednet.send(442, "place")
      end
  end