rednet.open("bottom")
 
--------file--------
fs.makeDir("settings")
local files = {"on","ControlRod","EC1"}
for i = 1,#files do
  local f = fs.find("settings/"..files[i]..".lua")
  if #f == 0 then
    local h = fs.open("settings/"..files[i]..".lua","w")
    h.write("0")
    h.flush()
    h.close()
  end
end
 
--------set-------
local ReN = {0}
local Re = {}
 
local Mon = peripheral.wrap("back")
 
for i = 1, #ReN do
  Re[i] = peripheral.wrap("BigReactors-Reactor_"..ReN[i])
end
 
--------buttons--------
local buttons = {}
buttons[1] = {1,3,20,7,3,"on","on","off"}--on/off
buttons[2] = {2,11,20,7,3,"^"}
buttons[3] = {2,11,24,7,3,"v"}
 
--------functions--------
function fileRead(name)
  file = fs.open("settings/"..name..".lua","r")
  local text = file.readAll()
  file.close()
  return text
end
 
function fileReadLine(name,num)
  local file = fs.open("settings/"..name..".lua","r")
  local T = file.readLine()
  local N = 1
  local arr = {}
  while T do
	arr[N] = T
    T = file.readLine()
	N = N + 1
  end
  return arr[num]
end

function fileWrite(name,text)
  file = fs.open("settings/"..name..".lua","w")
  file.write(text)
  file.flush()
  file.close()
end

function fileTrance(name,num,text)
  local file = fs.open("settings/"..name..".lua","r")
  local T = file.readLine()
  local N = 1
  local arr = {}
  while T do
	arr[N] = T
    T = file.readLine()
	N = N + 1
  end
  arr[num] = text
  file.close()
  file = fs.open("settings/"..name..".lua","w")
  for i = 1, #arr do
	file.writeLine(arr[i])
  end
  file.flush()
  file.close()
end
 
function Clear() -- monitor clear
  Mon.clear()
  Mon.setCursorPos(1,1)
end
 
function TC(color,text)
  Mon.setTextColor(color)
  Mon.write(text)
  Mon.setTextColor(colors.white)
end
 
function TB(color,text)
  Mon.setBackgroundColor(color)
  Mon.write(text)
  Mon.setBackgroundColor(colors.black)
end
 
function TBC(Tcolor,Bcolor,text)
  Mon.setTextColor(Tcolor)
  Mon.setBackgroundColor(Bcolor)
  Mon.write(text)
  Mon.setTextColor(colors.white)
  Mon.setBackgroundColor(colors.black)
end
 
function Graph(X,Y,W,H,R,F,N,C1,C2) --x,y,width,high,rotate,full,num,color1,color2
  local Num
  local per
  if F >= N then
    per = N/F
  elseif F < N then
    per = 1
  end
  if R == 0 then
    for i = 1, H do
      Num = 0
      for j = 1, math.ceil(W*per) do
        Mon.setCursorPos(X+Num,Y+i-1)
        TB(C1," ")
        Num = Num + 1
      end
      for j = math.ceil(W*per), W-1 do
        Mon.setCursorPos(X+Num,Y+i-1)
        TB(C2," ")
        Num = Num + 1
      end
    end
  end
  if R == 1 then
    for i = 1, W do
      Num = H
      for j = 1, math.ceil(H*per) do
        Mon.setCursorPos(X+i-1,Y+Num)
        TB(C1," ")
        Num = Num - 1
      end
      for j = math.ceil(H*per), H-1 do
        Mon.setCursorPos(X+i-1,Y+Num)
        TB(C2," ")
        Num = Num - 1
      end
    end
  end
end
 
function TF(num)
  if num == "false" then
    return "true"
  else
    return "false"
  end
end
 
function button_push(num)
  if num == 1 then
    fileWrite("on",TF(fileRead("on")))
  elseif num == 2 then
	if tonumber(fileRead("ControlRod")) < 100 then
      fileWrite("ControlRod",fileRead("ControlRod")+10)
    end
  elseif num == 3 then
	if tonumber(fileRead("ControlRod")) > 0 then
      fileWrite("ControlRod",fileRead("ControlRod")-10)
	end
  end
end
 
function button(X,Y)
  for i = 1, #buttons do
    if buttons[i][2]<X and X<buttons[i][2]+buttons[i][4] then
      if buttons[i][3]<Y and Y<buttons[i][3]+buttons[i][5] then
        button_push(i)
      end
    end
  end
end
 
 
function Label()
  TC(colors.green,"sk200103's Reactor Controller")
end
 
function Reactor_Information(X,Y,Num)
  Graph(X,Y,3,15,1,Re[Num].getFuelAmountMax(),Re[Num].getFuelAmount(),colors.yellow,colors.gray)
  Graph(X+4,Y,3,15,1,1000,Re[Num].getWasteAmount(),colors.blue,colors.gray)
  Graph(X+8,Y,3,15,1,10000000,Re[Num].getEnergyStored(),colors.red,colors.gray)
  Graph(X+12,Y,3,15,1,100,tonumber(fileRead("ControlRod")),colors.red,colors.gray)
  Mon.setCursorPos(X+16,Y+2)
  Mon.write("Fuel:"..Re[Num].getFuelAmount().."mB")
  Mon.setCursorPos(X+16,Y+3)
  Mon.write("Waste:"..Re[Num].getWasteAmount().."mB")
  Mon.setCursorPos(X+16,Y+5)
  Mon.write("Fuel/t:"..(math.floor(Re[Num].getFuelConsumedLastTick()*1000+0.5)/1000).."mB")
  Mon.setCursorPos(X+16,Y+6)
  Mon.write("RF/t:"..Re[Num].getEnergyProducedLastTick().."RF/t")
end

function Energy_Core_Information(X,Y)
  Mon.setCursorPos(X,Y-1)
  Mon.write("Energy Core")
  Graph(X,Y,3,20,1,fileReadLine("EC1",3),fileReadLine("EC1",1),colors.red,colors.gray)
  Mon.setCursorPos(X+4,Y+2)
  Mon.write(fileReadLine("EC1",1).."RF")
  Mon.setCursorPos(X+4,Y+3)
  if tonumber(fileReadLine("EC1",2)) > 0 then
	TC(colors.green,"+"..fileReadLine("EC1",2).."RF/T")
  else
    TC(colors.red,fileReadLine("EC1",2).."RF/T")
  end
end
 
function controll_panel()
  for num = 1, #buttons do
    if buttons[num][1] == 1 then
      if #buttons[num] == 8 then
        for i = 1, buttons[num][5] do
          if i == math.floor(buttons[num][5]/2+0.5) then
            local text
            local Color
            if fileRead(buttons[num][6]) == "true" then
              text = 7
              Color = colors.green
            elseif fileRead(buttons[num][6]) == "false" then
              text = 8
              Color = colors.red
            end
            Mon.setCursorPos(buttons[num][2],buttons[num][3]+(math.floor(buttons[num][5]/2-0.5)))
            for j = 1, buttons[num][4]-#buttons[num][text]+1 do
              if j == math.floor((buttons[num][4]-#buttons[num][text]+1)/2+0.5) then
                TBC(colors.white,Color,buttons[num][text])
              else
                TB(Color," ")
              end
            end
          else
            for j = 1, buttons[num][4] do
              Mon.setCursorPos(buttons[num][2]+j-1,buttons[num][3]+i-1)
              if fileRead(buttons[num][6]) == "true" then
                TB(colors.green," ")
              else
                TB(colors.red," ")
              end
            end
          end
        end
      end
    elseif buttons[num][1] == 2 then
	  for i = 1, buttons[num][5] do
        if i == math.floor(buttons[num][5]/2+0.5) then
		  Mon.setCursorPos(buttons[num][2],buttons[num][3]+(math.floor(buttons[num][5]/2-0.5)))
          for j = 1, buttons[num][4]-#buttons[num][6]+1 do
            if j == math.floor((buttons[num][4]-#buttons[num][6]+1)/2+0.5) then
              TBC(colors.white,colors.gray,buttons[num][6])
            else
              TB(colors.gray," ")
            end
		  end
        else
          for j = 1, buttons[num][4] do
            Mon.setCursorPos(buttons[num][2]+j-1,buttons[num][3]+i-1)
            TB(colors.gray," ")
          end
		end
	  end
    end
  end
end
 
function Panel()
  Clear()
  Label()
  Reactor_Information(3,3,1)
  Energy_Core_Information(3,29)
  controll_panel()
end
 
function Tester(num)
  if fileRead("on") == "true" then
    Re[num].setActive(true)
  else
    Re[num].setActive(false)
  end
  
  Re[num].setAllControlRodLevels(100-tonumber(fileRead("ControlRod")))
end
 
 
--------start--------
rednet.open("top")
local timer2 = os.startTimer(0.2)
local timer10 = os.startTimer(1)
 
while true do
  local event,a,b,c,d,e = os.pullEvent()
  if event == "timer" then
	if a == timer2 then
      Panel()
      Tester(1)
      timer2 = os.startTimer(0.2)
	end
    if a == timer10 then
      rednet.broadcast("ES","energy core 1")
      rednet.broadcast("TP","energy core 1")
   	  rednet.broadcast("ME","energy core 1")
	  timer10 = os.startTimer(1)
	end
  elseif event == "monitor_touch" then
    button(b,c)
  elseif event == "rednet_message" then
    if c == "ES1" then
	  fileTrance("EC1",1,b)
    elseif c == "TP1" then
	  fileTrance("EC1",2,b)
	elseif c == "ME1" then
	  fileTrance("EC1",3,b)
	end
  end
end