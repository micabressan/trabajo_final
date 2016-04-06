--Desktop

slc = 0
tBarC = 8
tBartC = 1
backColor = 1
term.setBackgroundColor(backColor)
term.clear()
contextX = 0
contextY = 0
function titleBar()
  term.setCursorPos(1,1)
  term.setBackgroundColor(tBarC)
  term.setTextColor(tBartC)
  term.clearLine()
  term.setCursorPos(3, 1)
  print("[Begin]")
end
function drawDesktop()
  term.setBackgroundColor(backColor)
  term.clear()
  bground = paintutils.loadImage("lol")
  paintutils.drawImage(bground,1,2)
  icon = paintutils.loadImage("icon")
  paintutils.drawImage(icon, 2, 3)
  term.setBackgroundColor(backColor)
  term.setTextColor(128)
  term.setCursorPos(2,9)
  print("icon 1")
  titleBar()

end

function drawMenu1()
term.setTextColor(256)
term.setBackgroundColor(128)
term.setCursorPos(1,2)
print("          ")
term.setCursorPos(1,3)
print(" Shutdown ")
term.setCursorPos(1,4)
print(" Restart  ")
term.setCursorPos(1,5)
print("          ")

end

function drawMenu2()
term.setBackgroundColor(128)
term.setTextColor(256)
term.setCursorPos(contextX, contextY)
print("                   ")
term.setCursorPos(comtextX, contextY+1)
print("  EDIT GUI   ")
term.setCursorPos(contextX, contextY+2)
print(" FileManager ")
term.setCursorPos(contextX, contextY+3)
print("             ")
end

drawDesktop()
while true do
local event, button, X, Y = os.pullEvent()
  if slc == 0 then
    if event == "mouse_click" then
      if X >=2 and X <=8 and Y==1 and button ==1 then
      drawMenu1()
      slc = 1
        elseif X>=2 and X<=5 and Y>=3 and Y<=9 and button ==1 then
        shell.run("file")
        elseif X >= 1 and Y >= 2 and button ==2 then slc =2
           contextX = X
           contextY = Y
           drawMenu2()
         else
        drawDesktop()
      end
    end
   elseif slc == 1 then
   if event == "mouse_click" then
     if X >=1 and X <=11 and button == 1 and Y== 3 then slc = 0 
       os.shutdown()
       elseif X>=1 and X<=11 and Y==4 and button ==1 then slc = 0 
       os.reboot()
       else
       slc = 0
       drawDesktop()
       end
    elseif slc == 2 then 
        if X >= 2 contextX and X<=contextX+13 and Y==contextY+1 and button ==1 then slc = 0
          shell.run("edit","gui")
          drawDesktop()
          elseif X>= contextX and X<= ocntextX+13 and Y == context+2 and button ==1 then slc = 0
          shell.run("file")
          drawDesktop()
        end
      
end
end
end