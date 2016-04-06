local Players = game:GetService("Players")
local Player = Players.LocalPlayer
repeat
	wait()
until Player.Character and Player.Character:IsDescendantOf(workspace)
local Character = Player.Character
local Mouse = Player:GetMouse()

local lastSelected
local Selected = false


Mouse.Move:connect(function()
	local Target = Mouse.Target
	if Target and Target:IsA("Part") then
		if Selected == false then
			if lastSelected then
				lastSelected:Destroy()
			end
			lastSelected = Instance.new("SelectionBox")
			lastSelected.Adornee = Target
			lastSelected.Parent = Target
		end
	end
end)

Mouse.Button1Down:connect(function()
	local Target = Mouse.Target
	if Target and Target.Name ~= "Base" or Target.Name ~= "Baseplate" then
		Selected = true
	else		
		Selected = false
	end
end)