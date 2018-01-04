-- miner for mining world

FUEL_SLOT = 1

WORTHLESS_BLOCKS = {
  "chisel",
  "minecraft:bedrock",
  "minecraft:cobblestone",
  "minecraft:lava",
  "minecraft:flowing_lava",
  "minecraft:water",
  "minecraft:flowing_water",
  "minecraft:dirt",
  "minecraft:grass",
  "minecraft:gravel",
  "minecraft:sand",
  "minecraft:stone",
  "minecraft:torch",
  "zzz_last_entry"
}

function refuel()
  if turtle.getFuelLevel() < 1000 then
    turtle.select(FUEL_SLOT)
    turtle.refuel()
  end
end

function dig(direction)
  direction = direction:lower()
  local _detect = {
    f = turtle.detect,
    u = turtle.detectUp,
    d = turtle.detectDown,
  }

  local _dig = {
    f = turtle.dig,
    u = turtle.digUp,
    d = turtle.digDown,
  }

  if _detect[direction] == nil then
    return
  end

  while _detect[direction]() do
    refuel()
    if not _dig[direction]() then
      return false
    end
    sleep(0.5)
  end
  return true
end

function move(direction)
  direction = direction:lower()
  local _move = {
    f = turtle.forward,
    b = turtle.back,
    u = turtle.up,
    d = turtle.down
  }

  if _move[direction] == nil then
    return false
  end

  if not dig(direction) then
    return false
  end
  return _move[direction]()
end

function is_valuable(inspect)
  ok, inspect = inspect()

  if not ok then
    return false
  end

  for _, i in pairs(WORTHLESS_BLOCKS) do
    if string.sub(inspect.name, 1, string.len(i)) == i then
      return false
    end
  end

  print(inspect.name)
  return true
end

function mine_vein()
  if is_valuable(turtle.inspectUp) then
    move('u')
    mine_vein()
    move('d')
  end

  if is_valuable(turtle.inspectDown) then
    move('d')
    mine_vein()
    move('u')
  end

  for i = 1, 4 do
    if is_valuable(turtle.inspect) then
      move('f')
      mine_vein()
      move('b')
    end
    turtle.turnLeft()
  end
end

-- start mining
depth = 0
while true do
  refuel()
  if not move('d') then
    break
  end
  depth = depth + 1
  mine_vein()
end

for i = 1, depth do
  move('u')
end