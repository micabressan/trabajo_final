local sensor=peripheral.wrap("right")
local m=peripheral.wrap("top")
local programpart=3 --1 Z sort --2 Heal --3 V select

term.redirect(m)
local list={}
local good={}
function wait()
while true do
list=sensor.getEntityIds('mob')
if #list==0 then
return
end
sleep(0.5)
end
end
if programpart==1 then
rs.setBundledOutput("left",colors.green+colors.red)

while true do
list=sensor.getEntityIds('mob')

if(#list==0) then 
rs.setBundledOutput("left",colors.green+colors.red)
rs.setOutput("back",true)
sleep(0.25)
rs.setOutput("back",false)
else
rs.setOutput("back",false)
  if #list >1 then
  print("too many enterers")
  rs.setBundledOutput("left",colors.green)
  wait()
  else
    if sensor.getEntityData(list[1],'mob').all().name=="Zombie" then
      if sensor.getEntityData(list[1],'mob').all().zombie.isVillagerZombie==true then
      rs.setBundledOutput("left", colors.lime+colors.red)
      wait()
      else
      rs.setBundledOutput("left",0)
      print("no Villager Z")
      wait()
      end
    else
    print("no Z")
    rs.setBundledOutput("left",0)
    wait()
    end
  end
end
end
elseif programpart==2 then
  rs.setBundledOutput("left",colors.green)
  while true do
    list=sensor.getEntityIds('mob')
    if #list==0 then
      rs.setBundledOutput("left",colors.green)
      rs.setOutput("back",true)
      sleep(0.25)
      rs.setOutput("back",false)
      sleep(0.25)
      print("dep Z")
    elseif sensor.getEntityData(list[1],'mob').all().name=="Zombie"  then
      rs.setOutput("back",false)
      if sensor.getEntityData(list[1],'mob').all().zombie.convertingToVillager==false then
        rs.setBundledOutput("left",colors.red+colors.green)
        sleep(0.25)
        print("Heal")
      else
        rs.setBundledOutput("left",colors.green)
        sleep(0.5)
        print("wait for heal")
      end
    elseif sensor.getEntityData(list[1],'mob').all().name=="Villager" then
     
      if  sensor.getEntityData(list[1],'mob').all().villager.profession==10 then --rft V
      rs.setBundledOutput("left",colors.lime+colors.green)
      print("pack V")
      wait()
      else --no rft V
      rs.setBundledOutput("left",0)
      wait()
      end
    end
  end
elseif programpart==3 then
while true do
  local l,ui  
  list=sensor.getAllStacks()
  
  for a,b in pairs(list) do
  if a < 37 then
  if sensor.getStackInSlot(a).raw_name~="item.emerald" then
  sensor.pushItem("EAST",a)
  end
  end
  end
  
  local count=0,f
  list=sensor.getAllStacks()
  
  for a,b in pairs(list) do
    if sensor.getStackInSlot(a).raw_name=="item.emerald" then
    f=sensor.getStackInSlot(a).qty
    count=count+f
    end
  end

  if count<64 then
  sensor.pullItem("DOWN",1,(64-count))
  end
  sensor.condenseItems()
  
  sleep(2)
end
end--programpart end