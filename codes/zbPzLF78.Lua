term.setBackgroundColor(colors.white)
term.setTextColor(colors.black)
term.setCursorPos(1,1)
term.clear()

local buttons = {}

--function makeButton(x,y,l,w,name,color1,color2)
--  table.insert(buttons,#buttons+1,{x,y,(x+l)-1,(y+w)-1,name,color1,color2})
--end

function drawButton(name,color)
  for i = 1, #buttons do
    if buttons[i][5] == name then
     if color ~= "green" then
        paintutils.drawFilledBox(buttons[i][1],buttons[i][2],buttons[i][3],buttons[i][4],buttons[i][6])  
      else
        paintutils.drawFilledBox(buttons[i][1],buttons[i][2],buttons[i][3],buttons[i][4],buttons[i][7])
      end
      term.setCursorPos(((buttons[i][1]+buttons[i][3])/2)-(#name/2)+1,(buttons[i][2]+buttons[i][4])/2)
      print(buttons[i][5])
    end
  end
end

function makeButton(x,y,l,w,name,color1,color2)
  table.insert(buttons,#buttons+1,{x,y,(x+l)-1,(y+w)-1,name,color1,color2})
  drawButton(name)
end  

function checkForButtonPressed()
  event, p1, x, y = os.pullEvent("mouse_click")
  for i = 1, #buttons do
    if x >= buttons[i][1] and x <= buttons[i][3] then
      if y >= buttons[i][2] and y <= buttons[i][4] then
        drawButton(buttons[i][5],"green")
        sleep(0.5)
        drawButton(buttons[i][5])
        return buttons[i][5]
      end
    end
  end
end