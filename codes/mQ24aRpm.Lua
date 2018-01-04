-- Made by fabuss254

local start_point = Vector3.new(187,10,175)
local end_point = Vector3.new(-191,164,-176)

local p1 = Vector3.new(
        math.min(start_point.X, end_point.X),
        math.min(start_point.Y, end_point.Y),
        math.min(start_point.Z, end_point.Z)
    )
local p2 = Vector3.new(
        math.max(start_point.X, end_point.X),
        math.max(start_point.Y, end_point.Y),
        math.max(start_point.Z, end_point.Z)
    )

function highlightModel(objObject, color)
local v = objObject
local bHA=Instance.new('BoxHandleAdornment',v)
bHA.Adornee=v
bHA.Size= v.Size
bHA.Color3= color or Color3.new(255,255,255)
bHA.Transparency=.5
bHA.ZIndex=1
bHA.AlwaysOnTop=true
end

function unHighlightModel(objObject)
objObject.BoxHandleAdornment:Destroy()
end

for _,gg in pairs(game.Workspace.Gold:GetChildren()) do
	if gg.Position.X > p1.X and gg.Position.Y > p1.Y and gg.Position.Z > p1.Z and gg.Position.X < p2.X and gg.Position.Y < p2.Y and gg.Position.Z < p2.Z then
		gg.CFrame = game.Players.LocalPlayer.Character.LeftFoot.CFrame
		wait()
	end
end