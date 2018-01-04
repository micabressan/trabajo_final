-- this module allows turtle movement based on a coordinate system; the turtle tracks it's own coordinates and the direction it's facing as it moves
-- for this reason it's important to use ONLY the functions in this module if you are using it at all
-- the turtle's current position will be (0, 0, 0) and it's current facing direction will be 0 upon creation of a new turtleController instance
-- all positions and directions given to that instance will be relative to that origin point

turtleController = {
    dir = 0,
    pos = {0, 0, 0}
}

function turtleController:new()
    -- creates a new turtleController instance
    obj = {}
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function turtleController:hasFullInventory()
    -- returns true if all the turtle's inventory slots have at least one item (except for slot 1, which is reserved for fuel)
    full = true
    for i = 2, 16 do
        full = full and turtle.getItemCount(i) > 0
    end

    return full
end

function turtleController:hasEnoughFuel(pos, fuelBuffer)
    -- returns true if the turtle has enough fuel to reach the given position and keep at least 'fuelBuffer' amount of fuel
    if not fuelBuffer then
        fuelBuffer = 0
    end

    if turtle.getFuelLimit() ~= "unlimited" then
        distance = 0
        for i = 1, 3 do
            distance = distance + math.abs(self.pos[i] - pos[i])
        end

        return distance <= turtle.getFuelLevel() - fuelBuffer
    end

    return true
end

function turtleController:turnRight(amount)
    -- turn right 'amount' times (modulo 4)
    if not amount then
        amount = 1
    end

    for i = 1, amount % 4 do
        turtle.turnRight()
        self.dir = (self.dir + 1) % 4
    end
end

function turtleController:turnLeft(amount)
    -- turn left 'amount' times (modulo 4)
    if not amount then
        amount = 1
    end

    for i = 1, amount % 4 do
        turtle.turnLeft()
        self.dir = (self.dir - 1) % 4
    end
end

function turtleController:setDir(dir)
    -- sets the turtle's direction to the given value
    if (self.dir + 1) % 4 == dir then
        turtle.turnRight()
    elseif (self.dir + 2) % 4 == dir then
        turtle.turnRight()
        turtle.turnRight()
    elseif (self.dir + 3) % 4 == dir then
        turtle.turnLeft()
    end

    self.dir = dir
end

function turtleController:move(dir, distance)
    -- move 'distance' blocks in the given direction
    if not dir then
        dir = self.dir
    end
    
    if not distance then
        distance = 1
    end

    self:setDir(dir)
    for i = 1, distance do
        if not turtle.detect() then
            turtle.forward()
            if dir == 0 then
                self.pos[2] = self.pos[2] + 1
            elseif dir == 1 then
                self.pos[1] = self.pos[1] + 1
            elseif dir == 2 then
                self.pos[2] = self.pos[2] - 1
            else
                self.pos[1] = self.pos[1] - 1
            end
        end
    end
end

function turtleController:moveUp(distance)
    -- move 'distance' blocks up
    if not distance then
        distance = 1
    end

    for i = 1, distance do
        if not turtle.detectUp() then
            turtle.up()
            self.pos[3] = self.pos[3] + 1
        end
    end
end

function turtleController:moveDown(distance)
    -- move 'distance' blocks down
    if not distance then
        distance = 1
    end

    for i = 1, distance do
        if not turtle.detectDown() then
            turtle.down()
            self.pos[3] = self.pos[3] - 1
        end
    end
end

function turtleController:setPos(pos, dir, fuelBuffer)
    -- sets the turtle's position and direction to the given values
    -- returns whether or not the turtle made it to the given position
    if not fuelBuffer then
        fuelBuffer = 0
    end

    if self:hasEnoughFuel(pos, fuelBuffer) then
        atPos = false
        moved = true
        while moved and not atPos do
            moved = false

            if not moved and self.pos[3] < pos[3] and not turtle.detectUp() then
                turtle.up()
                moved = true
                self.pos[3] = self.pos[3] + 1
            end
            if not moved and self.pos[3] > pos[3] and not turtle.detectDown() then
                turtle.down()
                moved = true
                self.pos[3] = self.pos[3] - 1
            end
            if not moved and self.pos[1] < pos[1] then
                self:setDir(1)
                if not turtle.detect() then
                    turtle.forward()
                    moved = true
                    self.pos[1] = self.pos[1] + 1
                end
            end
            if not moved and self.pos[1] > pos[1] then
                self:setDir(3)
                if not turtle.detect() then
                    turtle.forward()
                    moved = true
                    self.pos[1] = self.pos[1] - 1
                end
            end
            if not moved and self.pos[2] < pos[2] then
                self:setDir(0)
                if not turtle.detect() then
                    turtle.forward()
                    moved = true
                    self.pos[2] = self.pos[2] + 1
                end
            end
            if not moved and self.pos[2] > pos[2] then
                self:setDir(2)
                if not turtle.detect() then
                    turtle.forward()
                    moved = true
                    self.pos[2] = self.pos[2] - 1
                end
            end

            atPos = true
            for i = 1, 3 do
                atPos = atPos and self.pos[i] == pos[i]
            end

        end

        if atPos then
            self:setDir(dir)
            return true
        end
    end

    return false
end

function turtleController:refuelIfNeeded(refuelPos, refuelDir, fuelBuffer)
    -- checks if the turtle needs to refuel and if so moves to 'refuelPos' and 'refuelDir' in order to refuel
    -- returns whether or not the turtle refueled
    -- note that the the turtle won't automatically move back to its previous position
    if not fuelBuffer then 
        fuelBuffer = 0 
    end

    if not self:hasEnoughFuel(refuelPos, fuelBuffer + 1) then
        turtle.select(1)
        turtle.refuel()
        self:setPos(refuelPos, refuelDir, -1)
        success = true
        while success do
            turtle.suck()
            success = turtle.refuel()
        end

        return true
    end
    
    return false
end

function turtleController:emptyInventory(emptyPos, emptyDir, fuelBuffer)
    -- moves to 'emptyPos' and 'emptyDir' and dumps all inventory slots (except for slot 1, which is reserved for fuel)
    -- note that the the turtle won't automatically move back to its previous position
    if not fuelBuffer then
        fuelBuffer = 0
    end

    if self:hasEnoughFuel(emptyPos) then
        self:setPos(emptyPos, emptyDir)
        for i = 2, 16 do
            turtle.select(i)
            turtle.drop()
        end
    end
end