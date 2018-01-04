Enum = {
  NormalId = {
      Top = {0,1,0},
      Bottom = {0.-1,0},
      Right = {1,0,0},
      Left = {-1,0,0},
      Front = {0,0,-1},
      Back = {0,0,1}
  }
}


Vector3 = {}
local meta
meta = {
	__metatable = nil;
	__add = function(x,y)
		local m1,m2 = getmetatable(x),getmetatable(y)
		if m1 == meta and m2 == meta then
			return Vector3.new(x.X + y.X,x.Y + y.Y,x.Z + y.Z)
		end
	end;
	__div = function(x,y)
		local m1,m2 = getmetatable(x),getmetatable(y)
		if m1 == meta and m2 == meta then
			return Vector3.new(x.X/y.X,x.Y/y.Y,x.Z/y.Z)
		elseif type(x) == "number" then
			return Vector3.new(x/y.X,x/y.Y,x/y.Z)
		elseif type(y) == "number" then
			return Vector3.new(x.X/y,x.Y/y,x.Z/y)
		end
	end;
	__mul = function(x,y)
		local m1,m2 = getmetatable(x),getmetatable(y)
		if m1 == meta and m2 == meta then
			return Vector3.new(x.X*y.X,x.Y*y.Y,x.Z*y.Z)
		elseif type(x) == "number" then
			return Vector3.new(x*y.X,x*y.Y,x*y.Z)
		elseif type(y) == "number" then
			return Vector3.new(x.X*y,x.Y*y,x.Z*y)
		end		
	end;
	__sub = function(x,y)
		local m1,m2 = getmetatable(x),getmetatable(y)
		if m1 == meta and m2 == meta then
			return Vector3.new(x.X - y.X,x.Y - y.Y,x.Z - y.Z)
		end		
	end;
	__unm = function(_,x)
		return Vector3.new(-x.X,-x.Y,-x.Z)
	end;
	__concat = function(x,y)
        if getmetatable(y) == meta then
            return x..y.X.." "..y.Y.." "..y.Z
        else
            return x.X.." "..x.Y.." "..x.Z..y
        end
	end;
	__len = function()
		error("Attempt to get the length of a Vector3 value")
	end
}

function Vector3.new(x,y,z)
    local new = {}
    new.X = x or 0
    new.Y = y or 0
    new.Z = z or 0
    new.magnitude = ((0 - new.X)^2 + (0 - new.Y)^2 + (0 - new.Z)^2)^.5
    new.unit = setmetatable(
        {
        X = new.X/new.magnitude,
        Y = new.Y/new.magnitude,
        Z = new.Z/new.magnitude,
        magnitude = 1
        },meta
    )
    function new.Lerp(self,goal,alpha)
        local x = self.X*(1 - alpha) + goal.X*alpha
        local y = self.Y*(1 - alpha) + goal.Y*alpha
        local z = self.Z*(1 - alpha) + goal.Z*alpha
        return Vector3.new(x,y,z)
    end
    function new.Dot(self,other)
        return self.X*other.X + self.Y*other.Y + self.Z*other.Z
    end
    function new.Cross(self,other)
        local x = self.Y*other.Z - self.Z*other.Y
        local y = self.Z*other.X - self.X*other.Z
        local z = self.X*other.Y - self.Y*other.X
        return Vector3.new(x,y,z)
    end
    function new.IsClose(self,other,ep)
        
    end
    return setmetatable(new,meta)
end

function Vector3.FromNormalId(norm)
    return Vector3.new(unpack(norm))
end