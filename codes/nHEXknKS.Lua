local w,h = term.getSize()

local map = {
    ["player"] = {
        x = 1,
        y = 1,
        symbol = '@',
        color = colors.blue,
        name = "player",
    },
    ["item"] = {
        x = 8,
        y = 8,
        symbol = '!',
        color = colors.red,
        name = "player",
    }
}

local function draw(obj)
    term.setBackgroundColor(obj.color)
    term.setCursorPos(obj.x, obj.y)
    term.write(obj.symbol)
end

local dirty = {}
local empty = {
    x = 1,
    y = 1,
    color = colors.white,
    symbol = ' '
}

local function redraw()
    term.setBackgroundColor(colors.white)
    
    for i = #dirty, 1, -1 do
        local obj = dirty[i]
        
        empty.x = obj.x
        empty.y = obj.y
        
        draw(empty)
        draw(map[obj.name])
    end
end

local function inBounds(x, y)
    if x < 1 or y < 1 or x > w or y > h then
        return false
    end
    return true
end

local function move(obj, x, y)
    dirty[#dirty+1] = {
        x = obj.x,
        y = obj.y,
        name = obj.name
    }
    
    if inBounds(obj.x + x, obj.y + y) then
        obj.x = obj.x + x
        obj.y = obj.y + y
    end
end

local function destroy(obj)
    map[obj.name] = nil
    
    dirty[#dirty+1] = {
        x = obj.x,
        y = obj.y,
        name = obj.name
    }
end

local function touching(self, obj)
    if self.x == obj.x and self.y == obj.y then
        return true
    end
    return false
end

term.setBackgroundColor(colors.white)
term.setTextColor(colors.white)
term.clear()

for name, obj in pairs(map) do
    draw(obj)
end

local player = map["player"]
local item = map["item"]
while true do
    redraw()
    
    local event, key = os.pullEvent()
    if event == "key" then
        if key == keys.up then
            move(player, 0, -1)
        elseif key == keys.down then
            move(player, 0, 1)
        elseif key == keys.left then
            move(player, -1, 0)
        elseif key == keys.right then
            move(player, 1, 0)
        elseif key == keys.q then
            break
        end
    end
    
    if item and touching(player, item) then
        item = destroy(item)
        
        player.color = colors.green
    end
end