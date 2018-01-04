monitor = peripheral.wrap("left")
monitor.clear()
monitor.setTextScale(0.9)
-- peripheral.call("left", "write", "TODO" )
monitor.setCursorPos(1,1)
 
args = {...}
todoPath = "/disk/files/TODO.list"
 
 
function inArray(arr, val)
  for index, value in pairs(arr) do
    if value == val then
      return true
    end
  end
  return false
end
 
 
function printTODOlist()    
  local h = fs.open(todoPath, "r")
  local c = 2
  local line = h.readLine()
  monitor.write("TODO list:")
  while line ~= nil do
    monitor.setCursorPos(1,c)
    monitor.write( "#" .. (c-1) .. ": " .. line)
    c = c + 1
    line = h.readLine()
  end
  h.close()
end
 
 
function writeNewList(newList)
  local h = fs.open(todoPath, "w")
  for key, value in pairs(newList) do
    h.writeLine(value)
  end
  h.close()
end
 

function concat(arr1, arr2)
  for i=1,#arr2 do
    arr1[#arr1 + 1] = arr2[i]
  end
  return arr1
end
 
function changeTask(id, new)
  if type(id) ~= "number" then
    print("todo: changeTask: id argument must be a number")
    return
  end
 
  local h = fs.open(todoPath, "r")
  local newList = {}
  local c = 1
  local index = 1
 
  local line = h.readLine()
  while line ~= nil do
    if c == id then
      if new ~= nil then
        newList[index] = new
        index = index + 1
      end
    else
      newList[index] = line
      index = index + 1
    end
    line = h.readLine()
    c = c + 1
  end
  h.close()
 
  writeNewList(newList)
end
 
 
function moveTask(id, newID)
  if type(id) ~= "number" or type(newID) ~= "number" then
    print("todo: moveTask: id and newID needs to be numbers")
    return
  end
 
  local index = 1
  local first = {}
  local second = {}
  local third = {}
  local fourth = {}

  local h = fs.open(todoPath, "r")
  local line = h.readLine()
 
  if id > newID then -- Priority getting higher
    while line ~= nil do
      if index < newID then
        first[#first + 1] = line
      elseif index >= newID and index < id then
        third[#third + 1] = line
      elseif index == id then
        second[1] = line
      else
        fourth[#fourth + 1] = line
      end
      index = index + 1
      line = h.readLine()
    end
  elseif id < newID then -- Priority getting lower
    while line ~= nil do
      if index < id then
        first[#first + 1] = line
      elseif index == id then
        third[1] = line
      elseif index > id and index <= newID then
        second[#second + 1] = line
      else
        fourth[#fourth + 1] = line
      end
      index = index + 1
      line = h.readLine()
    end
  else
    local list = {}
    while line ~= nil do
      list[index] = line
      index = index + 1
      line = h.readLine()
    end
    return list
  end
 
  return concat(concat(concat(first, second), third), fourth);
end
 
 
function switchTasks(id1, id2)
  if type(id1) ~= "number" or type(id2) ~= "number" then
    print("todo: switchTasks: id1 and id2 must be numbers")
    return
  end
 
  local h = fs.open(todoPath, "r")
  local index = 1
  local newList = {}
  local line = h.readLine()
  while line ~= nil do
    if index == id1 then
      newList[id2] = line
    elseif index == id2 then
      newList[id1] = line
    else
      newList[index] = line
    end
    index = index + 1
    line = h.readLine()
  end
 
  writeNewList(newList)
end


function removeTasks(tasksIDs)   
    local index = 0
    local newIndex = 0
    local newList = {}
    local h = fs.open(todoPath, "r")
    local line = h.readLine()
    while line ~= nil do
      index = index + 1
      if not inArray(tasksIDs, index) then
        newIndex = newIndex + 1
        newList[newIndex] = line
      end
      line = h.readLine()
    end
    --for key, value in pairs(newList) do
      --print("Key: "..key.." - Value: "..value)
    --end
    return newList
end
 
 
if args[1] == "add" then
  if args[2] == nil then
    print("todo: Usage: todo add \"<new_task>\" [<taskID>]")
  else
    h = fs.open(todoPath, "a")
    h.writeLine(args[2])
    h.close()
    if args[3] ~= nil and type(tonumber(args[3])) == "number" then
      h = fs.open(todoPath, "r")
      local c = 0
      local line = h.readLine()
      while line ~= nil do
        c = c + 1
        line = h.readLine()
      end
      h.close()
      writeNewList(moveTask(c, tonumber(args[3])))
    end
  end
 
elseif args[1] == "remove" then
  if type(tonumber(args[2])) ~= "number" then
    print("todo: Usage: todo remove <taskID> [<taskID> ...]")
  else
    local tasksIDs = {}
    local c = 0
    for key, value in pairs(args) do
      if key > 1 then
        if type(tonumber(value)) == "number" then
          c = c + 1
          tasksIDs[c] = tonumber(value)
        else
          print("todo: Argument #" .. key .. " (Value: \"" .. value .. "\") is not a number. Ignoring it.")
        end
      end
    end

    writeNewList(removeTasks(tasksIDs))
  end
 
elseif args[1] == "change" then
  if type(tonumber(args[2])) ~= "number" or args[3] == nil then
    print("todo: Usage: todo change <taskID> \"Replacement\"")
  else
    changeTask(tonumber(args[2]), args[3])
  end
 
elseif args[1] == "move" then
  if type(tonumber(args[2])) ~= "number" or type(tonumber(args[3])) ~= "number" then
    print("todo: Usage: todo move <taskID> <newTaskID>")
  else
    writeNewList(moveTask(tonumber(args[2]), tonumber(args[3])))
  end
 
elseif args[1] == "switch" then
  if type(tonumber(args[2])) ~= "number" or type(tonumber(args[3])) ~= "number" then
    print("todo: Usage: todo switch <1stTaskID> <2ndTaskID>")
  else
    switchTasks(tonumber(args[2]), tonumber(args[3]))    
  end
                                                                                                                                             
elseif args[1] == "update" then
  
 
else
  print("todo: Usage:\ntodo add \"new task\" [<taskID>]\ntodo remove <taskID> [<taskID> ...]\ntodo change <taskID> \"replacement\"\ntodo move <taskID> <newTaskID>\ntodo switch <1stTaskID> <2ndTaskID>\ntodo update")
end

printTODOlist()