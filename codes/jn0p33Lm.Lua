local Player = game.Players.LocalPlayer
local ItemData = require(game.ReplicatedStorage.ItemData)
local Open = true
local Selected = 1
local Frames = {}

local GamePassIDs = {0,0,0,1209032431,1209033674,0}
local SelectedItem = {0,0,0,0,0,0}

local Titles = {
	"SWORDSMAN INVENTORY",
	"SPEARMAN INVENTORY",
	"HEAVY INVENTORY",
	"ARCHER INVENTORY",
	"MARAUDER INVENTORY",
	"EFFECTS INVENTORY"
}

function OpenFrame()
	script.Parent:TweenPosition(
		UDim2.new(0.5, 0, 0.5, -160),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Quad,
		0.2
	)
	Open = true
end

function CloseFrame()
	script.Parent:TweenPosition(
		UDim2.new(0.5, 0, 1, 0),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Quad,
		0.2
	)
	Open = false
end

script.Parent.Title.Close.MouseButton1Click:Connect(function ()
	script.Parent.Parent.Parent.Sounds.Pop:Play()
	if Open then
		CloseFrame()
	end
end)

script.Parent.Parent.Sidebar.Inventory.MouseButton1Click:Connect(function ()
	script.Parent.Parent.Parent.Sounds.Pop:Play()
	if Open then
		CloseFrame()
	else
		OpenFrame()
	end
end)

function HasAccess(TabID)
	if TabID == 4 then
		if not Player.Passes:FindFirstChild("Archer") then
			return false
		end
	end
	if TabID == 5 then
		if not Player.Passes:FindFirstChild("Marauder") then
			return false
		end
	end
	return true
end

script.Parent.Locked.Purchase.MouseButton1Click:Connect(function ()
	script.Parent.Parent.Parent.Sounds.Pop:Play()
	game:GetService("MarketplaceService"):PromptPurchase(Player, GamePassIDs[Selected])
end)

for Index = 1, #script.Parent.Frame:GetChildren() do
	local Button = script.Parent.Frame:FindFirstChild("Button" .. Index)
	if Button then
		Button.MouseButton1Click:Connect(function ()
			script.Parent.Parent.Parent.Sounds.Pop:Play()
			if Selected ~= Index then
				script.Parent.Frame:FindFirstChild("Button" .. Selected).BackgroundTransparency = 0
				Button.BackgroundTransparency = 0.25
				if HasAccess(Index) then
					script.Parent.Locked.Visible = false
					script.Parent.Items.Title.Text = Titles[Index]
					script.Parent.Items.Visible = true
				else
					script.Parent.Items.Visible = false
					script.Parent.Locked.Visible = true
				end
				Selected = Index
			end
		end)
	else
		print("Button missing from inventory")
	end
end

for Index = 1, #ItemData do
	local New = script.Frame:Clone()
	table.insert(Frames, New)
	New.LayoutOrder = Index
	New.Title.Text = ItemData[Index].Name
	New.Image = ItemData[Index].Icon
	New.MouseButton1Click:Connect(function ()
		SelectedItem[ItemData[Index].Type] = Index
	end)
	New.Parent = script.Parent.Items.Frame.ScrollingFrame
end

game:GetService("RunService").RenderStepped:Connect(function ()
	local Count = {0, 0, 0, 0, 0, 0}
	for Index = 1, #ItemData do
		local Frame = Frames[Index]
		local Item = ItemData[Index]
		local ItemCount = Player:WaitForChild("SaveFile")["Item" .. Index].Value
		if ItemCount > 0 and Selected == Item.Type then
			Count[Item.Type] = Count[Item.Type] + 1
			if Index == SelectedItem[Item.Type] then
				Frame.BackgroundColor3 = Color3.fromRGB(246, 73, 73)
			else
				Frame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
			end
			Frame.Visible = true
		else
			Frame.Visible = false
		end
	end
	script.Parent.Items.Frame.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, math.floor(Count[Selected] / 4) * 80)
	if SelectedItem[Selected] > 0 then
		local ItemCount = Player:WaitForChild("SaveFile")["Item" .. SelectedItem[Selected]].Value
		if ItemCount > 0 then
			local Item = ItemData[SelectedItem[Selected]]
			script.Parent.Items.Info.ItemName.Text = Item.Name
			script.Parent.Items.Info.Frame.Icon.Image = Item.Icon
			script.Parent.Items.Info.Desc.Text = Item.Desc
			script.Parent.Items.Info.Price.Price.Text = Item.Value .. " G"
			script.Parent.Items.Info.Visible = true
		else
			script.Parent.Items.Info.Visible = false
		end
	else
		script.Parent.Items.Info.Visible = false
	end
end)