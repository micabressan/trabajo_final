--MADE BY OneLegend (NOT THE SCRIPT) Thanks to CyberFromLU for letting me Publish! REGULAR SCRIPT: Go to line 3 and 1607 put your name where it says "YOUR NAME HERE"
-------------------------------------------------------------------
Player = script:FindFirstChild("Player") ~= nil and script.Player.Value or game:GetService("Players"):FindFirstChild("robnot29") --Replace my name with yours for the RPG to work.
Name = "robnot29" --Sets name of the RPG.
selected = true
canDual = false
dual = false
Button1Down = false
damage = 100 --Sets damage also.
canFire = true
canFire2 = false
readyTime = 0.5
automatic = false
burst = false
burstCount = 0
burstCountMax = 3
canSilence = false
silenced = false
canZoom = true
zoom = false
switchToSingle = true
switchToBurst = true
switchToAutomatic = false


ammoGui = Instance.new("ScreenGui")
ammoGui.Name = Name
local frame = Instance.new("Frame")
frame.Name = "Frame"
frame.Size = UDim2.new(0, 165, 0, 60)
frame.Position = UDim2.new(0, 0, 1, -60)
frame.BackgroundColor3 = Color3.new(1, 1, 1)
frame.BorderColor3 = Color3.new(0, 0, 0)
frame.Parent = ammoGui
local label = Instance.new("TextLabel")
label.Name = "Weapon"
label.Text = "Weapon: " ..Name
label.Size = UDim2.new(1, 0, 0, 20)
label.Position = UDim2.new(0, 0, 0, 0)
label.BackgroundColor3 = Color3.new(1, 0, 0)
label.BorderColor3 = Color3.new(0, 0, 0)
label.Parent = frame
local label = Instance.new("TextLabel")
label.Name = "MagazinePrefix"
label.Text = "    Magazine:"
label.TextXAlignment = "Left"
label.Size = UDim2.new(1, 0, 0, 20)
label.Position = UDim2.new(0, 0, 0, 20)
label.BackgroundColor3 = Color3.new(1, 1, 1)
label.BorderColor3 = Color3.new(0, 0, 0)
label.Parent = frame
local label = Instance.new("TextLabel")
label.Name = "Magazine"
label.Text = "0/0"
label.TextXAlignment = "Right"
label.Size = UDim2.new(1, 0, 0, 20)
label.Position = UDim2.new(0, -10, 0, 20)
label.BackgroundTransparency = 1
label.BorderSizePixel = 0
label.Parent = frame
local label = Instance.new("TextLabel")
label.Name = "AmmoPrefix"
label.Text = "    Ammunition:"
label.TextXAlignment = "Left"
label.Size = UDim2.new(1, 0, 0, 20)
label.Position = UDim2.new(0, 0, 0, 40)
label.BackgroundColor3 = Color3.new(1, 1, 1)
label.BorderColor3 = Color3.new(0, 0, 0)
label.Parent = frame
local label = Instance.new("TextLabel")
label.Name = "Ammo"
label.Text = "0/0"
label.TextXAlignment = "Right"
label.Size = UDim2.new(1, 0, 0, 20)
label.Position = UDim2.new(0, -10, 0, 40)
label.BackgroundTransparency = 1
label.BorderSizePixel = 0
label.Parent = frame


function updateGui()
	if selected == false then return end
	if Player:FindFirstChild("PlayerGui") == nil then Instance.new("PlayerGui").Parent = Player end
	if Player.PlayerGui:FindFirstChild(Name) == nil then
		ammoGui:Clone().Parent = Player.PlayerGui
	end
	Player.PlayerGui[Name].Frame.Magazine.Text = tostring(magazine.Value).. "/" ..tostring(magazineMax.Value)
	Player.PlayerGui[Name].Frame.Ammo.Text = tostring(ammo.Value).. "/" ..tostring(ammoMax.Value)
end


function makeParts(format)
	local model = Instance.new("Model")
	model.Name = Name
	local pm = Instance.new("Part")
	pm.Name = "Handle"
	pm.FormFactor = "Custom"
	pm.Size = Vector3.new(1, 1, 1)
	pm.BrickColor = BrickColor.new("Black")
	pm.Locked = true
	pm.TopSurface = 0
	pm.BottomSurface = 0
	pm.Parent = model
	local m = Instance.new("CylinderMesh")
	m.Scale = Vector3.new(0.35, 1.5, 0.35)
	m.Parent = pm
	if format ~= nil then
		local w = Instance.new("Weld")
		w.Part0 = pm
		if format == "RightHand" then
			w.Part1 = Player.Character:FindFirstChild("Right Arm")
			w.C0 = CFrame.new(0, 1.5, 0.75)
			w.C1 = CFrame.new()
		elseif format == "RightHolster" then
			w.Part1 = Player.Character:FindFirstChild("Torso")
			w.C0 = CFrame.new(-0.65, 1, 0) * CFrame.fromEulerAnglesXYZ(math.rad(185), math.rad(90), 0)
			w.C1 = CFrame.new()
			model.Name = Name.. " (Holstered)"
		end
		w.Parent = pm
		model.Parent = Player.Character
	end
	--[[
	sniper1  http://www.roblox.com/Asset/?id=1868836
	equip    http://www.roblox.com/Asset/?id=13510737
	fire1     http://www.roblox.com/Asset/?id=2760979
	fire2    http://www.roblox.com/Asset/?id=13510352
	fire3    http://www.roblox.com/Asset/?id=2692806
	fire4    http://www.roblox.com/Asset/?id=2691586
	fire5    http://www.roblox.com/Asset/?id=2920959
	fire6    http://www.roblox.com/Asset/?id=2697431
	fire7    http://www.roblox.com/Asset/?id=2920959
	reload1   http://www.roblox.com/Asset/?id=2691591
	reload2   http://www.roblox.com/Asset/?id=2697432
	reload3  http://www.roblox.com/Asset/?id=2920960
	reload4  http://www.roblox.com/Asset/?id=2761842
	shotgun1 http://www.roblox.com/Asset/?id=2697294
	--]]
	local s = Instance.new("Sound")
	s.Name = "Equip"
	s.SoundId = "http://www.roblox.com/Asset/?id=10209881"
	s.Volume = 1
	s.Pitch = 1
	s.Looped = false
	s.Parent = pm
	local s = Instance.new("Sound")
	s.Name = "Fire"
	s.SoundId = "rbxasset://sounds/Shoulder fired rocket.wav"
	s.Volume = 1
	s.Pitch = 1.25
	s.Looped = false
	s.Parent = pm
	local s = Instance.new("Sound")
	s.Name = "Reload"
	s.SoundId = "http://www.roblox.com/Asset/?id=2691591"
	s.Volume = 1
	s.Pitch = 1.25
	s.Looped = false
	s.Parent = pm
	local s = Instance.new("Sound")
	s.Name = "Empty"
	s.SoundId = "http://www.roblox.com/Asset/?id=2697295"
	s.Volume = 1
	s.Pitch = 5
	s.Looped = false
	s.Parent = pm
	local s = Instance.new("Sound")
	s.Name = "Switch"
	s.SoundId = "http://www.roblox.com/Asset/?id=2697295"
	s.Volume = 1
	s.Pitch = 10
	s.Looped = false
	s.Parent = pm
	local p = Instance.new("Part")
	p.Name = "Grip / Trigger Housing"
	p.FormFactor = "Custom"
	p.Size = Vector3.new(1, 1, 1)
	p.BrickColor = BrickColor.new("Black")
	p.Locked = true
	p.TopSurface = 0
	p.BottomSurface = 0
	p.Parent = model
	local m = Instance.new("SpecialMesh")
	m.MeshType = "Brick"
	m.Scale = Vector3.new(0.29, 0.75, 0.1)
	m.Parent = p
	local w = Instance.new("Weld")
	w.Part0 = p
	w.Part1 = pm
	w.C0 = CFrame.new(0, -0.2, -0.15)
	w.C1 = CFrame.new()
	w.Parent = p
	local p = Instance.new("Part")
	p.Name = "Grip 1"
	p.FormFactor = "Custom"
	p.Size = Vector3.new(1, 1, 1)
	p.BrickColor = BrickColor.new("Black")
	p.Locked = true
	p.TopSurface = 0
	p.BottomSurface = 0
	p.Parent = model
	local m = Instance.new("SpecialMesh")
	m.MeshType = "Brick"
	m.Scale = Vector3.new(0.29, 0.35, 0.9)
	m.Parent = p
	local w = Instance.new("Weld")
	w.Part0 = p
	w.Part1 = pm
	w.C0 = CFrame.new(0, -0.4, -0.65)
	w.C1 = CFrame.new()
	w.Parent = p
	local p = Instance.new("Part")
	p.Name = "Grip 2"
	p.FormFactor = "Custom"
	p.Size = Vector3.new(1, 1, 1)
	p.BrickColor = BrickColor.new("Reddish brown")
	p.Material = "Wood"
	p.Locked = true
	p.TopSurface = 0
	p.BottomSurface = 0
	p.Parent = model
	local m = Instance.new("SpecialMesh")
	m.MeshType = "Brick"
	m.Scale = Vector3.new(0.29, 0.35, 0.8)
	m.Parent = p
	local w = Instance.new("Weld")
	w.Part0 = p
	w.Part1 = pm
	w.C0 = CFrame.new(0, -1.1, -0.575)
	w.C1 = CFrame.new()
	w.Parent = p
	local p = Instance.new("Part")
	p.Name = "Trigger Housing 1"
	p.FormFactor = "Custom"
	p.Size = Vector3.new(1, 1, 1)
	p.BrickColor = BrickColor.new("Black")
	p.Locked = true
	p.TopSurface = 0
	p.BottomSurface = 0
	p.Parent = model
	local m = Instance.new("SpecialMesh")
	m.MeshType = "Brick"
	m.Scale = Vector3.new(0.1, 0.25, 0.025)
	m.Parent = p
	local w = Instance.new("Weld")
	w.Part0 = p
	w.Part1 = pm
	w.C0 = CFrame.new(0, -0.1, -0.5)
	w.C1 = CFrame.new()
	w.Parent = p
	local p = Instance.new("Part")
	p.Name = "Trigger Housing 2"
	p.FormFactor = "Custom"
	p.Size = Vector3.new(1, 1, 1)
	p.BrickColor = BrickColor.new("Black")
	p.Locked = true
	p.TopSurface = 0
	p.BottomSurface = 0
	p.Parent = model
	local m = Instance.new("SpecialMesh")
	m.MeshType = "Brick"
	m.Scale = Vector3.new(0.1, 0.025, 0.3)
	m.Parent = p
	local w = Instance.new("Weld")
	w.Part0 = p
	w.Part1 = pm
	w.C0 = CFrame.new(0, 0.01, -0.35)
	w.C1 = CFrame.new()
	w.Parent = p
	local p = Instance.new("Part")
	p.Name = "Trigger"
	p.FormFactor = "Custom"
	p.Size = Vector3.new(1, 1, 1)
	p.BrickColor = BrickColor.new("Black")
	p.Locked = true
	p.TopSurface = 0
	p.BottomSurface = 0
	p.Parent = model
	local m = Instance.new("SpecialMesh")
	m.MeshType = "Brick"
	m.Scale = Vector3.new(0.1, 0.05, 0.15)
	m.Parent = p
	local w = Instance.new("Weld")
	w.Part0 = p
	w.Part1 = pm
	w.C0 = CFrame.new(0, -0.11, -0.275)
	w.C1 = CFrame.new()
	w.Parent = p
	local p = Instance.new("Part")
	p.Name = "Center 1"
	p.FormFactor = "Custom"
	p.Size = Vector3.new(1, 1, 1)
	p.BrickColor = BrickColor.new("Black")
	p.Locked = true
	p.TopSurface = 0
	p.BottomSurface = 0
	p.Parent = model
	local m = Instance.new("CylinderMesh")
	m.Scale = Vector3.new(0.4, 0.5, 0.4)
	m.Parent = p
	local w = Instance.new("Weld")
	w.Part0 = p
	w.Part1 = pm
	w.C0 = CFrame.new(0, -1, 0)
	w.C1 = CFrame.new()
	w.Parent = p
	local p = Instance.new("Part")
	p.Name = "Center 2"
	p.FormFactor = "Custom"
	p.Size = Vector3.new(1, 1, 1)
	p.BrickColor = BrickColor.new("Reddish brown")
	p.Material = "Wood"
	p.Locked = true
	p.TopSurface = 0
	p.BottomSurface = 0
	p.Parent = model
	local m = Instance.new("CylinderMesh")
	m.Scale = Vector3.new(0.45, 1, 0.45)
	m.Parent = p
	local w = Instance.new("Weld")
	w.Part0 = p
	w.Part1 = pm
	w.C0 = CFrame.new(0, -1.75, 0)
	w.C1 = CFrame.new()
	w.Parent = p
	local p = Instance.new("Part")
	p.Name = "Center 3"
	p.FormFactor = "Custom"
	p.Size = Vector3.new(1, 1, 1)
	p.BrickColor = BrickColor.new("Reddish brown")
	p.Material = "Wood"
	p.Locked = true
	p.TopSurface = 0
	p.BottomSurface = 0
	p.Parent = model
	local m = Instance.new("SpecialMesh")
	m.MeshType = "FileMesh"
	m.MeshId = "http://www.roblox.com/Asset/?id=1778999"
	m.Scale = Vector3.new(0.335, 0.45, 0.335)
	m.Parent = p
	local w = Instance.new("Weld")
	w.Part0 = p
	w.Part1 = pm
	w.C0 = CFrame.new(0, -2.6225, 0)
	w.C1 = CFrame.new()
	w.Parent = p
	local p = Instance.new("Part")
	p.Name = "Center 4"
	p.FormFactor = "Custom"
	p.Size = Vector3.new(1, 1, 1)
	p.BrickColor = BrickColor.new("Reddish brown")
	p.Material = "Wood"
	p.Locked = true
	p.TopSurface = 0
	p.BottomSurface = 0
	p.Parent = model
	local m = Instance.new("CylinderMesh")
	m.Scale = Vector3.new(0.325, 1.25, 0.325)
	m.Parent = p
	local w = Instance.new("Weld")
	w.Part0 = p
	w.Part1 = pm
	w.C0 = CFrame.new(0, -3, 0)
	w.C1 = CFrame.new()
	w.Parent = p
	local p = Instance.new("Part")
	p.Name = "End 1"
	p.FormFactor = "Custom"
	p.Size = Vector3.new(1, 1, 1)
	p.BrickColor = BrickColor.new("Black")
	p.CanCollide = false
	p.Locked = true
	p.TopSurface = 0
	p.BottomSurface = 0
	p.Parent = model
	local m = Instance.new("CylinderMesh")
	m.Scale = Vector3.new(0.31, 0.1, 0.31)
	m.Parent = p
	local w = Instance.new("Weld")
	w.Part0 = p
	w.Part1 = pm
	w.C0 = CFrame.new(0, -3.625, 0)
	w.C1 = CFrame.new()
	w.Parent = p
	local p = Instance.new("Part")
	p.Name = "End 2"
	p.FormFactor = "Custom"
	p.Size = Vector3.new(1, 1, 1)
	p.BrickColor = BrickColor.new("Black")
	p.CanCollide = false
	p.Locked = true
	p.TopSurface = 0
	p.BottomSurface = 0
	p.Parent = model
	local m = Instance.new("SpecialMesh")
	m.MeshType = "FileMesh"
	m.MeshId = "http://www.roblox.com/Asset/?id=1778999"
	m.Scale = Vector3.new(0.425, 0.875, 0.425)
	m.Parent = p
	local w = Instance.new("Weld")
	w.Part0 = p
	w.Part1 = pm
	w.C0 = CFrame.new(0, 3.61, 0) * CFrame.fromEulerAnglesXYZ(math.rad(180), 0, 0)
	w.C1 = CFrame.new()
	w.Parent = p
	local f = Instance.new("Fire")
	f.Enabled = false
	f.Name = "Fire"
	f.Color = Color3.new(1, 0.5, 0)
	f.SecondaryColor = Color3.new(1, 0.75, 0.5)
	f.Heat = -25
	f.Size = 5
	f.Parent = p
	local s = Instance.new("Smoke")
	s.Enabled = false
	s.Name = "Smoke"
	s.Opacity = 0.5
	s.Color = Color3.new(0.8, 0.8, 0.8)
	s.RiseVelocity = -10
	s.Size = 5
	s.Parent = p
	local p = Instance.new("Part")
	p.Name = "Muzzle"
	p.FormFactor = "Custom"
	p.Size = Vector3.new(1, 1, 1)
	p.Transparency = 1
	p.CanCollide = false
	p.Locked = true
	p.Parent = model
	local w = Instance.new("Weld")
	w.Part0 = p
	w.Part1 = pm
	w.C0 = CFrame.new(0, 0.26, 0)
	w.C1 = CFrame.new()
	w.Parent = p
	local f = Instance.new("Fire")
	f.Enabled = false
	f.Name = "Fire"
	f.Color = Color3.new(1, 0.5, 0)
	f.SecondaryColor = Color3.new(1, 0.75, 0.5)
	f.Heat = -25
	f.Size = 2.5
	f.Parent = p
	local s = Instance.new("Smoke")
	s.Enabled = false
	s.Name = "Smoke"
	s.Opacity = 0.3
	s.Color = Color3.new(0.8, 0.8, 0.8)
	s.RiseVelocity = -10
	s.Size = 2.5
	s.Parent = p
	local pm2 = Instance.new("Part")
	if magazine.Value <= 0 then pm2.Transparency = 1 end
	pm2.Name = "Projectile"
	pm2.FormFactor = "Custom"
	pm2.Size = Vector3.new(1, 1, 1)
	pm2.BrickColor = BrickColor.new("Bright red")
	pm2.CanCollide = false
	pm2.Locked = true
	pm2.TopSurface = 0
	pm2.BottomSurface = 0
	pm2.Parent = model
	local m = Instance.new("CylinderMesh")
	m.Scale = Vector3.new(0.2, 1, 0.2)
	m.Parent = pm2
	local w = Instance.new("Weld")
	w.Part0 = pm2
	w.Part1 = pm
	w.C0 = CFrame.new(0, 0.3, 0)
	w.C1 = CFrame.new()
	w.Parent = pm2
	local f = Instance.new("Fire")
	f.Enabled = false
	f.Name = "Fire"
	f.Color = Color3.new(1, 0.5, 0)
	f.SecondaryColor = Color3.new(1, 0.75, 0.5)
	f.Heat = 25
	f.Size = 1
	f.Parent = pm2
	local s = Instance.new("Smoke")
	s.Enabled = false
	s.Name = "Smoke"
	s.Opacity = 0.25
	s.Color = Color3.new(0.8, 0.8, 0.8)
	s.RiseVelocity = 10
	s.Size = 5
	s.Parent = pm2
	local p = Instance.new("Part")
	if magazine.Value <= 0 then p.Transparency = 1 end
	p.Name = "Projectile Center 1"
	p.FormFactor = "Custom"
	p.Size = Vector3.new(1, 1, 1)
	p.BrickColor = BrickColor.new("Bright red")
	p.CanCollide = false
	p.Locked = true
	p.TopSurface = 0
	p.BottomSurface = 0
	p.Parent = model
	local m = Instance.new("SpecialMesh")
	m.MeshType = "FileMesh"
	m.MeshId = "http://www.roblox.com/Asset/?id=1033714" --http://www.roblox.com/Asset/?id=1778999
	m.Scale = Vector3.new(0.25, 1.25, 0.25)
	m.Parent = p
	local w = Instance.new("Weld")
	w.Part0 = p
	w.Part1 = pm2
	w.C0 = CFrame.new(0, 0.65, 0)
	w.C1 = CFrame.new()
	w.Parent = p
	local p = Instance.new("Part")
	if magazine.Value <= 0 then p.Transparency = 1 end
	p.Name = "Projectile Center 2"
	p.FormFactor = "Custom"
	p.Size = Vector3.new(1, 1, 1)
	p.BrickColor = BrickColor.new("Bright red")
	p.CanCollide = false
	p.Locked = true
	p.TopSurface = 0
	p.BottomSurface = 0
	p.Parent = model
	local m = Instance.new("SpecialMesh")
	m.MeshType = "FileMesh"
	m.MeshId = "http://www.roblox.com/Asset/?id=1033714" --http://www.roblox.com/Asset/?id=1778999
	m.Scale = Vector3.new(0.25, 1.1, 0.25)
	m.Parent = p
	local w = Instance.new("Weld")
	w.Part0 = p
	w.Part1 = pm2
	w.C0 = CFrame.new(0, -1.53, 0) * CFrame.fromEulerAnglesXYZ(math.rad(180), 0, 0)
	w.C1 = CFrame.new()
	w.Parent = p
	local p = Instance.new("Part")
	if magazine.Value <= 0 then p.Transparency = 1 end
	p.Name = "Projectile Tip"
	p.FormFactor = "Custom"
	p.Size = Vector3.new(1, 1, 1)
	p.BrickColor = BrickColor.new("Bright red")
	p.CanCollide = false
	p.Locked = true
	p.TopSurface = 0
	p.BottomSurface = 0
	p.Parent = model
	local m = Instance.new("CylinderMesh")
	m.Scale = Vector3.new(0.1, 0.1, 0.1)
	m.Parent = p
	local w = Instance.new("Weld")
	w.Part0 = p
	w.Part1 = pm2
	w.C0 = CFrame.new(0, 1.89, 0)
	w.C1 = CFrame.new()
	w.Parent = p
	return model
end


function removeParts(format)
	if format == "RightHand" then
		pcall(function() Player.Character[Name]:Remove() end)
	elseif format == "LeftHand" then
		pcall(function() Player.Character[Name.. " (Left)"]:Remove() end)
	elseif format == "RightHolster" then
		pcall(function() Player.Character[Name.. " (Holstered)"]:Remove() end)
	elseif format == "LeftHolster" then
		pcall(function() Player.Character[Name.. " (Holstered, Left)"]:Remove() end)
	end
end


function SetAngle(Joint, Angle, Character)
	if Character == nil then return false end
	local Joints = {
		Character.Torso:FindFirstChild("Right Shoulder 2"),
		Character.Torso:FindFirstChild("Left Shoulder 2"),
		Character.Torso:FindFirstChild("Right Hip 2"),
		Character.Torso:FindFirstChild("Left Hip 2")
	}
	if Joints[Joint] == nil then return false end
	if Joint == 1 or Joint == 3 then
		Joints[Joint].DesiredAngle = Angle
	end
	if Joint == 2 or Joint == 4 then
		Joints[Joint].DesiredAngle = -Angle
	end
end


function ForceAngle(Joint, Angle, Character)
	if Character == nil then return false end
	local Joints = {
		Character.Torso:FindFirstChild("Right Shoulder 2"),
		Character.Torso:FindFirstChild("Left Shoulder 2"),
		Character.Torso:FindFirstChild("Right Hip 2"),
		Character.Torso:FindFirstChild("Left Hip 2")
	}
	if Joints[Joint] == nil then return false end
	if Joint == 1 or Joint == 3 then
		Joints[Joint].DesiredAngle = Angle
		Joints[Joint].CurrentAngle = Angle
	end
	if Joint == 2 or Joint == 4 then
		Joints[Joint].DesiredAngle = -Angle
		Joints[Joint].CurrentAngle = -Angle
	end
end


function SetSpeed(Joint, Speed, Character)
	if Character == nil then return false end
	local Joints = {
		Character.Torso:FindFirstChild("Right Shoulder 2"),
		Character.Torso:FindFirstChild("Left Shoulder 2"),
		Character.Torso:FindFirstChild("Right Hip 2"),
		Character.Torso:FindFirstChild("Left Hip 2")
	}
	if Joints[Joint] == nil then return false end
	Joints[Joint].MaxVelocity = Speed
end


function DisableLimb(Limb, Character)
	if Character == nil then return false end
	if Character:FindFirstChild("Torso") == nil then return false end
	local Joints = {
		Character.Torso:FindFirstChild("Right Shoulder"),
		Character.Torso:FindFirstChild("Left Shoulder"),
		Character.Torso:FindFirstChild("Right Hip"),
		Character.Torso:FindFirstChild("Left Hip")
	}
	local Limbs = {
		Character:FindFirstChild("Right Arm"),
		Character:FindFirstChild("Left Arm"),
		Character:FindFirstChild("Right Leg"),
		Character:FindFirstChild("Left Leg")
	}
	if Joints[Limb] == nil then return false end
	if Limbs[Limb] == nil then return false end
	local Joint = Instance.new("Motor")
	Joint.Parent = Character.Torso
	Joint.Part0 = Character.Torso
	Joint.Part1 = Limbs[Limb]
	if Limb == 1 then
		Joint.C0 = CFrame.new(1.5, 0.5, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(90), 0)
		Joint.C1 = CFrame.new(0, 0.5, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(90), 0)
		Joint.Name = "Right Shoulder 2"
	elseif Limb == 2 then
		Joint.C0 = CFrame.new(-1.5, 0.5, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(-90), 0)
		Joint.C1 = CFrame.new(0, 0.5, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(-90), 0)
		Joint.Name = "Left Shoulder 2"
	elseif Limb == 3 then
		Joint.C0 = CFrame.new(0.5, -1, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(90), 0)
		Joint.C1 = CFrame.new(0, 1, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(90), 0)
		Joint.Name = "Right Hip 2"
	elseif Limb == 4 then
		Joint.C0 = CFrame.new(-0.5, -1, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(-90), 0)
		Joint.C1 = CFrame.new(0, 1, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(-90), 0)
		Joint.Name = "Left Hip 2"
	end
	Joint.MaxVelocity = Joints[Limb].MaxVelocity
	Joint.CurrentAngle = Joints[Limb].CurrentAngle
	Joint.DesiredAngle = Joints[Limb].DesiredAngle
	Joints[Limb]:Remove()
end


function ResetLimbCFrame(Limb, Character)
	if Character == nil then return false end
	if Character.Parent == nil then return false end
	if Character:FindFirstChild("Torso") == nil then return false end
	local Joints = {
		Character.Torso:FindFirstChild("Right Shoulder 2"),
		Character.Torso:FindFirstChild("Left Shoulder 2"),
		Character.Torso:FindFirstChild("Right Hip 2"),
		Character.Torso:FindFirstChild("Left Hip 2")
	}
	local Limbs = {
		Character:FindFirstChild("Right Arm"),
		Character:FindFirstChild("Left Arm"),
		Character:FindFirstChild("Right Leg"),
		Character:FindFirstChild("Left Leg")
	}
	if Joints[Limb] == nil then return false end
	if Limbs[Limb] == nil then return false end
	if Limb == 1 then
		Joints[Limb].C0 = CFrame.new(1.5, 0.5, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(90), 0)
		Joints[Limb].C1 = CFrame.new(0, 0.5, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(90), 0)
	elseif Limb == 2 then
		Joints[Limb].C0 = CFrame.new(-1.5, 0.5, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(-90), 0)
		Joints[Limb].C1 = CFrame.new(0, 0.5, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(-90), 0)
	elseif Limb == 3 then
		Joints[Limb].C0 = CFrame.new(0.5, -1, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(90), 0)
		Joints[Limb].C1 = CFrame.new(0, 1, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(90), 0)
	elseif Limb == 4 then
		Joints[Limb].C0 = CFrame.new(-0.5, -1, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(-90), 0)
		Joints[Limb].C1 = CFrame.new(0, 1, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(-90), 0)
	end
end


function EnableLimb(Limb, Character)
	if Character == nil then return false end
	if Character:FindFirstChild("Torso") == nil then return false end
	local Joints = {
		Character.Torso:FindFirstChild("Right Shoulder 2"),
		Character.Torso:FindFirstChild("Left Shoulder 2"),
		Character.Torso:FindFirstChild("Right Hip 2"),
		Character.Torso:FindFirstChild("Left Hip 2")
	}
	local Limbs = {
		Character:FindFirstChild("Right Arm"),
		Character:FindFirstChild("Left Arm"),
		Character:FindFirstChild("Right Leg"),
		Character:FindFirstChild("Left Leg")
	}
	if Joints[Limb] == nil then return false end
	if Limbs[Limb] == nil then return false end
	if Limb == 1 then
		Joints[Limb].Name = "Right Shoulder"
	elseif Limb == 2 then
		Joints[Limb].Name = "Left Shoulder"
	elseif Limb == 3 then
		Joints[Limb].Name = "Right Hip"
	elseif Limb == 4 then
		Joints[Limb].Name = "Left Hip"
	end
	Animate = Character:FindFirstChild("Animate")
	if Animate == nil then return false end
	Animate = Animate:Clone()
	Character.Animate:Remove()
	Animate.Parent = Character
end


function playAnimation(format, mouse)
	if format == "equip" then
		coroutine.resume(coroutine.create(function()
			for i = 0, 1, 0.025 do
				if Player.Character:FindFirstChild("Torso") ~= nil then
					if Player.Character.Torso:FindFirstChild("Left Shoulder 2") ~= nil and Player.Character.Torso:FindFirstChild("Right Shoulder 2") ~= nil then
						Player.Character.Torso["Left Shoulder 2"].C0 = CFrame.new(-1.5, 0.5, 0) * CFrame.fromEulerAnglesXYZ(math.rad(90) * i, 0, math.rad(67.5) * i)
						Player.Character.Torso["Left Shoulder 2"].C1 = CFrame.new(0, 0.5 * (1 - i), 0) * CFrame.new(0, 1.85 * i, 0)
					else return false end
				else return false end
				wait()
			end
		end))
		for i = 0, 1, 0.05 do
			if Player.Character:FindFirstChild("Torso") ~= nil then
				if Player.Character.Torso:FindFirstChild("Left Shoulder 2") ~= nil and Player.Character.Torso:FindFirstChild("Right Shoulder 2") ~= nil then
					Player.Character.Torso["Right Shoulder 2"].C0 = CFrame.new(1.5, 0.5, -0.25 * i) * CFrame.fromEulerAnglesXYZ(math.rad(-90) * i, 0, math.rad(-20) * i)
					Player.Character.Torso["Right Shoulder 2"].C1 = CFrame.new(0, 0.5, 0)
				else return false end
			else return false end
			wait()
		end
		removeParts("RightHolster")
		makeParts("RightHand")
		for i = 0, 1, 0.05 do
			if Player.Character:FindFirstChild("Torso") ~= nil then
				if Player.Character.Torso:FindFirstChild("Left Shoulder 2") ~= nil and Player.Character.Torso:FindFirstChild("Right Shoulder 2") ~= nil then
					Player.Character.Torso["Right Shoulder 2"].C0 = CFrame.new(1.5 * (1 - i), 0.5 * (1 - i), -0.25 * (1 - i)) * CFrame.fromEulerAnglesXYZ(math.rad(-90) * (1 - i), 0, math.rad(-20) * (1 - i)) * CFrame.new(1.25 * i, 0.5 * i, 0) * CFrame.fromEulerAnglesXYZ(math.rad(90) * i, 0, 0)
					Player.Character.Torso["Right Shoulder 2"].C1 = CFrame.new(0, 0.5 * (1 - i), 0) * CFrame.new(0, 0.75 * i, 0.1 * i)
				else return false end
			else return false end
			if Player.Character:FindFirstChild(Name) ~= nil then
				if Player.Character[Name]:FindFirstChild("Handle") ~= nil then
					Player.Character[Name].Handle.Weld.C0 = CFrame.new(0, 1.5, 0.75)
					Player.Character[Name].Handle.Weld.C1 = CFrame.fromEulerAnglesXYZ(math.rad(-90) * (1 - i), 0, 0)
				else return false end
			else return false end
			wait()
		end
		makeParts("RightHolster")
		removeParts("RightHand")
		return playAnimation("hold")
	end
	if format == "unequip" then
		coroutine.resume(coroutine.create(function()
			for i = 1, 0, -0.025 do
				if Player.Character:FindFirstChild("Torso") ~= nil then
					if Player.Character.Torso:FindFirstChild("Left Shoulder 2") ~= nil and Player.Character.Torso:FindFirstChild("Right Shoulder 2") ~= nil then
						Player.Character.Torso["Left Shoulder 2"].C0 = CFrame.new(-1.5, 0.5, 0) * CFrame.fromEulerAnglesXYZ(math.rad(90) * i, 0, math.rad(67.5) * i)
						Player.Character.Torso["Left Shoulder 2"].C1 = CFrame.new(0, 0.5 * (1 - i), 0) * CFrame.new(0, 1.85 * i, 0)
					else return false end
				else return false end
				wait()
			end
		end))
		for i = 1, 0, -0.05 do
			if Player.Character:FindFirstChild("Torso") ~= nil then
				if Player.Character.Torso:FindFirstChild("Left Shoulder 2") ~= nil and Player.Character.Torso:FindFirstChild("Right Shoulder 2") ~= nil then
					Player.Character.Torso["Right Shoulder 2"].C0 = CFrame.new(1.5 * (1 - i), 0.5 * (1 - i), -0.25 * (1 - i)) * CFrame.fromEulerAnglesXYZ(math.rad(-90) * (1 - i), 0, math.rad(-20) * (1 - i)) * CFrame.new(1.25 * i, 0.5 * i, 0) * CFrame.fromEulerAnglesXYZ(math.rad(90) * i, 0, 0)
					Player.Character.Torso["Right Shoulder 2"].C1 = CFrame.new(0, 0.5 * (1 - i), 0) * CFrame.new(0, 0.75 * i, 0.1 * i)
				else return false end
			else return false end
			if Player.Character:FindFirstChild(Name) ~= nil then
				if Player.Character[Name]:FindFirstChild("Handle") ~= nil then
					Player.Character[Name].Handle.Weld.C0 = CFrame.new(0, 1.5, 0.75)
					Player.Character[Name].Handle.Weld.C1 = CFrame.fromEulerAnglesXYZ(math.rad(-90) * (1 - i), 0, 0)
				else return false end
			else return false end
			wait()
		end
		makeParts("RightHolster")
		removeParts("RightHand")
		for i = 1, 0, -0.05 do
			if Player.Character:FindFirstChild("Torso") ~= nil then
				if Player.Character.Torso:FindFirstChild("Left Shoulder 2") ~= nil and Player.Character.Torso:FindFirstChild("Right Shoulder 2") ~= nil then
					Player.Character.Torso["Right Shoulder 2"].C0 = CFrame.new(1.5, 0.5, -0.25 * i) * CFrame.fromEulerAnglesXYZ(math.rad(-90) * i, 0, math.rad(-20) * i)
					Player.Character.Torso["Right Shoulder 2"].C1 = CFrame.new(0, 0.5, 0)
				else return false end
			else return false end
			wait()
		end
		removeParts("RightHolster")
		makeParts("RightHand")
		return true
	end
	if format == "hold" then
		if Player.Character:FindFirstChild("Torso") ~= nil then
			if Player.Character.Torso:FindFirstChild("Left Shoulder 2") ~= nil and Player.Character.Torso:FindFirstChild("Right Shoulder 2") ~= nil then
				Player.Character.Torso["Left Shoulder 2"].C0 = CFrame.new(-1.5, 0.5, 0) * CFrame.fromEulerAnglesXYZ(math.rad(90), 0, math.rad(67.5))
				Player.Character.Torso["Left Shoulder 2"].C1 = CFrame.new(0, 1.85, 0)
				Player.Character.Torso["Right Shoulder 2"].C0 = CFrame.new(1.25, 0.5, 0) * CFrame.fromEulerAnglesXYZ(math.rad(90), 0, 0)
				Player.Character.Torso["Right Shoulder 2"].C1 =  CFrame.new(0, 0.75, 0.1)
			else return false end
		else return false end
	end
	if format == "reload" then
		Player.Character[Name].Handle.Reload.Volume = 0
		Player.Character[Name].Handle.Reload.Pitch = 1.78
		Player.Character[Name].Handle.Reload:Play()
		coroutine.resume(coroutine.create(function()
			for i = 0, 1, 0.06 do
				if Player.Character:FindFirstChild("Torso") ~= nil and Player.Character:FindFirstChild(Name) ~= nil then
					if Player.Character.Torso:FindFirstChild("Right Shoulder 2") ~= nil and Player.Character[Name]:FindFirstChild("Handle") ~= nil then
						Player.Character.Torso["Right Shoulder 2"].C0 = CFrame.new(1.25 + i / 10, 0.5, 0) * CFrame.fromEulerAnglesXYZ(math.rad(90), 0, math.rad(i * 90))
						Player.Character.Torso["Right Shoulder 2"].C1 = CFrame.new(0, 0.75, 0.1)
						Player.Character[Name].Handle.Weld.C1 = CFrame.new(0, -1.4 * i, 0) * CFrame.fromEulerAnglesXYZ(0, 0, math.rad(-i * 170))
					end
				end
				wait()
			end
		end))
		for i = 1, 0, -0.1 do
			if Player.Character:FindFirstChild("Torso") ~= nil then
				if Player.Character.Torso:FindFirstChild("Left Shoulder 2") ~= nil and Player.Character.Torso:FindFirstChild("Right Shoulder 2") ~= nil then
					Player.Character.Torso["Left Shoulder 2"].C0 = CFrame.new(-1.5, 0.5, 0) * CFrame.fromEulerAnglesXYZ(math.rad(90) * i, 0, math.rad(67.5) * i)
					Player.Character.Torso["Left Shoulder 2"].C1 = CFrame.new(0, 0.5 * (1 - i), 0) * CFrame.new(0, 1.85 * i, 0)
				else return false end
			else return false end
			wait()
		end
		local projectile = Instance.new("Model")
		projectile.Name = Name.. " Projectile"
		local source = Player.Character[Name]:FindFirstChild("Projectile")
		if source == nil then return end
		source = source:Clone()
		source.Transparency = 0
		source.Parent = projectile
		for _, Part in pairs(Player.Character[Name]:GetChildren()) do
			if string.match(Part.Name, "Projectile") and Part.Name ~= "Projectile" then
				local new = Part:Clone()
				new.Parent = projectile
				new.Transparency = 0
				--new.CFrame = source.CFrame * (Part.Weld.C0 * Part.Weld.C1):inverse()
				local w = Instance.new("Weld", new)
				w.Part0 = w.Parent
				w.Part1 = source
				w.C0 = Part.Weld.C0
				w.C1 = Part.Weld.C1
			end
		end
		local w = Instance.new("Weld", source)
		w.Part0 = w.Parent
		w.Part1 = Player.Character:FindFirstChild("Left Arm")
		w.C0 = CFrame.new(0.2, -0.8, -0.6) * CFrame.fromEulerAnglesXYZ(math.rad(180), 0, math.rad(-37.5))
		projectile.Parent = Player.Character[Name]
		for i = 0, 1, 0.1 do
			if Player.Character:FindFirstChild("Torso") ~= nil then
				if Player.Character.Torso:FindFirstChild("Left Shoulder 2") ~= nil and Player.Character.Torso:FindFirstChild("Right Shoulder 2") ~= nil then
					Player.Character.Torso["Left Shoulder 2"].C0 = CFrame.new(-1.5, 0.5, 0) * CFrame.fromEulerAnglesXYZ(math.rad(110) * i, 0, math.rad(67.5) * i)
					Player.Character.Torso["Left Shoulder 2"].C1 = CFrame.new(0, 0.5 * (1 - i), 0) * CFrame.new(0.35 * i, 1.85 * i, 0)
				else return false end
			else return false end
			wait()
		end
		Player.Character[Name].Handle.Reload.Volume = 1
		Player.Character[Name].Handle.Reload.Pitch = 0.9
		for i = 0, 0.9, 0.1 do
			if Player.Character:FindFirstChild("Torso") ~= nil then
				if Player.Character.Torso:FindFirstChild("Left Shoulder 2") ~= nil and Player.Character.Torso:FindFirstChild("Right Shoulder 2") ~= nil then
					Player.Character.Torso["Left Shoulder 2"].C0 = CFrame.new(-1.5 + i, 0.5, 0) * CFrame.fromEulerAnglesXYZ(math.rad(110), 0, math.rad(67.5))
					Player.Character.Torso["Left Shoulder 2"].C1 = CFrame.new(0.35 * (1 - i), 1.85, 0)
				else return false end
			else return false end
			wait()
		end
		projectile:Remove()
		Player.Character[Name].Handle.Reload:Stop()
		for _, Part in pairs(Player.Character[Name]:GetChildren()) do
			if string.match(Part.Name, "Projectile") then
				Part.Transparency = 0
			end
		end
		coroutine.resume(coroutine.create(function()
			for i = 1, 0, -0.1 do
				if Player.Character:FindFirstChild("Torso") ~= nil and Player.Character:FindFirstChild(Name) ~= nil then
					if Player.Character.Torso:FindFirstChild("Right Shoulder 2") ~= nil and Player.Character[Name]:FindFirstChild("Handle") ~= nil then
						Player.Character.Torso["Right Shoulder 2"].C0 = CFrame.new(1.25 + i / 10, 0.5, 0) * CFrame.fromEulerAnglesXYZ(math.rad(90), 0, math.rad(i * 90))
						Player.Character.Torso["Right Shoulder 2"].C1 = CFrame.new(0, 0.75, 0.1)
						Player.Character[Name].Handle.Weld.C1 = CFrame.new(0, -1.4 * i, 0) * CFrame.fromEulerAnglesXYZ(0, 0, math.rad(-i * 170))
					end
				end
				wait()
			end
		end))
		for i = 0.9, 0, -0.1 do
			if Player.Character:FindFirstChild("Torso") ~= nil then
				if Player.Character.Torso:FindFirstChild("Left Shoulder 2") ~= nil and Player.Character.Torso:FindFirstChild("Right Shoulder 2") ~= nil then
					Player.Character.Torso["Left Shoulder 2"].C0 = CFrame.new(-1.5 + i, 0.5, 0) * CFrame.fromEulerAnglesXYZ(math.rad(110), 0, math.rad(67.5))
					Player.Character.Torso["Left Shoulder 2"].C1 = CFrame.new(0, 1.85, 0)
				else return false end
			else return false end
			wait()
		end
		Player.Character[Name].Handle.Weld.C1 = CFrame.new()
		playAnimation("hold")
		return true
	end
	if format == "fire" then
		if Player.Character[Name]:FindFirstChild("Handle") ~= nil then
			Player.Character[Name].Handle.Fire:Play()
			CamShake(0.1, 5000)
		else return false end
		if Player.Character:FindFirstChild("Humanoid") ~= nil then
			coroutine.resume(coroutine.create(function() if Player.Character.Humanoid.PlatformStand == false and Player.Character.Humanoid.Sit == false then Player.Character.Humanoid.PlatformStand = true wait(0.1) Player.Character.Humanoid.PlatformStand = false end end))
		else return false end
		if Player.Character:FindFirstChild("Torso") ~= nil then
			coroutine.resume(coroutine.create(function() Player.Character.Torso.Velocity = Player.Character.Torso.Velocity + (Player.Character.Torso.CFrame.lookVector * -100) + Vector3.new(0, 25, 0) end))
		else return false end
		if Player.Character[Name]:FindFirstChild("Muzzle") ~= nil then
			coroutine.resume(coroutine.create(function() Player.Character[Name].Muzzle.Smoke.Enabled = true Player.Character[Name].Muzzle.Fire.Enabled = true wait(0.5) Player.Character[Name].Muzzle.Smoke.Enabled = false Player.Character[Name].Muzzle.Fire.Enabled = false end))
		else return false end
		if Player.Character[Name]:FindFirstChild("End 2") ~= nil then
			coroutine.resume(coroutine.create(function() Player.Character[Name]["End 2"].Smoke.Enabled = true Player.Character[Name]["End 2"].Fire.Enabled = true wait(0.5) Player.Character[Name]["End 2"].Smoke.Enabled = false Player.Character[Name]["End 2"].Fire.Enabled = false end))
		else return false end
	end
	return true
end


function CamShake(time, freq)
	coroutine.resume(coroutine.create(function()
		local cam = Workspace.CurrentCamera
		local time = 10
		local seed = Vector3.new(math.random(100, 200) / freq, math.random(100, 200) / freq, 0)
		if math.random(1, 2) == 1 then seed = Vector3.new(-seed.x, seed.y, 0) end
		if math.random(1, 2) == 1 then seed = Vector3.new(seed.x, -seed.y, 0) end
		cam.CoordinateFrame = (CFrame.new(cam.Focus.p) * (cam.CoordinateFrame - cam.CoordinateFrame.p) * CFrame.fromEulerAnglesXYZ(seed.x * time, seed.y * time, 0)) * CFrame.new(0, 0, (cam.CoordinateFrame.p - cam.Focus.p).magnitude)
		for i = 1, time do
			cam.CoordinateFrame = (CFrame.new(cam.Focus.p) * (cam.CoordinateFrame - cam.CoordinateFrame.p) * CFrame.fromEulerAnglesXYZ(-seed.x, -seed.y, 0)) * CFrame.new(0, 0, (cam.CoordinateFrame.p - cam.Focus.p).magnitude)
			wait()
		end
	end))
end


function Weld(x, y)
	local weld = Instance.new("Weld")
	weld.Part0 = x
	weld.Part1 = y
	CJ = CFrame.new(x.Position)
	C0 = x.CFrame:inverse() * CJ
	C1 = y.CFrame:inverse() * CJ
	weld.C0 = C0
	weld.C1 = C1
	weld.Parent = x
end


function tagHumanoid(humanoid)
	local tag = Instance.new("ObjectValue")
	tag.Name = "creator"
	tag.Value = Player
	tag.Parent = humanoid
	local tag = Instance.new("StringValue")
	tag.Name = "creatorType1"
	tag.Value = Name
	tag.Parent = humanoid
	local tag = Instance.new("StringValue")
	tag.Name = "creatorType2"
	tag.Value = "blown to bits"
	tag.Parent = humanoid
end


function untagHumanoid(humanoid)
	if humanoid ~= nil then
		local tag = humanoid:FindFirstChild("creator")
		if tag ~= nil then
			tag:Remove()
		end
		local tag = humanoid:FindFirstChild("creatorType1")
		if tag ~= nil then
			tag:Remove()
		end
		local tag = humanoid:FindFirstChild("creatorType2")
		if tag ~= nil then
			tag:Remove()
		end
	end
end


function fire(startPoint, endPoint, hit)
	local projectile = Instance.new("Model")
	projectile.Name = Name.. " Projectile"
	local source = Player.Character[Name]:FindFirstChild("Projectile")
	if source == nil then return end
	source.Transparency = 1
	source = source:Clone()
	source.Transparency = 0
	source.CanCollide = false
	pcall(function() source.Fire.Enabled = true end)
	pcall(function() source.Smoke.Enabled = true end)
	source.CFrame = CFrame.new(startPoint, endPoint) * CFrame.fromEulerAnglesXYZ(math.rad(90), 0, 0)
	source.Parent = projectile
	for _, Part in pairs(Player.Character[Name]:GetChildren()) do
		if string.match(Part.Name, "Projectile") and Part.Name ~= "Projectile" then
			local new = Part:Clone()
			new.Parent = projectile
			new.Transparency = 0
			new.CFrame = source.CFrame * (Part.Weld.C0 * Part.Weld.C1):inverse()
			local w = Instance.new("Weld", new)
			w.Part0 = w.Parent
			w.Part1 = source
			w.C0 = Part.Weld.C0
			w.C1 = Part.Weld.C1
			Part.Transparency = 1
		end
	end
	projectile.Parent = Workspace
	local vel = Instance.new("BodyVelocity")
	vel.maxForce = Vector3.new(math.huge, math.huge, math.huge)
	vel.velocity = (endPoint - startPoint).unit * 100
	vel.Parent = source
	local gyro = Instance.new("BodyGyro")
	gyro.maxTorque = Vector3.new(math.huge, math.huge, math.huge)
	gyro.cframe = CFrame.new(startPoint, endPoint) * CFrame.fromEulerAnglesXYZ(math.rad(90), 0, 0)
	gyro.Parent = source
	coroutine.resume(coroutine.create(function() wait(1) gyro:Remove() end))
	wait(0.2)
	source.CanCollide = true
	local connection = nil
	connection = source.Touched:connect(function()
		if hit.Parent == nil then return end
		if hit.Parent == projectile then return end
		if hit.Parent == Player.Character then return end
		if hit.Parent == Player.Character:FindFirstChild(Name) then return end
		if hit.Parent.Parent == Player.Character then return end
		for i = 1, math.random(3, 6) do
			local s = Instance.new("Sound", source)
			s.SoundId = "http://www.roblox.com/Asset/?id=2101148"
			s.Volume = 1
			s.Pitch = math.random(1, 10) / 10
			s:Play()
		end
		coroutine.resume(coroutine.create(function()
			pcall(function() vel:Remove() end)
			for _, Part in pairs(projectile:GetChildren()) do
				if Part.Name ~= "Projectile" then
					Part:Remove()
				else
					Part.Anchored = true
					Part.Transparency = 1
					Part.CanCollide = false
					pcall(function() Part.Fire.Enabled = false end)
					pcall(function() Part.Smoke.Enabled = false end)
				end
			end
			connection:disconnect()
			wait(5)
			projectile:Remove()
		end))
		local range = damage / 5
		local power = damage / 2
		local function Push(Part)
			if #Part:GetChildren() > 0 then for _, Parts in pairs(Part:GetChildren()) do Push(Parts) end end
			if pcall(function() local x = Part.CFrame end) == false then return end
			if Part.Anchored == true then return end
			if (Part.Position - source.Position).magnitude > range then return end
			Part.Velocity = Part.Velocity + ((Part.Position - source.Position).unit * power)
			coroutine.wrap(function()
					if Part.Parent:FindFirstChild("Humanoid") ~= nil then
						Part.Parent.Humanoid:TakeDamage(1000000) --Set to damage of explosion
					end
			end)()
		end
		Push(Workspace)
		for i = 1, math.random(5, 20) do
			local blast = Instance.new("Part")
			blast.FormFactor = 0
			blast.Size = Vector3.new(1, 1, 1)
			local color = math.random(1, 4)
			if color == 1 then
				blast.BrickColor = BrickColor.new("Really red")
			elseif color == 2 then
				blast.BrickColor = BrickColor.new("Bright orange")
			elseif color == 3 then
				blast.BrickColor = BrickColor.new("Neon orange")
			elseif color == 4 then
				blast.BrickColor = BrickColor.new("Bright red")
			end
			blast.TopSurface = 0
			blast.BottomSurface = 0
			blast.Anchored = true
			blast.CanCollide = false
			blast.CFrame = source.CFrame * CFrame.new(math.random(-damage / 50, damage / 50), math.random(-damage / 50, damage / 50), math.random(-damage / 50, damage / 50))
			blast.Parent = Workspace
			local mesh = Instance.new("SpecialMesh")
			mesh.MeshType = "Sphere"
			mesh.Parent = blast
			coroutine.resume(coroutine.create(function()
				for i = 1, range, math.random(range, range + 100) / 100 do
					blast.Transparency = i / range
					mesh.Scale = Vector3.new(i, i, i)
					wait()
				end
				blast:Remove()
			end))
		end
	end)
	coroutine.resume(coroutine.create(function()
		wait(10)
		for _, Part in pairs(projectile:GetChildren()) do
			Part.CanCollide = false
		end
		pcall(function() source.Fire.Enabled = false end)
		pcall(function() source.Smoke.Enabled = false end)
		pcall(function() vel:Remove() end)
		pcall(function() connection:disconnect() end)
	end))
end


function onButton1Down(mouse)
	if selected == false then return end
	if Player.Character:FindFirstChild(Name) ~= nil and Button1Down == false and canFire == true and (function() if dual == true then if Player.Character:FindFirstChild(Name.. " (Left)") ~= nil then return true else return false end else return true end end)() == true then
		if Player.Character[Name]:FindFirstChild("Handle") == nil then return end
		if Player.Character[Name]:FindFirstChild("Muzzle") == nil then return end
		if dual == true then if Player.Character[Name.. " (Left)"]:FindFirstChild("Handle") == nil then return end end
		if dual == true then if Player.Character[Name.. " (Left)"]:FindFirstChild("Muzzle") == nil then return end end
		mouse.Icon = "rbxasset://textures\\GunWaitCursor.png"
		Button1Down = true
		canFire = false
		canFire2 = true
		while canFire2 == true do
			local humanoid = Player.Character:FindFirstChild("Humanoid")
			if humanoid == nil then
				canFire2 = false
				break
			end
			if humanoid.Health <= 0 then
				canFire2 = false
				break
			end
			local fireLeft = false
			if automatic == false and burst == false then
				canFire2 = false
			elseif automatic == false and burst == true then
				if burstCount >= burstCountMax then
					canFire2 = false
					burstCount = 0
					break
				end
				burstCount = burstCount + 1
			elseif automatic == true and burst == false then
				fireLeft = true
			end
			if magazine.Value > 0 then
				magazine.Value = magazine.Value - 1
				updateGui()
				fire(Player.Character[Name].Muzzle.Position, mouse.Hit.p, mouse.Target)
				coroutine.resume(coroutine.create(function()
					if dual == true then
						playAnimation("rightFire")
					elseif dual == false then
						playAnimation("fire")
					end
				end))
			else
				Player.Character[Name].Handle.Empty:Play()
			end
			if fireLeft == true and dual == true and automatic == true then
				if magazine.Value > 0 then
					coroutine.resume(coroutine.create(function()
						wait(readyTime / 2)
						magazine.Value = magazine.Value - 1
						updateGui()
						fire(Player.Character[Name.. " (Left)"].Muzzle.Position, mouse.Hit.p, mouse.Target)
						playAnimation("leftFire")
					end))
				else
					coroutine.resume(coroutine.create(function()
						wait(readyTime / 2)
						Player.Character[Name].Handle.Empty:Play()
					end))
				end
			end
			wait(readyTime)
		end
		mouse.Icon = "rbxasset://textures\\GunCursor.png"
		canFire = true
	end
end


function onButton1Up(mouse)
	if selected == false then return end
	Button1Down = false
	canFire2 = false
	burstCount = 0
	while canFire == false do wait() end
	if dual == true and automatic == false then
		if Player.Character[Name.. " (Left)"]:FindFirstChild("Handle") == nil then return end
		if Player.Character[Name.. " (Left)"]:FindFirstChild("Muzzle") == nil then return end
		mouse.Icon = "rbxasset://textures\\GunWaitCursor.png"
		canFire = false
		canFire2 = true
		while canFire2 == true do
			local humanoid = Player.Character:FindFirstChild("Humanoid")
			if humanoid == nil then
				canFire2 = false
				break
			end
			if humanoid.Health <= 0 then
				canFire2 = false
				break
			end
			if burst == false then
				canFire2 = false
			elseif burst == true then
				if burstCount >= burstCountMax then
					canFire2 = false
					burstCount = 0
					break
				end
				burstCount = burstCount + 1
			end
			if magazine.Value <= 0 then
				Player.Character[Name].Handle.Empty:Play()
			else
				coroutine.resume(coroutine.create(function()
					playAnimation("leftFire")
				end))
				magazine.Value = magazine.Value - 1
				updateGui()
				fire(Player.Character[Name.. " (Left)"].Muzzle.Position, mouse.Hit.p, mouse.Target)
			end
			wait(readyTime)
		end
		mouse.Icon = "rbxasset://textures\\GunCursor.png"
		canFire = true
	end
end


function onKeyDown(key, mouse)
	if selected == false then return end
	key = key:lower()
	if key == "q" and Button1Down == false and canFire == true then
		if mouse.Target == nil then return end
		if game:GetService("Players"):GetPlayerFromCharacter(mouse.Target.Parent) ~= nil then
			if dual == true then onKeyDown("t", mouse) end
			onDeselected(mouse)
			removeParts("RightHolster")
			script.Parent.Parent = game:GetService("Players"):GetPlayerFromCharacter(mouse.Target.Parent).Backpack
		end
	end
	if key == "e" and Button1Down == false and canFire == true and canSilence == true then
		if silenced then
			silenced = false
			if Player.Character:FindFirstChild(Name) == nil then return end
			if Player.Character[Name]:FindFirstChild("Muzzle") == nil then return end
			if Player.Character[Name]:FindFirstChild("Muzzle 2") == nil then return end
			Player.Character[Name].Muzzle.Transparency = 1
			Player.Character[Name].Muzzle.Name = "Silencer"
			Player.Character[Name]["Muzzle 2"].Name = "Muzzle"
			if dual == true then
				if Player.Character[Name.. " (Left)"]:FindFirstChild("Muzzle") == nil then return end
				if Player.Character[Name.. " (Left)"]:FindFirstChild("Muzzle 2") == nil then return end
				Player.Character[Name.. " (Left)"].Muzzle.Transparency = 1
				Player.Character[Name.. " (Left)"].Muzzle.Name = "Silencer"
				Player.Character[Name.. " (Left)"]["Muzzle 2"].Name = "Muzzle"
			end
		else
			silenced = true
			if Player.Character:FindFirstChild(Name) == nil then return end
			if Player.Character[Name]:FindFirstChild("Silencer") == nil then return end
			if Player.Character[Name]:FindFirstChild("Muzzle") == nil then return end
			Player.Character[Name].Silencer.Transparency = 0
			Player.Character[Name].Muzzle.Name = "Muzzle 2"
			Player.Character[Name].Silencer.Name = "Muzzle"
			if dual == true then
				if Player.Character[Name.. " (Left)"]:FindFirstChild("Silencer") == nil then return end
				if Player.Character[Name.. " (Left)"]:FindFirstChild("Muzzle") == nil then return end
				Player.Character[Name.. " (Left)"].Silencer.Transparency = 0
				Player.Character[Name.. " (Left)"].Muzzle.Name = "Muzzle 2"
				Player.Character[Name.. " (Left)"].Silencer.Name = "Muzzle"
			end
		end
	end
	if key == "r" and Button1Down == false and canFire == true then
		if ammo.Value > 0 and magazine.Value ~= magazineMax.Value then
			canFire = false
			burstCount = 0
			mouse.Icon = "rbxasset://textures\\GunWaitCursor.png"
			if magazine.Value > 0 then ammo.Value = ammo.Value + magazine.Value magazine.Value = 0 end
			updateGui()
			if dual == true then
				playAnimation("reloadDual")
			elseif dual == false then
				playAnimation("reload")
			end
			if ammo.Value - magazineMax.Value < 0 then
				magazine.Value = ammo.Value
				ammo.Value = 0
			elseif ammo.Value - magazineMax.Value >= 0 then
				ammo.Value = ammo.Value - magazineMax.Value
				magazine.Value = magazineMax.Value
			end
			updateGui()
			mouse.Icon = "rbxasset://textures\\GunCursor.png"
			canFire = true
		end
	end
	if key == "t" and Button1Down == false and canFire == true and canDual == true then
		canFire = false
		if dual == false then
			local weapon = nil
			for _, p in pairs(Player.Backpack:GetChildren()) do
				if p.Name == Name and p ~= script.Parent then weapon = p break end
			end
			if weapon ~= nil then
				dual = true
				weapon.Name = "Dual"
				weapon.Parent = script
				silenced = false
				removeParts("RightHand")
				makeParts("RightHand")
				removeParts("RightHolster")
				makeParts("LeftHolster")
				playAnimation("leftEquip")
				removeParts("LeftHolster")
				makeParts("LeftHand")
				magazineMax.Value = math.ceil(magazineMax.Value * 2)
				ammoMax.Value = math.ceil(ammoMax.Value * 2)
				magazine.Value = magazine.Value + weapon.Magazine.Value
				ammo.Value = ammo.Value + weapon.Ammo.Value
				updateGui()
			end
		elseif dual == true then
			local weapon = script:FindFirstChild("Dual")
			if weapon ~= nil then
				dual = false
				weapon.Name = Name
				weapon.Parent = Player.Backpack
				silenced = false
				removeParts("RightHand")
				makeParts("RightHand")
				playAnimation("leftUnequip")
				removeParts("LeftHand")
				makeParts("RightHolster")
				playAnimation("hold")
				weapon.Magazine.Value = math.floor(magazine.Value / 2)
				weapon.Ammo.Value = math.floor(ammo.Value / 2)
				magazineMax.Value = math.ceil(magazineMax.Value / 2)
				ammoMax.Value = math.ceil(ammoMax.Value / 2)
				magazine.Value = math.ceil(magazine.Value / 2)
				ammo.Value = math.ceil(ammo.Value / 2)
				updateGui()
			end
		end
		canFire = true
	end
	if key == "y" and canZoom == true then
		if zoom == false then
			zoom = true
			local pos = mouse.Hit.p
			local target = mouse.Target
			local cam = Workspace.CurrentCamera
			focus = Instance.new("Part", Workspace)
			focus.Anchored = true
			focus.CanCollide = false
			focus.Transparency = 1
			focus.TopSurface = 0
			focus.BottomSurface = 0
			focus.FormFactor = "Plate"
			focus.Size = Vector3.new(0, 0, 0)
			focus.CFrame = CFrame.new(pos) * (CFrame.new(Player.Character.Torso.Position, pos) - CFrame.new(Player.Character.Torso.Position, pos).p)
			cam.CameraSubject = focus
			cam.CameraType = "Attach"
			while zoom == true and selected == true do
				local set = false
				if target ~= nil then
					if target.Parent ~= nil then
						if target.Anchored == false then
							focus.CFrame = CFrame.new(target.Position) * (CFrame.new(Player.Character.Torso.Position, target.Position) - CFrame.new(Player.Character.Torso.Position, target.Position).p)
							set = true
						end
					end
				end
				if set == false then
					focus.CFrame = CFrame.new(pos) * (CFrame.new(Player.Character.Torso.Position, pos) - CFrame.new(Player.Character.Torso.Position, pos).p)
				end
				wait()
			end
			if focus ~= nil then focus:Remove() focus = nil end
			local cam = Workspace.CurrentCamera
			cam.CameraSubject = Player.Character:FindFirstChild("Humanoid")
			cam.CameraType = "Custom"
		else
			zoom = false
		end
	end
	if key == "u" and Button1Down == false and canFire == true then
		if automatic == false and burst == false then
			if switchToBurst == true then
				burst = true
				local m = Instance.new("Message", Player)
				m.Text = "Burst"
				pcall(function() Player.Character[Name].Handle.Switch:Play() end)
				delay(2.5, function() m:Remove() end)
			elseif switchToAutomatic == true then
				automatic = true
				local m = Instance.new("Message", Player)
				m.Text = "Automatic"
				pcall(function() Player.Character[Name].Handle.Switch:Play() end)
				delay(2.5, function() m:Remove() end)
			end
		elseif automatic == false and burst == true then
			if switchToAutomatic == true then
				automatic = true
				burst = false
				local m = Instance.new("Message", Player)
				m.Text = "Automatic"
				pcall(function() Player.Character[Name].Handle.Switch:Play() end)
				delay(2.5, function() m:Remove() end)
			elseif switchToSingle == true then
				burst = false
				local m = Instance.new("Message", Player)
				m.Text = "Single"
				pcall(function() Player.Character[Name].Handle.Switch:Play() end)
				delay(2.5, function() m:Remove() end)
			end
		elseif automatic == true and burst == false then
			if switchToSingle == true then
				automatic = false
				local m = Instance.new("Message", Player)
				m.Text = "Single"
				pcall(function() Player.Character[Name].Handle.Switch:Play() end)
				delay(2.5, function() m:Remove() end)
			elseif switchToBurst == true then
				automatic = false
				burst = true
				local m = Instance.new("Message", Player)
				m.Text = "Burst"
				pcall(function() Player.Character[Name].Handle.Switch:Play() end)
				delay(2.5, function() m:Remove() end)
			end
		end
	end
end


function onSelected(mouse)
	if selected == true then return end
	selected = true
	canFire = false
	mouse.Icon = "rbxasset://textures\\GunWaitCursor.png"
	while Player.Character:FindFirstChild("WeaponActivated") ~= nil do
		if Player.Character.WeaponActivated.Value == nil then break end
		if Player.Character.WeaponActivated.Value.Parent == nil then break end
		wait()
	end
	updateGui()
	local weapon = Instance.new("ObjectValue")
	weapon.Name = "WeaponActivated"
	weapon.Value = script.Parent
	weapon.Parent = Player.Character
	DisableLimb(1, Player.Character)
	DisableLimb(2, Player.Character)
	ForceAngle(1, 0, Player.Character)
	ForceAngle(2, 0, Player.Character)
	if dual == true then
		coroutine.resume(coroutine.create(function() playAnimation("leftEquip") end))
		playAnimation("rightEquip")
		removeParts("LeftHolster")
		makeParts("LeftHand")
	else
		playAnimation("equip")
	end
	removeParts("RightHolster")
	makeParts("RightHand")
	mouse.Button1Down:connect(function() onButton1Down(mouse) end)
	mouse.Button1Up:connect(function() onButton1Up(mouse) end)
	mouse.KeyDown:connect(function(key) onKeyDown(key, mouse) end)
	mouse.Icon = "rbxasset://textures\\GunCursor.png"
	canFire = true
end


function onDeselected(mouse)
	if selected == false then return end
	Button1Down = false
	while canFire == false do
		wait()
	end
	selected = false
	if dual == true then
		if math.random(1, 2) == 1 then
			coroutine.resume(coroutine.create(function() playAnimation("leftUnequip") end))
			wait(math.random(1, 10) / 10)
			playAnimation("rightUnequip")
		else
			coroutine.resume(coroutine.create(function() playAnimation("rightUnequip") end))
			wait(math.random(1, 10) / 10)
			playAnimation("leftUnequip")
		end
		removeParts("LeftHand")
		makeParts("LeftHolster")
	else
		playAnimation("unequip")
	end
	removeParts("RightHand")
	makeParts("RightHolster")
	ForceAngle(1, 0, Player.Character)
	ForceAngle(2, 0, Player.Character)
	ResetLimbCFrame(1, Player.Character)
	ResetLimbCFrame(2, Player.Character)
	EnableLimb(1, Player.Character)
	EnableLimb(2, Player.Character)
	silenced = false
	if Player.PlayerGui:FindFirstChild(Name) ~= nil then Player.PlayerGui[Name]:Remove() end
	if Player.Character:FindFirstChild("WeaponActivated") ~= nil then
		if Player.Character.WeaponActivated.Value == script.Parent then
			Player.Character.WeaponActivated:Remove()
		end
	end
	while Player.Character:FindFirstChild("WeaponActivated") ~= nil do
		if Player.Character.WeaponActivated.Value == nil then break end
		if Player.Character.WeaponActivated.Value.Parent == nil then break end
		wait()
	end
end


if script.Parent.ClassName ~= "HopperBin" then
	if Player == nil then print("Error: Player not found!") return end
	Tool = Instance.new("HopperBin")
	Tool.Name = Name
	Tool.Parent = Player.Backpack
	script.Name = "Main"
	script.Parent = Tool
elseif script.Parent.ClassName == "HopperBin" then
	while script.Parent.Parent.ClassName ~= "Backpack" do
		wait()
	end
	if script.Parent:FindFirstChild("MagazineMax") == nil then
		magazineMax = Instance.new("NumberValue")
		magazineMax.Name = "MagazineMax"
		magazineMax.Value = 3
		magazineMax.Parent = script.Parent
	else
		magazineMax = script.Parent.MagazineMax
	end
	if script.Parent:FindFirstChild("Magazine") == nil then
		magazine = Instance.new("NumberValue")
		magazine.Name = "Magazine"
		magazine.Value = 3
		magazine.Parent = script.Parent
	else
		magazine = script.Parent.Magazine
	end
	if script.Parent:FindFirstChild("AmmoMax") == nil then
		ammoMax = Instance.new("NumberValue")
		ammoMax.Name = "AmmoMax"
		ammoMax.Value = 50 --You may set the ammo of the RPG here.
		ammoMax.Parent = script.Parent
	else
		ammoMax = script.Parent.AmmoMax
	end
	if script.Parent:FindFirstChild("Ammo") == nil then
		ammo = Instance.new("NumberValue")
		ammo.Name = "Ammo"
		ammo.Value = script.Parent.AmmoMax.Value
		ammo.Parent = script.Parent
	else
		ammo = script.Parent.Ammo
	end
	Player = script.Parent.Parent.Parent
	makeParts("RightHolster")
	script.Parent.Selected:connect(onSelected)
	script.Parent.Deselected:connect(onDeselected)
end
--lego
game.Workspace.mogoon.Humanoid.MaxHealth = math.huge  -----Replace my name with yours for INF HP
print(lego)