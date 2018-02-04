--[[
  Made by jimtek
  (very messy code)
--]]
spamming = 0
random3 = 0
PartSize = 0
RandomMat = 0
char = game.Players.LocalPlayer.Character
if char == nil then
	warn("Error loading! no charecter")
else
	print(char.name)
end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Spam_Parts = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local AmmountBox = Instance.new("TextBox")
local SizeBox = Instance.new("TextBox")
local label = Instance.new("TextLabel")
local label_2 = Instance.new("TextLabel")

ScreenGui.Parent = game.Players.Capetown7.PlayerGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
MainFrame.BorderColor3 = Color3.new(1, 1, 1)
MainFrame.Draggable = true
MainFrame.Position = UDim2.new(0.323266208, 0, 0.408496737, 0)
MainFrame.Selectable = true
MainFrame.Size = UDim2.new(0, 317, 0, 230)

Spam_Parts.Name = "Spam_Parts"
Spam_Parts.Parent = MainFrame
Spam_Parts.BackgroundColor3 = Color3.new(0, 0, 0)
Spam_Parts.BorderColor3 = Color3.new(1, 1, 1)
Spam_Parts.Position = UDim2.new(0.00157728698, 0, 0.759278297, 0)
Spam_Parts.Size = UDim2.new(0, 317, 0, 55)
Spam_Parts.Font = Enum.Font.SourceSansBold
Spam_Parts.FontSize = Enum.FontSize.Size32
Spam_Parts.Text = "Spawn"
Spam_Parts.TextColor3 = Color3.new(1, 1, 1)
Spam_Parts.TextSize = 32

Spam_Parts.MouseButton1Down:connect(function()
	spamming = 0
	warn("Spamming parts!")
	while spamming <500 do
		wait()
		local part = Instance.new("Part",game.Workspace)
		part.BrickColor = BrickColor.Random()
		random3 = math.random(3)
		if random3 == 1 then
			part.Shape = Enum.PartType.Block
		end
		if random3 == 2 then
			part.Shape = Enum.PartType.Cylinder
		end
		if random3 == 3 then
			part.Shape = Enum.PartType.Ball
		end
		
		RandomMat = math.random(19)
		if RandomMat == 1 then
			part.Material = Enum.Material.Plastic
		end
		if RandomMat == 2 then
			part.Material = Enum.Material.Wood
		end
		if RandomMat == 3 then
			part.Material = Enum.Material.Slate
		end
		if RandomMat == 4 then
			part.Material = Enum.Material.Concrete
		end
		if RandomMat == 5 then
			part.Material = Enum.Material.CorrodedMetal
		end
		if RandomMat == 6 then
			part.Material = Enum.Material.DiamondPlate
		end
		if RandomMat == 7 then
			part.Material = Enum.Material.Foil
		end
		if RandomMat == 8 then
			part.Material = Enum.Material.Grass
		end
		if RandomMat == 9 then
			part.Material = Enum.Material.Ice
		end
		if RandomMat == 10 then
			part.Material = Enum.Material.Marble
		end
		if RandomMat == 11 then
			part.Material = Enum.Material.Granite
		end
		if RandomMat == 12 then
			part.Material = Enum.Material.Brick
		end
		if RandomMat == 13 then
			part.Material = Enum.Material.Pebble
		end
		if RandomMat == 14 then
			part.Material = Enum.Material.Sand
		end
		if RandomMat == 15 then
			part.Material = Enum.Material.Fabric
		end
		if RandomMat == 16 then
			part.Material = Enum.Material.Metal
		end
		if RandomMat == 17 then
			part.Material = Enum.Material.WoodPlanks
		end
		if RandomMat == 18 then
			part.Material = Enum.Material.Cobblestone
		end
		if RandomMat == 19 then
			part.Material = Enum.Material.Neon
		end
		
		
		local PlayerPos = game.Players.LocalPlayer.Character.Torso.Position
		
		local PlayerX = game.Players.LocalPlayer.Character.Torso.Position.X
		local PlayerY = game.Players.LocalPlayer.Character.Torso.Position.Y
		local PlayerZ = game.Players.LocalPlayer.Character.Torso.Position.Z
		part.Position = Vector3.new(PlayerX,PlayerY,PlayerZ)
		part.Position = part.Position + Vector3.new(0,2,0)
		
		PartSize = tonumber(SizeBox.Text)
		part.Size = Vector3.new(PartSize,PartSize,PartSize)
						
		
		if spamming <tonumber(AmmountBox.Text) then --loop ammount
			spamming = spamming + 1
		else
			break
		end
	end
	
end)

TextLabel.Parent = MainFrame
TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel.BackgroundTransparency = 1
TextLabel.Size = UDim2.new(0, 316, 0, 66)
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.FontSize = Enum.FontSize.Size60
TextLabel.TextColor3 = Color3.new(1, 1, 1)
TextLabel.TextSize = 50
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.Text = "Part spammer"

AmmountBox.Name = "SizeBox"
AmmountBox.Parent = MainFrame
AmmountBox.BackgroundColor3 = Color3.new(0, 0, 0)
AmmountBox.BorderColor3 = Color3.new(1, 1, 1)
AmmountBox.Position = UDim2.new(0.422712922, 0, 0.5, 0)
AmmountBox.Size = UDim2.new(0, 175, 0, 50)
AmmountBox.Font = Enum.Font.ArialBold
AmmountBox.FontSize = Enum.FontSize.Size28
AmmountBox.Text = "10"
AmmountBox.TextColor3 = Color3.new(1, 1, 1)
AmmountBox.TextSize = 28

SizeBox.Name = "AmmountBox"
SizeBox.Parent = MainFrame
SizeBox.BackgroundColor3 = Color3.new(0, 0, 0)
SizeBox.BorderColor3 = Color3.new(1, 1, 1)
SizeBox.Position = UDim2.new(0.422712922, 0, 0.25, 0)
SizeBox.Size = UDim2.new(0, 175, 0, 50)
SizeBox.Font = Enum.Font.ArialBold
SizeBox.FontSize = Enum.FontSize.Size28
SizeBox.Text = "2"
SizeBox.TextColor3 = Color3.new(1, 1, 1)
SizeBox.TextSize = 28

label.Name = "label"
label.Parent = MainFrame
label.BackgroundColor3 = Color3.new(1, 1, 1)
label.BackgroundTransparency = 1
label.Position = UDim2.new(0.00315457419, 0, 0.217391297, 0)
label.Size = UDim2.new(0, 316, 0, 66)
label.Font = Enum.Font.SourceSansBold
label.FontSize = Enum.FontSize.Size60
label.Text = "Size:"
label.TextColor3 = Color3.new(1, 1, 1)
label.TextSize = 50
label.TextXAlignment = Enum.TextXAlignment.Left

label_2.Name = "label"
label_2.Parent = MainFrame
label_2.BackgroundColor3 = Color3.new(1, 1, 1)
label_2.BackgroundTransparency = 1
label_2.Position = UDim2.new(0.00315457419, 0, 0.465217382, 0)
label_2.Size = UDim2.new(0, 316, 0, 66)
label_2.Font = Enum.Font.SourceSansBold
label_2.FontSize = Enum.FontSize.Size48
label_2.Text = "Spawn:"
label_2.TextColor3 = Color3.new(1, 1, 1)
label_2.TextSize = 48
label_2.TextXAlignment = Enum.TextXAlignment.Left