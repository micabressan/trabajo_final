-- Tic-Tac-Toe Minigame for ComputerCraft, Made by Tomlacko.

function checkPos(pX, pY)
  return grid[(pY*sizeX)+pX]
end

term.clear()
term.setCursorPos(1, 1)
if term.isColor() == false then
  error("You need an advanced computer or an advanced monitor to play this minigame!")
end
term.clear()
term.setCursorPos(1, 1)
print("If you want to play this on a monitor, enter the side on which you have the monitor or leave this blank if you want to play on this terminal.")
print(" ")
side = read()
if side == "right" or side == "left" or side == "top" or side == "bottom" or side == "back" or side == "front" then
  m = peripheral.wrap(side)
  sizeX, sizeY = m.getSize()
  device = "monitor"
  m.clear()
  m.setCursorPos(1, 1)
else
  device = "term"
  sizeX, sizeY = term.getSize()
end

playX = 0
playY = 0
while playX < 3 or playX > sizeX or playY < 3 or playY > sizeY do
  term.clear()
  term.setCursorPos(1, 1)
  print("Enter the size of the plane, on which you want to play the game:")
  print("(Minimum: 3x3   Maximum: " .. sizeX .. "x" .. sizeY .. ")")
  print(" ")
  write("Width: ")
  playX = read() + 0
  write("Height: ")
  playY = read() + 0
  if playX < 3 or playX > sizeX or playY < 3 or playY > sizeY then
    print("This size is invalid!")
    sleep(2)
  end
end
if playX > 5 and playY > 5 then
  lenght = 5
else
  lenght = 3
end

fieldUp = math.floor((sizeY-(playY+2))/2)
fieldDown = fieldUp+playY+1
fieldLeft = math.floor((sizeX-(playX+2))/2)
fieldRight = fieldLeft+playX+1
print("You can now play!")
sleep(1)
term.clear()
term.setCursorPos(1, 1)
if device == "monitor" then
  m.clear()
  m.setCursorPos(1, 1)
  print("Game in progress...")
  m.setBackgroundColor(colors.white)
else
  term.setBackgroundColor(colors.white)
end
for y = 1, sizeY do
  for x = 1, sizeX do
    if (x/2) == math.floor(x/2) then
      odd = true
    else
      odd = false
    end
    if (y/2) == math.floor(y/2) then
      odd = not odd
    end
    if (y == fieldUp or y == fieldDown or x == fieldLeft or x == fieldRight) and x < fieldRight+1 and x > fieldLeft-1 and y < fieldDown+1 and y > fieldUp-1 then
      if device == "monitor" then
        m.setBackgroundColor(colors.white)
        m.setCursorPos(x, y)
        m.write(" ")
      else
        term.setBackgroundColor(colors.white)
        term.setCursorPos(x, y)
        term.write(" ")
      end
    elseif x < fieldRight and x > fieldLeft and y < fieldDown and y > fieldUp and odd == true then
      if device == "monitor" then
        m.setBackgroundColor(colors.gray)
        m.setCursorPos(x, y)
        m.write(" ")
      else
        term.setBackgroundColor(colors.gray)
        term.setCursorPos(x, y)
        term.write(" ")
      end
    elseif x < fieldRight and x > fieldLeft and y < fieldDown and y > fieldUp and odd == false then
      if device == "monitor" then
        m.setBackgroundColor(colors.lightGray)
        m.setCursorPos(x, y)
        m.write(" ")
      else
        term.setBackgroundColor(colors.lightGray)
        term.setCursorPos(x, y)
        term.write(" ")
      end
    end
  end
end
winner = " "
player = "X"
grid = {}
if device == "monitor" then
  m.setBackgroundColor(colors.black)
else
  term.setBackgroundColor(colors.black)
end

--main game loop
while winner == " " do
  if device == "monitor" then
    event, side, posX, posY = os.pullEvent("monitor_touch")
  else
    event, button, posX, posY = os.pullEvent("mouse_click")
  end
  if posX < fieldRight and posX > fieldLeft and posY < fieldDown and posY > fieldUp and checkPos(posX, posY) == nil then
    if device == "monitor" then
      m.setCursorPos(posX, posY)
      m.write(player)
    else
      term.setCursorPos(posX, posY)
      term.write(player)
    end
    grid[(posY*sizeX)+posX] = player
    --check for a winning move
    points = 1

    for i = 1, lenght do
      if checkPos(posX+i, posY) == player then
        points = points + 1
      else
        break
      end
    end
    for i = 1, lenght do
      if checkPos(posX-i, posY) == player then
        points = points + 1
      else
        break
      end
    end
    if points >= lenght then
      winner = player
      win =1
      break
    end
    points = 1
    for i = 1, lenght do
      if checkPos(posX+i, posY+i) == player then
        points = points + 1
      else
        break
      end
    end
    for i = 1, lenght do
      if checkPos(posX-i, posY-i) == player then
        points = points + 1
      else
        break
      end
    end
    if points >= lenght then
      winner = player
      win = 2
      break
    end
    points = 1
    for i = 1, lenght do
      if checkPos(posX, posY+i) == player then
        points = points + 1
      else
        break
      end
    end
    for i = 1, lenght do
      if checkPos(posX, posY-i) == player then
        points = points + 1
      else
        break
      end
    end
    if points >= lenght then
      winner = player
      win = 3
      break
    end
    points = 1
    for i = 1, lenght do
      if checkPos(posX+i, posY-i) == player then
        points = points + 1
      else
        break
      end
    end
    for i = 1, lenght do
      if checkPos(posX-i, posY+i) == player then
        points = points + 1
      else
        break
      end
    end
    if points >= lenght then
      winner = player
      win = 4
      break
    end
    
    if player == "X" then
      player = "O"
    else
      player = "X"
    end
  end
end

if device == "monitor" then
  m.setBackgroundColor(colors.blue)
else
  term.setBackgroundColor(colors.blue)
end

if win == 1 then
  for i = 0, lenght do
    if checkPos(posX+i, posY) == player then
      if device == "monitor" then
        m.setCursorPos(posX+i, posY)
        m.write(player)
      else
        term.setCursorPos(posX+i, posY)
        term.write(player)
      end
    else
      break
    end
  end
  for i = 0, lenght do
    if checkPos(posX-i, posY) == player then
      if device == "monitor" then
        m.setCursorPos(posX-i, posY)
        m.write(player)
      else
        term.setCursorPos(posX-i, posY)
        term.write(player)
      end
    else
      break
    end
  end
end

if win == 2 then
  for i = 0, lenght do
    if checkPos(posX+i, posY+i) == player then
      if device == "monitor" then
        m.setCursorPos(posX+i, posY+i)
        m.write(player)
      else
        term.setCursorPos(posX+i, posY+i)
        term.write(player)
      end
    else
      break
    end
  end
  for i = 0, lenght do
    if checkPos(posX-i, posY-i) == player then
      if device == "monitor" then
        m.setCursorPos(posX-i, posY-i)
        m.write(player)
      else
        term.setCursorPos(posX-i, posY-i)
        term.write(player)
      end
    else
      break
    end
  end
end

if win == 3 then
  for i = 0, lenght do
    if checkPos(posX, posY+i) == player then
      if device == "monitor" then
        m.setCursorPos(posX, posY+i)
        m.write(player)
      else
        term.setCursorPos(posX, posY+i)
        term.write(player)
      end
    else
      break
    end
  end
  for i = 0, lenght do
    if checkPos(posX, posY-i) == player then
      if device == "monitor" then
        m.setCursorPos(posX, posY-i)
        m.write(player)
      else
        term.setCursorPos(posX, posY-i)
        term.write(player)
      end
    else
      break
    end
  end
end

if win == 4 then
  for i = 0, lenght do
    if checkPos(posX+i, posY-i) == player then
      if device == "monitor" then
        m.setCursorPos(posX+i, posY-i)
        m.write(player)
      else
        term.setCursorPos(posX+i, posY-i)
        term.write(player)
      end
    else
      break
    end
  end
  for i = 0, lenght do
    if checkPos(posX-i, posY+i) == player then
      if device == "monitor" then
        m.setCursorPos(posX-i, posY+i)
        m.write(player)
      else
        term.setCursorPos(posX-i, posY+i)
        term.write(player)
      end
    else
      break
    end
  end
end

if device == "monitor" then
  m.setBackgroundColor(colors.black)
else
  term.setBackgroundColor(colors.black)
  term.setCursorPos(1, sizeY)
end
print('Player "' .. player .. '" won!')