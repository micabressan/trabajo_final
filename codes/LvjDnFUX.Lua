list={}
local monitor = peripheral.wrap("left")
monitor.setTextScale(2)
while true do
  cmd=read()
  if string.sub(cmd,1,4)=="add " then
    list[#list+1]=string.sub(cmd,5,#cmd)
    term.clear()
    term.setCursorPos(1,1)
    for k,v in pairs(list) do
      print(k..": "..v)
    end
  end
  if string.sub(cmd,1,4)=="rem " then
    table.remove(list,tonumber(string.sub(cmd,5,#cmd)))
    term.clear()
    term.setCursorPos(1,1)
    for k,v in pairs(list) do
      print(k..": "..v)
    end
  end
end