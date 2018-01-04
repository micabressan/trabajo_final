local std = dofile("../src/stdlua.lua") 

local Vector3 = class
{ "Vector3",
	public =
	{
		x = 0.0,
		y = 0.0,
		z = 0.0
	}
}

function Vector3:construct(x, y, z)
	self.x = x or 0
	self.y = y or 0
	self.z = z or 0
end

function Vector3.operator_plus(a, b)
	print(a:toString(), b:toString())
	return Vector3(a.x + b.x, a.y + b.y, a.z + b.z)
end

function Vector3:toString()
	return "(" .. self.x .. ", " .. self.y .. ", " .. self.z .. ")"
end

local v1 = Vector3(2, 3, 4)
local v2 = Vector3(1, 2, 3)

local v3 = (v1 + v2)

print("v1 + v2 = " .. v3:toString())