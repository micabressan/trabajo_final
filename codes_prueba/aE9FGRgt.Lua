local term = require("term")
local sides = require("sides")
local comp = require("component")
local computer = require("computer")
local geo = comp.geolyzer
local gen = comp.generator


local AxeSlot = 16
local InvSize = 15
local item = comp.inventory_controller.getStackInInternalSlot(AxeSlot)
local robot = require("robot")
local tool = comp.inventory_controller
local livingBlocks = { "Botania:livingwood", "Botania:livingrock" }
local halfEngergy = computer.maxEnergy() / 2
 
robot.select(1)



if item then
  if item.name == "TConstruct:lumberaxe" then
    robot.select(AxeSlot)
    print("Equip Axe")
    tool.equip()
  else
    print("Slot is empty")
  end
end

function checkFront()
  local inFront = geo.analyze(sides.front)
  print(inFront.name)
  for k,v in pairs(livingBlocks) do
    if inFront.name == v then
      return true
    else   
      return false
    end
  end
end

function checkBattery()
  local myEnergy = computer.energy()
  print("Checking Battery")
  if(myEnergy == halfEnergy) then
    print("Need to Charge")
    if(checkInvForBlocks() == true) then
      print("Inserting fuel") 
      robot.select(findFuel())
      gen.insert(5)
    else
      print("There's no fuel")
    end


  else
    print("Battery is OK")
  end
end

function findEmptySlot() 
  for slot = 1, robot.inventorySize() do
    if(robot.count(slot) == 0) then 
      return slot
    end
  end
end

function checkInvForBlocks() 
  for slot = 1, robot.inventorySize() do
    if(robot.count(slot) > 0) then
      return true
    else 
      return false
    end
  end
end

function breakBlock()
  if(checkFront() == true) then
    print("Break ", geo.analyze().name)
    robot.swing()
  end
end

function putInChest()
  if(robot.count(15) >= 5) then
    robot.turnRight()
    print("Put LivingBlock into chest")
    for chest = 1, chestSlot do
      tool.dropIntoSlot(sides.front, chest)
    end
  else
    return
  end
end

function findFuel()
  for slot = 1, robot.inventorySize() do
    if(robot.count(slot) > 0) then
      return slot
    end
  end
end

function fillSlots()
  local chest = 1
  local chestSlots = 0
  local emptySlot = 0
  robot.turnAround()
  print("Take Block from chest")
  if(geo.analyze(sides.front).name == "IronChest:IronChest") then
    chestSlots = tool.getInventorySize(sides.front)
    while(chest < chestSlots) do
        emptySlot = findEmptySlot() -1
        robot.select(emptySlot)
        tool.suckFromSlot(sides.front, chest)
		chest = chest + 1
    end
  end
  robot.turnAround()
  robot.select(1)
  return
end



function StartWorking()
	while(true) do
		checkBattery()
		if(checkInvForBlocks() == false) then
			print("Need blocks to Place")
			fillSlots()
		else
		breakBlock()
		putInChest()
		end
	end
end


StartWorking()